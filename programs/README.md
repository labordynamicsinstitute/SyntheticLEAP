# Programs

These programs can simply be run in numeric sequence. Programs without prepended numbers should be ignored.

For Linux, the following will run the programs in the correct sequence:

```
for file in $(ls 0*do 1*do)
do
   stata -b do $file
done
```

For convenience, a file `run_all.sh` has been provided.
