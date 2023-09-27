function Window_FRanalysis

path='C:\Users\C238\CheetahWRLV20220213\touchcellLtRt_Hirokane';

cd(path)
LS=ls;
Rt4step1 = []; Rt4step2 = []; Rt4step3 = []; Rt4step4 = []; Rt4step5 = [];
Lt4step1 = []; Lt4step2 = []; Lt4step3 = []; Lt4step4 = []; Lt4step5 = [];
Rt3step1 = []; Rt3step2 = []; Rt3step3 = []; Rt3step4 = []; Rt3step5 = []; Rt3step6 = []; Rt3step7 = []; Rt3step8 = []; Rt3step9 = []; Rt3step10 = [];
Lt3step1 = []; Lt3step2 = []; Lt3step3 = []; Lt3step4 = []; Lt3step5 = []; Lt3step6 = []; Lt3step7 = []; Lt3step8 = []; Lt3step9 = []; Lt3step10 = [];

Rt5step_c = []; Rt4step_c = [];Rt3step_c = []; Rt2step_c = []; Rt1step_c = [];
Lt5step_c = []; Lt4step_c = [];Lt3step_c = []; Lt2step_c = []; Lt1step_c = []; %%連続でwindowに入った場合の発火頻度

Rt4step_nc = []; Rt3step_nc = [];
Lt4step_nc = []; Lt3step_nc = [];

