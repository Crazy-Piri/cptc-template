#!/bin/bash

/tmp/tools/bin/rasm PlayerAndMusic.asm -o PlayerAndMusic -s -sl -sq

/tmp/tools/bin/Disark PlayerAndMusic.bin Final.asm --symbolFile PlayerAndMusic.sym --sourceProfile sdcc

mv Final.asm arkostracker2.s

#rm PlayerAndMusic.bin PlayerAndMusic.sym

zip asm *.asm

rm -f *.asm
rm -f PlayerAndMusic.sym
rm -f PlayerAndMusic.bin
