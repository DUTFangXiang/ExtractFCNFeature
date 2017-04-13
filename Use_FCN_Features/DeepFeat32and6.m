%%%%%%%%%%%%%%%%%%%%%%%
%%% Fang Xiang 2016-10-1
%%% img: the input image name, e.g. image0.jpg  
%%% DB:  the size of the image, e.g. 400*266 DB.R = 400 DB.C = 266 
%%% matRoot: the saved Deep FCN feature Path, e.g. 'E:/Deep_Feature/FCNfeature_PASCAL/'

%%% if your are take the superpixel as the basic unit for every image, 
%%% DB.sp_idx is the cell set of all superpixels.
%%%%%%%%%%%%%%%%%%%%%%%
function DpFeat = DeepFeat32and6(img,DB,matRoot)
 
    layer1 = 32;
    layer2 = 6;    
    padding = [0 100 100 100 100 ... 
               52 52 52 52 52 ... 
               26 26 26 26 26 26 26 ... 
               14 14 14 14 14 14 14 ...
               7 7 7 7 7 7 7 ...
               4];      
	matName = [matRoot,'32','/',img(1:end-4),'.mat'];
	eval(['load ',matName,';']);

	temp = layer32;  
	vgg_feat1 = temp(padding(layer1):end-padding(layer1)+1,padding(layer1):end-padding(layer1)+1,:);
	vgg_feat1 = double(imresize(vgg_feat1,[DB.R,DB.C]));
	%meanVgg1  = GetMeanColor(vgg_feat1,DB.sp_idx,'vgg');   % for superpixle   
    
    matName1 = [matRoot,'6','/',img(1:end-4),'.mat'];
	eval(['load ',matName1,';']);
	temp = layer6; 
	vgg_feat2 = temp(padding(layer2):end-padding(layer2)+1,padding(layer2):end-padding(layer2)+1,:);
	vgg_feat2 = double(imresize(vgg_feat2,[DB.R,DB.C]));
	% meanVgg2  = GetMeanColor(vgg_feat2,DB.sp_idx,'vgg');  % for superpixle 
    
    DpFeat = [vgg_feat1 vgg_feat2]; %[meanVgg1 meanVgg2];   % for superpixle 
end