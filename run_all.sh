#!/bin/bash

BASE_DIR=$(pwd)

open_tab() {
  if command -v gnome-terminal &> /dev/null; then
    gnome-terminal --tab --title="$1" -- bash -c "$2; exec bash"
  elif command -v konsole &> /dev/null; then
    konsole --new-tab -p tabtitle="$1" -e bash -c "$2"
  elif command -v x-terminal-emulator &> /dev/null; then
    x-terminal-emulator -e bash -c "$2; exec bash"
  else
    echo "❌ No supported terminal emulator found"
    exit 1
  fi
}

echo "🚀 Starting all services..."

open_tab "AgenticAI Backend" "
cd $BASE_DIR/AgenticAi_Claude &&
source venv/bin/activate &&
python run.py
"

open_tab "AgenticAI Frontend" "
cd $BASE_DIR/AgenticAi_Claude/frontend &&
npm start
"

open_tab "Ecommerce Backend" "
cd $BASE_DIR/ecommerce-website &&
source venv/bin/activate &&
python run.py
"

open_tab "Ecommerce Frontend" "
cd $BASE_DIR/ecommerce-website/frontend &&
npm start
"
