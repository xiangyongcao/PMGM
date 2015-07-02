clear all

system('mingw32-make.exe')

system('benchmark.exe -N 500 -k 30 -maxk 300 -mu 0.3 -minc 100 -maxc 150')

load('network.dat')

load('community.dat')

for i = 1:length(network)
    
    A(network(i,1), network(i, 2)) = 1;

end

Q = max(community(:,2));


[Est_Label,Gamma,Parameter,Iter,llh] = DC_Poi_Directed_EM(A,Q,'random',100,1e-4);

cer = CER(Est_Label, community(:,2));

NMI = nmi(Est_Label, community(:,2));

disp(['CER is: ',num2str(cer)]);
disp(['NMI is: ',num2str(NMI)]);

