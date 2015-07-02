clear all;
tic;
addpath(genpath(pwd));

system('benchmark.exe -N 200 -k 30 -maxk 300 -mu 0.3 -minc 100 -maxc 150');

for i = 1:length(network)
    
    A(network(i,1), network(i, 2)) = 1;

end

Q = max(community(:,2));

T_label = community(:,2);

[Est_Label,Gamma,Parameter,Iter,llh] = DC_Poi_Directed_EM(A,Q,'random',100,1e-4);


cer = CER(Est_Label, T_label);

NMI = nmi(Est_Label, T_label);

disp(['CER is: ',num2str(cer)]);

disp(['NMI is: ',num2str(NMI)]);