\ LP format - for model browsing. Use MPS format to capture full model detail.
Minimize
  y[1,2] + y[1,4] + y[2,3] + y[2,4] + y[2,5] + y[2,6] + y[4,5] + y[3,5]
   + y[3,6] + y[5,6]
Subject To
 constr2: x[1,0] + x[1,1] + x[1,2] >= 1
 constr2: x[2,0] + x[2,1] + x[2,2] >= 1
 constr2: x[4,0] + x[4,1] + x[4,2] >= 1
 constr2: x[3,0] + x[3,1] + x[3,2] >= 1
 constr2: x[5,0] + x[5,1] + x[5,2] >= 1
 constr2: x[6,0] + x[6,1] + x[6,2] >= 1
 constr3: - y[1,4] + x[1,0] + x[4,0] <= 1
 constr3: - y[1,4] + x[1,1] + x[4,1] <= 1
 constr3: - y[1,4] + x[1,2] + x[4,2] <= 1
 constr3: - y[2,3] + x[2,0] + x[3,0] <= 1
 constr3: - y[2,3] + x[2,1] + x[3,1] <= 1
 constr3: - y[2,3] + x[2,2] + x[3,2] <= 1
 constr3: - y[2,4] + x[2,0] + x[4,0] <= 1
 constr3: - y[2,4] + x[2,1] + x[4,1] <= 1
 constr3: - y[2,4] + x[2,2] + x[4,2] <= 1
 constr3: - y[2,5] + x[2,0] + x[5,0] <= 1
 constr3: - y[2,5] + x[2,1] + x[5,1] <= 1
 constr3: - y[2,5] + x[2,2] + x[5,2] <= 1
 constr3: - y[3,6] + x[3,0] + x[6,0] <= 1
 constr3: - y[3,6] + x[3,1] + x[6,1] <= 1
 constr3: - y[3,6] + x[3,2] + x[6,2] <= 1
 constr3: - y[5,6] + x[5,0] + x[6,0] <= 1
 constr3: - y[5,6] + x[5,1] + x[6,1] <= 1
 constr3: - y[5,6] + x[5,2] + x[6,2] <= 1
 constr4: y[1,2] + x[1,0] - x[2,0] >= 0
 constr4: y[1,2] + x[1,1] - x[2,1] >= 0
 constr4: y[1,2] + x[1,2] - x[2,2] >= 0
 constr4: y[2,6] + x[2,0] - x[6,0] >= 0
 constr4: y[2,6] + x[2,1] - x[6,1] >= 0
 constr4: y[2,6] + x[2,2] - x[6,2] >= 0
 constr4: y[4,5] + x[4,0] - x[5,0] >= 0
 constr4: y[4,5] + x[4,1] - x[5,1] >= 0
 constr4: y[4,5] + x[4,2] - x[5,2] >= 0
 constr4: y[3,5] + x[3,0] - x[5,0] >= 0
 constr4: y[3,5] + x[3,1] - x[5,1] >= 0
 constr4: y[3,5] + x[3,2] - x[5,2] >= 0
 constr5: y[1,2] - x[1,0] + x[2,0] >= 0
 constr5: y[1,2] - x[1,1] + x[2,1] >= 0
 constr5: y[1,2] - x[1,2] + x[2,2] >= 0
 constr5: y[2,6] - x[2,0] + x[6,0] >= 0
 constr5: y[2,6] - x[2,1] + x[6,1] >= 0
 constr5: y[2,6] - x[2,2] + x[6,2] >= 0
 constr5: y[4,5] - x[4,0] + x[5,0] >= 0
 constr5: y[4,5] - x[4,1] + x[5,1] >= 0
 constr5: y[4,5] - x[4,2] + x[5,2] >= 0
 constr5: y[3,5] - x[3,0] + x[5,0] >= 0
 constr5: y[3,5] - x[3,1] + x[5,1] >= 0
 constr5: y[3,5] - x[3,2] + x[5,2] >= 0
Bounds
Binaries
 y[1,2] y[1,4] y[2,3] y[2,4] y[2,5] y[2,6] y[4,5] y[3,5] y[3,6] y[5,6]
 x[1,0] x[1,1] x[1,2] x[2,0] x[2,1] x[2,2] x[4,0] x[4,1] x[4,2] x[3,0]
 x[3,1] x[3,2] x[5,0] x[5,1] x[5,2] x[6,0] x[6,1] x[6,2]
End
