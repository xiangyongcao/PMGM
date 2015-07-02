function Gamma = init(A,Q,init_method)
n = size(A,1);
switch init_method
    case 'random'
        tmp = rand(n,Q);
        Gamma = tmp./repmat(sum(tmp,2),1,Q);
    case 'spectral'
        [ C, ~, ~ ] = SpectralClustering(A, Q, 3 );
        Gamma = full(C);
end


