pragma Singleton

import QtQuick
import Quickshell

Singleton {
    readonly property string dayNow : {
        const day = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]
        day[clock.date.getDay()];
    }
    readonly property string dateMonthNow : {
        Qt.formatDateTime(clock.date, "dd/MM");
    }
    readonly property string hourNow : {
        Qt.formatDateTime(clock.date, "hh:mm:ss");
    }
    SystemClock {
        id : clock
        precision : SystemClock.Seconds
    }
}
