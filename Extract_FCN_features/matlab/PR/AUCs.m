clc;clear;close all;
names = dir('*.mat');
num = length(names);
Names = cell(num,1);
% method_col = { 'r', 'g', 'b', 'm', 'c', '--r', '--g', 'b', 'm--', 'c--' };
% method_col = { 'r', 'g', 'm','c','b','k' ,'y','r-o','g-o','m-o'};
method_col = {[1,0,0],[0,1,0],[0.5 0.5 0.5],[136 0 21]/255,[255 127 39]/255,...
    [0 162 232]/255,[163 73 164]/255,[1 0 1],[0 0 0],[1 1 0],[0 1 1]};
figure;
% SCOREs = cell(num,2);
num_ECSSD = 0;
num_PASCALS = 0;
index_ECSSD = [];
index_PASCALS = [];
for i = 1 : num

    name = names(i).name;
    load(name);
    ind = strfind(name,'_');
    Names{i} = [name(1:ind-1)];
    if strcmp(name(ind+1:end-4),'ECSSD')
        figure(1);
        num_ECSSD = num_ECSSD + 1;
        index_ECSSD = [index_ECSSD,i];
        hold on;
%     for j=1:len
        plot(mRecall,mPre,'Color',method_col{num_ECSSD},'LineWidth',2);
%     end
        grid on;
    elseif strcmp(name(ind+1:end-4),'PASCALS')
        figure(2);
        num_PASCALS = num_PASCALS + 1;
        index_PASCALS = [index_PASCALS,i];
        hold on; 
%     for j=1:len
        plot(mRecall,mPre,'Color',method_col{num_PASCALS},'LineWidth',2);
%     end
        grid on;
    end
%     saveas( figure(4), [basedir, 'msra_pr.fig']);

%     figure(5);
%     barMsra = [mFmeasure' AUC'];
%     bar( barMsra );
%     set( gca, 'xtick', 1:1:len ),
%     grid on;
%     set( gca ,'xticklabels',  method2 , 'fontsize', 8 );
%     legend('Precision','Recall','Fmeasure','AUC');
%     saveas( figure(5), [ basedir, 'msra_bar.fig'] );
%     SCOREs{i,1} = score;
%     SCOREs{i,2} = names(i).name;
end

hold off;
figure(1);
legend( Names{index_ECSSD} );
xlabel('Recall');     ylabel('Precision');
title('ECSSD');
figure(2);
legend( Names{index_PASCALS} );
xlabel('Recall');     ylabel('Precision');
title('PASCAL-S');