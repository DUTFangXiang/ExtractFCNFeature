# ExtractFCNFeature
MATLAB toolbox Matconvnet extracts the FCN features for computer vision applications
### MatConvNet
MatConvNet is a MATLAB toolbox implementing Convolutional Neural Networks (CNNs) for computer vision applications. 
It is simple, efficient, and can run and learn state-of-the-art CNNs. Several example CNNs are included to classify 
and encode images. Please visit the homepage to know more.

In case of compilation issues, please read first the Installation and FAQ section before creating an GitHub issue. 
For general inquiries regarding network design and training related questions, please use the Discussion forum.

the main task is published in https://github.com/vlfeat/matconvnet. And, http://www.vlfeat.org/matconvnet/ is the home 
page for Matconvnet project. 
### FCN 
The Fully Convolutional Network (FCN) makes no use of any pre- and post-processing complication, which is trained 
end-to-end taking input of arbitrary size. Hence, the FCN feature extraction can be performed whole-image-at\-atime 
without any operation for the input image. 

The FCN is first proposed in "Fully convolutional networks for semantic segmentation", published by J. Long *et. al.* 
in CVPR, 2015.
### Project Layout
#### Extract_FCN_features 
The main function of this file is for extracting the FCN features from the existed FCN structure.  

First, you need to download the pascal-fcn8s-dag.mat in http://www.vlfeat.org/matconvnet/pretrained/ and save it in FCN file.

Then, you open the main.m file and modify some parameters according to the instructions.

In our work, we extract the fine layer pool1(the 6th)—— 349×349×64 and the coarse layer pool5(the 32th) —— 22×22×512,
and save the cell results in .mat file named layer6 and layer32.

#### Use_FCN_Features
This file is aim to teach you how to use the extarcted FCN features. 

For every image, you can use the DeepFeat32and6.m to extract the FCN features for every pixel or superpixel. 
