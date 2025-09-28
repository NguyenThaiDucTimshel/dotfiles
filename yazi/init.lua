-- The init.lua file to configure the Yazi plugins I use

-- Configure the relative motions plugin
require("relative-motions"):setup({
	show_numbers = "relative",
	show_motion = true,
})

-- You can configure your bookmarks using simplified syntax
local bookmarks = {
	{ tag = "Desktop", path = "~/Desktop", key = "d" },
	{ tag = "Documents", path = "~/Documents", key = "D" },
	{ tag = "Downloads", path = "~/Downloads", key = "o" },
}

-- Windows-specific bookmarks
if ya.target_family() == "windows" then
	local home_path = os.getenv("USERPROFILE")
	table.insert(bookmarks, {
		tag = "Scoop Local",
		path = os.getenv("SCOOP") or (home_path .. "\\scoop"),
		key = "p",
	})
	table.insert(bookmarks, {
		tag = "Scoop Global",
		path = os.getenv("SCOOP_GLOBAL") or "C:\\ProgramData\\scoop",
		key = "P",
	})
end

require("whoosh"):setup({
	-- Configuration bookmarks (cannot be deleted through plugin)
	bookmarks = bookmarks,

	-- Notification settings
	jump_notify = false,

	-- Key generation for auto-assigning bookmark keys
	keys = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ",

	-- File path for storing user bookmarks
	path = (ya.target_family() == "windows" and os.getenv("APPDATA") .. "\\yazi\\config\\bookmark")
		or (os.getenv("HOME") .. "/.config/yazi/bookmark"),

	-- Path truncation in navigation menu
	path_truncate_enabled = false, -- Enable/disable path truncation
	path_max_depth = 3, -- Maximum path depth before truncation

	-- Path truncation in fuzzy search (fzf)
	fzf_path_truncate_enabled = false, -- Enable/disable path truncation in fzf
	fzf_path_max_depth = 5, -- Maximum path depth before truncation in fzf

	-- Long folder name truncation
	path_truncate_long_names_enabled = false, -- Enable in navigation menu
	fzf_path_truncate_long_names_enabled = false, -- Enable in fzf
	path_max_folder_name_length = 20, -- Max length in navigation menu
	fzf_path_max_folder_name_length = 20, -- Max length in fzf

	-- History directory settings
	history_size = 10, -- Number of directories in history (default 10)
	history_fzf_path_truncate_enabled = false, -- Enable/disable path truncation by depth for history
	history_fzf_path_max_depth = 5, -- Maximum path depth before truncation for history (default 5)
	history_fzf_path_truncate_long_names_enabled = false, -- Enable/disable long folder name truncation for history
	history_fzf_path_max_folder_name_length = 30, -- Maximum length for folder names in history (default 30)
})

require("full-border"):setup({
	-- Available values: ui.Border.PLAIN, ui.Border.ROUNDED
	type = ui.Border.ROUNDED,
})

-- require("yaziline"):setup()

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