cellnum = 0;
for i=1:length(LS) %それぞれの細胞でイテレーションを回す。 
    folder = LS(i,:);
    if ~isempty(strfind(folder,'.'))
        continue
    end
    folder = strtrim(folder);
    path1 = [path, '\', folder];
    cd(path1)
    
    load('response.mat')
    if isempty(strfind(response, 'mod98')) && isempty(strfind(response, 'modBgra')); %% もしRt Lt両足反応性細胞でなければスキップ
        continue
    end
    
    cellnum = cellnum+1;
    
    filename = [num2str(folder), 'FR_compilation.mat'];
    RtFRarray = load(filename, 'RtFRarray');
    RtFRarray = RtFRarray.RtFRarray;
    LtFRarray = load(filename, 'LtFRarray');
    LtFRarray = LtFRarray.LtFRarray;
    

    Rt4step1=[Rt4step1 RtFRarray(2,2,2,2,1)];
    Rt4step2=[Rt4step2 RtFRarray(2,2,2,1,2)];
    Rt4step3=[Rt4step3 RtFRarray(2,2,1,2,2)];
    Rt4step4=[Rt4step4 RtFRarray(2,1,2,2,2)];
    Rt4step5=[Rt4step5 RtFRarray(1,2,2,2,2)];
    
    Lt4step1=[Lt4step1 LtFRarray(2,2,2,2,1)];
    Lt4step2=[Lt4step2 LtFRarray(2,2,2,1,2)];
    Lt4step3=[Lt4step3 LtFRarray(2,2,1,2,2)];
    Lt4step4=[Lt4step4 LtFRarray(2,1,2,2,2)];
    Lt4step5=[Lt4step5 LtFRarray(1,2,2,2,2)];
    
    Rt3step1=[Rt3step1 RtFRarray(2,2,2,1,1)];
    Rt3step2=[Rt3step2 RtFRarray(2,2,1,2,1)];
    Rt3step3=[Rt3step3 RtFRarray(2,2,1,1,2)];
    Rt3step4=[Rt3step4 RtFRarray(2,1,2,2,1)];
    Rt3step5=[Rt3step5 RtFRarray(2,1,2,1,2)];
    Rt3step6=[Rt3step6 RtFRarray(2,1,1,2,2)];
    Rt3step7=[Rt3step7 RtFRarray(1,2,2,2,1)];
    Rt3step8=[Rt3step8 RtFRarray(1,2,2,1,2)];
    Rt3step9=[Rt3step9 RtFRarray(1,2,1,2,2)];
    Rt3step10=[Rt3step10 RtFRarray(1,1,2,2,2)];
    
    Lt3step1=[Lt3step1 LtFRarray(2,2,2,1,1)];
    Lt3step2=[Lt3step2 LtFRarray(2,2,1,2,1)];
    Lt3step3=[Lt3step3 LtFRarray(2,2,1,1,2)];
    Lt3step4=[Lt3step4 LtFRarray(2,1,2,2,1)];
    Lt3step5=[Lt3step5 LtFRarray(2,1,2,1,2)];
    Lt3step6=[Lt3step6 LtFRarray(2,1,1,2,2)];
    Lt3step7=[Lt3step7 LtFRarray(1,2,2,2,1)];
    Lt3step8=[Lt3step8 LtFRarray(1,2,2,1,2)];
    Lt3step9=[Lt3step9 LtFRarray(1,2,1,2,2)];
    Lt3step10=[Lt3step10 LtFRarray(1,1,2,2,2)];
    
    Rt5step_c = [Rt5step_c RtFRarray(2,2,2,2,2)]; 
    Rt4step_c = [Rt4step_c (RtFRarray(1,2,2,2,2)+RtFRarray(2,2,2,2,1))/2];
    Rt3step_c = [Rt3step_c (RtFRarray(1,1,2,2,2)+RtFRarray(1,2,2,2,1)+RtFRarray(2,2,2,1,1))/3]; 
    Rt2step_c = [Rt2step_c (RtFRarray(1,1,1,2,2)+RtFRarray(1,1,2,2,1)+RtFRarray(1,2,2,1,1)+RtFRarray(2,2,1,1,1))/4]; 
    Rt1step_c = [Rt1step_c (RtFRarray(1,1,1,1,2)+RtFRarray(1,1,1,2,1)+RtFRarray(1,1,2,1,1)+RtFRarray(1,2,1,1,1)+RtFRarray(2,1,1,1,1))/5];
    Lt5step_c = [Lt5step_c LtFRarray(2,2,2,2,2)]; 
    Lt4step_c = [Lt4step_c (LtFRarray(1,2,2,2,2)+LtFRarray(2,2,2,2,1))/2];
    Lt3step_c = [Lt3step_c (LtFRarray(1,1,2,2,2)+LtFRarray(1,2,2,2,1)+LtFRarray(2,2,2,1,1))/3]; 
    Lt2step_c = [Lt2step_c (LtFRarray(1,1,1,2,2)+LtFRarray(1,1,2,2,1)+LtFRarray(1,2,2,1,1)+LtFRarray(2,2,1,1,1))/4]; 
    Lt1step_c = [Lt1step_c (LtFRarray(1,1,1,1,2)+LtFRarray(1,1,1,2,1)+LtFRarray(1,1,2,1,1)+LtFRarray(1,2,1,1,1)+LtFRarray(2,1,1,1,1))/5];

    Rt4step_nc = [Rt4step_nc (RtFRarray(2,1,2,2,2)+RtFRarray(2,2,1,2,2)+RtFRarray(2,2,2,1,2))/3];
    Rt3step_nc = [Rt3step_nc (RtFRarray(1,2,1,2,2)+RtFRarray(1,2,2,1,2)+RtFRarray(2,1,1,2,2)+RtFRarray(2,1,2,1,2)+RtFRarray(2,1,2,2,1)+RtFRarray(2,2,1,1,2)+RtFRarray(2,2,1,2,1))/7];
    Lt4step_nc = [Lt4step_nc (LtFRarray(2,1,2,2,2)+LtFRarray(2,2,1,2,2)+LtFRarray(2,2,2,1,2))/3];
    Lt3step_nc = [Lt3step_nc (LtFRarray(1,2,1,2,2)+LtFRarray(1,2,2,1,2)+LtFRarray(2,1,1,2,2)+LtFRarray(2,1,2,1,2)+LtFRarray(2,1,2,2,1)+LtFRarray(2,2,1,1,2)+LtFRarray(2,2,1,2,1))/7];
     
end
Rt4step = [Rt4step1; Rt4step2; Rt4step3; Rt4step4; Rt4step5];
Lt4step = [Lt4step1; Lt4step2; Lt4step3; Lt4step4; Lt4step5];
Rt3step = [Rt3step1; Rt3step2; Rt3step3; Rt3step4; Rt3step5; Rt3step6; Rt3step7; Rt3step8; Rt3step9; Rt3step10];
Lt3step = [Lt3step1; Lt3step2; Lt3step3; Lt3step4; Lt3step5; Lt3step6; Lt3step7; Lt3step8; Lt3step9; Lt3step10];

RtLt4step = (Rt4step+Lt4step)/2;
RtLt3step = (Rt3step+Lt3step)/2;

Rt_c = [Rt1step_c; Rt2step_c; Rt3step_c; Rt4step_c; Rt5step_c];
Lt_c = [Lt1step_c; Lt2step_c; Lt3step_c; Lt4step_c; Lt5step_c];

cd('C:\Users\C238\CheetahWRLV20220213\WindowFigure')

%%%4歩の時のそれぞれのwindowに応じた発火頻度と有意差
Rt4stepFigure=figure;
x = [1 2 3 4 5];
y = mean(Rt4step, 2) ;
bar(x,y)
hold on
SEM = std(Rt4step,0,2)./sqrt(length(Rt4step));
err = errorbar(y,SEM);
err.LineStyle = 'None';
err.Color = 'k';
hold off
title('Rt FiringRate (4step)')
saveas(Rt4stepFigure, 'Rt4stepFR.bmp')
[p,~,stats] = anova1(Rt4step.');
[results,means] = multcompare(stats,'CType','bonferroni');
save('Rt4step.mat', 'p', 'results', 'means')

Lt4stepFigure=figure;
x = [1 2 3 4 5];
y = mean(Lt4step, 2) ;
bar(x,y)
hold on
SEM = std(Lt4step,0,2)./sqrt(length(Lt4step));
err = errorbar(y,SEM);
err.LineStyle = 'None';
err.Color = 'k';
hold off
title('Lt FiringRate (4step)')
saveas(Lt4stepFigure, 'Lt4stepFR.bmp')
[p,~,stats] = anova1(Lt4step.');
[results,means] = multcompare(stats,'CType','bonferroni');
save('Lt4step.mat', 'p', 'results', 'means')

RtLt4stepFigure=figure;
x = [1 2 3 4 5];
y = mean(RtLt4step, 2) ;
bar(x,y)
hold on
SEM = std(RtLt4step,0,2)./sqrt(length(RtLt4step));
err = errorbar(y,SEM);
err.LineStyle = 'None';
err.Color = 'k';
hold off
title('RtLt FiringRate (4step)')
saveas(RtLt4stepFigure, 'RtLt4stepFR.bmp')
[p,~,stats] = anova1(RtLt4step.');
[results,means] = multcompare(stats,'CType','bonferroni');
save('RtLt4step.mat', 'p', 'results', 'means')


%%%3歩の時のそれぞれのwindowに応じた発火頻度と有意差
Rt3stepFigure=figure;
x = [1 2 3 4 5 6 7 8 9 10];
y = mean(Rt3step, 2) ;
bar(x,y)
hold on
SEM = std(Rt3step,0,2)./sqrt(length(Rt3step));
err = errorbar(y,SEM);
err.LineStyle = 'None';
err.Color = 'k';
hold off
title('Rt FiringRate (3step)')
saveas(Rt3stepFigure, 'Rt3stepFR.bmp')
[p,~,stats] = anova1(Rt3step.');
[results,means] = multcompare(stats,'CType','bonferroni');
save('Rt3step.mat', 'p', 'results', 'means')

Lt3stepFigure=figure;
x = [1 2 3 4 5 6 7 8 9 10];
y = mean(Lt3step, 2) ;
bar(x,y)
hold on
SEM = std(Lt3step,0,2)./sqrt(length(Lt3step));
err = errorbar(y,SEM);
err.LineStyle = 'None';
err.Color = 'k';
hold off
title('Lt FiringRate (3step)')
saveas(Lt3stepFigure, 'Lt3stepFR.bmp')
[p,~,stats] = anova1(Lt3step.');
[results,means] = multcompare(stats,'CType','bonferroni');
save('Lt3step.mat', 'p', 'results', 'means')

RtLt3stepFigure=figure;
x = [1 2 3 4 5 6 7 8 9 10];
y = mean(RtLt3step, 2) ;
bar(x,y)
hold on
SEM = std(RtLt3step,0,2)./sqrt(length(RtLt3step));
err = errorbar(y,SEM);
err.LineStyle = 'None';
err.Color = 'k';
hold off
title('RtLt FiringRate (3step)')
saveas(RtLt3stepFigure, 'RtLt3stepFR.bmp')
[p,~,stats] = anova1(RtLt3step.');
[results,means] = multcompare(stats,'CType','bonferroni');
save('RtLt3step.mat', 'p', 'results', 'means')


%%%連続する歩数に応じた比較(1~5歩)
Rt_cFigure=figure;
x = [1 2 3 4 5];
y = mean(Rt_c, 2) ;
bar(x,y)
hold on
SEM = std(Rt_c,0,2)./sqrt(length(Rt_c));
err = errorbar(y,SEM);
err.LineStyle = 'None';
err.Color = 'k';
hold off
title('Rt repeat FiringRate')
saveas(Rt_cFigure, 'Rt_cFR.bmp')
[p,~,stats] = anova1(Rt_c.');
[results,means] = multcompare(stats,'CType','bonferroni');
save('Rt_c.mat', 'p', 'results', 'means')

Lt_cFigure=figure;
x = [1 2 3 4 5];
y = mean(Lt_c, 2) ;
bar(x,y)
hold on
SEM = std(Lt_c,0,2)./sqrt(length(Lt_c));
err = errorbar(y,SEM);
err.LineStyle = 'None';
err.Color = 'k';
hold off
title('Lt repeat FiringRate')
saveas(Lt_cFigure, 'Lt_cFR.bmp')
[p,~,stats] = anova1(Lt_c.');
[results,means] = multcompare(stats,'CType','bonferroni');
save('Lt_c.mat', 'p', 'results', 'means')


%%% 連続かどうかによって発火頻度が変化するかをチェック
Repeatcheck_Rt4step=figure;
Rt4step_c = Rt_c(4,:);
y = [mean(Rt4step_nc, 2) mean(Rt4step_c, 2)];
bar(y)
hold on
SEM = [std(Rt4step_nc)./sqrt(length(Rt4step_nc)) std(Rt4step_c)./sqrt(length(Rt4step_c))];
err = errorbar(y,SEM);
err.LineStyle = 'None';
err.Color = 'k';
hold off
title('Rt4step non-continuous/countinuous comparison')
saveas(Repeatcheck_Rt4step, 'Repeatcheck_Rt4step.bmp')
[result,p] = ttest2(Rt4step_nc, Rt4step_c); % result=1なら有意差あり
save('Repeatcheck_Rt4step.mat', 'result', 'p')

Repeatcheck_Lt4step=figure;
Lt4step_c = Lt_c(4,:);
y = [mean(Lt4step_nc, 2) mean(Lt4step_c, 2)];
bar(y)
hold on
SEM = [std(Lt4step_nc)./sqrt(length(Lt4step_nc)) std(Lt4step_c)./sqrt(length(Lt4step_c))];
err = errorbar(y,SEM);
err.LineStyle = 'None';
err.Color = 'k';
hold off
title('Lt4step non-continuous/countinuous comparison')
saveas(Repeatcheck_Lt4step, 'Repeatcheck_Lt4step.bmp')
[result,p] = ttest2(Lt4step_nc, Lt4step_c); % result=1なら有意差あり
save('Repeatcheck_Lt4step.mat', 'result', 'p')

Repeatcheck_Rt3step=figure;
Rt3step_c = Rt_c(3,:);
y = [mean(Rt3step_nc, 2) mean(Rt3step_c, 2)];
bar(y)
hold on
SEM = [std(Rt3step_nc)./sqrt(length(Rt3step_nc)) std(Rt3step_c)./sqrt(length(Rt3step_c))];
err = errorbar(y,SEM);
err.LineStyle = 'None';
err.Color = 'k';
hold off
title('Rt3step non-continuous/countinuous comparison')
saveas(Repeatcheck_Rt3step, 'Repeatcheck_Rt3step.bmp')
[result,p] = ttest2(Rt3step_nc, Rt3step_c); % result=1なら有意差あり
save('Repeatcheck_Rt3step.mat', 'result', 'p')

Repeatcheck_Lt3step=figure;
Lt3step_c = Lt_c(3,:);
y = [mean(Lt3step_nc, 2) mean(Lt3step_c, 2)];
bar(y)
hold on
SEM = [std(Lt3step_nc)./sqrt(length(Lt3step_nc)) std(Lt3step_c)./sqrt(length(Lt3step_c))];
err = errorbar(y,SEM);
err.LineStyle = 'None';
err.Color = 'k';
hold off
title('Lt3step non-continuous/countinuous comparison')
saveas(Repeatcheck_Lt3step, 'Repeatcheck_Lt3step.bmp')
[result,p] = ttest2(Lt3step_nc, Lt3step_c); % result=1なら有意差あり
save('Repeatcheck_Lt3step.mat', 'result', 'p')
cellnum

