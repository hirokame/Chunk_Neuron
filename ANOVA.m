function ANOVA

cd('C:\Users\C238\Desktop\touchcellLtRt_matsuda');
load('anovadata.mat');
Include3ArraySpike2=[];
NotInclude3ArraySpike2=[];
Include3ArraySpike3=[];
NotInclude3ArraySpike3=[];
Include3ArraySpike4=[];
NotInclude3ArraySpike4=[];



for a=1:length(LtRepeat5TouchSpike2FR_BinArray(1,:))
    if a==2 || a==3 || a==5 || a==10
        Include3ArraySpike2=[Include3ArraySpike2;LtRepeat5TouchSpike2FR_BinArray(:,a)];
    else
        NotInclude3ArraySpike2=[NotInclude3ArraySpike2;LtRepeat5TouchSpike2FR_BinArray(:,a)];
    end
end
[h2,p2,ci2,stats2] = ttest2(Include3ArraySpike2,NotInclude3ArraySpike2);

sem2include3=std(Include3ArraySpike2)/sqrt(length(Include3ArraySpike2));
mean2include3=mean(Include3ArraySpike2);
sem2Notinclude3=std(NotInclude3ArraySpike2)/sqrt(length(NotInclude3ArraySpike2));
mean2Notinclude3=mean(NotInclude3ArraySpike2);

bar(mean2include3)
hold on
errorbar(mean2include3,sem2include3)
hold off

for b=1:length(LtRepeat5TouchSpike3FR_BinArray(1,:))
    if b==1 || b==2 || b==3 || b==6 || b==7 || b==9
        Include3ArraySpike3=[Include3ArraySpike3;LtRepeat5TouchSpike3FR_BinArray(:,b)];
    else
        NotInclude3ArraySpike3=[NotInclude3ArraySpike3;LtRepeat5TouchSpike3FR_BinArray(:,b)];
    end
end
[h3,p3,ci3,stats3] = ttest2(Include3ArraySpike3,NotInclude3ArraySpike3);
sem3include3=std(Include3ArraySpike3)/sqrt(length(Include3ArraySpike3));
mean3include3=mean(Include3ArraySpike3);
sem3Notinclude3=std(NotInclude3ArraySpike3)/sqrt(length(NotInclude3ArraySpike3));
mean3Notinclude3=mean(NotInclude3ArraySpike3);
for c=1:length(LtRepeat5TouchSpike4FR_BinArray(1,:))
    if c==1 || c==2 || c==3 || c==5
        Include3ArraySpike4=[Include3ArraySpike4;LtRepeat5TouchSpike4FR_BinArray(:,c)];
    else
        NotInclude3ArraySpike4=[NotInclude3ArraySpike4;LtRepeat5TouchSpike4FR_BinArray(:,c)];
    end
end
[h4,p4,ci4,stats4] = ttest2(Include3ArraySpike4,NotInclude3ArraySpike4);
sem4include3=std(Include3ArraySpike4)/sqrt(length(Include3ArraySpike4));
mean4include3=mean(Include3ArraySpike4);
sem4Notinclude3=std(NotInclude3ArraySpike4)/sqrt(length(NotInclude3ArraySpike4));
mean4Notinclude3=mean(NotInclude3ArraySpike4);



[p_Lt,anovatab_Lt,stats_Lt]=anova1(LtRepeat5TouchSpike2FR_BinArray);
[c_Lt,m_Lt,h_Lt,nms_Lt]=multcompare(stats_Lt);
[p_Rt,anovatab_Rt,stats_Rt]=anova1(LtRepeat5TouchSpike2FR_BinArray);
[c_Rt,m_Rt,h_Rt,nms_Rt]=multcompare(stats_Rt);
% [p_5,anovatab_5,stats_5]=anova1(Repeat5TouchCountArray);
% [c_5,m_5,h_5,nms_5]=multcompare(stats_5);


[p_LtRt,anovatab_LtRt,stats_LtRt]=anova1(Repeat5TouchSpikeFR_BinArray);
[c_LtRt,m_LtRt,h_LtRt,nms_LtRt]=multcompare(stats_LtRt);
[p_3,anovatab_3,stats_3]=anova1(Repeat3TouchSpikeFR_BinArray);
[c_3,m_3,h_3,nms_3]=multcompare(stats_3);

[p_Lt,anovatab_Lt,stats_Lt]=anova1(LtRepeat5TouchSpikeFR_BinArray);
[c_Lt,m_Lt,h_Lt,nms_Lt]=multcompare(stats_Lt);

[p_Rt,anovatab_Rt,stats_Rt]=anova1(RtRepeat5TouchSpikeFR_BinArray);
[c_Rt,m_Rt,h_Rt,nms_Rt]=multcompare(stats_Rt);

[p_LtRt,anovatab_LtRt,stats_LtRt]=anova1(Repeat5TouchSpikeFR_BinArray);
[c_LtRt,m_LtRt,h_LtRt,nms_LtRt]=multcompare(stats_LtRt);