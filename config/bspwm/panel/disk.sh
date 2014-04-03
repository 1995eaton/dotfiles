#!/bin/sh

df -h --output=pcent / | tail -n1 | cut -c2-
