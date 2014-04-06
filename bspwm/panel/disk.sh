#!/bin/sh

__=`df -h --output=pcent / | tail -n1 | cut -c2- | sed 's/%//'`
echo $__
