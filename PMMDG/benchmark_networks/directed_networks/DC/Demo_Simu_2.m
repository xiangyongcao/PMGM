% Simulation 2: the change of CER as n increases
tic;
clc;clear;

N = [50,100,200,500,1000,2000,5000,10000];
% N = [50,100,200,300,500];
len_N = length(N);
init_num = 5;


for i = 1:len_N
    
    n = N(i); Pi = [0.2,0.8];
    Q = length(Pi);
    Theta = floor(40*rand(n,Q));
    
    [adj, G_Label, True_w, True_Pi, True_Theta, True_wTheta] = random_directed_graph(n,Pi,Theta);
    
     ELabel = [];GAM=[];PAR=[];ITER=[];Llh=[];
    
    for j = 1:init_num
        
        % call function
        [Est_Label,Gamma,Parameter,Iter,llh] = DC_Poi_Directed_EM(adj,Q,'random',100,1e-6);
        
        ELabel(:,j) = Est_Label;
        GAM(:,:,j) = Gamma;
        PAR{j} = Parameter;
        ITER(j) = Iter;
        Llh(j) = llh(end);

    end
    
    [val,ind] = max(Llh);
    Est_Label = ELabel(:,ind);
    Gamma = GAM(:,:,ind);
    Parameter = PAR(ind);
    Iter = ITER(ind);

    
    % CER
    cerr(i) = CER(G_Label,Est_Label);
    
end

figure;
plot(N,cerr);
xlabel('n');ylabel('CER');title('The change of CER as graph size n increases')
fig_deal;
toc;



