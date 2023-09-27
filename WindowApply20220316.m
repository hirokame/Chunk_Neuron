function WindowApply20220316

global RtouchSpikeOnUnit LtouchSpikeOnUnit RtouchSpikeOffUnit LtouchSpikeOffUnit LtNegativeSpikeOffKaisuu RtNegativeSpikeOffKaisuu ...
    RtPositiveSpikeOffKaisuu LtPositiveSpikeOffKaisuu pegpatternum pegpatternname... 
    LtPositiveFiringRate LtNegativeFiringRate RtPositiveFiringRate RtNegativeFiringRate LtPositiveSpikeOnKaisuu LtNegativeSpikeOnKaisuu RtPositiveSpikeOnKaisuu RtNegativeSpikeOnKaisuu...
    LtPositiveHistogramXaxis LtNegativeHistogramXaxis RtPositiveHistogramXaxis RtNegativeHistogramXaxis...
    LtPositive_beta_hist LtNegative_beta_hist RtPositive_beta_hist RtNegative_beta_hist LtPositive_R_hist LtNegative_R_hist RtPositive_R_hist RtNegative_R_hist cellnum CellNumList...
    LtRsq1 RtRsq1 Ltbeta1 Rtbeta1 Windowinterval

%%%%%%%% Lt SpikeOn
LtPositiveSpikeOnKaisuu=ones(2,2,2,2,2);
LtPositiveHistogramXaxis=ones(2,2,2,2,2);  %%%%% Positiveヒストグラムを作成する際の発火頻度
LtouchPositive5windowPoint=LtouchSpikeOnUnit(:,(1:6));%%%% 発火数とPositiveだけ抜き出す
for i=1:length(LtouchPositive5windowPoint(:,1))
    w1 = LtouchPositive5windowPoint(i,(2))+1; %%  0or1 -> 1or2 
    w2 = LtouchPositive5windowPoint(i,(3))+1;
    w3 = LtouchPositive5windowPoint(i,(4))+1;
    w4 = LtouchPositive5windowPoint(i,(5))+1;
    w5 = LtouchPositive5windowPoint(i,(6))+1;
    
    LtPositiveHistogramXaxis(w1, w2, w3, w4, w5) = LtPositiveHistogramXaxis(w1, w2, w3, w4, w5) + LtouchPositive5windowPoint(i,1);
    LtPositiveSpikeOnKaisuu(w1, w2, w3, w4, w5) = LtPositiveSpikeOnKaisuu(w1, w2, w3, w4, w5) + 1;
end

%%%%%%%% Rt SpikeOn
RtPositiveSpikeOnKaisuu=ones(2,2,2,2,2);
RtPositiveHistogramXaxis=ones(2,2,2,2,2);  %%%%% Positiveヒストグラムを作成する際の発火頻度
RtouchPositive5windowPoint=RtouchSpikeOnUnit(:,(1:6));%%%% 発火数とPositiveだけ抜き出す
for i=1:length(RtouchPositive5windowPoint(:,1))
    w1 = RtouchPositive5windowPoint(i,(2))+1; %%  0or1 -> 1or2 
    w2 = RtouchPositive5windowPoint(i,(3))+1;
    w3 = RtouchPositive5windowPoint(i,(4))+1;
    w4 = RtouchPositive5windowPoint(i,(5))+1;
    w5 = RtouchPositive5windowPoint(i,(6))+1;
    
    RtPositiveHistogramXaxis(w1, w2, w3, w4, w5) = RtPositiveHistogramXaxis(w1, w2, w3, w4, w5) + RtouchPositive5windowPoint(i,1);
    RtPositiveSpikeOnKaisuu(w1, w2, w3, w4, w5) = RtPositiveSpikeOnKaisuu(w1, w2, w3, w4, w5) + 1;
end

%%%%%%%% Lt Spikeoff
LtPositiveSpikeOffKaisuu=ones(2,2,2,2,2);
LtouchPositive5windowPoint=LtouchSpikeOffUnit(:,(1:5));%%%% 発火数とPositiveだけ抜き出す
for i=1:length(LtouchPositive5windowPoint(:,1))
    w1 = LtouchPositive5windowPoint(i,(1))+1; %%  0or1 -> 1or2 
    w2 = LtouchPositive5windowPoint(i,(2))+1;
    w3 = LtouchPositive5windowPoint(i,(3))+1;
    w4 = LtouchPositive5windowPoint(i,(4))+1;
    w5 = LtouchPositive5windowPoint(i,(5))+1;
    
    LtPositiveSpikeOffKaisuu(w1, w2, w3, w4, w5) = LtPositiveSpikeOffKaisuu(w1, w2, w3, w4, w5) + 1;
