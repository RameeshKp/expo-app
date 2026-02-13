#!/bin/bash

echo "Running eas-pre-install hook for profile: $EAS_BUILD_PROFILE"

if [ "$EAS_BUILD_PROFILE" == "production" ]; then
  if [ -n "$PLAY_STORE_KEYSTORE_BASE64" ]; then
    echo "Injecting Play Store keystore..."
    echo "$PLAY_STORE_KEYSTORE_BASE64" | base64 --decode > play-store.jks
    echo "$PLAY_STORE_CREDENTIALS_JSON" > credentials.json
  else
    echo "Warning: PLAY_STORE_KEYSTORE_BASE64 not found"
  fi
elif [ "$EAS_BUILD_PROFILE" == "solana" ]; then
  if [ -n "$SOLANA_KEYSTORE_BASE64" ]; then
    echo "Injecting Solana keystore..."
    echo "$SOLANA_KEYSTORE_BASE64" | base64 --decode > solana.jks
    echo "$SOLANA_CREDENTIALS_JSON" > credentials.json
  else
    echo "Warning: SOLANA_KEYSTORE_BASE64 not found"
  fi
else
  echo "No keystore injection needed for profile: $EAS_BUILD_PROFILE"
fi
