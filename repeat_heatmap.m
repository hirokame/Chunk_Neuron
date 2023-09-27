function repeat_heatmap

%%% gt3��lt2��devide�q�[�g�}�b�v�̉��
%%% devide�̃q�[�g�}�b�v�𕽋ς�1�ɂȂ�悤�ɕW�������Ă��Ƃ�Figure�ɏ㏑������v���O����

path = 'C:\Users\C238\Desktop\touchcellLtRt_Hirokane';
savepath = 'C:\Users\C238\Desktop\Rhythm';
patternnum = 1;
for i=1:82 %���ꂼ��̍זE�ŃC�e���[�V�������񂷁B 
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
            
            %%%���ϒl�Ŋ���Z
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