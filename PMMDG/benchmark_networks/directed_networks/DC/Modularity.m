function modularity = Modularity(adj_mat,partition,type)
%
% Author - Zhiqiang Xu, 05/2012
%
% Email  - zxu1@e.ntu.edu.sg
%
% Description - evaluates the structure quality of the
%               resulting clustering;
%               modularity is to measure structure quality
%
% Input  - adj_mat    : adjacency matrix
%        - partition  : the final posterior distribution of the cluster labels
%        - type       : 'directed' and 'undirected'
% Output - modularity : scalar
% -------------------------------------------------------------------------

cltId = unique(partition);
N = length(partition);
K = length(cltId);
M = sum(adj_mat(:));
clt = true(N,K);
cltSize = zeros(K,1);
modularity = 0;
% -----------------------modularity------------------------
switch type
    case 'undirected'
        for k = 1:K
            clt(:,k) = logical(partition==cltId(k));
            cltSize(k) = sum(clt(:,k));
            e_kk =  sum(sum(adj_mat(clt(:,k),clt(:,k))))/M;
            a_k = sum(sum(adj_mat(clt(:,k),:)))/M;
            modularity =  modularity + (e_kk - a_k^2);
        end
    case 'directed'
        for k = 1:K
            clt(:,k) = logical(partition==cltId(k));
            cltSize(k) = sum(clt(:,k));
            e_kk =  sum(sum(adj_mat(clt(:,k),clt(:,k))))/M;
            a_k = sum(sum(adj_mat(clt(:,k),:)))/M;  
            b_k  = sum(sum(adj_mat(:,clt(:,k))))/M;
            modularity =  modularity + (e_kk - a_k*b_k);
        end
end

