#!/bin/bash

form_=edge1
method_=mip 

for n in 60
do
    for k in 5 #2 3 4 5 
    do
        for pos in 30
        do
            for neg in 5
            do
                for err in 5 10 20
                do
                    for id in 1 2 3 4 5
                    do
                        julia edge_signed.jl --inst data/kmbs/RANDOM/random_n${n}_k${k}_pos${pos}_neg${neg}_err${err}_${id}.g --form ${form_} --numbk ${k} --method ${method_} >> /home/jossian/Downloads/develop/report/signed_graphs/out_${method}_f${form_}_random_n${n}_k${k}_pos${pos}_neg${neg}_err${err}_${id}.txt
                    done
                done
            done
        done
        mv saida.txt result/${method_}_random_n${n}_k${k}_f${form_}.txt
    done
done
