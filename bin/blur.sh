#!/usr/bin/env bash

# convert -blur 20 $1 
convert $1 -blur 0x9 -fill black -colorize 50% $2
