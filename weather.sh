#!/bin/bash

# Set coordinates (Colombo, Sri Lanka as example)
# LAT=6.9271
# LON=79.8612

# Get location automatically from IP
LOC=$(curl -s http://ip-api.com/json)
LAT=$(echo "$LOC" | jq -r '.lat')
LON=$(echo "$LOC" | jq -r '.lon')
CITY=$(echo "$LOC" | jq -r '.city')
COUNTRY=$(echo "$LOC" | jq -r '.country')

# API URL
URL="https://api.open-meteo.com/v1/forecast?latitude=$LAT&longitude=$LON&current=temperature_2m,relative_humidity_2m,wind_speed_10m&timezone=auto"

# Variables to store weather data
TEMP=""
HUMIDITY=""
WIND=""

# Function to fetch weather
fetch_weather() {
    RESPONSE=$(curl -s "$URL")
    TEMP=$(echo "$RESPONSE" | jq -r '.current.temperature_2m')
    HUMIDITY=$(echo "$RESPONSE" | jq -r '.current.relative_humidity_2m')
    WIND=$(echo "$RESPONSE" | jq -r '.current.wind_speed_10m')
}

# Initial fetch
fetch_weather
LAST_FETCH=$(date +%s)

while true; do
    clear

    # Current time
    TIME=$(date +"%Y-%m-%d %H:%M:%S")

    # Check if 5 minutes passed (300 seconds)
    NOW=$(date +%s)
    if (( NOW - LAST_FETCH >= 300 )); then
        fetch_weather
        LAST_FETCH=$NOW
    fi

    # Display weather info
    echo "🌍 Location    : $CITY, $COUNTRY"
    echo "🌤️  Current Weather"
    echo "--------------------------------------"
    echo "⏰ Time       : $TIME"
    echo "🌡️ Temperature: $TEMP °C"
    echo "💧 Humidity   : $HUMIDITY %"
    echo "🌬️ Wind Speed : $WIND km/h"
    echo "--------------------------------------"
    # echo "🔄 Updates every 5 min (time refresh every sec)"

    sleep 1
done

