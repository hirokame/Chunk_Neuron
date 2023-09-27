function Statics

cd('C:\Users\C238\Desktop\touchcellLtRt_Hirokane');

LtPositiveFR=load('RtLtFirngRate_AllCell.mat','LtPositiveFiringRateArray');
LtNegativeFR=load('RtLtFirngRate_AllCell.mat','LtNegativeFiringRateArray');
RtPositiveFR=load('RtLtFirngRate_AllCell.mat','RtPositiveFiringRateArray');
RtNegativeFR=load('RtLtFirngRate_AllCell.mat','RtNegativeFiringRateArray');
LtPositiveFR=struct2array(LtPositiveFR);
LtNegativeFR=struct2array(LtNegativeFR);
RtPositiveFR=struct2array(RtPositiveFR);
RtNegativeFR=struct2array(RtNegativeFR);

[pLP,~,LPstats]=anova1(LtPositiveFR);
[pLN,~,LNstats]=anova1(LtNegativeFR);
[pRP,~,RPstats]=anova1(RtPositiveFR);
[pRN,~,RNstats]=anova1(RtNegativeFR);

pLP
pLN
pRP
pRN

[LPresults,LPmeans]=multcompare(LPstats,'CType','bonferroni')
[LNresults,LNmeans]=multcompare(LNstats,'CType','bonferroni')
[RPresults,RPmeans]=multcompare(RPstats,'CType','bonferroni')
[RNresults,RNmeans]=multcompare(RNstats,'CType','bonferroni')

FRmean=figure;
subplot(2,2,1)
x=[0 1 2 3 4 5];
y=LPmeans(:,1).';
err=nanstd(LtPositiveFR);
barwitherr(err,x,y)

subplot(2,2,2)
x=[0 1 2 3 4];
y=LNmeans(:,1).';
err=nanstd(LtNegativeFR);
barwitherr(err,x,y)

subplot(2,2,3)
x=[0 1 2 3 4 5];
y=RPmeans(:,1).';
err=nanstd(RtPositiveFR);
barwitherr(err,x,y)

subplot(2,2,4)
x=[0 1 2 3 4];
y=RNmeans(:,1).';
err=nanstd(RtNegativeFR);
barwitherr(err,x,y)

saveas(FRmean,'FRmean.bmp')