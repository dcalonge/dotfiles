#!/bin/sh

location="${1:-}"

if [ -n "$location" ]; then
  url="https://wttr.in/${location}?format=j1"
else
  url="https://wttr.in?format=j1"
fi

weather_json=$(
  curl -fsS --max-time 3 "$url" 2>/dev/null
) || exit 1

# -----------------------------
# DAY / NIGHT DETECTION
# -----------------------------
sun_data=$(
  printf '%s\n' "$weather_json" |
    jq -er '
      [
        .weather[0].astronomy[0].sunrise,
        .weather[0].astronomy[0].sunset
      ] | @tsv
    '
) || exit 1

OLDIFS=$IFS
IFS=$(printf '\t')
set -- $sun_data
IFS=$OLDIFS

sunrise=$1
sunset=$2

now_epoch=$(date +%s)
sunrise_epoch=$(date -d "today $sunrise" +%s 2>/dev/null || echo 0)
sunset_epoch=$(date -d "today $sunset" +%s 2>/dev/null || echo 0)

if [ "$sunrise_epoch" -gt 0 ] &&
  [ "$sunset_epoch" -gt 0 ] &&
  { [ "$now_epoch" -lt "$sunrise_epoch" ] ||
    [ "$now_epoch" -ge "$sunset_epoch" ]; }; then
  night=true
else
  night=false
fi

# -----------------------------
# ICON MAP
# -----------------------------
get_icon() {
  code=$1

  case "$code" in
  113)
    [ "$night" = true ] && echo "" || echo ""
    ;;
  116)
    [ "$night" = true ] && echo "" || echo ""
    ;;
  119 | 122)
    echo ""
    ;;
  143 | 248 | 260)
    echo ""
    ;;
  176 | 263 | 353)
    [ "$night" = true ] && echo "" || echo ""
    ;;
  179 | 227 | 230 | 323 | 326 | 368)
    [ "$night" = true ] && echo "" || echo ""
    ;;
  182 | 185 | 281 | 284 | 311 | 314 | 317 | 320 | 350 | 362 | 365 | 374 | 377)
    echo ""
    ;;
  200 | 386 | 389 | 392 | 395)
    echo ""
    ;;
  266 | 293 | 296 | 299 | 302 | 305 | 308 | 356 | 359)
    echo ""
    ;;
  329 | 332 | 335 | 338 | 371)
    echo ""
    ;;
  *)
    echo ""
    ;;
  esac
}

# -----------------------------
# CURRENT CONDITIONS
# -----------------------------
weather_data=$(
  printf '%s\n' "$weather_json" |
    jq -er '
      [
        .current_condition[0].weatherCode,
        .current_condition[0].temp_C,
        .current_condition[0].FeelsLikeC,
        .current_condition[0].weatherDesc[0].value,
        .current_condition[0].humidity,
        .current_condition[0].windspeedKmph
      ]
      | @tsv
    '
) || exit 1

OLDIFS=$IFS
IFS=$(printf '\t')
set -- $weather_data
IFS=$OLDIFS

weather_code=$1
temp_c=$2
feels_like=$3
description=$4
humidity=$5
wind_kmph=$6

if [ "$night" = true ]; then
  description="$description (Night)"
fi

icon=$(get_icon "$weather_code")

# -----------------------------
# TIME (for hourly filtering)
# -----------------------------
now=$(date +%H)
now=${now#0}

# -----------------------------
# HOURLY FORECAST
# -----------------------------
hourly_forecast=$(
  printf '%s\n' "$weather_json" |
    jq -r '
      .weather[0].hourly[]
      | "\(.time)\t\(.tempC)\t\(.chanceofrain)\t\(.weatherCode)"
    ' |
    while IFS="$(printf '\t')" read -r time temp rain code; do

      hour=$((time / 100))

      if [ "$hour" -ge "$now" ]; then
        hicon=$(get_icon "$code")

        printf ' - %02d:00  %s %s°C   %s%%\n' \
          "$hour" "$hicon" "$temp" "$rain"
      fi

    done | head -n 6
)

# -----------------------------
# DAILY FORECAST
# -----------------------------
daily_forecast=$(
  printf '%s\n' "$weather_json" |
    jq -r '
      .weather[0:3][] |
      [
        .date,
        .maxtempC,
        .mintempC,
        .weatherCode
      ] | @tsv
    ' |
    while IFS="$(printf '\t')" read -r date max min code; do

      dow=$(
        date -d "$date" '+%a' 2>/dev/null ||
          gdate -d "$date" '+%a' 2>/dev/null ||
          echo ""
      )

      pretty_date=$(
        date -d "$date" '+%d %b' 2>/dev/null ||
          gdate -d "$date" '+%d %b' 2>/dev/null ||
          echo "$date"
      )

      dicon=$(get_icon "$code")

      printf ' - %s %s  %s %s°/%s°\n' \
        "$dow" "$pretty_date" "$dicon" "$max" "$min"
    done
)

# -----------------------------
# TOOLTIP
# -----------------------------
tooltip=$(printf '%s\n  Temperature: %s\n  Feels like: %s°C\n  Humidity: %s%%\n  Wind: %s km/h\n\nNext Hours:\n%s\n\nForecast:\n%s' \
  "$description" \
  "$temp_c°C" \
  "$feels_like" \
  "$humidity" \
  "$wind_kmph" \
  "$hourly_forecast" \
  "$daily_forecast")

tooltip_json=$(printf '%s' "$tooltip" | jq -Rs .)

# -----------------------------
# WAYBAR OUTPUT
# -----------------------------
printf '{"text":"%s %s°C","tooltip":%s}\n' \
  "$icon" "$temp_c" "$tooltip_json"
