%%
function [ mPre, mRecall, mFmeasure, mHitRate , mFalseAlarm, AUC ] = ...
    performCalcu(datasetStruct,algStructArray) %输入真值库的名字，以及候选算法的结构体

evaluateSal = @(sMap,thresholds,gtMap) thresholdBased_HR_FR(sMap,thresholds,gtMap);
% switch lower(datasetStruct.datasetName)
%     case 'msra'
%         evaluateSal = @(sMap,thresholds,gtMap) MSRAthresholdBased_HR_FR(sMap,thresholds,gtMap);
%     case 'asd'
%     case 'sed1'
%     case 'sed2'
%     case 'sod'
%         %         Do nothing
%     otherwise
%         fprintf('\nPerforming analysis on unknown dataset (%s)\nMake sure that the ground-truth maps are handled correctly\n',datasetStruct.datasetName);
% end

fprintf(['\nEvaluating dataset: ' datasetStruct.datasetName '\n']);
thresholds = 1:-.05:0;         %分成21份，
GTfiles=dir([datasetStruct.GTdir '/*.png']); %返回真值库的元素的结构体1000*！
GTfiles = [GTfiles; dir([datasetStruct.GTdir '/*.jpg'])];
GTfiles = [GTfiles; dir([datasetStruct.GTdir '/*.bmp'])];%选择真值库里面某种格式的图像

numOfFiles = size(GTfiles,1);%1000*1
numOfAlgos = length(algStructArray);  %输入的候选算法的个数
%hitRate：1000*21*4零矩阵；同理[falseAlarm，Pre, Recall]，4表示4个算法

[hitRate, falseAlarm] = deal(zeros(numOfFiles,length(thresholds),numOfAlgos));%

%%目的是生成一个关于pr的矩阵组
[Pre, Recall] = deal(zeros(numOfFiles,length(thresholds),numOfAlgos));
[Fmeasure] = deal(zeros(numOfFiles,3,numOfAlgos)); %1000*3*4

%Iterate over images
for imIndx=1:numOfFiles  %1000个文件
    
%      if imIndx == 5
%          break;
%      end

    fprintf('Processing image %i out of %i\n',imIndx,numOfFiles);
    [~,base_name,ext] = fileparts(GTfiles(imIndx).name); %返回真值库里第一张图片的名字，格式
    %将其变为0~1之间大小
    gtMap = im2double(imread([datasetStruct.GTdir base_name ext]));
    gtSize = size(gtMap); %如果不是单通道的，变为灰度图像（单通道）
    if (length(gtSize) == 3)
        gtMap = rgb2gray(gtMap);
        gtSize(3)= [];
    end
    gtMap = logical(gtMap>=0.1); %对输入图像处理一下，顺便变成逻辑矩阵
    totalNum = numOfFiles* ones(numOfAlgos,1); %4*1   ( [1000;1000;1000;1000] ) 
    for algIdx = 1:numOfAlgos %考虑每个（4个）候选算法，计算出每个算法中相应的第一张图片的pr，存在Pre, Recall的第一行里面
        if strcmp(algStructArray{numOfAlgos}.dir(end-12:end-7),'useLBP')
            sMap = readSaliencyMap(algStructArray{algIdx},[base_name,'_LBP'],gtSize);
        elseif strcmp(algStructArray{numOfAlgos}.dir(end-12:end-7),'stage1')
            sMap = readSaliencyMap(algStructArray{algIdx},[base_name,'_stage1'],gtSize);
        elseif strcmp(algStructArray{numOfAlgos}.dir(end-12:end-7),'stage2')
            sMap = readSaliencyMap(algStructArray{algIdx},[base_name,'_stage2'],gtSize);
        elseif strcmp(algStructArray{numOfAlgos}.dir(end-12:end-7),'stage3')
            sMap = readSaliencyMap(algStructArray{algIdx},[base_name,'_stage3'],gtSize);
        elseif strcmp(algStructArray{numOfAlgos}.dir(end-13:end-7),'useLBP2')
            sMap = readSaliencyMap(algStructArray{algIdx},[base_name,'_LBP'],gtSize);
        elseif strcmp(algStructArray{numOfAlgos}.dir(end-12:end-7),'LBPLAB')
            sMap = readSaliencyMap(algStructArray{algIdx},[base_name,'_LBP'],gtSize);
        elseif strcmp(algStructArray{numOfAlgos}.dir(end-12:end-7),'useLAB')
            sMap = readSaliencyMap(algStructArray{algIdx},[base_name,'_Lab'],gtSize);
        elseif strcmp(algStructArray{numOfAlgos}.dir(end-13:end-7),'LBPLAB2')
            sMap = readSaliencyMap(algStructArray{algIdx},[base_name,'_LBP'],gtSize);
        else
            sMap = readSaliencyMap(algStructArray{algIdx},[base_name],gtSize);%读入第一个候选算法中相应的显著性图像
        end
        if sum(sum(sMap)) == 0
            totalNum(algIdx) = totalNum(algIdx) - 1;
        end
                
        [Pre(imIndx,:,algIdx), Recall(imIndx,:,algIdx), ...        %计算出该候选算法中的想阻性图像的Pre，Recall，
         hitRate(imIndx,:,algIdx), falseAlarm(imIndx,:,algIdx)] ...
            = evaluateSal(sMap,thresholds,gtMap);
        
        [Fmeasure(imIndx,:,algIdx)] = Fmeasure_calu(sMap,gtMap,gtSize);
    end
    
