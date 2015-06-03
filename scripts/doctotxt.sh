#!/bin/sh

libreoffice --headless --convert-to txt:Text "$1" &> /dev/null
  output="${1/\.[^.]*/.txt}" &&
  cat "$output" && rm "$output"
