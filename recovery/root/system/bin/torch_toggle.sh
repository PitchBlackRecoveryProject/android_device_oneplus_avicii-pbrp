#!/system/bin/sh

TORCH="/tmp/torch/brightness"
TORCH0="/sys/class/leds/led:torch_0/brightness"
SW0="/sys/class/leds/led:switch_0/brightness"
TORCH1="/sys/class/leds/led:torch_1/brightness"
SW1="/sys/class/leds/led:switch_1/brightness"

mkdir -p /tmp/torch_state
echo 0 > "$TORCH"
chmod 0666 "$TORCH"

LAST_STATE="0"

while true; do
    CUR_STATE=$(cat "$TORCH" 2>/dev/null)
    if [ "$CUR_STATE" != "$LAST_STATE" ]; then
        if [ "$CUR_STATE" != "0" ] && [ -n "$CUR_STATE" ]; then
            echo 150 > "$TORCH0"
            echo 1 > "$SW0"
            echo 150 > "$TORCH1"
            echo 1 > "$SW1"
        else
            echo 0 > "$SW0"
            echo 0 > "$SW1"
            echo 0 > "$TORCH0"
            echo 0 > "$TORCH1"
        fi
        LAST_STATE="$CUR_STATE"
    fi
    sleep 0.2
done
