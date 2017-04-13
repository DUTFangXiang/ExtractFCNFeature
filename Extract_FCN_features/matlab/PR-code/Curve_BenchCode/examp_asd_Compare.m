%%
% ASD
clear all;
close all;
gt_dir = { 'ASD', 'J:\hsaliency&cosaliency code\ASDgt\' };
alg_dir = ...
    { { 'Ours', 'E:\Map\code_absorb_MC\code_absorb_MC\map\', [], [], 'png' }
    };
% { {'Ours', 'J:\hsaliency&cosaliency code\MSRAsalmap\', [], '_stage2', 'png'}
% {'CB', 'E:\Map\CB_Map_5000\', [], [], 'png'}
% {'SVO', 'E:\Map\SVOmap\', [], [], 'jpg'}
% {'SF', 'E:\Map\SF_maps\', [], [], 'jpg'}
% {'XIE', 'E:\Map\Xie_SaliencyMap\SaliencyMap\', [], '_OUR', 'jpg'}
% {'RC', 'E:\Map\RC_5000\', [], [], 'png'}
% {'GS', 'E:\Map\Berkeley300_GS_SP\', [], '.jpg_GS_SP', 'png'}
% {'CA', 'E:\Map\CAmap\', [], '_SaliencyMap', 'jpg'}
% {'FT', 'E:\Map\FT_5000\', [], [], 'png'}
% {'GB', 'E:\Map\Gbvs_Map\', [], [], 'png'}
% {'SR', 'E:\Map\SRmap\', [], '_SR', 'png'}
% {'LC', 'E:\Map\LCmap\', [], '_LC', 'png'}
% {'AC', 'e:/Map/'  , [], [], 'png'}
% {'MZ', 'e:/Map/'  , [], [], 'png'}
% {'IT', 'E:\Map\Itmap5000\', [], [], 'png'} };

alg_dir_FF = candidateAlgStructure( alg_dir );
dataset = datasetStructure( gt_dir(1), gt_dir(2) );

[ mPre, mRecall, mFmeasure, mHitRate , mFalseAlarm, AUC ] = ...
    performCalcu(dataset,alg_dir_FF);

basedir = './base_pr_bar_figtem/';
mkdir(basedir);
save( [ basedir 'base_amc'], 'mPre', 'mRecall', 'mFmeasure', 'mHitRate', 'mFalseAlarm', 'AUC' );

curve_bar_plot( basedir, gt_dir, alg_dir, mPre, mRecall, mFmeasure, AUC );


% % SED1
% clear all;
% close all;
% gt_dir = { 'SED1', 'E:\SED\GrdSed1\' };
% alg_dir = ...
% { {'Ours', 'J:\hsaliency&cosaliency code\SED1salmap\', [], '_stage2', 'png'}
% {'CB', 'E:\SED\CB_Map_SED1\', [], [], 'png'}
% {'SVO', 'E:\SED\Svo_CA_map_SED1\', [], '_svo', 'png'}
% {'RC', 'E:\SED\RCSed1\', [], '_RC', 'png'}
% {'CA', 'E:\SED\Svo_CA_map_SED1\', [], '_CA_', 'png'}
% {'FT', 'E:\SED\FTSed1\', [], '_FT', 'png'}
% {'GB', 'E:\SED\GbvsMapSED1\', [], [], 'png'}
% {'SR', 'E:\SED\RCSed\', [], '_SR', 'png'}
% {'LC', 'E:\SED\RCSed\', [], '_LC', 'png'}
% {'IT', 'E:\SED\ItmapSed1\', [], [], 'png'} };
% 
% alg_dir_FF = candidateAlgStructure( alg_dir );
% dataset = datasetStructure( gt_dir(1), gt_dir(2) );
% 
% [ mPre, mRecall, mFmeasure, mHitRate , mFalseAlarm, AUC ] = ...
%     performCalcu(dataset,alg_dir_FF);
% 
% curve_bar_plot( gt_dir, alg_dir, mPre, mRecall, mFmeasure, AUC );
% 
% basedir = './base_pr_bar_fig/';
% mkdir(basedir);
% save( [ basedir 'base_SED1'], 'mPre', 'mRecall', 'mFmeasure', 'mHitRate', 'mFalseAlarm', 'AUC' );
%  
% % SED2
% clear all;
% close all;
% gt_dir = { 'SED2', 'E:\SED\GrdSed2\' };
% alg_dir = ...
% { {'Ours', 'J:\hsaliency&cosaliency code\SED2salmap\', [], '_stage2', 'png'}
% {'CB', 'E:\SED\CB_Map_SED2\', [], [], 'png'}
% {'SVO', 'E:\SED\Svo_CA_map_SED2\', [], '_svo', 'png'}
% {'RC', 'E:\SED\RCSed2\', [], '_RC', 'png'}
% {'CA', 'E:\SED\Svo_CA_map_SED2\', [], '_CA_', 'png'}
% {'FT', 'E:\SED\FTSed2\', [], '_FT', 'png'}
% {'GB', 'E:\SED\GbvsMapSED2\', [], [], 'png'}
% {'SR', 'E:\SED\RCSed\', [], '_SR', 'png'}
% {'LC', 'E:\SED\RCSed\', [], '_LC', 'png'}
% {'IT', 'E:\SED\ItmapSed2\', [], [], 'png'} };
% 
% alg_dir_FF = candidateAlgStructure( alg_dir );
% dataset = datasetStructure( gt_dir(1), gt_dir(2) );
% 
% [ mPre, mRecall, mFmeasure, mHitRate , mFalseAlarm, AUC ] = ...
%     performCalcu(dataset,alg_dir_FF);
% 
% curve_bar_plot( gt_dir, alg_dir, mPre, mRecall, mFmeasure, AUC );
% 
% basedir = './base_pr_bar_fig/';
% mkdir(basedir);
% save( [ basedir 'base_SED2'], 'mPre', 'mRecall', 'mFmeasure', 'mHitRate', 'mFalseAlarm', 'AUC' );
% 
% 
% % SOD
% clear all;
% close all;
% gt_dir = { 'SOD', 'E:\Map\BSD298Masks\' };
% alg_dir = ...
% { {'Ours', 'J:\hsaliency&cosaliency code\SODsalmap\', [], '_stage2', 'png'}
% {'GS', 'E:\Map\Berkeley300_GS_SP\', [], '.jpg_GS_SP', 'png'}
% {'CB', 'E:\Map\CB_Map_berke\', [], [], 'png'}
% {'SVO', 'E:\Map\Svo_CA_map_Berke\', [], '_svo', 'png'}
% {'RC', 'E:\Map\RC_Berke\', [], '_RC', 'png'}
% {'CA', 'E:\Map\Svo_CA_map_Berke\', [], '_CA_', 'png'}
% {'FT', 'E:\Map\RC_Berke\', [], '_FT', 'png'}
% {'GB', 'E:\Map\Gbvs_Map_berke\', [], [], 'png'}
% {'SR', 'E:\Map\RC_Berke\', [], '_SR', 'png'}
% {'LC', 'E:\Map\RC_Berke\', [], '_LC', 'png'}
% {'IT', 'E:\Map\Itti_Map_berke\', [], [], 'png'} };
% 
% alg_dir_FF = candidateAlgStructure( alg_dir );
% dataset = datasetStructure( gt_dir(1), gt_dir(2) );
% 
% [ mPre, mRecall, mFmeasure, mHitRate , mFalseAlarm, AUC ] = ...
%     performCalcu(dataset,alg_dir_FF);
% 
% curve_bar_plot( gt_dir, alg_dir, mPre, mRecall, mFmeasure, AUC );
% 
% basedir = './base_pr_bar_fig/';
% mkdir(basedir);
% save( [ basedir 'base_SOD'], 'mPre', 'mRecall', 'mFmeasure', 'mHitRate', 'mFalseAlarm', 'AUC' );
% 
% clear all;
% close all;
% % system('shutdown -s')
