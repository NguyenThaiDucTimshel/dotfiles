-- The init.lua file to configure the Yazi plugins I use

-- Configure the relative motions plugin
require("relative-motions"):setup({
	show_numbers = "relative",
	show_motion = true,
})

-- You can configure your bookmarks by lua language
local bookmarks = {}

local path_sep = package.config:sub(1, 1)
local home_path = ya.target_family() == "windows" and os.getenv("USERPROFILE") or os.getenv("HOME")
if ya.target_family() == "windows" then
	table.insert(bookmarks, {
		tag = "Scoop Local",
		path = (os.getenv("SCOOP") or home_path .. "\\scoop") .. "\\",
		key = "p",
	})
	table.insert(bookmarks, {
		tag = "Scoop Global",
		path = (os.getenv("SCOOP_GLOBAL") or "C:\\ProgramData\\scoop") .. "\\",
		key = "P",
	})
end
table.insert(bookmarks, {
	tag = "Desktop",
	path = home_path .. path_sep .. "Desktop" .. path_sep,
	key = "d",
})

require("yamb"):setup({
	-- Optional, the path ending with path seperator represents folder.
	bookmarks = bookmarks,
	-- Optional, recieve notification everytime you jump.
	jump_notify = true,
	-- Optional, the cli of fzf.
	cli = "fzf",
	-- Optional, a string used for randomly generating keys, where the preceding characters have higher priority.
	keys = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ",
	-- Optional, the path of bookmarks
	path = (ya.target_family() == "windows" and os.getenv("APPDATA") .. "\\yazi\\config\\bookmark")
		or (os.getenv("HOME") .. "/.config/yazi/bookmark"),
})

require("full-border"):setup({
	-- Available values: ui.Border.PLAIN, ui.Border.ROUNDED
	type = ui.Border.ROUNDED,
})

require("yaziline"):setup({
	color = "#98c379",
	secondary_color = "#5A6078",
	default_files_color = "darkgray", -- color of the file counter when it's inactive
	selected_files_color = "white",
	yanked_files_color = "green",
	cut_files_color = "red",

	separator_style = "empty", -- "angly" | "curvy" | "liney" | "empty"
	separator_open = "",
	separator_close = "",
	separator_open_thin = "",
	separator_close_thin = "",
	separator_head = "",
	separator_tail = "",

	select_symbol = "",
	yank_symbol = "󰆐",

	filename_max_length = 24, -- truncate when filename > 24
	filename_truncate_length = 6, -- leave 6 chars on both sides
	filename_truncate_separator = "...",
})

-- require("mime-preview"):setup()

-- require("mime-ext"):setup({
-- 	-- -- Expand the existing filename database (lowercase), for example:
-- 	-- with_files = {
-- 	-- 	makefile = "text/makefile",
-- 	-- 	-- ...
-- 	-- },
-- 	--
-- 	-- -- Expand the existing extension database (lowercase), for example:
-- 	-- with_exts = {
-- 	-- 	mk = "text/makefile",
-- 	-- 	-- ...
-- 	-- },
--
-- 	-- If the mime-type is not in both filename and extension databases,
-- 	-- then fallback to Yazi's preset `mime` plugin, which uses `file(1)`
-- 	fallback_file1 = false,
-- })
