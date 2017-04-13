% clc;clear;close all;
im = imread('2_72_72778.jpg');
[l, Am, C] = slic(im, 200, 18, 1.5, 'median');
show(drawregionboundaries(l, im, [255 255 255]));
tic();
lc = spdbscan(l, C, Am, 5);
toc();
show(drawregionboundaries(lc, im, [255 255 255]))