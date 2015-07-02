function [minc,maxc] = min_max_size(n,Q)

Tmp = floor(n/Q);
minc = Tmp - 100;
maxc = Tmp + 100;