function boundary_sp = extract_bg_sp(sulabel,r,c)
% function bg_sp = extract_bg_sp(sulabel,r,c) can find the label 
% for each boundary superpixels.
%
% Input: sulabel - the superpixel label for all pixels
%        r - the number of pixel rows
%        c - the number of pixel columns
%
% Output:boundary_sp - the labels for boundary superpixels

r1=unique(sulabel(1,:));
rend=unique(sulabel(r,:));
c1=unique(sulabel(:,1));
cend=unique(sulabel(:,c));
boundary_sp=[r1 rend c1' cend'];
boundary_sp = unique(boundary_sp);