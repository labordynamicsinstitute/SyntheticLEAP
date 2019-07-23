#!/bin/bash
for file in $(ls [0-9]*.do )
do
   stata14 -b do $file
done
