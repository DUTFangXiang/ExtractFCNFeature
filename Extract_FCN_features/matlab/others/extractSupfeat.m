function [sup_feat] = extractSupfeat(input_imlab,regions,sup_num)
% The function can extract the LAB features of each superpixel.
%
% Input; 
%        input_imlab - the input image with LAB information
%        regions - the region pixel index for each superpixel
%        sup_num - the number of superpixels
%
% Output: sup_feat - the normalized LAB features of
%                    each superpixel
  
L = input_imlab(:,:,1);
A = input_imlab(:,:,2);
B = input_imlab(:,:,3);
    
% normalize the LAB color feature
L = (L-min(L(:)))/(max(L(:))-min(L(:)));
A = (A-min(A(:)))/(max(A(:))-min(A(:)));
B = (B-min(B(:)))/(max(B(:))-min(B(:)));
    
sup_feat = zeros(sup_num,3);
for r = 1:sup_num
    ind = regions{r}.pixelInd;
	meanall = [mean(L(ind)),mean(A(ind)),mean(B(ind))];
	sup_feat(r,:) = meanall;
end
