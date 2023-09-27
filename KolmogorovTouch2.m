function [LTouchfromPeg,StdLTouchTiming,RTouchfromPeg,StdRTouchTiming,MeanStdTouch,StdTouchfromPeg]=KolmogorovTouch2
%Kolmogorov-Smirnov
% KolmogorovTouch(LpegTouchCell)
%ワークスペースにLpegTouchCellなどを置いておき、コマンドウインドウから動かす。

% TouchfromPegはPegからのタッチの時間、それぞれ左右での平均
% StdTouchTimingは各ペグにおけるPegからのタッチの時間の標準偏差、それぞれ左右の値
global PTpegHistoCell ShowFig LpegTouchCell LpegTimeArray2D RpegTouchCell RpegTimeArray2D OneTurnTime
ShowFig=0;
yhight=10;
[fig_touch PTpegHistoCell PegTouchBypegCell]=TouchAlignByPeg(LpegTouchCell,LpegTimeArray2D,yhight);
MeanL=zeros(1,12); StdL=zeros(1,12); KS_L=zeros(1,12); 
for n=1:12
    a=PegTouchBypegCell{n}; a(a>OneTurnTime*1.5/12)=[]; a(a<-OneTurnTime*1.5/12)=[];
    LLen(n)=length(a);
    if length(a)>=5      
       LTouchfromPeg(n)=mean(a);
       StdLTouchTiming(n)=std(a);
       b=(a-mean(a))/std(a);
%        KS_L(n)=kstest(b);
    end
end

LTouchfromPeg
StdLTouchTiming
KS_L
LLen


[fig_touch PTpegHistoCell PegTouchBypegCell]=TouchAlignByPeg(RpegTouchCell,RpegTimeArray2D,yhight);
MeanR=zeros(1,12); StdR=zeros(1,12); KS_R=zeros(1,12); 

for n=1:12
    ar=PegTouchBypegCell{n}; ar(ar>OneTurnTime*1.5/12)=[]; ar(ar<-OneTurnTime*1.5/12)=[];
    RLen(n)=length(ar);
    if length(ar)>=5       
       RTouchfromPeg(n)=mean(ar);
       StdRTouchTiming(n)=std(ar);
       b=(ar-mean(ar))/std(ar);
%        KS_R(n)=kstest(b);
    end
end

RTouchfromPeg
StdRTouchTiming
KS_R
RLen

LTouchfromPeg(LTouchfromPeg==0)=[];
RTouchfromPeg(RTouchfromPeg==0)=[];
StdLTouchTiming(StdLTouchTiming==0)=[];
StdRTouchTiming(StdRTouchTiming==0)=[];
RLTouchfromPeg=[LTouchfromPeg RTouchfromPeg];
StdTouchfromPeg=std(RLTouchfromPeg);
MeanStdTouch=(mean(StdLTouchTiming(1:length(StdLTouchTiming)))+mean(StdRTouchTiming(1:length(StdRTouchTiming))))/2;
StdTouchfromPeg
MeanStdTouch

% MeanLpeg=zeros(1,12); StdRpeg=zeros(1,12); MeanRpeg=zeros(1,12); StdLpeg=zeros(1,12);
% for n=1:12
%     b=LpegTimeArray2D_turn(:,n);
%     MeanLpeg(n)=mean(b);
%     StdLpeg(n)=std(b);
% end
% MeanLpeg
% StdLpeg
% 
% for n=1:12
%     c=RpegTimeArray2D_turn(:,n);
%     MeanRpeg(n)=mean(c);
%     StdRpeg(n)=std(c);
% end
% MeanRpeg
% StdRpeg

