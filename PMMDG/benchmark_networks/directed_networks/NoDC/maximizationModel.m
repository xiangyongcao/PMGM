function Parameter = maximizationModel(A,Gamma,Parameter)
% update the model parameter

n = size(A,1);
Q = size(Gamma,2);
w = Parameter.w;    %  1 x n

% update Pi
Pi = sum(Gamma)/n;  %  1 x Q

% update Theta
for q = 1:Q
%     tmp1 = repmat(Gamma(:,q),1,n);
    Theta(:,q) = (A * Gamma(:,q))/(w * Gamma(:,q));     %  n x 1
end

w = ones(1,n);

Parameter.Pi = Pi;
Parameter.Theta = Theta;
Parameter.w = w;

