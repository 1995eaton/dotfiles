#!/bin/sh

for i in `pip list | sed -e 's/(.*)//'`; do sudo pip install --upgrade $i; done
