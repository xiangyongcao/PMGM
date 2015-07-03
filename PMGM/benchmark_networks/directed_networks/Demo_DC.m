% demo in benchmark networks for DCPMGM
tic;
clear all
addpath(genpath(pwd));

system('benchmark.exe -N 500 -k 15 -maxk 150 -mu 0.1 -minc 100 -maxc 200')
load('network.dat')
load('community.dat')

N = size(community,1);

% Construct adjacent matrix
A = zeros(N);
for i = 1:length(network)
    A(network(i,1), network(i, 2)) = 1;
end

x_in = sum(A);
x_out = sum(A,2);
figure;
[xpdf,ypdf,xcdf,ycdf,logk,logx]=pdf_cdf_rank(x_in,'on');
figure;
[xpdf,ypdf,xcdf,ycdf,logk,logx]=pdf_cdf_rank(x_out,'on');

% True Label
T_Label = community(:,2);

% Number of group
Q = max(T_Label);

% Call function: DC
[Est_Label,Gamma,Parameter,Iter,llh] = DC_Poi_Directed_EM(A,Q,'random',100,1e-4,1);

% True Pi
True_Pi = zeros(1,Q);
for q = 1:Q
    True_Pi(q) = length(find(community==q))/N; 
end
disp(['True proportion is: ', num2str(True_Pi)]);

%Criterion: CER and Normal Mutual Informatioin(NMI) 
cer_DC = CER(Est_Label, T_Label);NMI_DC = nmi(Est_Label, T_Label);
disp(['CER_DC is: ',num2str(cer_DC)]);disp(['NMI_DC is: ',num2str(NMI_DC)]);
toc;
