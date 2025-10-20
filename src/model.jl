#include("graph.jl")

using JuMP
using Gurobi
using DataStructures

function STDFormulation(g::myGraph, k::Int)
    md = Model(Gurobi.Optimizer) 		

    #variables
    @variable(md, x[v=1:g.n, i=1:k] , Bin)
    @variable(md, y[v=1:g.n, u=(v+1):g.n; has_edge(g,v,u)] , Bin)
    
    for v in 1:g.n
    	con = @constraint(md, sum(x[v,i] for i=1:k) >= 1)
        set_name(con, "VERTEX =$v MUST HAVE A GROUP")
    end
    
    for v in 1:g.n
    	for u in (v+1):g.n
    		if has_edge_plus(g,v,u)
    			for i in 1:k
	    			con = @constraint(md, x[v,i] + x[u,i] <= y[v,u] + 1)
				set_name(con, "POSITIVE EDGE CONST ($v,$u)")
			end    		
    		end
    	end
    end
    
    
    for v in 1:g.n
    	for u in (v+1):g.n
    		if has_edge_minus(g,v,u)
    			for i in 1:k
	    			con = @constraint(md, x[v,i] >= x[u,i] - y[v,u])
				set_name(con, "NEGATIVE EDGE CONST ($v,$u) vs1")
				con = @constraint(md, x[u,i] >= x[v,i] - y[v,u])
				set_name(con, "NEGATIVE EDGE CONST ($v,$u) vs2")
				end    		
    		end
    	end
    end

   @objective(md, Min, sum(y[v,u] for v=1:g.n, u=(v+1):g.n if has_edge(g,v,u) ) )

    return (md, x, y)
end



