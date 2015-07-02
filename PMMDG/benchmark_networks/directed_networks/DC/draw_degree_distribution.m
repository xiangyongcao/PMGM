% Draw  in-dgree and out-dgree distribution and caculate p value
clc;clear;
addpath(genpath(pwd));
load('blog.mat');

% data preprocessing
RowSum  = sum(blog,2); ColSum = sum(blog,1);
RowIndex = find(RowSum==0); ColIndex = find(ColSum==0);
InterIndex = intersect(RowIndex,ColIndex);
blog(InterIndex,:) = []; blog(:,InterIndex) = [];

x_in = sum(blog);
x_out = sum(blog,2);
figure;
subplot(1,2,1);
[xpdf,ypdf,xcdf,ycdf,logk,logx]=pdf_cdf_rank(x_in,'on');fig_deal;
subplot(1,2,2);[xpdf,ypdf,xcdf,ycdf,logk,logx]=pdf_cdf_rank(x_out,'on');fig_deal;
% figure;[xpdf,ypdf,xcdf,ycdf,logk,logx]=pdf_cdf_rank(x_out,'on');
% 
% [alpha, xmin, L]=plfit(x_in);
% [p,gof]=plpva(x_in, xmin);
% disp(['p value of in-degreee is: ',num2str(p)]);
% 
% [alpha, xmin, L]=plfit(x_out);
% [p,gof]=plpva(x_out, xmin);
% disp(['p value of out-degreee is: ',num2str(p)]);