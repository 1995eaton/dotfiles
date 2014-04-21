#!/bin/sh
echo -ne "\ue045 $(bspc query -D | sed ':a;N;$!ba;s/\n/  /g')" | sed "s/\s\+\?\(\w\+\)\b/%{A:bspc desktop -f \1:} \1 %{A}/g" | \
  sed "s/} \(`bspc query -D -d`\) %/}%{R} \1 %{R}%{/"
