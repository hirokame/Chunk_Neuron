function repeat_heatmap

%%% gt3とlt2のdevideヒートマップの解析
%%% devideのヒートマップを平均が1になるように標準化してもとのFigureに上書きするプログラム

path = 'C:\Users\C238\Desktop\touchcellLtRt_Hirokane';
savepath = 'C:\Users\C238\Desktop\Rhythm';
patternnum = 1;
for i=1:82 %それぞれの細胞でイテレーションを回す。 
    path1 = [path, '\', num2str(i)];
    cd(path1)
    LS = ls;
    heat_file=[];
    for j=1:length(LS(:,1))
        file1 = strfind(LS(j,:), 'heatmap.mat');
        if ~isempty(file1)
            heat_file = [heat_file; LS(j,:)];
        end
    end
    if ~isempty(heat_file)
        for j=1:length(heat_file(:,1))
            cd(path1)
            patternnum=patternnum+1
            
            LtPositiveFiringRateArray_devide = load(heat_file(j,:), 'LtPositiveFiringRateArray_devide');
            RtPositiveFiringRateArray_devide = load(heat_file(j,:), 'RtPositiveFiringRateArray_devide');
            LtPositiveFiringRateArray_devide = cell2mat(struct2cell(LtPositiveFiringRateArray_devide));
            RtPositiveFiringRateArray_devide = cell2mat(struct2cell(RtPositiveFiringRateArray_devide));
            
            %%%平均値で割り算
            LtPositiveFiringRateArray_devide = LtPositiveFiringRateArray_devide.*(1/mean(mean(LtPositiveFiringRateArray_devide)));
            RtPositiveFiringRateArray_devide = RtPositiveFiringRateArray_devide.*(1/mean(mean(RtPositiveFiringRateArray_devide)));
            
            
            
            h=HeatMap(LtPositiveFiringRateArray_devide,'Colormap',jet);
            h.plot
            figname=[num2str(patternnum),'Heatmap_LP_gt3.bmp'];
            saveas(gcf,figname)
            
            h=HeatMap(RtPositiveFiringRateArray_devide,'Colormap',jet);
            h.plot
            figname=[num2str(patternnum),'Heatmap_RP_gt3.bmp'];
            saveas(gcf,figname)
            cd(savepath)
            filename=[num2str(patternnum),'heatmap.mat'];
            save(filename,'LtPositiveFiringRateArray_devide','RtPositiveFiringRateArray_devide')
                               
        end
    end
end