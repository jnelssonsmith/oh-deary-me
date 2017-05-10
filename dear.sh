#!/bin/bash

if [ $# -eq 2 ]; then
    NOFLAG=1
    OUTFILE=$1
    INDIR=$2
elif [ $# -eq 3 ]; then
    NOFLAG=0
    FLAG=$1
    OUTFILE=$2
    INDIR=$3
else 
    echo "You gave me an incorrect number of args"
    exit 1
fi


if [ -d "${INDIR}" ]; then
    echo "Detected ${INDIR} as a directory"
else
    echo "${INDIR} is not a directory"
    exit 1
fi


if [ ${NOFLAG} -eq 0 ]; then
    case "${FLAG}" in
        -g)
            echo "g flag detected"
            ;;
        -b)
            echo "b flag detected"
            ;;
        -c)
            echo "c flag detected"
            ;;
        *)
            echo "Unsupported flag detected"
            exit 1
            ;;
    esac
else 
    echo "handling no flags"
fi
    