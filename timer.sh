#!/bin/bash

timer() {
  local minutes=$1

  # Colors
  local GREEN='\033[0;32m'
  local YELLOW='\033[1;33m'
  local RED='\033[0;31m'
  local NC='\033[0m' # No Color

  if [ -z "$minutes" ]; then
    echo -e "${RED}Usage: timer <minutes>${NC}"
    exit 1
  fi

  # Convert minutes to seconds properly (handles decimals)
  local seconds
  seconds=$(echo "$minutes * 60" | bc)
  seconds=${seconds%.*}  # remove decimal part

  while [ "$seconds" -gt 0 ]; do
    if [ "$seconds" -le 10 ]; then
      color=$RED
    elif [ "$seconds" -le 60 ]; then
      color=$YELLOW
    else
      color=$GREEN
    fi

    printf "\r${color}⏳ %02d:%02d remaining${NC}" $((seconds/60)) $((seconds%60))
    sleep 1
    ((seconds--))
  done

  echo -e "\n${RED}⏰ Time's up!${NC}"

  # Optional nudges
  # say "Germaine, Time's up!"
}

# Auto-run the function if called with an argument
timer "$@"
