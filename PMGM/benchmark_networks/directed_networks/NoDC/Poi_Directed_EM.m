function [Label,Gamma,Parameter,Iter,llh] = Poi_Directed_EM(A,Q,init_method,maxIter,tol,init_num)
% ---------------------------------------------------------------------------
% Description: EM algorithm for "Poisson Mixture Model for
% Directed Graph"

% Input
% A - adjacent matrix of the input network
% Q -  the number of groups
% init_method - the intialization method to the original partition:
%             - "random method" and "specatral method"  - Default "random"
% maxIter - maximum number of iterations   - Default 500
% tol - tolerance for stopping criterion   - Default 1e-6

% Output
% Gamma - n x Q  Gamma_iq: the probability of vertice i belongs to class q
% Parameter: the parameter of the model
%       -Parameter.Pi - 1 x Q   Pi_q: the fraction of vertices in class q
%       -Parameter.Theta  - n x Q  Theta_iq: the probability of vertice i connents a vertice in class q
%
% Iter: the number of iteration when algorithm stops
% llh - the log likelihood value when algorithm stops

% Author: Xiangyong Cao(caoxiangyong45@gmail.com)
%         Xiangyu Chang(xiangyuchang@gmail.com)

% check the input
if nargin < 5, tol = 1e-6;  end
if nargin < 4, maxIter = 500;  end
if nargin < 3, init_method = 'random';  end

% constant
n = size(A,1);   % the number of vertices

for i = 1:init_num
    
    disp(['Inital time: ', num2str(i)]);
    
    % posterior initialization
    Gamma = init(A,Q,init_method);
    
    % model parameter initialization
    w = ones(1,n);
    Parameter.w = w;
    
    % convergence condition initialization
    converged = false;
    iter = 1;
    
    while  ~converged && iter<=maxIter
        
        iter = iter + 1;
        
        % M step
        Parameter = maximizationModel(A,Gamma,Parameter);
        
        % E step
        [Gamma,llh(iter)] = posterior(A,Parameter);
        
        disp(['Iteration: ',num2str(iter), '. Log likelihood value is: ', num2str(llh(iter))]);
        disp(['The number of group is: ',num2str(Q), '. And the proportion of each group is: ', num2str(Parameter.Pi)]);
        
        % convergence
        converged = (abs(llh(iter)-llh(iter-1)) < tol);
        
    end
    
    Parameter.Theta = floor(Parameter.Theta);
    [~,Label] = max(Gamma,[],2);
    Iter = iter;
    
    ELabel(:,i) = Label;
    GAM(:,:,i) = Gamma;
    PAR{i} = Parameter;
    ITER(i) = Iter;
    Llh(i) = llh(end);
    LLH{i} = llh;
end

[~,ind] = max(Llh);
Label = ELabel(:,ind);
Gamma = GAM(:,:,ind);
Parameter = PAR(ind);
Iter = ITER(ind);
llh = LLH(ind);
