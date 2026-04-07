#!/bin/bash

method="mip"

for form in 1
do
    for n in 60
    do
        for k in 2 3 4 5 
        do
            for pos in 30
            do
                for neg in 5
                do
                    for err in 5 10 20
                    do
                        for id in 1 2 3 4 5
                        do
                            python3 src/edge${form}_signed.py ${method} random_n${n}_k${k}_pos${pos}_neg${neg}_err${err}_${id}.g >> report/out_${method}_random_n${n}_k${k}_pos${pos}_neg${neg}_err${err}_${id}.txt
                        done
                    done
                done
            done
        done
    done
done
