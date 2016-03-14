#!/bin/bash

CLIENT_ID="FREE_TRIAL_ACCOUNT"
CLIENT_SECRET="PUBLIC_SECRET"

read -r -d '' jsonPayload << _EOM_
  {
    "number": "5511$2",
    "message": "$1"
  }
_EOM_

curl -X POST \
     -H "X-WM-CLIENT-ID: $CLIENT_ID" \
     -H "X-WM-CLIENT-SECRET: $CLIENT_SECRET" \
     -H "Content-Type: application/json" \
     -d "$jsonPayload"   \
     http://api.whatsmate.net/v1/whatsapp/queue/message