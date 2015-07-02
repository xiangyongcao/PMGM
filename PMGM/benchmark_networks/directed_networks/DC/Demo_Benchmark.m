% benchmark experiments: different N and mu
clear all;
tic;
addpath(genpath(pwd));

Mu = 0.1:0.1:0.6;
N = [500,1000,5000];

Len_Mu = length(Mu);
Len_N = length(N);

init_num = 20;  % times of call the main function for a generated network

cerr = zeros(Len_N,Len_Mu);
NMII = zeros(Len_N,Len_Mu);
var_cerr = zeros(Len_N,Len_Mu);
var_NMII = zeros(Len_N,Len_Mu);

 k = 15; % average in-degree 
 maxk = 300; %maximum in-degree
 Q = 2;

for i = 1:Len_N
    n = N(i);
    [minc,maxc] = min_max_size(n,Q);  % determine minc and maxc by n and Q
    for j = 1:Len_Mu
        mu = Mu(j);
       
        % call Benchmark_Generator function
        [A, T_Label] = Benchmark_Generator(n,k,maxk,mu,minc,maxc);
        
        cer = zeros(1,init_num); NMI = zeros(1,init_num);
        for l =  1:init_num
            [Est_Label,Gamma,Parameter,Iter,llh] = DC_Poi_Directed_EM(A,Q,'random',100,1e-4);
            cer(l) = CER(T_Label,Est_Label);
            NMI(l) = nmi(T_Label, Est_Label);
        end
        cerr(i,j) = mean(cer);
        var_cerr(i,j) = var(cer);
        NMII(i,j) = mean(NMI);
        var_NMII(i,j) = var(NMI);
    end
end

% draw fig
for i = 1:Len_N
   n = N(i);
   NMI = NMII(i,:);
   
   figure;
   plot(Mu,NMI);
   xlabel('Mixture parameter \mu');
   ylabel('Normalized Mutual Information');
   fig_deal;  % fig setting 
end


% save result
save BenchMark_Result.mat N Mu cerr var_cerr NMII var_NMII;



