push!(LOAD_PATH, "src/")
# push!(DEPOT_PATH, JULIA_DEPOT_PATH)

#using Pkg
#Pkg.activate(".")
#Pkg.instantiate()
#Pkg.build()

using JuMP
using Gurobi
using CPLEX
using Graphs, SimpleWeightedGraphs
using GraphPlot
using SCIP

import data
import parameters
import edgeFormulation

params = parameters.readParameters(ARGS)

#julia edge_signed.jl --inst instancia --form ${form} 

# read instance data
inst = data.readData(params.instName, params)

if (params.form == "edge1")
    edgeFormulation.edgeForm1(inst,params)
elseif (params.form == "edge2")
    edgeFormulation.edgeForm2(inst,params)
elseif (params.form == "edge3")
    edgeFormulation.edgeForm3(inst,params)
end
