#!/bin/bash

KERNEL=$(uname -r)

dkms status -k "$KERNEL"                       \
  | grep -E 'WARNING|: added'                  \
  | sed 's/^\([^,]\+\), \([^,:]\+\).*/\1\/\2/' \
  | while read module; do
      dkms remove -k "$KERNEL" -m "$module"
      dkms install -k "$KERNEL" -m "$module"
    done
