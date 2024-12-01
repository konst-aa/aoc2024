#!/usr/bin/env bash

for d in {01..24}; do
	if [ ! -d $d ]; then
		continue
	fi
	./day.sh $d
	echo
done
