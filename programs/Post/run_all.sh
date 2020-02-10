#!/bin/bash
for file in $(ls [0-9]*.do )
do
   stata14 -b do $file
done

for file in $(ls [0-9]*.R)
do
   progname=$(basename $file .R)
   Rscript $file > ${progname}.log 2>&1
done

