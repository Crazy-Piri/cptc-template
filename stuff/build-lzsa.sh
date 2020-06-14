#!/bin/bash

if [ $# -eq 0 ]
  then
    echo "Usage: build_lzsa filename"
    exit
fi

#FILE="${1%.*}"
FILE=$1
VAR=${FILE/./_}

/tmp/tools/bin/addhead -r $FILE $FILE.bin
/tmp/tools/bin/lzsa -f 2 -r $FILE.bin $FILE.lzsa
/tmp/tools/bin/bin2c $FILE.lzsa $VAR.c G_$VAR
 
cp $VAR.c ../src

rm $FILE.bin
rm $FILE.lzsa
rm $VAR.c
