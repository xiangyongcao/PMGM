function [Gamma,llh] = posterior(A,parameter)
% logsumexp trick
Theta = parameter.Theta;
Pi = parameter.Pi;
w = parameter.w;

n = size(A,2);
Q = length(Pi);
logRho = zeros(n,Q);

for q = 1:Q
    w(w==0) = 1e-6;
    tmp1 = sum(repmat(log(w'),1,n).*A,1)';  % n x 1  
    tmp = Theta(:,q); tmp(tmp==0) = 1e-6;  
    tmp2 = (sum(repmat(log(tmp),1,n).*A,1))'; % n x 1
    tmp3 = sum(Theta(:,q))*w'; % n x 1
    logRho(:,q) =  tmp1 + tmp2 + tmp3;
end

logRho = bsxfun(@plus,logRho,log(Pi));
T = logsumexp(logRho,2);
llh = sum(T);
logGamma = bsxfun(@minus,logRho,T);
Gamma = exp(logGamma);

