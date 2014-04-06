#!/bin/sh

conky -c ~/.config/bspwm/panel/conkyrc | bar -g 1920x15+0 -p -B "#fff1b1d1e" -F "#fff8f8f8f" -f "-*-terminus-medium-r-normal--12-120-72-72-c-60-iso8859-1" | sh
