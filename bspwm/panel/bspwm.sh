#!/bin/sh
echo -ne "%{B#fff333333}"$(echo -ne "$(bspc query -D | sed ':a;N;$!ba;s/\n/  /g')" | sed "s/\s\+\?\(\w\+\)\b/%{A:bspc desktop -f \1:} \1 %{A}/g" | \
  sed "s/} \(`bspc query -D -d`\) %/}%{R} \1 %{R}%{/")"%{B#fff1b1d1e}"

# echo -ne "\ue045 $(bspc query -D | sed ':a;N;$!ba;s/\n/  /g')" | sed "s/\s\+\?\(\w\+\)\b/%{A:bspc desktop -f \1:} \1 %{A}/g" | \
#   sed "s/} \(`bspc query -D -d`\) %/}%{R} \1 %{R}%{/"
