#!/bin/bash

echo "Starting SA-MP server with OS: $SERVER_OS"

if [ "$SERVER_OS" = "linux" ]; then
    echo "Running Linux binary: ./samp03svr"
    ./samp03svr
elif [ "$SERVER_OS" = "windows" ]; then
    echo "Running Windows binary with Wine: samp-server.exe"
    wine64 ./samp-server.exe
else
    echo "ERROR: SERVER_OS tidak valid (harus linux atau windows)"
    exit 1
fi
