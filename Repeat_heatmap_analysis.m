function Repeat_heatmap_analysis

%%% gt3とlt2のdevideのヒートマップの解析
%%% devideのヒートマップでのmodulationとcomplex patternでのmodulationを直接計算したものを比較している。

path='C:\Users\C238\Desktop\touchcellLtRt_Hirokane';

R_interval_mod=[];
L_interval_mod=[];
R_interval_mod_heat=[];
L_interval_mod_heat=[];

R_phase_mod=[];
L_phase_mod=[];
R_phase_mod_heat=[];
L_phase_mod_heat=[];

for i=1:82 %それぞれの細胞でイテレーションを回す。 
    path1 = [path, '\', num2str(i)];
    cd(path1)
    LS = ls;
    heat_file=[];
    ph_int_file=[];
    for j=1:length(LS(:,1))
        file1 = strfind(LS(j,:), 'heatmap.mat');
        file2 = strfind(LS(j,:), 'ph_int_fromBgra98.mat');
        if ~isempty(file1)
            heat_file = [heat_file; LS(j,:)];
        end
        if ~isempty(file2)
            ph_int_file = [ph_int_file; LS(j,:)];
        end
    end
    
    if ~isempty(heat_file)
        for j=1:length(heat_file(:,1))
            R_int = load(ph_int_file(j,:), 'RintPeak');
            L_int = load(ph_int_file(j,:), 'LintPeak');
            R_ph = load(ph_int_file(j,:), 'RphPeakIndexRatio');
            L_ph = load(ph_int_file(j,:), 'LphPeakIndexRatio');
            
            R_int = cell2mat(struct2cell(R_int));
            L_int = cell2mat(struct2cell(L_int));
            R_ph = cell2mat(struct2cell(R_ph));
            L_ph = cell2mat(struct2cell(L_ph));
            
            R_interval_mod = [R_interval_mod; R_int];
            L_interval_mod = [L_interval_mod; L_int];
            R_phase_mod = [R_phase_mod; R_ph];
            L_phase_mod = [L_phase_mod; L_ph];
            
            
            LtPositiveFiringRateArray_devide = load(heat_file(j,:), 'LtPositiveFiringRateArray_devide');
            RtPositiveFiringRateArray_devide = load(heat_file(j,:), 'RtPositiveFiringRateArray_devide');
            LtPositiveFiringRateArray_devide = cell2mat(struct2cell(LtPositiveFiringRateArray_devide));
            RtPositiveFiringRateArray_devide = cell2mat(struct2cell(RtPositiveFiringRateArray_devide));
            
%             LtPositiveFiringRateArray_gt4 = load(heat_file(j,:), 'LtPositiveFiringRateArray_gt4');
%             RtPositiveFiringRateArray_gt4 = load(heat_file(j,:), 'RtPositiveFiringRateArray_gt4');
%             LtPositiveFiringRateArray_gt4 = cell2mat(struct2cell(LtPositiveFiringRateArray_gt4));
%             RtPositiveFiringRateArray_gt4 = cell2mat(struct2cell(RtPositiveFiringRateArray_gt4));
            
            LtPositiveFiringRateArray_devide(isnan(LtPositiveFiringRateArray_devide))=0;
            RtPositiveFiringRateArray_devide(isnan(RtPositiveFiringRateArray_devide))=0;
            
%             LtPositiveFiringRateArray_gt4(isnan(LtPositiveFiringRateArray_gt4))=0;
%             RtPositiveFiringRateArray_gt4(isnan(RtPositiveFiringRateArray_gt4))=0;
            
            %maximumL = max(max(LtPositiveFiringRateArray_devide, [], 'omitnan'), [], 'omitnan');
            %maximumR = max(max(RtPositiveFiringRateArray_devide, [], 'omitnan'), [], 'omitnan');
            %maxL = find(LtPositiveFiringRateArray_devide==maximumL);
            %maxR = find(RtPositiveFiringRateArray_devide==maximumR);
            
            %intR_heat = (rem((maxR-1), 21)+1)*10+290;
            %intL_heat = (rem((maxL-1), 21)+1)*10+290;
            %phaseR_heat = (fix((maxR-1)/21)+1)*(1/21);
            %phaseL_heat = (fix((maxL-1)/21)+1)*(1/21);
            
            
            %%% phaseとintervalを計算するときはもう片方のindexに関しては平均をとる。 
            %%% phaseの計算の時には列平均mean(A)、intervalの計算の時には行平均mean(A,2)
            %%% devide
            R_intarr = mean(RtPositiveFiringRateArray_devide,2);
            L_intarr = mean(LtPositiveFiringRateArray_devide,2);
            R_phasearr = mean(RtPositiveFiringRateArray_devide);
            L_phasearr = mean(LtPositiveFiringRateArray_devide);
            
            maximum_intR = max(R_intarr);
            intR_heat = find(R_intarr==maximum_intR)*10+290;
            maximum_intL = max(L_intarr);
            intL_heat = find(L_intarr==maximum_intL)*10+290;
            
            maximum_phaseR = max(R_phasearr);
            phaseR_heat = rem(find(R_phasearr==maximum_phaseR)-1,10)*0.1;
            maximum_phaseL = max(L_phasearr);
            phaseL_heat = rem(find(L_phasearr==maximum_phaseL)-1,10)*0.1;
            
            R_interval_mod_heat=[R_interval_mod_heat; intR_heat];
            L_interval_mod_heat=[L_interval_mod_heat; intL_heat];
            R_phase_mod_heat=[R_phase_mod_heat; phaseR_heat];
            L_phase_mod_heat=[L_phase_mod_heat; phaseL_heat];
            
            %%% phaseとintervalを計算するときはもう片方のindexに関しては平均をとる。 
            %%% phaseの計算の時には列平均mean(A)、intervalの計算の時には行平均mean(A,2)
            %%% gt3
%             R_intarr = mean(RtPositiveFiringRateArray_gt4,2);
%             L_intarr = mean(LtPositiveFiringRateArray_gt4,2);
%             R_phasearr = mean(RtPositiveFiringRateArray_gt4);
%             L_phasearr = mean(LtPositiveFiringRateArray_gt4);
%             
%             maximum_intR = max(R_intarr);
%             intR_heat = find(R_intarr==maximum_intR)*10+290;
%             maximum_intL = max(L_intarr);
%             intL_heat = find(L_intarr==maximum_intL)*10+290;
%             
%             maximum_phaseR = max(R_phasearr);
%             phaseR_heat = rem(find(R_phasearr==maximum_phaseR)-1,10)*0.1;
%             maximum_phaseL = max(L_phasearr);
%             phaseL_heat = rem(find(L_phasearr==maximum_phaseL)-1,10)*0.1;
%             
%             R_interval_mod_heat=[R_interval_mod_heat; intR_heat];
%             L_interval_mod_heat=[L_interval_mod_heat; intL_heat];
%             R_phase_mod_heat=[R_phase_mod_heat; phaseR_heat];
%             L_phase_mod_heat=[L_phase_mod_heat; phaseL_heat];
            
            
            %%% intervalの平均を計算するときはphaseの0.8～0～0.2の範囲で計算(Bgra想定)。phaseの計算をするときはintervalの400ms以上で計算。(98のintervalは8なら500ms, 9なら444msだから。)
            %%% devide
%             R_intarr = mean(RtPositiveFiringRateArray_devide(:,[1,2,3,9:13,19,20,21]),2);
%             L_intarr = mean(LtPositiveFiringRateArray_devide(:,[1,2,3,9:13,19,20,21]),2);
%             R_phasearr = mean(RtPositiveFiringRateArray_devide(1:11,:));
%             L_phasearr = mean(LtPositiveFiringRateArray_devide(1:11,:));
%             
%             maximum_intR = max(R_intarr);
%             intR_heat = find(R_intarr==maximum_intR)*10+290;
%             maximum_intL = max(L_intarr);
%             intL_heat = find(L_intarr==maximum_intL)*10+290;
%             
%             maximum_phaseR = max(R_phasearr);
%             phaseR_heat = rem(find(R_phasearr==maximum_phaseR)-1,10)*0.1;
%             maximum_phaseL = max(L_phasearr);
%             phaseL_heat = rem(find(L_phasearr==maximum_phaseL)-1,10)*0.1;
%             
%             
%             R_interval_mod_heat=[R_interval_mod_heat; intR_heat];
%             L_interval_mod_heat=[L_interval_mod_heat; intL_heat];
%             R_phase_mod_heat=[R_phase_mod_heat; phaseR_heat];
%             L_phase_mod_heat=[L_phase_mod_heat; phaseL_heat];
%             
            %%% intervalの平均を計算するときはphaseの0.8～0～0.2の範囲で計算(Bgra想定)。phaseの計算をするときはintervalの400ms以上で計算。(98のintervalは8なら500ms, 9なら444msだから。)
            %%% devide
%             R_intarr = mean(RtPositiveFiringRateArray_gt4(:,[1,2,3,9:13,19,20,21]),2);
%             L_intarr = mean(LtPositiveFiringRateArray_gt4(:,[1,2,3,9:13,19,20,21]),2);
%             R_phasearr = mean(RtPositiveFiringRateArray_gt4(1:11,:));
%             L_phasearr = mean(LtPositiveFiringRateArray_gt4(1:11,:));
%             
%             maximum_intR = max(R_intarr);
%             intR_heat = find(R_intarr==maximum_intR)*10+290;
%             maximum_intL = max(L_intarr);
%             intL_heat = find(L_intarr==maximum_intL)*10+290;
%             
%             maximum_phaseR = max(R_phasearr);
%             phaseR_heat = rem(find(R_phasearr==maximum_phaseR)-1,10)*0.1;
%             maximum_phaseL = max(L_phasearr);
%             phaseL_heat = rem(find(L_phasearr==maximum_phaseL)-1,10)*0.1;
%             
%             
%             R_interval_mod_heat=[R_interval_mod_heat; intR_heat];
%             L_interval_mod_heat=[L_interval_mod_heat; intL_heat];
%             R_phase_mod_heat=[R_phase_mod_heat; phaseR_heat];
%             L_phase_mod_heat=[L_phase_mod_heat; phaseL_heat];
        end
    end
end
cd(path)
filename=['ph_int_modulation.mat'];
save(filename,'R_interval_mod','L_interval_mod','R_phase_mod','L_phase_mod','R_interval_mod_heat','L_interval_mod_heat','R_phase_mod_heat','L_phase_mod_heat')

mod_correlation=figure;
subplot(2,2,1)
x=L_interval_mod;
y=L_interval_mod_heat;
scatter(x,y)
title('Left Interval corr')

subplot(2,2,2)
x=R_interval_mod;
y=R_interval_mod_heat;
scatter(x,y)
title('Right Interval corr')

subplot(2,2,3)
x=L_phase_mod;
y=L_phase_mod_heat;
scatter(x,y)
title('Left Phase corr')

subplot(2,2,4)
x=R_phase_mod;
y=L_phase_mod_heat;
scatter(x,y)
title('Right Phase corr')

figname=['mod_corr.bmp'];
saveas(mod_correlation,figname);



%%%%ヒートマップのデータ"heatmap.mat"からヒートマップ上のどこが最もmodulationを受けているかを判定するプログラム。