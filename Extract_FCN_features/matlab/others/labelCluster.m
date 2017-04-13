function [ featLabel ] = labelCluster( centers, LAB_feature, N_sample, K )
% function [ featLabel ] sort the input superpixels into K clusters based on
%   the their CIE LAB color features.
%
% Input;
%    -centers: formed codebook 
%    -LAB_feature: the LAB features of the boundary superpixels
%    -N_sample: the number of the boundary superpixels
%    -K: the number of clusters
% Output:
%    -featLabel: a row vector of the boundary superpixels' cluster label


distance = zeros(K,N_sample);

for i = 1 : K
    temp = repmat(centers(:,i),[1 N_sample]);
    distance(i,:) = sum((LAB_feature-temp).^2);
end
% 
% for i=1:K
%     for j=1:N_sample
%         distance(i,j) = norm(LAB_feature(:,j)-centers(:,i));
%     end
% end

[~ , featLabel] = min(distance);