% Demo 1: Political Blog
tic; clc; clear;
addpath(genpath(pwd));
load('blog.mat');
load('T_Label.mat');

% data preprocessing
RowSum  = sum(blog,2); ColSum = sum(blog,1);
RowIndex = find(RowSum==0); ColIndex = find(ColSum==0);
InterIndex = intersect(RowIndex,ColIndex);

blog(InterIndex,:) = []; blog(:,InterIndex) = [];
T_Label(InterIndex) = [];

init_num = 1;

for i = 1:init_num
    Q = 2;
    [Label,Gamma,Parameter,Iter,llh] = DC_Poi_Directed_EM(blog,Q,'random',200,1e-6);
    llh(1)=[];
    Llh{i} = llh;
    LLH(i) = llh(end);
    ITER(i) = Iter;
    PAR(i) = Parameter;
    GAMMA(:,:,i) = Gamma;
    LABEL(:,i) = Label;
end

[value, index] = max(LLH);
llh = Llh{index};
Iter = ITER(index);
Parameter = PAR(index);
Gamma = GAMMA(:,:,index);
Label = LABEL(:,index);

disp(['The proportion is: ', num2str(Parameter.Pi)]);
cer = CER(T_Label,Label);
disp(['CER is: ', num2str(cer)]);

modularity = Modularity(blog,Label,'directed');
disp(['Modularity is: ', num2str(modularity)]);

plot(1:length(llh),llh)
toc;
    



