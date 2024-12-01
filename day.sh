#!/usr/bin/env bash

cd $1
echo "Day $1:"
echo


if [ -f sol.py ]; then
	echo 'python sol:'
	time python3 sol.py
fi

echo

if [ -f sol.hs ]; then
	echo 'haskell sol:'
	time runhaskell sol.hs
fi

echo
