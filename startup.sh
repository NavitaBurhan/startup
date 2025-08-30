#!/bin/bash

# Warna ANSI
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
MAGENTA='\033[0;35m'
CYAN='\033[0;36m'
WHITE='\033[1;37m'
RESET='\033[0m'

line() {
  echo -e "${MAGENTA}=========================================${RESET}"
}

clear
line
echo -e "${CYAN}🚀 SkyNest SA-MP${RESET}"
line
echo -e "${YELLOW}🌐 OS           :${RESET} ${GREEN}$SERVER_OS${RESET}"
echo -e "${YELLOW}📡 Port         :${RESET} ${GREEN}$SERVER_PORT${RESET}"
echo -e "${YELLOW}👥 Max Players  :${RESET} ${GREEN}$MAX_PLAYERS${RESET}"
line

if [ "$SERVER_OS" = "linux" ]; then
    echo -e "${BLUE}🐧 Menjalankan SA-MP Linux server...${RESET}"
    exec ./samp03svr
elif [ "$SERVER_OS" = "windows" ]; then
    echo -e "${MAGENTA}🪟 Menjalankan SA-MP Windows server (Wine)...${RESET}"
    exec wine64 ./samp-server.exe
else
    echo -e "${RED}❌ ERROR: SERVER_OS tidak valid (harus 'linux' atau 'windows')${RESET}"
    exit 1
fi
