function Repeat_heatmap_analysis_eachwindow

%%% ヒートマップ0~5(何回当てはまったか)それぞれの解析
%%% それぞれのヒートマップの一番大きな値or上位1/4とかでその細胞の繰り返し時の発火頻度を計算する。

path='C:\Users\C238\CheetahWRLV20220213\touchcellLtRt_Hirokane';
Left_FR = double.empty(5,0);
Right_FR = double.empty(5,0);
LeftP1_FR = double.empty(5,0);
RightP1_FR = double.empty(5,0);

for i=1:149 %それぞれの細胞でイテレーションを回す。 
    path1 = [path, '\', num2str(i)];
    cd(path1)
    LS = ls;
    heat_file=[];
    modulation_file=[];
    for j=1:length(LS(:,1))
        response = load('response.mat');
        file = strfind(LS(j,:), 'heatmap_each.mat');
        mod_file = strfind(LS(j,:), 'ph_int_fromBgra98.mat');
        if ~isempty(file)
            heat_file = [heat_file; LS(j,:)];
        end
        if ~isempty(mod_file)
            modulation_file = [modulation_file; LS(j,:)];
        end
    end
    if ~isempty(heat_file)
        for j=1:length(heat_file(:,1))
            RintPeak = load(modulation_file(j,:),'RintPeak');
            RintPeak = round((RintPeak.RintPeak-280)/20);
            LintPeak = load(modulation_file(j,:),'LintPeak');
            LintPeak = round((LintPeak.LintPeak-280)/20);
            RphPeak = load(modulation_file(j,:),'RphPeakIndexRatio');
            RphPeak = round(RphPeak.RphPeakIndexRatio*10+1);
            LphPeak = load(modulation_file(j,:),'LphPeakIndexRatio');
            LphPeak = round(LphPeak.LphPeakIndexRatio*10+1);
            
%             LtPositiveFiringRateArray_0 = load(heat_file(j,:), 'LtPositiveFiringRateArray_0');
            LtPositiveFiringRateArray_1 = load(heat_file(j,:), 'LtPositiveFiringRateArray_1');
            LtPositiveFiringRateArray_2 = load(heat_file(j,:), 'LtPositiveFiringRateArray_2');
            LtPositiveFiringRateArray_3 = load(heat_file(j,:), 'LtPositiveFiringRateArray_3');
            LtPositiveFiringRateArray_4 = load(heat_file(j,:), 'LtPositiveFiringRateArray_4');
            LtPositiveFiringRateArray_5 = load(heat_file(j,:), 'LtPositiveFiringRateArray_5');
            
%             RtPositiveFiringRateArray_0 = load(heat_file(j,:), 'RtPositiveFiringRateArray_0');
            RtPositiveFiringRateArray_1 = load(heat_file(j,:), 'RtPositiveFiringRateArray_1');
            RtPositiveFiringRateArray_2 = load(heat_file(j,:), 'RtPositiveFiringRateArray_2');
            RtPositiveFiringRateArray_3 = load(heat_file(j,:), 'RtPositiveFiringRateArray_3');
            RtPositiveFiringRateArray_4 = load(heat_file(j,:), 'RtPositiveFiringRateArray_4');
            RtPositiveFiringRateArray_5 = load(heat_file(j,:), 'RtPositiveFiringRateArray_5');
            
%             LtPositiveFiringRateArrayP1_0 = load(heat_file(j,:), 'LtPositiveFiringRateArrayP1_0');
%             LtPositiveFiringRateArrayP1_1 = load(heat_file(j,:), 'LtPositiveFiringRateArrayP1_1');
%             LtPositiveFiringRateArrayP1_2 = load(heat_file(j,:), 'LtPositiveFiringRateArrayP1_2');
%             LtPositiveFiringRateArrayP1_3 = load(heat_file(j,:), 'LtPositiveFiringRateArrayP1_3');
%             LtPositiveFiringRateArrayP1_4 = load(heat_file(j,:), 'LtPositiveFiringRateArrayP1_4');
%             LtPositiveFiringRateArrayP1_5 = load(heat_file(j,:), 'LtPositiveFiringRateArrayP1_5');
%             
%             RtPositiveFiringRateArrayP1_0 = load(heat_file(j,:), 'RtPositiveFiringRateArrayP1_0');
%             RtPositiveFiringRateArrayP1_1 = load(heat_file(j,:), 'RtPositiveFiringRateArrayP1_1');
%             RtPositiveFiringRateArrayP1_2 = load(heat_file(j,:), 'RtPositiveFiringRateArrayP1_2');
%             RtPositiveFiringRateArrayP1_3 = load(heat_file(j,:), 'RtPositiveFiringRateArrayP1_3');
%             RtPositiveFiringRateArrayP1_4 = load(heat_file(j,:), 'RtPositiveFiringRateArrayP1_4');
%             RtPositiveFiringRateArrayP1_5 = load(heat_file(j,:), 'RtPositiveFiringRateArrayP1_5');
            
%             LtPositiveFiringRateArray_0 = cell2mat(struct2cell(LtPositiveFiringRateArray_0));
            LtPositiveFiringRateArray_1 = cell2mat(struct2cell(LtPositiveFiringRateArray_1));
            LtPositiveFiringRateArray_2 = cell2mat(struct2cell(LtPositiveFiringRateArray_2));
            LtPositiveFiringRateArray_3 = cell2mat(struct2cell(LtPositiveFiringRateArray_3));
            LtPositiveFiringRateArray_4 = cell2mat(struct2cell(LtPositiveFiringRateArray_4));
            LtPositiveFiringRateArray_5 = cell2mat(struct2cell(LtPositiveFiringRateArray_5));
            
%             RtPositiveFiringRateArray_0 = cell2mat(struct2cell(RtPositiveFiringRateArray_0));
            RtPositiveFiringRateArray_1 = cell2mat(struct2cell(RtPositiveFiringRateArray_1));
            RtPositiveFiringRateArray_2 = cell2mat(struct2cell(RtPositiveFiringRateArray_2));
            RtPositiveFiringRateArray_3 = cell2mat(struct2cell(RtPositiveFiringRateArray_3));
            RtPositiveFiringRateArray_4 = cell2mat(struct2cell(RtPositiveFiringRateArray_4));
            RtPositiveFiringRateArray_5 = cell2mat(struct2cell(RtPositiveFiringRateArray_5));
            
%             LtPositiveFiringRateArrayP1_0 = cell2mat(struct2cell(LtPositiveFiringRateArrayP1_0));
%             LtPositiveFiringRateArrayP1_1 = cell2mat(struct2cell(LtPositiveFiringRateArrayP1_1));
%             LtPositiveFiringRateArrayP1_2 = cell2mat(struct2cell(LtPositiveFiringRateArrayP1_2));
%             LtPositiveFiringRateArrayP1_3 = cell2mat(struct2cell(LtPositiveFiringRateArrayP1_3));
%             LtPositiveFiringRateArrayP1_4 = cell2mat(struct2cell(LtPositiveFiringRateArrayP1_4));
%             LtPositiveFiringRateArrayP1_5 = cell2mat(struct2cell(LtPositiveFiringRateArrayP1_5));
%             
%             RtPositiveFiringRateArrayP1_0 = cell2mat(struct2cell(RtPositiveFiringRateArrayP1_0));
%             RtPositiveFiringRateArrayP1_1 = cell2mat(struct2cell(RtPositiveFiringRateArrayP1_1));
%             RtPositiveFiringRateArrayP1_2 = cell2mat(struct2cell(RtPositiveFiringRateArrayP1_2));
%             RtPositiveFiringRateArrayP1_3 = cell2mat(struct2cell(RtPositiveFiringRateArrayP1_3));
%             RtPositiveFiringRateArrayP1_4 = cell2mat(struct2cell(RtPositiveFiringRateArrayP1_4));
%             RtPositiveFiringRateArrayP1_5 = cell2mat(struct2cell(RtPositiveFiringRateArrayP1_5));
            
            %%%%%普通にheatmapのmaxの値で計算
%             Left_FR = cat(2,Left_FR,[max(max(LtPositiveFiringRateArray_1));max(max(LtPositiveFiringRateArray_2));max(max(LtPositiveFiringRateArray_3));max(max(LtPositiveFiringRateArray_4));max(max(LtPositiveFiringRateArray_5))]);
%             Right_FR = cat(2,Right_FR,[max(max(RtPositiveFiringRateArray_1));max(max(RtPositiveFiringRateArray_2));max(max(RtPositiveFiringRateArray_3));max(max(RtPositiveFiringRateArray_4));max(max(RtPositiveFiringRateArray_5))]);
%             
%             LeftP1_FR = cat(2,LeftP1_FR,[max(max(LtPositiveFiringRateArrayP1_0));max(max(LtPositiveFiringRateArrayP1_1));max(max(LtPositiveFiringRateArrayP1_2));max(max(LtPositiveFiringRateArrayP1_3));max(max(LtPositiveFiringRateArrayP1_4));max(max(LtPositiveFiringRateArrayP1_5))]);
%             RightP1_FR = cat(2,RightP1_FR,[max(max(RtPositiveFiringRateArrayP1_0));max(max(RtPositiveFiringRateArrayP1_1));max(max(RtPositiveFiringRateArrayP1_2));max(max(RtPositiveFiringRateArrayP1_3));max(max(RtPositiveFiringRateArrayP1_4));max(max(RtPositiveFiringRateArrayP1_5))]);            
            
            %%%%% 位相、周期細反応性に基づいたwindowで解析
            Left_FR = cat(2,Left_FR,[LtPositiveFiringRateArray_1(LintPeak,LphPeak);LtPositiveFiringRateArray_2(LintPeak,LphPeak);LtPositiveFiringRateArray_3(LintPeak,LphPeak);LtPositiveFiringRateArray_4(LintPeak,LphPeak);LtPositiveFiringRateArray_5(LintPeak,LphPeak)]);
            Right_FR = cat(2,Right_FR,[RtPositiveFiringRateArray_1(RintPeak,RphPeak);RtPositiveFiringRateArray_2(RintPeak,RphPeak);RtPositiveFiringRateArray_3(RintPeak,RphPeak);RtPositiveFiringRateArray_4(RintPeak,RphPeak);RtPositiveFiringRateArray_5(RintPeak,RphPeak)]);
%          
        end
    end
end
cd(path)
filename='repeat_FR_from_heatmap.mat';
save(filename,'Left_FR','Right_FR','LeftP1_FR','Right_FR')

format longEng

figure('Name','Left FR','NumberTitle','off');
data = Left_FR;
x = 1:5;
y = mean(data,2);
SEM = std(data,0,2)./sqrt(length(data));
bar(x,y);
hold on
err = errorbar(y,SEM);
err.LineStyle = 'None';
err.Color = 'k';
hold off
saveas(gcf, 'Left_FR.bmp')
[p,~,stats] = anova1(Left_FR.')
[results,means] = multcompare(stats,'CType','bonferroni')

figure('Name','Right FR','NumberTitle','off');
data = Right_FR;
y = mean(data,2);
SEM = std(data,0,2)./sqrt(length(data));
bar(x,y);
hold on 
err = errorbar(y,SEM);
err.LineStyle = 'None';
err.Color = 'k';
hold off
saveas(gcf, 'Right_FR.bmp')
[p,~,stats] = anova1(Right_FR.')
[results,means] = multcompare(stats,'CType','bonferroni')


% figure('Name','Left P1 FR','NumberTitle','off');
% y = LeftP1_FR;
% bar(x,y)
% savefig('LeftP1_FR.fig')
% 
% figure('Name','Right P1 FR','NumberTitle','off');
% y = RightP1_FR;
% bar(x,y)
% savefig('RightP1_FR.fig')