clc;clear;
load('blog.mat');
x_in = sum(blog);
x_out = sum(blog,2);
figure;[xpdf,ypdf,xcdf,ycdf,logk,logx]=pdf_cdf_rank(x_in,'on')
figure;[xpdf,ypdf,xcdf,ycdf,logk,logx]=pdf_cdf_rank(x_out,'on');

% p value
% [alpha, xmin, L]=plfit(x_out);
% [p,gof]=plpva(x_out, xmin)
