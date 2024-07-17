#!/usr/bin/env bash

## Author : Aditya Shakya (adi1090x)
## Github : @adi1090x
#
## Rofi   : Launcher (Modi Drun, Run, File Browser, Window)
#
## Available Styles
#
## style-1     style-2     style-3     style-4     style-5
## style-6     style-7     style-8     style-9     style-10
## style-11    style-12    style-13    style-14    style-15

export XDG_DATA_DIRS="$HOME/.nix-profile/share:$XDG_DATA_DIRS"
export PATH="$HOME/.nix-profile/bin:$HOME/.nix-profile/bin:$PATH"

dir="$HOME/.config/rofi/launchers/type-1"
theme='style-5'

## Run
rofi \
    -show window \
    -theme ${dir}/${theme}.rasi
