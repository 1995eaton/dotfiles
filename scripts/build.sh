#!/bin/sh

$(cat $1 | grep -oP 'BUILD:.*(?<!\*\/)' | cut -c8- | head -c-3)
