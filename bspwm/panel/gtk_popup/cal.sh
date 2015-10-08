#!/bin/sh

CALENDER=$(cal --color=always | head -n-1 | sed 's/\s\+$//g')
echo -n "$CALENDER" | sed 's/[^m]\+m\([^]\+\)[^m]\+m/<span font_weight="bold" color="#f92672">\1<\/span>/'
