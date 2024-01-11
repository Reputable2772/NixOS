#!/usr/bin/env bash

flameshot gui --raw | tesseract stdin stdout | wl-copy
