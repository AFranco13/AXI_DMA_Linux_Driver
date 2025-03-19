#!/usr/bin/env bash
python3 -m http.server -b 172.17.0.1 8000 & server_pid=$!
echo ${server_pid}
