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


% update w
tmp1 = repmat(sum(Theta,1),n,1);
tmp2 = sum(Gamma.*tmp1,2);   % denominator
tmp3 = repmat(sum(A)',1,Q);
tmp4 = sum(Gamma.*tmp3,2);  % numerator
tmp2(tmp2==0) = 1e-6;
w = (tmp4./tmp2)';
% % w = w/sum(w);
% [~,Label] = max(Gamma,[],2);
% for q = 1:Q
%   index = find(Label==q);
%   tmp = w(index)/sum(w(index));
%   w(index) = tmp;
% end


Parameter.Pi = Pi;
Parameter.Theta = Theta;
Parameter.w = w;

