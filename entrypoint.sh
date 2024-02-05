#!/bin/bash

# Check if /home/pwserver/serverfiles is empty, copy the contents of /home/pwserver/serverfiles-backup
if [ -z "$(ls -A /home/pwserver/serverfiles)" ]; then
    cp -R /home/pwserver/serverfiles-backup/* /home/pwserver/serverfiles
fi

# Start the application
/home/pwserver/pwserver start

# Keep the container running
tail -f /dev/null
