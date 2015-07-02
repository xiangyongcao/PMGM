% Simulation 1: Consistent Simulation
tic;
clc;clear;

% Generate degree-corrected directed poisson graph
% parameter setting
init_num = 5;
N = [50,100,200,300,500,800,1000,1500,2000,3000,5000];
len_N = length(N);


% % Degree Distribution
% % outdegree distribution
% x_out = sum(adj,2);
% figure;[xpdf,ypdf,xcdf,ycdf,logk,logx]=pdf_cdf_rank(x_out,'on');
% x_in = sum(adj,1);
% figure;[xpdf,ypdf,xcdf,ycdf,logk,logx]=pdf_cdf_rank(x_in,'on');
for i = 1:len_N
    n = N(i);
    Pi = [0.3,0.7];
    Q = length(Pi);
    Theta = floor(40*rand(n,Q));
    [adj, G_Label, True_w, True_Pi, True_Theta, True_wTheta] = random_directed_graph(n,Pi,Theta);
    
     ELabel = [];GAM=[];PAR=[];ITER=[];Llh=[];
    for j = 1:init_num
        % call function
        [Est_Label,Gamma,Parameter,Iter,llh] = DC_Poi_Directed_EM(adj,Q,'random',100,1e-8);
        ELabel(:,j) = Est_Label;
        GAM(:,:,j) = Gamma;
        PAR{j} = Parameter;
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
    cerr(i) = CER(G_Label,Est_Label);
    Parameter = Parameter{1};
    Est_Pi  = Parameter.Pi;
    Res_Pi(i) = norm(True_Pi-sort(Est_Pi));
    norm_res_w(i) = norm(True_w-Parameter.w)/n;
    
    Est_Theta = Parameter.Theta;
    Tmp1 = Est_Theta(:,1);
    Est_Theta(:,1) = Est_Theta(:,2);
    Est_Theta(:,2) = Tmp1;
    norm_res_theta1(i) = norm(True_Theta(:)-Est_Theta(:))/n;
    
    Est_Theta = Parameter.Theta;
    norm_res_theta2(i) = norm(True_Theta(:)-Est_Theta(:))/n;
end
figure;
subplot(2,3,1);
plot(N,cerr);
subplot(2,3,2);
plot(N,Res_Pi);
subplot(2,3,3);
plot(N,norm_res_w);
subplot(2,3,4);
plot(N,norm_res_theta1);
subplot(2,3,5);
plot(N,norm_res_theta2);


% % Convergence of objective function
% figure;subplot(2,3,1);
% llh(1)=[]; plot(1:length(llh),llh(1:end));
% title('Convergence of Likelihood Function');xlabel('Iteration');ylabel('Likelihood Function Value');


% CER
% cerr = CER(G_Label,Est_Label);
% disp(['CER is: ',num2str(cerr)]);

% The sum of w_i in each group
%  figure;imshow(abs(reshape(Est_wTheta-True_wTheta,20,20)))
% [~,Label] = max(Gamma,[],2);
% w = Parameter.w;
% for q = 1:Q
%     index = find(Label==q);
%     w_sum(q) = sum(w(index));
% end
% disp(['The sum of w_{i} in each group is: ', num2str(w_sum)]);

% Comparison of Estimated parameters and True parameters
% Pi
% subplot(2,3,2);
% x = 1:Q;
% plot(x,True_Pi);
% hold on;
% plot(x,sort(Parameter.Pi),'r--');
% legend('True','Est','Location','NorthWest')
% title('Pi')
%
% hold off;
%
% % w
% subplot(2,3,3);
% x = 1:n;
% res_w = abs(True_w-Parameter.w);
% plot(x,res_w);
% title('|w_{true}-w_{est}|')
%
% norm_res_w = norm(True_w-Parameter.w,2)/n;
%
% % theta(case 1)
% subplot(2,3,4);
% x = 1:n*Q;
% Est_Theta = Parameter.Theta;
% Tmp1 = Est_Theta(:,1);
% Est_Theta(:,1) = Est_Theta(:,2);
% Est_Theta(:,2) = Tmp1;
%
% res_theta = abs(True_Theta(:)-Est_Theta(:));
% plot(x,res_theta);
% title('|theta_{true}-theta_{est}|')
%
% norm_res_theta1 = norm(True_Theta(:)-Est_Theta(:),2)/n;
%
% % theta(case 2)
% subplot(2,3,5);
% x = 1:n*Q;
% Est_Theta = Parameter.Theta;
%
% res_theta = abs(True_Theta(:)-Est_Theta(:));
% plot(x,res_theta);
% title('|theta_{true}-theta_{est}|')
%
% norm_res_theta2 = norm(True_Theta(:)-Est_Theta(:),2)/n;
%
% subplot(2,3,6);
% x = 1:n*Q;
% True_wTheta = repmat(w',1,Q).*True_Theta;
% Est_wTheta = repmat(Parameter.w',1,Q).*Est_Theta;
%
% res_wTheta = abs(True_wTheta(:)-Est_wTheta(:));
% plot(x,res_wTheta(:));
% title('|wTheta_{true}-wTheta_{est}|')
%
% toc;