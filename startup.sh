#!/bin/bash

echo "====================================="
echo "  SkyNest SA-MP MultiOS - Startup"
echo "====================================="
echo "OS Pilihan: $SERVER_OS"
echo "Port: $SERVER_PORT"
echo "Max Players: $MAX_PLAYERS"
echo "====================================="

# Ganti working dir ke /mnt/server
cd /mnt/server || exit 1

if [ "$SERVER_OS" = "linux" ]; then
    echo "Menjalankan SA-MP Linux server..."
    exec ./samp03svr
elif [ "$SERVER_OS" = "windows" ]; then
    echo "Menjalankan SA-MP Windows server (Wine)..."
    exec wine64 ./samp-server.exe
else
    echo "ERROR: SERVER_OS tidak valid (harus 'linux' atau 'windows')"
    exit 1
fi
