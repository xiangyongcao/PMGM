% Generate random directed degree-corrected poisson graph

% Output: adj -- adjacent matrix
% Input: n  -- number of nodes
%        Pi -- proportions of each group
%        Theta -- Theta_{iq}: the expected number of edges from node i to a nose in
%        group q
% Author: Xiangyong Cao (caoxiangyong45@gmail.com)

function [adj, G_Label, True_Pi, True_Theta] = random_directed_graph(n,Pi,Theta)

Q = length(Pi);

% Generate Label of Each Node
g = mnrnd(1,Pi,n);
G_Label = zeros(n,1);
for i = 1:n
 G_Label(i) = find(g(i,:)==1);     
end

w = ones(1,n);

% Generate Adjacent Matrix
adj = zeros(n);
for i = 1:n
       lambda = w.*Theta(i,G_Label);
       adj(i,:) = random('poisson',lambda); 
end

True_Pi = Pi;
True_Theta = Theta;









