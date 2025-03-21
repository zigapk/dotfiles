BAR_HEIGHT=40
TRANSPARENT=0x00000000
BG_ITEM=0x66222222
BLUR_RADIUS=8
ITEM_HEIGHT=28
CORNER_RADIUS=100
PADDING_X=10
FONT_SIZE=14
Y_OFFSET=-2
FONT_FACE="JetBrainsMono Nerd Font"

# Transparent bg
sketchybar --bar \
  color=${TRANSPARENT} \
  height=${BAR_HEIGHT} \
  y_offset=${Y_OFFSET}

# Add spaces
sketchybar --add event aerospace_workspace_change
sketchybar --add item spaces left \
  --subscribe spaces aerospace_workspace_change \
  --set spaces \
  background.height=${ITEM_HEIGHT} \
  background.color=${BG_ITEM} \
  background.corner_radius=${CORNER_RADIUS} \
  background.y_offset=${Y_OFFSET} \
  label.padding_left=${PADDING_X} \
  label.padding_right=${PADDING_X} \
  blur_radius=${BLUR_RADIUS} \
  label.font.size=${FONT_SIZE} \
  label.font.family="${FONT_FACE}" \
  label="🦄" \
  script="sketchybar --set spaces label=\"🦄 \${FOCUSED_WORKSPACE}\""

# Add weather
sketchybar --add item weather right
sketchybar \
  --subscribe weather system_woke \
  --set weather \
  background.height=${ITEM_HEIGHT} \
  background.color=${BG_ITEM} \
  background.corner_radius=${CORNER_RADIUS} \
  background.y_offset=${Y_OFFSET} \
  label.padding_left=${PADDING_X} \
  label.padding_right=${PADDING_X} \
  blur_radius=${BLUR_RADIUS} \
  label.font.size=${FONT_SIZE} \
  label.font.family="${FONT_FACE}" \
  update_freq=180 \
  label="❔" \
  script="sketchybar --set weather label=\"\$(curl -s 'wttr.in/Ljubljana?format=%C|%t' | awk -F'|' '{ cond=\$1; temp=\$2; sub(/^\+/, \"\", temp); \
    if(cond ~ /Clear|Sunny/) { emoji=\"☀️\" } \
    else if(cond ~ /Partly/) { emoji=\"⛅\" } \
    else if(cond ~ /Cloud/) { emoji=\"☁️\" } \
    else if(cond ~ /Drizzle/) { emoji=\"🌦️\" } \
    else if(cond ~ /Rain/) { emoji=\"🌧️\" } \
    else if(cond ~ /Thunder/) { emoji=\"⛈️\" } \
    else if(cond ~ /Snow/) { emoji=\"❄️\" } \
    else if(cond ~ /Sleet/) { emoji=\"🌨️\" } \
    else if(cond ~ /Mist|Fog|Haze/) { emoji=\"😶‍🌫️\" } \
    else if(cond ~ /Smoke/) { emoji=\"💨\" } \
    else if(cond ~ /Dust|Sand/) { emoji=\"🌪️\" } \
    else if(cond ~ /Squall/) { emoji=\"🌬️\" } \
    else if(cond ~ /Tornado/) { emoji=\"🌪️\" } \
    else if(cond ~ /Light drizzle/) { emoji=\"🌂\" } \
    else { emoji=\"🌈\" }; \
    print emoji\" \"temp }')\""

# Add clock
sketchybar --add item clock right
sketchybar --set clock \
  background.height=${ITEM_HEIGHT} \
  background.color=${BG_ITEM} \
  background.corner_radius=${CORNER_RADIUS} \
  background.y_offset=${Y_OFFSET} \
  label.padding_left=${PADDING_X} \
  label.padding_right=${PADDING_X} \
  blur_radius=${BLUR_RADIUS} \
  label.font.size=${FONT_SIZE} \
  label.font.family="${FONT_FACE}" \
  background.padding_right=${PADDING_X} \
  label="⏰" \
  update_freq=5 \
  script="sketchybar --set clock label=\"\$(date +'%H:%M')\""

# TODO: partly cloudy

# Add battery with integrated plugin logic
sketchybar --add item battery right \
  --subscribe battery power_source_change \
  --set battery \
  background.padding_right=${PADDING_X} \
  background.height=${ITEM_HEIGHT} \
  background.color=${BG_ITEM} \
  background.corner_radius=${CORNER_RADIUS} \
  background.y_offset=${Y_OFFSET} \
  label.padding_left=${PADDING_X} \
  label.padding_right=${PADDING_X} \
  blur_radius=${BLUR_RADIUS} \
  label.font.size=${FONT_SIZE} \
  label.font.family="${FONT_FACE}" \
  icon.font.family="${FONT_FACE}" \
  icon.padding_left=${PADDING_X} \
  update_freq=60 \
  script="\
PERCENTAGE=\$(pmset -g batt | grep -Eo '\d+%' | cut -d% -f1); \
CHARGING=\$(pmset -g batt | grep 'AC Power'); \
if [ \"\${PERCENTAGE}\" = \"\" ]; then exit 0; fi; \
case \${PERCENTAGE} in \
  [8-9][0-9] | 100) ICON=''; ICON_COLOR=0xffa6da95 ;; \
  7[0-9]) ICON=''; ICON_COLOR=0xffeed49f ;; \
  [4-6][0-9]) ICON=''; ICON_COLOR=0xfff5a97f ;; \
  [1-3][0-9]) ICON=''; ICON_COLOR=0xffee99a0 ;; \
  [0-9]) ICON=''; ICON_COLOR=0xffed8796 ;; \
esac; \
if [ \"\${CHARGING}\" != \"\" ]; then \
  ICON=''; ICON_COLOR=0xffeed49f; \
fi; \
sketchybar --set battery icon=\${ICON} label=\"\${PERCENTAGE}%\" icon.color=\${ICON_COLOR}\
"

sketchybar --update
