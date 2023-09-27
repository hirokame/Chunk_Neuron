function [fig_TM,PTTMHistoCell MedianPTTM Max]=TouchAlignByTM(PegTouchCell,TurnMarkerTime,yhight) 
%TouchAlignByPeg(PegTouchCell,pegTimeArray2D,100,30)
%Called by PegTouch,Detach
%Touch aligned By Pegs
global PTpegHistoCell OneTurnTime ShowFig

PegTouchByTM1=[];PegTouchByTM2=[];PegTouchByTM3=[];PegTouchByTM4=[];PegTouchByTM5=[];PegTouchByTM6=[];...
    PegTouchByTM7=[];PegTouchByTM8=[];PegTouchByTM9=[];PegTouchByTM10=[];PegTouchByTM11=[];PegTouchByTM12=[];
PegTouchByTMCell={PegTouchByTM1,PegTouchByTM2,PegTouchByTM3,PegTouchByTM4,PegTouchByTM5,PegTouchByTM6,...
    PegTouchByTM7,PegTouchByTM8,PegTouchByTM9,PegTouchByTM10,PegTouchByTM11,PegTouchByTM12};
%disp(PegTouchCell);

for n=1:length(PegTouchCell) %ペグの前後5秒
    for m=1:length(TurnMarkerTime) %pegTimeArray2D(:,n))
        A=PegTouchCell{n}(TurnMarkerTime(m)>PegTouchCell{n}-OneTurnTime)-TurnMarkerTime(m);
        PegTouchByTMCell{n}=[PegTouchByTMCell{n};A];
        
%         H=hist(PegTouchByTMCell{n});
%         plot(H);
    end
end

xbins=ceil(OneTurnTime/10);
X_duration=OneTurnTime;%表示する時間幅　片側
PTTMHisto1=zeros(xbins,1);PTTMHisto2=zeros(xbins,1);PTTMHisto3=zeros(xbins,1);PTTMHisto4=zeros(xbins,1);PTTMHisto5=zeros(xbins,1);PTTMHisto6=zeros(xbins,1);...
    PTTMHisto7=zeros(xbins,1);PTTMHisto8=zeros(xbins,1);PTTMHisto9=zeros(xbins,1);PTTMHisto10=zeros(xbins,1);PTTMHisto11=zeros(xbins,1);PTTMHisto12=zeros(xbins,1);
PTTMHistoCell={PTTMHisto1,PTTMHisto2,PTTMHisto3,PTTMHisto4,PTTMHisto5,PTTMHisto6,PTTMHisto7,PTTMHisto8,PTTMHisto9,PTTMHisto10,PTTMHisto11,PTTMHisto12};
for n=1:length(PegTouchByTMCell)%
    PTTM=[];
    for p=1:xbins%PTTMHistoCell;ペグごとのタッチのヒストグラム　
        PTTMHistoCell{n}(p)=length(PegTouchByTMCell{n}((p*(X_duration/xbins)<PegTouchByTMCell{n})&(PegTouchByTMCell{n}<(p+1)*(X_duration/xbins))));%length(PegTouchByTMCell{n}((p*(X_duration/xbins)*2-X_duration<PegTouchByTMCell{n})&(PegTouchByTMCell{n}<p*(X_duration/xbins)*2-X_duration+100)));
        PTTM=[PTTM; PegTouchByTMCell{n}((p*(X_duration/xbins)<PegTouchByTMCell{n})&(PegTouchByTMCell{n}<(p+1)*(X_duration/xbins)))];
    end
    if length(PTTM)>10
            MedianPTTM(n)=median(PTTM)/10;
        else
            MedianPTTM(n)=NaN;
    end   
end

cl={'k','c','m','r','g','b','k','c','m','r','g','b'};

%描画するときはこの部分を脱コメント化ーーーーー-----------------------------
if ShowFig==1
    fig_TM=figure;hold on
    Max=0;
    for n=1:12
        PTTMHistoCell{n}=MovWindow(PTTMHistoCell{n},2);
%         text(MeanPTTM(n),Max+1,'l','FontSize',18,'color',cl{n});
        plot(PTTMHistoCell{n},cl{n})
        if max(PTTMHistoCell{n})>Max;Max=max(PTTMHistoCell{n});end
        
    end;    
    MAX=ones(1,12)*(Max+1);
    for n=1:12
        text(MedianPTTM(n),MAX(n),'l','FontSize',18,'color',cl{n});
    end
    axis([0 xbins 0 Max+2]);
    hold off;
else fig_TM=0;
end
%------------------------------------------------------------------------