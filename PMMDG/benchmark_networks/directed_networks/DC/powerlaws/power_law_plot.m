%This function is to plot a degree distribution of a network graph.
% Input: g is a graph constructed by function construct_graph.
% Output: d_dis is a degree distribution of a network graph.
% Author: Xiangyu Chang
function d_dis = power_law_plot(g)
A = g.A;
num_ver = length(A);
d = get_degree(A);
d_dis = tabulate(d);
[a, b] = find(d_dis(:,2)==0);
d_dis(a,:) = [];
x_degree = log(d_dis(:,1));
y_fre = log(d_dis(:,3)*0.01);
plot(x_degree,y_fre,'.')
d_sort = log(sort(d));
for k = 1 : num_ver-1
    gamma(k) = mean(d_sort(num_ver-k+1:num_ver))-d_sort(num_ver-k);
end
alpha = 1 + 1./gamma;
figure
plot(alpha);