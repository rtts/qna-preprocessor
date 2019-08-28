#!/bin/bash

# Expects a video stream on standard input, writes images to the
# current directory and outputs an audio stream

FRAMERATE=1
IMAGE=image.jpg
touch $IMAGE

(
    inotifywait -q -m -e close_write $IMAGE | while read event
    do
        >&2 echo -n "."
    done
) &

ffmpeg -y -hide_banner -loglevel panic \
       -re -i - \
       -r $FRAMERATE -f image2 -update 1 $IMAGE \
       -f wav -

rm $IMAGE
