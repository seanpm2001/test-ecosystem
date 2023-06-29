#!/usr/bin/env bash

# Installs mercurial via PIP
#
# Prerequisites:
# - Python

set -eu -o pipefail

python -m pip install --upgrade pip
pip install mercurial
