#!/bin/bash

# 🎨 Warna ANSI
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
MAGENTA='\033[0;35m'
CYAN='\033[0;36m'
WHITE='\033[1;37m'
RESET='\033[0m'
BOLD='\033[1m'

# Garis gradien elegan
line() {
  echo -e "${MAGENTA}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}"
}

# Efek progress bar
progress() {
  local duration=${1:-5}
  local interval=0.1
  local steps=$((duration / interval))
  echo -ne "${CYAN}⚡ Starting up:${RESET} "
  for ((i=0; i<steps; i++)); do
    local percent=$(( (i * 100) / steps ))
    local filled=$((percent / 4))
    local empty=$((25 - filled))
    printf "\r${CYAN}⚡ Starting up:${RESET} [${GREEN}%0.s█${RESET}" $(seq 1 $filled)
    printf "%0.s░" $(seq 1 $empty)
    printf "] ${YELLOW}%d%%${RESET}" "$percent"
    sleep $interval
  done
  echo -e "\r${GREEN}✅ Startup selesai!                        ${RESET}"
}

clear
line
echo -e "${BOLD}${CYAN}🚀 SkyNest SA-MP MultiOS - Startup${RESET}"
line
echo -e "${YELLOW}🌐 OS Pilihan   :${RESET} ${GREEN}$SERVER_OS${RESET}"
echo -e "${YELLOW}📡 Port         :${RESET} ${GREEN}$SERVER_PORT${RESET}"
echo -e "${YELLOW}👥 Max Players  :${RESET} ${GREEN}$MAX_PLAYERS${RESET}"
line

# Progress loading biar keren
progress 3
echo ""
sleep 1

# Ganti working dir ke /mnt/server
cd /mnt/server || { echo -e "${RED}❌ Gagal masuk ke /mnt/server${RESET}"; exit 1; }

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
