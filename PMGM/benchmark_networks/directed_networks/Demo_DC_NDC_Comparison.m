tic;
clear all
addpath(genpath(pwd));


system('benchmark.exe -N 500 -k 40 -maxk 200 -mu 0.3 -minc 100 -maxc 200')
load('network.dat')
load('community.dat')



N = size(community,1);

% Construct adjacent matrix
A = zeros(N);
for i = 1:length(network)
    A(network(i,1), network(i, 2)) = 1;
end

% True Label
T_Label = community(:,2);

% Number of group
Q = max(T_Label);

% True Pi
True_Pi = zeros(1,Q);
for q = 1:Q
    True_Pi(q) = length(find(community==q))/N; 
end
disp(['True proportion is: ', num2str(True_Pi)]);

init_num = 1;
% Call function: DC
[Est_Label,Gamma,Parameter,Iter,llh] = DC_Poi_Directed_EM(A,Q,'random',100,1e-4,init_num);

% Call function: NoDC
[Est_Label1,Gamma1,Parameter1,Iter1,llh1] = Poi_Directed_EM(A,Q,'random',100,1e-4,init_num);

%Criterion: CER and Normal Mutual Informatioin(NMI) 
cer_DC = CER(Est_Label, T_Label);NMI_DC = nmi(Est_Label, T_Label);
cer_NDC = CER(Est_Label1, T_Label);NMI_NDC = nmi(Est_Label1, T_Label);
disp(['CER_DC is: ',num2str(cer_DC)]);disp(['NMI_DC is: ',num2str(NMI_DC)]);
disp(['CER_NDC is: ',num2str(cer_NDC)]);disp(['NMI_NDC is: ',num2str(NMI_NDC)]);
toc;
  
