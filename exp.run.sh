#!/bin/bash

echo "experiment,type,threads,chunk,size,padding,time" > "output.csv"

for schedule_type in 0 2 1; do
    for chunk_size in 0 1 64 1024 2048; do
        gcc -Wall rand.c -o rand -fopenmp -DCHUNKSIZE=$chunk_size -DPADDING=0
        for threads in 1 4 8 14 16 20 24 32 48 64 96 128 256; do
            echo "run for" $chunk_size "chunk size and" $threads "threads"
            OMP_NUM_THREADS=$threads OMP_DYNAMIC=false; ./rand $1 $2 $schedule_type >> "output.csv";
        done
    done
done
