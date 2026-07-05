-- ~/.config/swayimg/init.lua

-- ========================================================================
-- General & Font Configuration
-- ========================================================================
swayimg.set_mode("viewer")
swayimg.enable_antialiasing(false)

swayimg.text.set_font("Iosevka")
swayimg.text.set_size(18)
swayimg.text.set_foreground(0xfffefefe) -- #fefefeff
swayimg.text.set_background(0xcc282828) -- #282828cc
swayimg.text.set_shadow(0xff333333) -- #333333ff

-- ========================================================================
-- Image List Configuration
-- ========================================================================
swayimg.imagelist.set_order("alpha")
swayimg.viewer.enable_loop(true)
swayimg.imagelist.enable_recursive(false)
swayimg.imagelist.enable_adjacent(true) -- 'all = yes' equivalent

-- ========================================================================
-- Viewer Mode Configuration
-- ========================================================================
swayimg.viewer.set_window_background(0x00000000) -- #00000000
swayimg.viewer.set_image_chessboard(20, 0xff333333, 0xff4c4c4c) -- transparency = grid
swayimg.viewer.set_default_scale("optimal")
swayimg.viewer.set_default_position("center")
swayimg.viewer.enable_centering(true) -- fixed = yes
swayimg.slideshow.set_timeout(3)
swayimg.viewer.limit_history(1)
swayimg.viewer.limit_preload(1)

-- Viewer Info Text
swayimg.viewer.set_text("topleft", {
	"{name}",
	"{format}",
	"{sizehr}",
	"{frame.width}x{frame.height}",
	"{meta.Exif.Image.Model}",
})
swayimg.viewer.set_text("topright", { "{list.index} of {list.total}" })
swayimg.viewer.set_text("bottomleft", { "Scale: {scale}", "Frame: {frame.index}" })
swayimg.viewer.set_text("bottomright", {})

-- ========================================================================
-- Gallery Mode Configuration
-- ========================================================================
swayimg.gallery.set_thumb_size(450)
swayimg.gallery.limit_cache(100)
swayimg.gallery.set_aspect("keep") -- fill = no / aspect = keep
swayimg.gallery.set_window_color(0x00000000) -- #00000000
swayimg.gallery.set_unselected_color(0xff202020) -- #202020ff
swayimg.gallery.set_selected_color(0x00333333) -- #33333300
swayimg.gallery.set_border_color(0xffab4642) -- #ab4642ff
swayimg.gallery.set_selected_scale(1.0)

-- Gallery Info Text
swayimg.gallery.set_text("topleft", {})
swayimg.gallery.set_text("topright", {})
swayimg.gallery.set_text("bottomleft", {})
swayimg.gallery.set_text("bottomright", { "{name}" })

-- ========================================================================
-- Key Bindings (Viewer)
-- ========================================================================
-- Note: Lua uses specific callback functions for actions rather than direct strings.

swayimg.viewer.on_key("h", function()
	swayimg.viewer.switch_image("prev")
end)
swayimg.viewer.on_key("l", function()
	swayimg.viewer.switch_image("next")
end)

-- Custom zoom mapped to j and k
swayimg.viewer.on_key("j", function()
	local scale = swayimg.viewer.get_scale()
	local pos = swayimg.viewer.get_position()
	swayimg.viewer.set_abs_scale(scale - 0.1, pos.x, pos.y) -- Zoom out ~10%
end)

swayimg.viewer.on_key("k", function()
	local scale = swayimg.viewer.get_scale()
	local pos = swayimg.viewer.get_position()
	swayimg.viewer.set_abs_scale(scale + 0.1, pos.x, pos.y) -- Zoom in ~10%
end)

-- Shift+Delete mapping to move file to trash
swayimg.viewer.on_key("Shift-Delete", function()
	local image = swayimg.viewer.get_image()
	os.execute("gio trash --force '" .. image.path .. "'")
	swayimg.viewer.switch_image("next")
	swayimg.text.set_status("Moved to trash: " .. image.path)
end)

swayimg.viewer.on_key("q", function()
	os.exit()
end)

-- ========================================================================
-- Key Bindings (Gallery)
-- ========================================================================
swayimg.gallery.on_key("h", function()
	swayimg.gallery.switch_image("left")
end)
swayimg.gallery.on_key("j", function()
	swayimg.gallery.switch_image("down")
end)
swayimg.gallery.on_key("k", function()
	swayimg.gallery.switch_image("up")
end)
swayimg.gallery.on_key("l", function()
	swayimg.gallery.switch_image("right")
end)

swayimg.gallery.on_key("Ctrl-Down", function()
	swayimg.gallery.switch_image("down")
	swayimg.gallery.switch_image("down")
end)

swayimg.gallery.on_key("Ctrl-Up", function()
	swayimg.gallery.switch_image("up")
	swayimg.gallery.switch_image("up")
end)

swayimg.gallery.on_key("Shift-Delete", function()
	local image = swayimg.gallery.get_image()
	os.execute("gio trash --force '" .. image.path .. "'")
	swayimg.text.set_status("Moved to trash: " .. image.path)
end)

swayimg.gallery.on_key("q", function()
	os.exit()
end)
