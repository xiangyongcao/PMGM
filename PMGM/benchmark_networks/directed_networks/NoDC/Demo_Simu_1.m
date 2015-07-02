% Simulation 1: Consistent Simulation
tic;
clc;clear;

% Generate degree-corrected directed poisson graph
% parameter setting
init_num = 1;
n = 1000; Pi = [0.5,0.5];
Q = length(Pi);
Theta = floor(40*rand(n,Q));
[adj, G_Label, True_Pi, True_Theta] = random_directed_graph(n,Pi,Theta);


for j = 1:init_num
    % call function
    [Est_Label,Gamma,Parameter,Iter,llh] = Poi_Directed_EM(adj,Q,'random',200,1e-8);
    ELabel(:,j) = Est_Label;
    GAM(:,:,j) = Gamma;
    PAR(j) = Parameter;
    ITER(j) = Iter;
    Llh(j) = llh(end);
    LLH(:,j) = llh';
end
[val,ind] = max(Llh);
Est_Label = ELabel(:,ind);
Gamma = GAM(:,:,ind);
Parameter = PAR(ind);
Iter = ITER(ind);
llh = LLH(:,ind);



% Convergence of objective function
figure;subplot(2,2,1);
llh(1)=[]; plot(1:length(llh),llh(1:end));
title('Convergence of Likelihood Function');xlabel('Iteration');ylabel('Likelihood Function Value');


% CER
cerr = CER(G_Label,Est_Label);
disp(['CER is: ',num2str(cerr)]);

% Comparison of Estimated parameters and True parameters
% Pi
subplot(2,2,2);
x = 1:Q;
plot(x,True_Pi);
hold on;
plot(x,sort(Parameter.Pi),'r--');
legend('True','Est','Location','NorthWest')
title('Pi')
hold off;

% theta(case 1)
subplot(2,2,3);
x = 1:n*Q;
Est_Theta = Parameter.Theta;
Tmp1 = Est_Theta(:,1);
Est_Theta(:,1) = Est_Theta(:,2);
Est_Theta(:,2) = Tmp1;

res_theta = abs(True_Theta(:)-Est_Theta(:));
plot(x,res_theta);
title('|theta_{true}-theta_{est}|')


% theta(case 2)
subplot(2,2,4);
x = 1:n*Q;
Est_Theta = Parameter.Theta;

res_theta = abs(True_Theta(:)-Est_Theta(:));
plot(x,res_theta);
title('|theta_{true}-theta_{est}|')

toc;