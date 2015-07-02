% Generate a directed graph
function [A, Glabel,Z] = GGraph(n,Pi,P)

A = zeros(n);
Z = mnrnd(1,Pi,n);

Glabel = zeros(1,n);
for i = 1:n
 Glabel(i) = find(Z(i,:)==1);     
end

% for i = 1:n
%     for j = 1:n
%       edge_seed = rand(1);
%       if P(Glabel(i),Glabel(j)) <= edge_seed 
%           A(i,j) = 1;
%       end
%     end
% end

B = Z * P * Z';
C = rand(n);
A = (C>=B);
A = A - diag(diag(A));