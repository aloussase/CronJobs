#!/bin/bash

current_timestamp=$(date "+%s")
picsum_url="https://picsum.photos/seed/${current_timestamp}/200"

logger -i -s -p user.info "Downloading image from Picsum"
wget "$picsum_url" -O "$HOME/Pictures/daily.png" > /dev/null 2>&1

if [ $? -ne 0 ]; then
    logger -i -s -p user.err "Failed to download image from Picsum"
    exit 1
fi

logger -i -s -p user.info "Setting wallpaper to the newly downloaded image"
xwallpaper --zoom "$HOME/Pictures/daily.png"

# The above command will work on Linux systems running a WM on X11
