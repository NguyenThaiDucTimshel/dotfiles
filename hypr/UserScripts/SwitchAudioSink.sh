#!/bin/bash

# Lấy danh sách ID của các audio sink đang hoạt động
sinks=($(pactl list short sinks | awk '{print $1}'))
sink_count=${#sinks[@]}

if [ "$sink_count" -le 1 ]; then
    notify-send "Audio Sink" "Chỉ có 1 thiết bị đầu ra, không cần chuyển đổi."
    exit 0
fi

# Tìm tên sink đang được dùng làm mặc định
current_sink=$(pactl info | grep "Default Sink" | awk '{print $3}')

# Tìm vị trí (index) của sink hiện tại trong mảng
current_index=-1
for i in "${!sinks[@]}"; do
    sink_name=$(pactl list short sinks | grep "^${sinks[$i]}" | awk '{print $2}')
    if [[ "$sink_name" == "$current_sink" ]]; then
        current_index=$i
        break
    fi
done

# Tính toán index của sink tiếp theo (xoay vòng)
next_index=$(( (current_index + 1) % sink_count ))
next_sink_id=${sinks[$next_index]}

# Đổi sink mặc định sang thiết bị mới
pactl set-default-sink "$next_sink_id"

# Chuyển tất cả các ứng dụng đang phát âm thanh sang sink mới
pactl list short sink-inputs | awk '{print $1}' | while read -r input; do
    pactl move-sink-input "$input" "$next_sink_id" 2>/dev/null
done

# Lấy tên hiển thị của thiết bị mới để gửi thông báo
next_sink_desc=$(pactl list sinks | grep -A 15 "Sink #${next_sink_id}" | grep "Description:" | head -n 1 | sed 's/^[ \t]*Description: //')

notify-send -t 2000 "🔊 Audio Output Switched" "$next_sink_desc"
