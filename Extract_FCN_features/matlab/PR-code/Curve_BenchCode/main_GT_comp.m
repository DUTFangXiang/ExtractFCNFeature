%%
% MSRA
clear all;
close all;
gt_dir = { 'SED1', 'F:\Mywork\SED2-gt\',[],[] 'png'};   %��ֵ·�������ص���һ��1*5��cell()
%gt_dir = { 'MSRA', 'E:\Saliency Experiment\B-BSD300-Masks\', [], [], 'png'};
alg_dir = ...                                            %�õ�����4*1��cell
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
alg_dir_FF = candidateAlgStructure( alg_dir );  %��ѡ���㷨�ṹ������4*1�Ľṹ�壬������alg_dir ������
dataset = datasetStructure( gt_dir(1), gt_dir(2) );%���ؿ�����֣�·��

[ mPre, mRecall, mFmeasure, mHitRate , mFalseAlarm, AUC ] = ...
    performCalcu(dataset,alg_dir_FF); %������ֵ������֣�·���� ��ѡ�㷨�Ļ�����

basedir = './base_pr_bar_fig/';
mkdir(basedir);
save( [ basedir 'base_SED1'], 'mPre', 'mRecall', 'mFmeasure', 'mHitRate', 'mFalseAlarm', 'AUC' );

curve_bar_plot( basedir, gt_dir, alg_dir, mPre, mRecall, mFmeasure, AUC );

