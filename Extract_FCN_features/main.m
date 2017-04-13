%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Fang Xiang  2016-10-1
%%% extract the FCN features from the existed FCN structure
%%% the platform is based on the MatConvNet (CNNs for MATLAB)
%%% In our work, we extract the fine layer pool1(the 6th)���� 349��349��64
%%% and the coarse layer pool5(the 32th) ���� 22��22��512,
%%% and save the cell results in .mat file named layer6 and layer32.

%%% 1 you need download the pascal-fcn8s-dag.mat in http://www.vlfeat.org/matconvnet/pretrained/
%%% and save it in FCN file.
%%% 2 add your image dataset path to 'imgFile' variable
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% add the model path
   addpath('matlab');
   addpath('FCN'); 
  %% load the Net
  global res;
  imgFile = 'D:/image/F-PASCAL/';    % the path of the image dataset
  outFile_6Level = './6/';           % the 6th layer
  outFile_32Level = './32/';         % the 32th layer
  imgPath = dir([imgFile  '*.bmp']); % you can modify the image format.
  for len = 1:length(imgPath)
      disp(len);                                             
      run matlab/vl_setupnn;                                               
      net = dagnn.DagNN.loadobj(load('FCN/pascal-fcn8s-dag.mat'));  
      net.mode = 'test';
      %% load and preprocess the image
      im = imread([imgFile imgPath(len).name] );
      im_= single(im);
      im_= imresize(im_,net.meta.normalization.imageSize(1:2));
      im_= bsxfun(@minus,im_ ,net.meta.normalization.averageImage);      
      %% run the CNN
      net.eval({'data',im_});
      layer6 = res{6};
      addr = [outFile_6Level imgPath(len).name(1:end-4) '.mat'];
      save(addr,'layer6');
      layer32 = res{32};
      addr = [outFile_32Level imgPath(len).name(1:end-4) '.mat'];
      save(addr,'layer32');     
  end
  