-- Auto-start config
-- if you dont use UWSM add your auto start programs here, otherwise use XDG autostart https://wiki.archlinux.org/title/XDG_Autostart

hl.on("hyprland.start", function()
    hl.exec_cmd("dbus-update-activation-environment --systemd --all")
    hl.exec_cmd("noctalia")
    hl.exec_cmd("xhost +SI:localuser:root")
    hl.exec_cmd("fcitx5 &")
    hl.exec_cmd("tixati &")
    hl.exec_cmd("udiskie --tray &")
    hl.exec_cmd("xdman-beta &")
end)

hl.exec_cmd("gsettings set org.gnome.desktop.interface cursor-theme catppuccin-frappe-red-cursors")
