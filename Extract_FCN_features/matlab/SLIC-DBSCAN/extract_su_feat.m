function [Sp,focusness,mean_focusness]= extract_su_feat(im,Am,l,colopt)
    focusness_p = CalFocus_p(im);
    mean_focusness = mean(focusness_p(:));
    MEANCENTRE = 1;
    MEDIANCENTRE = 2;
    [LBP_map,~] = LBP_uniform(rgb2gray(im));
    if strcmp(colopt, 'mean')
        centre = MEANCENTRE;
    elseif strcmp(colopt, 'median')
        centre = MEDIANCENTRE;        
    else
        error('Invalid colour centre computation option');
    end
imlab = rgb2lab(im);
% [rows, cols, ~] = size(imlab);
N = length(Am);
% %     Sp = struct('L', cell(1,N), 'a', cell(1,N), 'b', cell(1,N), ...
% %                 'stdL', cell(1,N), 'stda', cell(1,N), 'stdb', cell(1,N), ...
% %                 'r', cell(1,N), 'c', cell(1,N), 'N', cell(1,N));
    Sp = struct('L', cell(1,N), 'a', cell(1,N), 'b', cell(1,N), ...
                'N', cell(1,N),'R', cell(1,N), 'G', cell(1,N), 'B', cell(1,N), ...
                'LBP',cell(1,N),'pixelInd',cell(1,N),'pixelIndxy',cell(1,N),'focusness',cell(1,N));
%     [X,Y] = meshgrid(1:cols, 1:rows);
    L = imlab(:,:,1);    
    A = imlab(:,:,2);    
    B = imlab(:,:,3); 
    R = im(:,:,1);
    G = im(:,:,2);
    Bc = im(:,:,3);
%     regions = calculateRegionProps(supNum,sulabel);

    focusness = zeros(N,1);
    for n = 1:N
        indxy = find(l==n);
        [indx, indy] = find(l==n);
        Sp(n).pixelInd = indxy;
        Sp(n).pixelIndxy = [indx indy];
        f_temp = mean(focusness_p(indxy));
        Sp(n).focusness = f_temp;
        focusness(n) = f_temp;
        temp = LBP_map(indxy);
        lbp_vals = hist(temp,1:59);
        Sp(n).LBP = lbp_vals;
        mask = l==n;
        nm = sum(mask(:));
        if centre == MEANCENTRE     
            Sp(n).L = sum(L(mask))/nm;
            Sp(n).a = sum(A(mask))/nm;
            Sp(n).b = sum(B(mask))/nm;
        elseif centre == MEDIANCENTRE
            Sp(n).L = median(L(mask));
            Sp(n).a = median(A(mask));
            Sp(n).b = median(B(mask));
        end
        Sp(n).R = sum(R(mask))/nm;
        Sp(n).G = sum(G(mask))/nm;
        Sp(n).B = sum(Bc(mask))/nm;
%         Sp(n).r = sum(Y(mask))/nm;
%         Sp(n).c = sum(X(mask))/nm;
        
        % Compute standard deviations of the colour components of each super
        % pixel. This can be used by code seeking to merge superpixels into
        % image segments.  Note these are calculated relative to the mean colour
        % component irrespective of the centre being calculated from the mean or
        % median colour component values.
%         Sp(n).stdL = std(L(mask));
%         Sp(n).stda = std(A(mask));
%         Sp(n).stdb = std(B(mask));

        Sp(n).N = nm;  % Record number of pixels in superpixel too.
    end