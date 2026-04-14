from pathlib import Path
import os
import networkx as nx
import gurobipy as gp
import sys

if __name__ == "__main__":

    results_path = Path('result/')
    instance_path = Path('data/kmbs/RANDOM')
    out_path = Path('/home/jossian/Downloads/develop/report/signed_graphs')

    # instance
    if len(sys.argv) < 2:
        print("input instance")
    else:
        method = sys.argv[1]
        instance = sys.argv[2]
    
    data = os.path.join(instance_path,instance)
        
    with open(data, 'r') as file:
        lines = file.readlines()

    lines = [a.strip() for a in lines]

    values = lines[0].split()
    n, m = int(values[0]), int(values[1])

    # network
    G = nx.Graph()

    for k in range(n):
        G.add_node(k)

    for e in range(1,m+1):   
        values = lines[e].split()
        i, j, val = int(values[0]), int(values[1]), int(values[2])
        G.add_edge(i, j, weight=val)

    # sets
    nodes = G.nodes()
    edges = G.edges()
    
    #k = 2
    K = range(k)

    EP = [(u, v) for (u, v, d) in G.edges(data=True) if d["weight"] > 0]
    EN = [(u, v) for (u, v, d) in G.edges(data=True) if d["weight"] < 0]

    A = []
    for i in nodes:
        neighbors = G.neighbors(i)
        lst = []
        for j in neighbors:
            if G[i][j]["weight"] < 0:
                lst.append(j)
        lst.append(i)
        lstCoV =  list(set(nodes) - set(lst))
        for j in lstCoV:
            if (i<j):
                a = (i,j)
                A.append(a)
        
    A0 = A
    for i in nodes:
        a = (i,i)
        A0.append(a)
        
    D = []
    for i in nodes:
        lst = []
        for j in nodes:
            if (i,j) in A0:
                lst.append(j)
        D.append(lst)        

    O = []
    for j in nodes:
        lst = []
        for i in nodes:
            if (i,j) in A0:
                lst.append(i)
        O.append(lst)

    VK = []
    for i in nodes:
        for j in range(k):
            a = (i,j)
            VK.append(a)

    # model
    model = gp.Model()

    # silent/verbose mode
    model.Params.OutputFlag = 0 
    
    # variables
    y = model.addVars(edges,vtype=gp.GRB.BINARY, name="y")
    x = model.addVars(VK,vtype=gp.GRB.BINARY, name="x")

    model.update()
        
    #objective function
    obj = 0
    for e in edges:
        obj += y[e]
         
    model.setObjective(obj, gp.GRB.MINIMIZE)

    # constraints
    
    for v in nodes:
        constr = 0
        for i in K:
            constr += x[(v,i)] 
        model.addConstr(constr >= 1.0, "con2")

    for e in EN:
        for i in K:
            model.addConstr(x[(e[0],i)] + x[(e[1],i)] <= 1 + y[(e[0],e[1])], "con3")

    for e in EP:
        for i in K:
            model.addConstr(x[(e[0],i)] >= x[(e[1],i)] - y[(e[0],e[1])], "con4")

    for e in EP:
        for i in K:
            model.addConstr(x[(e[1],i)] >= x[(e[0],i)] - y[(e[0],e[1])], "con5")

    if method != "mip":
        for v in model.getVars():
            v.setAttr('vtype', 'C')

    #model.write("edge1_signed.lp")
    
    # parameters 
    model.setParam(gp.GRB.Param.TimeLimit,3600.0)
    model.setParam(gp.GRB.Param.MIPGap,1.e-6)
    model.setParam(gp.GRB.Param.Threads,1)
        
    model.setParam(gp.GRB.Param.Presolve,0)
    # Controls the presolve level. 
    # automatic setting (-1). 
    # off (0), 
    # conservative (1), 
    # or aggressive (2). 
    # More aggressive application of presolve takes more time, 
    # but can sometimes lead to a significantly tighter model.
    
    #model.setParam(gp.GRB.Param.Cuts,0)
    # Global cut aggressiveness setting. 
    # Use value 0 to shut off cuts, 
    # 1 for moderate cut generation, 
    # 2 for aggressive cut generation, 
    # and 3 for very aggressive cut generation. 
    # The default -1 value chooses automatically.

    #model.setParam(gp.GRB.Param.BranchDir,1)
    # default 0
    # -1 will always explore the down branch first, 
    # 1 will always explore the up branch first.    

    # optimize
    model.optimize()
        
    tmp = 0
    if model.status == gp.GRB.OPTIMAL:
        tmp = 1
 
    objval = model.objVal
    runtime = model.Runtime
    status = tmp
    if method == "mip":
        objbound = model.objBound 
        mipgap = model.MIPGap
        nodecount = model.NodeCount

    xval = {}
    for v in VK:
        xval[v] = x[v].x

    yval = {}
    for e in edges:
        yval[e] = y[e].x

    Ex = []
    for key, value in xval.items():
        if value > 0.5:
            Ex.append(key)

    Ey = []
    for key, value in yval.items():
        if value > 0.5:
            Ey.append(key)

    model.dispose()
            
    # export solution
    if method == "mip":
        arq = open(os.path.join(results_path,f'{method}_n{n}_edge1_signed_presolve0.txt'),'a')
        arq.write(instance+';'
        +str(round(objval,2))+';'
        +str(round(objbound,2))+';'
        +str(round(mipgap,2))+';'
        +str(round(runtime,2))+';'
        +str(round(nodecount,2))+';'
        +str(round(tmp,2))+'\n')
    else:
        arq = open(os.path.join(results_path,f'{method}_n{n}_edge1_signed_default.txt'),'a')
        arq.write(instance+';'
        +str(round(objval,2))+';'
        +str(round(runtime,2))+'\n')
	
    arq.close()
