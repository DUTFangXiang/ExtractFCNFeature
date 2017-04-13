%%
% MSRA
clear all;
close all;
gt_dir = { 'SED1', 'F:\Mywork\SED2-gt\',[],[] 'png'};   %真值路径，返回的是一个1*5的cell()
%gt_dir = { 'MSRA', 'E:\Saliency Experiment\B-BSD300-Masks\', [], [], 'png'};
alg_dir = ...                                            %得到的是4*1的cell
{ 
%{'LUP', 'F:\Mywork\1000SF\', [], [], 'jpg'};
 {'AMC', 'F:\Mywork\SED2-AMC\', [],[] 'jpg'};
  {'DSR', 'F:\Mywork\SED2-DSR\', [],[] 'jpg'};

%{'Ychuan', 'F:\Mywork\1000compare\', [], 'ychuan', 'png'};

%{'LUP1', 'F:\Mywork\map9\', [], 'filterexp', 'png'}
 %{'LUP2', 'F:\Mywork\map9\', [], 'filterno', 'png'}
% {'SVR0.2/0.4', 'E:\Saliency Experiment\Map_MSRA1000\SVRnoObj_0.2_0.4\',  [], '_saliency','bmp'}
% {'SVR0.9/0.3', 'E:\Saliency Experiment\Map_MSRA1000\SVRnoObj_0.9_0.3\',  [], '_saliency','bmp'}
% {'SVRAd0.9/0.3', 'E:\Saliency Experiment\Map_MSRA1000\SVRnoObjAdja_0.9_0.3\',  [], '_saliency','bmp'}
  %{'SVRObj0.2/0.4', 'E:\Saliency Experiment\Map_MSRA1000\SVRObj_0.2_0.4\',[], '_saliency','bmp'}
  %{'SVRObj0.9/0.3', 'E:\Saliency Experiment\Map_MSRA1000\SVRObj_0.9_0.3\', [],'_saliency','bmp'}
  %{'SVRObjAd0.9/0.3', 'E:\Saliency Experiment\Map_MSRA1000\SVRObjAdja_0.9_0.3\', [], '_saliency', 'bmp'} 
  %{'SVRObj0.1/0.2', 'E:\Saliency Experiment\Map_MSRA1000\SVRObject_0.1_0.2\', [],'_saliency', 'bmp'} 
  %{'DicObjPost', 'E:\Saliency Experiment\Map_MSRA1000\DicObjectnessPost\',  [], '_saliency','bmp'}
  %{'DSR', 'E:\Saliency Experiment\A-MSRA-1000-SalMap\DSR\', [], [], 'jpg'} 
  };
alg_dir_FF = candidateAlgStructure( alg_dir );  %候选的算法结构，返回4*1的结构体，类似于alg_dir 的内容
dataset = datasetStructure( gt_dir(1), gt_dir(2) );%返回库的名字，路径

[ mPre, mRecall, mFmeasure, mHitRate , mFalseAlarm, AUC ] = ...
    performCalcu(dataset,alg_dir_FF); %输入真值库的名字，路径； 候选算法的机构体

basedir = './base_pr_bar_fig/';
mkdir(basedir);
save( [ basedir 'base_SED1'], 'mPre', 'mRecall', 'mFmeasure', 'mHitRate', 'mFalseAlarm', 'AUC' );

curve_bar_plot( basedir, gt_dir, alg_dir, mPre, mRecall, mFmeasure, AUC );

