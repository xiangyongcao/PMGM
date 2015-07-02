function Q=modularity_metric(modules,adj)

nedges=sum(adj(:)); % total number of edges

Q = 0;
for m=1:length(modules)

  e_mm=sum(sum((adj(modules{m},modules{m}))))/(nedges);
  a_m=sum(sum(adj(modules{m},:)))/(nedges);
  Q = Q + (e_mm - a_m^2);
  
end