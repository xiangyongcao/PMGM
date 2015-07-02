% Simulation 1: Consistent Simulation
tic;
clc;clear;

% N = [50,100,200,500];
N = 100;
len_N = length(N);
data_num = 10;

% Generate degree-corrected directed poisson graph
for i = 1:len_N
    n = N(i); Pi = [0.4,0.6];
    Q = length(Pi);
    Theta = floor(40*rand(n,Q));
    
     % generate data   
    [adj, G_Label, True_w, True_Pi, True_Theta, True_wTheta] = random_directed_graph(n,Pi,Theta);   
    
    for j = 1:data_num
        
    % call function
    [Est_Label,Gamma,Parameter,Iter,llh] = DC_Poi_Directed_EM(adj,Q,'random',100,1e-6);
    
    cer(j) = CER(G_Label,Est_Label);
    Lh(j) = llh(end);
    end
    
    [val,ind] = max(Lh);
    % CER
    cerr(i) = cer(ind);
    
end
cer
Lh
cerr
% figure;
% plot(N,cerr);




