#! /usr/bin/env bash

# Installs fossil via package manager

if [ "$RUNNER_OS" == "Linux" ]; then
  sudo apt-get update
  sudo apt-get install fossil
elif [ "$RUNNER_OS" == "macOS" ]; then
  brew update
  brew install fossil
elif [ "$RUNNER_OS" == "Windows" ]; then
  choco install fossil
else
  echo "Unsupported OS $RUNNER_OS"
  exit 1
fi
