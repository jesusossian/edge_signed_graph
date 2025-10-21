#!/bin/bash

form_=edge 
inst_="data/kmbs/RANDOM/random_n20_k2_pos30_neg5_err5_1.g"
method_="mip"
k=2

julia edge_signed.jl --inst ${inst_} --form ${form_} --numbk ${k}

#mv saida.txt result/
