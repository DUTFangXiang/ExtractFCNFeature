%% PR
addpath([pwd '\Curve_BenchCode']);%
% models={'ASCA_ECSSD','ASCA_PASCALS','BSCA_ECSSD','BSCA_PASCALS'};
% models = {'ASCA_ECSSD','BSCA_ECSSD'};
% models = {'TSCA_ECSSD'};
% models = {'ASMC_PASCALS','TSCA_PASCALS'};
% models = {'SSCA_PASCALS'};
% models = {'ASCA2_ECSSD'};
% models = {'ASCA2_PASCALS'};
% models = {'NSCA_ECSSD'};
% models = {'NSCA_PASCALS'};
% models = {'NASCA_ECSSD','NASCA_PASCALS'};
% models = {'DRFI','GBMR'};
% models = {'GBMR'};
% models = {'BSCA-Close_ECSSD','BSCA-Close_PASCALS'};
% models = {'Iter-opt_PASCALS','Iter-opt_ECSSD'};
% models = {'Iter-04_PASCALS'};
% models = {'Iter_ECSSD'};
% models = {'Iter200_PASCALS','Iter200_ECSSD'};
% models = {'Iter200Con2New_ECSSD'};
% models = {'Iter-NewAdj3_ECSSD'};
% models = {'use-gt-2layers-stage1_ECSSD','use-gt-2layers-stage2_ECSSD','use-gt-2layers-stage3_ECSSD',...
%     'use-gt-2layers-stage1_PASCALS','use-gt-2layers-stage2_PASCALS','use-gt-2layers-stage3_PASCALS'};
% models = {'useLAB_ECSSD','useLBP_ECSSD','2LCA_ECSSD'};
% models = {'SCAstage1_ECSSD','SCAstage2_ECSSD','SCAstage3_ECSSD'};
% for iii = 1 : 38
    models = ['vggedge_ECSSD'];
% models = {'vgg37pm_ECSSD'};
% for mm=1:length(models)
    model_name=models;
% for j=1:1
% gt_dir = { 'SED1', 'E:\ls\������\1100\data\1100hou_ground\',[],[] 'bmp'};   %��ֵ·�������ص���һ��1*5��cell()
% gt_dir = { 'Itti_withoutVPChannel', 'E:\FengMY\MyDocument\Ali(VanishingPoint)\program\pb\PB\GT1\',[],[] 'png'};
% gt_dir = { 'Itti_withVPChannel', 'E:\FengMY\MyDocument\Ali(VanishingPoint)\program\pb\PB\GT1\',[],[] 'png'};
% gt_dir = { 'Itti', 'E:\FengMY\MyDocument\saliency����\2012֮ǰ-����\02����-Global Contrast based Salient Region Detection\Program\Data\AttCut\',[],[] 'png'};
% gt_dir = { 'Itti_withVPdetector', 'E:\FengMY\MyDocument\Ali(VanishingPoint)\program\pb\PB\GT1\',[],[] 'png'};
% gt_dir = { 'Itti_26', 'E:\FengMY\MyDocument\Ali(VanishingPoint)\program\pb\stage1\GT1\',[],[] 'png'};
% name=[mod_name,'_',num2str(j)];
ind = strfind(model_name,'_');
name = [model_name(ind+1:end)];
% name = 'ECSSD';
% name = 'PASCALS';
gt_dir = { name, ['E:\Datasets\Database-S\',name,'\',name,'-Mask\'],[],[] 'png'};

% basedir = ['E:\FengMY\MyDocument\Ali(VanishingPoint)\program\pb\stage2\',mod_name,'\',num2str(j),'\'];
% impath = ['E:\FengMY\MyDocument\Database-S\PASCALS\PASCAL_S-SalMap\',model_name,'\'];
impath=['E:\MyWorkOnSaliency\YaoQin\TestOnDLvgg\',model_name,'\'];
basedir = ['E:\MyWorkOnSaliency\YaoQin\TestOnDLvgg\PR\'];
mkdir(basedir);

alg_dir = ...                                            %�õ�����4*1��cell
{
% {'nVP', 'E:\Feng MY\MyDocument\Ali(Vanishing Point)\program\pb\PB\Itti_saliency', [],'' 'png'};
% {'VP', 'E:\Feng MY\MyDocument\Ali(Vanishing Point)\program\pb\PB\simpsal_code\Itti_saliency', [],'' 'png'};
{'VPdetector', impath, [],'' 'png'};
% {'f', 'E:\Feng MY\MyDocument\Ali(Vanishing Point)\program\pb\PB\add_channel\output', [],'' 'png'};
% {'f', 'E:\Feng MY\MyDocument\Ali(Vanishing Point)\program\pb\PB\add_channel\output_Vpdetector', [],'' 'png'};


  };

alg_dir_FF = candidateAlgStructure( alg_dir );  %��ѡ���㷨�ṹ������4*1�Ľṹ�壬������alg_dir ������
dataset = datasetStructure( gt_dir(1), gt_dir(2) );%���ؿ�����֣�·��

[ mPre, mRecall, mFmeasure, mHitRate , mFalseAlarm, AUC ] = ...
    performCalcu(dataset,alg_dir_FF); %������ֵ������֣�·���� ��ѡ�㷨�Ļ�����

% save( [ basedir 'Itti_withoutVPChannel'], 'mPre', 'mRecall', 'mFmeasure', 'mHitRate', 'mFalseAlarm', 'AUC' );
% save( [ basedir 'Itti_withVPChannel'], 'mPre', 'mRecall', 'mFmeasure', 'mHitRate', 'mFalseAlarm', 'AUC' );

save( [ basedir,model_name], 'mPre', 'mRecall', 'mFmeasure', 'mHitRate', 'mFalseAlarm', 'AUC' );

curve_bar_plot( basedir, gt_dir, alg_dir, mPre, mRecall, mFmeasure, AUC );

% end
% end