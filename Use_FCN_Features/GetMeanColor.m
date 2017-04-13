function meanCol = GetMeanColor(image, pixelList,feat_type)
    [h, w, chn] = size(image);
    if ~strcmp(feat_type,'vgg')
        image = uint8(image*255);
    end
    tmpImg=reshape(image, h*w, chn);
    spNum = length(pixelList);
    meanCol=zeros(spNum, chn);
    for i=1:spNum
        meanCol(i, :)=mean(tmpImg(pixelList{i},:), 1);
    end
end