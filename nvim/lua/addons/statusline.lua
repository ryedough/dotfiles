---@return string
function _G.git_component()
    local head = vim.b.gitsigns_head
    if not head then
        return ''
    end

    return string.format(' %s ', head)
end

-- File type with Nerd Font icon
function _G.file_type_component()
	local ft = vim.bo.filetype
	local icons = {
		lua = "\u{e620} ", -- nf-dev-lua
		python = "\u{e73c} ", -- nf-dev-python
		javascript = "\u{e74e} ", -- nf-dev-javascript
		typescript = "\u{e628} ", -- nf-dev-typescript
		javascriptreact = "\u{e7ba} ",
		typescriptreact = "\u{e7ba} ",
		html = "\u{e736} ", -- nf-dev-html5
		css = "\u{e749} ", -- nf-dev-css3
		scss = "\u{e749} ",
		json = "\u{e60b} ", -- nf-dev-json
		markdown = "\u{e73e} ", -- nf-dev-markdown
		vim = "\u{e62b} ", -- nf-dev-vim
		sh = "\u{f489} ", -- nf-oct-terminal
		bash = "\u{f489} ",
		zsh = "\u{f489} ",
		rust = "\u{e7a8} ", -- nf-dev-rust
		go = "\u{e724} ", -- nf-dev-go
		c = "\u{e61e} ", -- nf-dev-c
		cpp = "\u{e61d} ", -- nf-dev-cplusplus
		java = "\u{e738} ", -- nf-dev-java
		php = "\u{e73d} ", -- nf-dev-php
		ruby = "\u{e739} ", -- nf-dev-ruby
		swift = "\u{e755} ", -- nf-dev-swift
		kotlin = "\u{e634} ",
		dart = "\u{e798} ",
		elixir = "\u{e62d} ",
		haskell = "\u{e777} ",
		sql = "\u{e706} ",
		yaml = "\u{f481} ",
		toml = "\u{e615} ",
		xml = "\u{f05c} ",
		dockerfile = "\u{f308} ", -- nf-linux-docker
		gitcommit = "\u{f418} ", -- nf-oct-git_commit
		gitconfig = "\u{f1d3} ", -- nf-fa-git
		vue = "\u{fd42} ", -- nf-md-vuejs
		svelte = "\u{e697} ",
		astro = "\u{e628} ",
	}

	if ft == "" then
		return " \u{f15b} " -- nf-fa-file_o
	end

	return ((icons[ft] or " \u{f15b} ") .. ft)
end

-- Mode indicators with Nerd Font icons
function _G.mode_icon_component()
	local mode = vim.fn.mode()
	local modes = {
		n = " \u{f121}  NORMAL",
		i = " \u{f11c}  INSERT",
		v = " \u{f0168} VISUAL",
		V = " \u{f0168} V-LINE",
		["\22"] = " \u{f0168} V-BLOCK",
		c = " \u{f120} COMMAND",
		s = " \u{f0c5} SELECT",
		S = " \u{f0c5} S-LINE",
		["\19"] = " \u{f0c5} S-BLOCK",
		R = " \u{f044} REPLACE",
		r = " \u{f044} REPLACE",
		["!"] = " \u{f489} SHELL",
		t = " \u{f120} TERMINAL",
	}
	return modes[mode] or (" \u{f059} " .. mode)
end

function _G.diagnostic_status_component()
  local ok = '   '

  local ignore = {
    ['c'] = true, -- command mode
    ['t'] = true  -- terminal mode
  }

  local mode = vim.api.nvim_get_mode().mode

  if ignore[mode] then
    return ok
  end

  local levels = vim.diagnostic.severity
  local errors = #vim.diagnostic.get(0, {severity = levels.ERROR})
  if errors > 0 then
    return '  ('.. errors .. ') '
  end

  local warnings = #vim.diagnostic.get(0, {severity = levels.WARN})
  if warnings > 0 then
    return '  ('.. warnings .. ') '
  end

  return ok
end

-- Function to change statusline based on window focus
local function render()
	vim.api.nvim_create_autocmd({ "WinEnter", "BufEnter" }, {
		callback = function()
			vim.opt_local.statusline = table.concat({
				"%#StatusLineBold#",
                " ",
				"%{v:lua.mode_icon_component()}",
                " ",
                "%#StatusLineDiv1#",
                "\u{e0b8} ",
				"%#StatusLine#",
				"%t ",
				"%{v:lua.git_component()}",
                "%#StatusLineDiv2#",
				"\u{e0b8} ", -- nf-pl-left_hard_divider
                "%#StatusLineFile#",
				"%{v:lua.file_type_component()}",
				"%=", -- Right-align everything after this
                "%{v:lua.diagnostic_status_component()}",
                "%#StatusLineRight#",
				" %l:%c / %L ", -- nf-fa-clock_o for line/col
			})
		end,
	})

    local primary = "#00FF26"
    local secondary ="#394260"
    local tertiary = "#212736"
    local primary_text = "#090c0c"

    vim.api.nvim_set_hl(0, "StatusLineBold", {bg = primary, fg = primary_text, bold = true })
    vim.api.nvim_set_hl(0, "StatusLineDiv1", {bg = secondary, fg=primary})
    vim.api.nvim_set_hl(0, "StatusLine", {bg = secondary, fg=primary})
    vim.api.nvim_set_hl(0, "StatusLineDiv2", {bg = tertiary, fg=secondary})
    vim.api.nvim_set_hl(0, "StatusLineFile", {bg = tertiary, fg=primary})
    vim.api.nvim_set_hl(0, "StatusLineRight", {bg = secondary, fg=primary})

	-- vim.api.nvim_create_autocmd({ "WinLeave", "BufLeave" }, {
	-- 	callback = function()
	-- 		vim.opt_local.statusline = "  %f %h%m%r \u{e0b1} %{v:lua.file_type()} %=  %l:%c   %P "
	-- 	end,
	-- })
end

render()