end %End of image loop

%Average across images -
mmHitRate = permute( sum(hitRate,1),[2 3 1] );
mmFalseAlarm = permute( sum(falseAlarm,1),[2 3 1]);

%% 关于pr的计算
mmPre = permute( sum(Pre,1),[2 3 1]);  %sum(Pre,1),把每列相加，得到一个行向量  %permute此时相当于把向量（矩阵）转置
mmRecall = permute( sum(Recall,1),[2 3 1]);
mmFmeasure = permute( sum(Fmeasure,1),[2 3 1]);
for j=1:numOfAlgos
    mmHitRate(:,j) = mmHitRate(:,j)./totalNum(j);
    mmFalseAlarm(:,j) = mmFalseAlarm(:,j)./totalNum(j);%均值
    mmPre(:,j) = mmPre(:,j)./totalNum(j);%均值
    mmRecall(:,j) = mmRecall(:,j)./totalNum(j);
    mmFmeasure(:,j) = mmFmeasure(:,j)./totalNum(j);
end
mHitRate = mmHitRate;
mFalseAlarm = mmFalseAlarm;
mPre = mmPre;
mRecall = mmRecall;
mFmeasure = mmFmeasure;    

AUC = nan(1,size(mFalseAlarm,2));
for algIdx=1:numOfAlgos
        AUC(algIdx) = trapz(mFalseAlarm(:,algIdx),mHitRate(:,algIdx));
end

end



%% 备用函数

% Read and resize saliency map
function sMap = readSaliencyMap(algStruct,base_name,gtSize)
file_name = fullfile(algStruct.dir,[algStruct.prefix base_name algStruct.postfix '.' algStruct.ext]);
% sMap = imresize(im2double(imread([file_name(1:end-7),'FT.png'])),gtSize(1:2));
% sMap = imresize(im2double(imread([file_name(1:end-7),'.png'])),gtSize(1:2));
% sMap = imresize(im2double(imread([file_name(1:end-8),'.jpg'])),gtSize(1:2));
sMap = imresize(im2double(imread(file_name)),gtSize(1:2));
if (size(sMap,3)==3)
    sMap = rgb2gray(sMap);
end
sMap(sMap<0)=0;
maxnum = max(sMap(:));
if maxnum==0
    sMap = zeros(gtSize(1:2));
else
    sMap = sMap./maxnum;
end  

end


function [Pre, Recall, hitRate, falseAlarm] ...
    = thresholdBased_HR_FR(sMap,thresholds,gtMap) %输入显著性图像，阈值，真值图像（逻辑值）
numOfThreshs = length(thresholds);  %阈值组的大小
%此时的Pre表示的是计算pr曲线用的
[Pre, Recall, hitRate, falseAlarm] = deal(zeros(1,numOfThreshs));%生成4个 1*21的零向量
for threshIdx=1:numOfThreshs
    cThrsh=thresholds(threshIdx);   %阈值按照从大到小的顺序 
    [Pre(threshIdx), Recall(threshIdx), hitRate(threshIdx), falseAlarm(threshIdx)] ...
        = Pre_Recall_hitRate((sMap>=cThrsh),gtMap);    %输入的是两个逻辑值，注意此时是大于等于
end
end


% function [hitRate, falseAlarm] = MSRAthresholdBased_HR_FR(sMap,thresholds,gtMap)
% numOfThreshs = length(thresholds);
% [hitRate, falseAlarm] = deal(zeros(1,numOfThreshs));
% 
% for threshIdx=1:numOfThreshs
%     cThrsh=thresholds(threshIdx);
%     STATS = regionprops(uint8(sMap>=cThrsh),'BoundingBox');
%     bMap = zeros(size(sMap));
%     bbox = round([STATS.BoundingBox]);
%     if (numel(bbox)>0)
%         bMap(bbox(2):(bbox(2)+bbox(4)-1),bbox(1):(bbox(1)+bbox(3)-1))=1;
%     end
%     [hitRate(threshIdx) , falseAlarm(threshIdx)] = hitRates(bMap,gtMap);    
% end
% end



