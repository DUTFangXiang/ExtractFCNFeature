%%
% DUT_OMRON
clear all;
close all;
gt_dir = { 'DUT_OMRON', 'E:\yuanxz\binarymasks\' };
alg_dir = ...
{{'Ours', 'E:\yuanxz\cvprcode\saliencymap\', [], [], 'png'}
{'CB', 'E:\MapOmron\Omron-CB\', [], [], 'jpg'}
{'SVO', 'E:\MapOmron\Omron-SVO\', [], [], 'jpg'}
{'RC', 'E:\MapOmron\Omron-RC\', [], [], 'jpg'}
{'CA', 'E:\MapOmron\Omron-CA\', [], [], 'jpg'}
{'FT', 'E:\MapOmron\Omron-FT\', [], [], 'jpg'}
{'GB', 'E:\MapOmron\Omron-GB\', [], [], 'jpg'}
{'SR', 'E:\MapOmron\Omron-SR\', [], [], 'jpg'}
{'IT', 'E:\MapOmron\Omron-ITTI\', [], [], 'jpg'} };

alg_dir_FF = candidateAlgStructure( alg_dir );
dataset = datasetStructure( gt_dir(1), gt_dir(2) );

[ mPre, mRecall, mFmeasure, mHitRate , mFalseAlarm, AUC ] = ...
    performCalcu_Rect(dataset,alg_dir_FF);

basedir = './base_pr_bar_fig/';
mkdir(basedir);
save( [ basedir 'base_Omron'], 'mPre', 'mRecall', 'mFmeasure', 'mHitRate', 'mFalseAlarm', 'AUC' );

curve_bar_plot( basedir, gt_dir, alg_dir, mPre, mRecall, mFmeasure, AUC );

clear all;
close all;
% system('shutdown -s')
