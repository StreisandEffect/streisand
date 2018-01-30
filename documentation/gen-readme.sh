#!/bin/bash

# Exit on errors
set -e

LANG_SUFFIX=".md -chs.md -fr.md -ru.md"
FRAGMENT_ORDER="header intro more-features services install reqs install credits"

for suffix in $LANG_SUFFIX; do
    output="./README${suffix}"
    rm -f "${output}"
    for fragment in $FRAGMENT_ORDER; do
	cat "README-${fragment}${suffix}" >> "${output}"
	echo >> "${output}"
    done
done


