#!/bin/bash

killall conky bar

conky -c ~/.config/bspwm/panel/conkyrc | ~/.config/bspwm/panel/bar.sh
