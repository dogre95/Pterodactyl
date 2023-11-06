#!/bin/bash
echo "...Starting Server..."
./server/TrackmaniaServer /title=Trackmania /game_Settings=Matchsettings/tracklist.txt /dedicated_cfg=dedicated_cfg.txt /nodaemon &

cd EvoSC

# Start EvoSC as soon as the Server is listening
while true; do
    if ss -tuln | grep ":$RPC_PORT " >/dev/null; then
        echo -e "\e[92m\e[1mServer is listening on port $RPC_PORT. Attempting to start EvoSC."
        php esc run --no-logo &
        break
    fi
done

while [[ $INPUT != "!stop" ]]; do
    eval $INPUT
    read INPUT
done

pid=$(pgrep -f ./server/TrackmaniaServer)
kill $pid

echo "...Server stopped..."