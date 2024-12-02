#!/usr/bin/env bash

cd $1
echo "DAY $1:"
echo


if [ -f sol.py ] && [ -x "$(command -v python3)" ]; then
	echo 'python sol:'
	time python3 sol.py
    echo
fi


if [ -f sol.hs ] && [ -x "$(command -v runhaskell)" ]; then
	echo 'haskell sol:'
	time runhaskell sol.hs
    echo
fi


if [ -f sol.pdb ] && [ -x "$(command -v swipl)" ]; then
	echo 'prolog sol:'
	time swipl -q -t main. sol.pdb
    echo
fi

