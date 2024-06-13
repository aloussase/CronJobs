#!/bin/bash

# See https://linuxsimply.com/bash-scripting-tutorial/basics/examples/send-email/
# for how to configure your mail client to use Gmail.

subject="Daily Quotes"
recipient="goussasalexander@gmail.com"

payload="$(curl https://api.breakingbadquotes.xyz/v1/quotes 2>/dev/null)"
quote="$(echo "$payload" | jq .[0].quote | tr -d "\"")"
author="$(echo "$payload" | jq .[0].author | tr -d "\"")"
body="$quote\n\nSaid $author calmly"

echo -e "$body" | mailx -s "$subject" "$recipient"
