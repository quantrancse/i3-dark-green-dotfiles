#!/usr/bin/env sh

## Add this to your wm startup file.

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Launch bar1 and bar2
# polybar -c ~/.config/polybar/config.ini main &


if type "xrandr"; then
  HDMI=$(xrandr --query | grep " connected" | cut -d" " -f1 | grep HDMI)
  eDP=$(xrandr --query | grep " connected" | cut -d" " -f1 | grep eDP)
  if [[ $HDMI != "" ]]; then
    xrandr --output $HDMI --mode 1920x1080 --rate 120.00 --right-of $eDP
    MONITOR=$HDMI polybar -c ~/.config/polybar/config.ini main &
  else
    xrandr --output HDMI-2 --off --output $eDP --auto
    MONITOR=$eDP polybar -c ~/.config/polybar/config.ini main &
  fi
else
  polybar -c ~/.config/polybar/config.ini main &
fi
