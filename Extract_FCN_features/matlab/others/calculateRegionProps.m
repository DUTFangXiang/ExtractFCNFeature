function regions = calculateRegionProps(sup_num,sulabel_im)
% function regions = calculateRegionProps(sup_num,sulabel_im) can  
% calculate the region pixel index for each superpixel.
%
% Input: sup_num - the number of superpixels
%        sublabel_im - the superpixel labels for all pixels
%
% Output: regions - the region pixel index for each superpixel
regions = cell(sup_num,1);
for su_ind = 1:sup_num
	indxy = find(sulabel_im==su_ind);
	[indx, indy] = find(sulabel_im==su_ind);
	regions{su_ind}.pixelInd = indxy;
    regions{su_ind}.pixelIndxy = [indx indy];
end