end

%%%%%%%% Rt Spikeoff
RtPositiveSpikeOffKaisuu=ones(2,2,2,2,2);
RtouchPositive5windowPoint=RtouchSpikeOffUnit(:,(1:5));%%%% 発火数とPositiveだけ抜き出す
for i=1:length(RtouchPositive5windowPoint(:,1))
    w1 = RtouchPositive5windowPoint(i,(1))+1; %%  0or1 -> 1or2 
    w2 = RtouchPositive5windowPoint(i,(2))+1;
    w3 = RtouchPositive5windowPoint(i,(3))+1;
    w4 = RtouchPositive5windowPoint(i,(4))+1;
    w5 = RtouchPositive5windowPoint(i,(5))+1;
    
    RtPositiveSpikeOffKaisuu(w1, w2, w3, w4, w5) = RtPositiveSpikeOffKaisuu(w1, w2, w3, w4, w5) + 1;
end


LtPositiveFiringRate=(LtPositiveHistogramXaxis*1000*4/Windowinterval)./(LtPositiveSpikeOnKaisuu+LtPositiveSpikeOffKaisuu);

RtPositiveFiringRate=(RtPositiveHistogramXaxis*1000*4/Windowinterval)./(RtPositiveSpikeOnKaisuu+RtPositiveSpikeOffKaisuu);


LtFR1 = (LtPositiveFiringRate(2,1,1,1,1)+LtPositiveFiringRate(1,2,1,1,1)+LtPositiveFiringRate(1,1,2,1,1)+LtPositiveFiringRate(1,1,1,2,1)+LtPositiveFiringRate(1,1,1,1,2))/5;
LtFR2 = (LtPositiveFiringRate(2,2,1,1,1)+LtPositiveFiringRate(1,2,2,1,1)+LtPositiveFiringRate(1,1,2,2,1)+LtPositiveFiringRate(1,1,1,2,2))/4;
LtFR3 = (LtPositiveFiringRate(2,2,2,1,1)+LtPositiveFiringRate(1,2,2,2,1)+LtPositiveFiringRate(1,1,2,2,2))/3;
LtFR4 = (LtPositiveFiringRate(2,2,2,2,1)+LtPositiveFiringRate(1,2,2,2,2))/2;
LtFR5 = LtPositiveFiringRate(2,2,2,2,2);
x=[1 2 3 4 5];
y=[LtFR1 LtFR2 LtFR3 LtFR4 LtFR5];
beta=polyfit(x,y,1);
beta0=beta(2);
Rtbeta1=beta(1);
yCalc=Rtbeta1*x+beta0;
LtRsq1=1-sum((y-yCalc).^2)/sum((y-mean(y)).^2);

RtFR1 = (RtPositiveFiringRate(2,1,1,1,1)+RtPositiveFiringRate(1,2,1,1,1)+RtPositiveFiringRate(1,1,2,1,1)+RtPositiveFiringRate(1,1,1,2,1)+RtPositiveFiringRate(1,1,1,1,2))/5;
RtFR2 = (RtPositiveFiringRate(2,2,1,1,1)+RtPositiveFiringRate(1,2,2,1,1)+RtPositiveFiringRate(1,1,2,2,1)+RtPositiveFiringRate(1,1,1,2,2))/4;
RtFR3 = (RtPositiveFiringRate(2,2,2,1,1)+RtPositiveFiringRate(1,2,2,2,1)+RtPositiveFiringRate(1,1,2,2,2))/3;
RtFR4 = (RtPositiveFiringRate(2,2,2,2,1)+RtPositiveFiringRate(1,2,2,2,2))/2;
RtFR5 = RtPositiveFiringRate(2,2,2,2,2);
y=[RtFR1 RtFR2 RtFR3 RtFR4 RtFR5];
beta=polyfit(x,y,1);
beta0=beta(2);
Ltbeta1=beta(1);
yCalc=Ltbeta1*x+beta0;
RtRsq1=1-sum((y-yCalc).^2)/sum((y-mean(y)).^2);
