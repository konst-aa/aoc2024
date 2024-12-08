#!/usr/bin/env bash

cd $1
echo "DAY $1:"
echo


if [ -f sol.py ] && [ -x "$(command -v python3)" ]; then
	echo 'python sol:'
	time python3 sol.py
    echo
fi


if [ -f sol.hs ] && [ -x "$(command -v ghc)" ]; then
	echo 'haskell sol:'
    echo compiling
    ghc -O2 sol.hs > /dev/null
    echo running
    time ./sol
	# time runhaskell sol.hs
    echo
fi


if [ -f sol.pdb ] && [ -x "$(command -v swipl)" ]; then
	echo 'prolog sol:'
	time swipl -q -t main. sol.pdb
    echo
fi

