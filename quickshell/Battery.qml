pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Io
import Quickshell.Services.UPower

Singleton {
    enum State {
        Charging,
        Discharging,
        Full
    }
    enum Mode {
        Performance,
        Balanced,
        PowerSaver,
        Unknown
    }
    property var bat: UPower.displayDevice
    readonly property int percentage : {
        Math.floor(UPower.displayDevice.percentage * 100)
    }
    readonly property int status : {
        switch(UPower.displayDevice.state) {
            case 0 :
            case 2 :
            case 3 :
                return Battery.Discharging
            case 1 :
            case 5 :
            case 6 :
                return Battery.Charging
            case 4 :
                return Battery.Full
        }
    }
    readonly property int mode : modeProcess.mode
    readonly property string modeStr : {
        switch(Battery.mode){
            case Battery.Mode.Performance : return "Performance";
            case Battery.Mode.Balanced : return "Balanced";
            case Battery.Mode.PowerSaver : return "Power Saver";
            case Battery.Mode.Unknown : return "";
        };
    }
    Process {
        id: modeProcess
        property int mode : Battery.Mode.Unknown
        running : true
        command : ["sudo", "-n", "/usr/sbin/tlp-stat", "-m"]
        stdout : StdioCollector {
            onStreamFinished : {
                if(this.text.includes("performance")){
                    modeProcess.mode = Battery.Mode.Performance
                } else if (this.text.includes("balanced")) {
                    modeProcess.mode = Battery.Mode.Balanced
                } else if (this.text.includes("power-saver")) {
                    modeProcess.mode = Battery.Mode.PowerSaver
                } else {
                    modeProcess.mode = Battery.Mode.Unknown
                }
            }
        }
    }
    Connections {
       target: UPower
       function onOnBatteryChanged() { modeProcess.running = true }
    }
    Timer {
        interval : 10000
        repeat: true
        running: true
        onTriggered: {
            modeProcess.running = true
        }
    }
}
