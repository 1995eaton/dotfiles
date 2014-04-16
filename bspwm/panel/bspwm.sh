#!/bin/sh
echo -n " $(bspc query -D | sed ':a;N;$!ba;s/\n/  /g')" | sed "s/ \?\(`bspc query -D -d`\) \?/%{R} \1 %{R}/g" | sed 's/$/ /' | sed 's/} $/}/'
