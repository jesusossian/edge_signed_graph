#!/bin/bash

form_=edge1
method_="mip"
inst_="data/kmbs/RANDOM/random_n60_k3_pos30_neg5_err20_4.g"

julia edge_signed.jl --inst ${inst_} --form ${form_} --numbk ${k} --method ${method_}

