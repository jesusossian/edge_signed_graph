
mutable struct myGraph
    n::Integer
    m_plus::Integer
    m_minus::Integer
    edges_plus
	edges_minus		

    function myGraph(x)
        vec_plus = [[] for i = 1:x]
        vec_minus = [[] for i = 1:x]
        return new(x,0,0,vec_plus,vec_minus)
    end
end

function readGraph(f)
	ln = readline(f)
	q = split(ln, " ")

    g = myGraph(parse(Int64, q[0]))
    for l in eachline(f)

        q = split(l, " ")

        v = parse(Int64, q[0]) + 1
        u = parse(Int64, q[1]) + 1
        w = parse(Int64, q[2])

       	if w >= 0
			add_edge_plus(g, v, u)
        else	
          	add_edge_minus(g, v, u)
          	
        end
    end
    return g
end

function add_edge_plus(g::myGraph, v::Integer, u::Integer)
	if(!has_edge(g,v,u))
		append!(g.edges_plus[v],u)
		append!(g.edges_plus[u],v)
		g.m_plus = g.m_plus + 1
	end    
end

function add_edge_minus(g::myGraph, v::Integer, u::Integer)
    if(!has_edge(g,v,u))
		append!(g.edges_minus[v], u)
		append!(g.edges_minus[u] , v)
		g.m_minus = g.m_minus + 1
	end
end

function has_edge(g::myGraph, v::Integer, u::Integer)
    return has_edge_plus(g,u,v) || has_edge_minus(g,u,v) 
end

function has_edge_plus(g::myGraph, v::Integer, u::Integer)
    return u in g.edges_plus[v]
end

function has_edge_minus(g::myGraph, v::Integer, u::Integer)
    return u in g.edges_minus[v]
end

function degree(g::myGraph, v::Integer)
    return degree_plus(g,v) + degree_minus(g,v)
end

function degree_plus(g::myGraph, v::Integer)
    return length(g.edges_plus[v])
end

function degree_minus(g::myGraph, v::Integer)
    return length(g.edges_minus[v])
end

function ∆(g::myGraph)
	d = 0
    for v in 1:g.n
    	dv = degree(g,v)
    	if dv > d
    		d = dv
    	end
    end
    return d
end

function ∆_plus(g::myGraph)
    d = 0
    for v in 1:g.n
    	dv = degree_plus(g,v)
    	if dv > d
    		d = dv
    	end
    end
    return d
end

function ∆_minus(g::myGraph)
    d = 0
    for v in 1:g.n
    	dv = degree_minus(g,v)
    	if dv > d
    		d = dv
    	end
    end
    return d
end

function δ(g::myGraph)
    d = g.n
    for v in 1:g.n
    	dv = degree(g,v)
    	if dv < d
    		d = dv
    	end
    end
    return d
end

function δ_plus(g::myGraph)
	d = g.n
    for v in 1:g.n
    	dv = degree_plus(g,v)
    	if dv < d
    		d = dv
    	end
    end
    return d
end

function δ_minus(g::myGraph)
    d = g.n
    for v in 1:g.n
    	dv = degree_plus(g,v)
    	if dv < d
    		d = dv
    	end
    end
    return d
end

function N(g::myGraph, v::Integer)
    return union(g.edges_plus[v], g.edges_minus[v])
end

function N_plus(g::myGraph, v::Integer)
    return copy(g.edges_plus[v])
end

function N_minus(g::myGraph, v::Integer)
    return copy(g.edges_minus[v])
end

function printGraph(g::myGraph)
	println("Grafo com |V(G)|= $(g.n) and |E+| = $(g.m_plus) |E-| = $(g.m_minus) ")
    for i = 1:g.n
        print("N+(", i, ") = ")
        println(g.edges_plus[i])
        print("N-(", i, ") = ")
        println(g.edges_minus[i])
    end
end

###############################################################################


