#!/bin/bash

# See https://linuxsimply.com/bash-scripting-tutorial/basics/examples/send-email/
# for how to configure your mail client to use Gmail.

command -v mailx >/dev/null || { logger -i -s -p user.err "mailx executable not found" && exit 1; }

recipient="goussasalexander@gmail.com"
subject="Stay hydrated"
body="Remember to drink water!"

logger -i -s -p user.info "Sending email to: $recipient"

echo -E "$body" | mailx -s "$subject" "$recipient"
