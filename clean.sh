#!/bin/bash

rm -f *.sym *.rel *.noi *.map *.lst *.lk *.ihx *.asm *.rst

cd obj
rm -f *.sym *.rel *.noi *.map *.lst *.lk *.ihx *.asm *.rst
cd ..

rm -f screen1.ras raster.rst shmup.dsk main.log main.bin
