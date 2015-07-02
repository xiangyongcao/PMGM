 function L = Loglikelihood(A,Parameter,Gamma)

 Theta = Parameter.Theta;
 Pi = Parameter.Pi;
 w = Parameter.w;
 
 n = size(A,1);
Q = length(Pi);

[~, partition] = max(Gamma,[],2); 
Gamma = sparse(1:n,partition,1,n,Q,n);
 


% PI = repmat(Pi,n,1);
% S1 = sum(sum(Gamma.*log(PI)));

Theta(Theta==0) =eps;
b = log(Theta);
w(w==0) = eps;
b1 = repmat(log(w'),1,Q);
B1 = b + b1;

S2 = 0;
for q = 1:Q
   tmp1 = Gamma(:,q)';
   tmp2 = B1(:,q);
   S2 = S2 + tmp1 * A * tmp2;
end

S3 = sum(sum((repmat(w',1,Q).*Gamma).*repmat(sum(Theta',2)',n,1)));

L = S2 -S3;
