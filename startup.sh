#!/bin/bash
# SkyNest SA-MP MultiOS Startup (Neon Blue)

# 🎨 Warna (tema biru neon)
NEON='\033[1;96m'   # cyan terang / biru neon
BLUE='\033[0;34m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
RESET='\033[0m'
BOLD='\033[1m'

# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
line() { echo -e "${NEON}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}"; }

# Repeat char tanpa 'seq' (lebih kompatibel)
repeat_char() {
  # $1 = jumlah, $2 = char
  local n="$1" ch="$2" out=""
  printf -v out '%*s' "$n" ""
  echo -n "${out// /$ch}"
}

# ✅ Progress bar HALUS & AMAN (tanpa aritmetika float di bash)
# usage: progress <durasi_detik> [lebar_bar]
progress() {
  local seconds="${1:-5}"
  local width="${2:-30}"
  local steps=100

  # hitung interval via awk (kalau awk ga ada, fallback ke 0.05s)
  local interval
  interval=$(awk -v d="$seconds" 'BEGIN{ if (d<=0) d=5; printf "%.4f", d/100 }' 2>/dev/null)
  [ -z "$interval" ] && interval="0.05"

  for ((i=0; i<=steps; i++)); do
    local filled=$(( i * width / steps ))
    local empty=$(( width - filled ))

    # build bar efisien, tanpa seq
    printf "\r${NEON}⚡ Starting up:${RESET} [${NEON}"
    repeat_char "$filled" "█"
    echo -n "${RESET}"
    repeat_char "$empty" "░"
    printf "] ${YELLOW}%3d%%%s" "$i" "${RESET}"

    sleep "$interval"
  done
  echo -e "\n${GREEN}✅ Startup selesai!${RESET}"
}

# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# MAIN
clear
line
echo -e "${BOLD}${NEON}🚀 SkyNest SA-MP MultiOS - Startup${RESET}"
line
echo -e "${YELLOW}🌐 OS Pilihan   :${RESET} ${NEON}${SERVER_OS:-unknown}${RESET}"
echo -e "${YELLOW}📡 Port         :${RESET} ${NEON}${SERVER_PORT:-7777}${RESET}"
echo -e "${YELLOW}👥 Max Players  :${RESET} ${NEON}${MAX_PLAYERS:-100}${RESET}"
line

# Progress loading (atur durasi & lebar bar di sini)
progress 6 34
echo ""
sleep 0.5

# Jalankan server sesuai OS
case "$SERVER_OS" in
  linux|Linux)
    echo -e "${BLUE}🐧 Menjalankan SA-MP Linux server...${RESET}"
    exec ./samp03svr
    ;;
  windows|Windows)
    echo -e "${NEON}🪟 Menjalankan SA-MP Windows server (Wine)...${RESET}"
    exec wine64 ./samp-server.exe
    ;;
  *)
    echo -e "${RED}❌ ERROR: SERVER_OS tidak valid (harus 'linux' atau 'windows')${RESET}"
    exit 1
    ;;
esac  
  echo -e "\n${GREEN}✅ Startup selesai!${RESET}"
}

# ============================
# Main Startup
# ============================
clear
line
echo -e "${BOLD}${CYAN}🚀 SkyNest SA-MP 🚀${RESET}"
line
echo -e "${YELLOW}🌐 OS Pilihan   :${RESET} ${GREEN}$SERVER_OS${RESET}"
echo -e "${YELLOW}📡 Port         :${RESET} ${GREEN}$SERVER_PORT${RESET}"
echo -e "${YELLOW}👥 Max Players  :${RESET} ${GREEN}$MAX_PLAYERS${RESET}"
line

# Progress loading
progress 5
echo ""
sleep 1

# Jalankan server sesuai OS
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
