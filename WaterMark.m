function WaterMarkTurn=WaterMark(WaterOnArray, WaterOffArray, StartTime, FinishTime, TurnMarkerTime, OneTurnTime)
%StartTimeからFinishTimeの間の、最初のTurnMarkerTimeから最後のTurnMarkerTimeまでの水のみ割合を算出。

global DrName %WaterOnArray WaterOffArray StartTime FinishTime TurnMarkerTime OneTurnTime 

TurnMarkerTime1=TurnMarkerTime(TurnMarkerTime>StartTime & TurnMarkerTime<FinishTime);
% TurnMarkerTime1=TurnMarkerTime1-TurnMarkerTime1(1);
WaterMarks=size(1,TurnMarkerTime1(end)-TurnMarkerTime1(1));
% disp(TurnMarkerTime1(1));
%WaterOnの部分(ms)に１をいれる。全長で処理。turnごとにわけていない。
for n=1:min(length(WaterOnArray),length(WaterOffArray))
    if n==1 & WaterOnArray(1)==0;
        WaterMarks(WaterOnArray(n)+1:WaterOffArray(n)-1)=1;
    else
        WaterMarks(WaterOnArray(n):WaterOffArray(n)-1)=1;
    end
end
% disp(length(WaterMarks(WaterMarks==1)));

WaterMarkTurn=zeros(1,fix(OneTurnTime));
for n=1:(length(TurnMarkerTime1)-1)
    if (TurnMarkerTime1(n)+OneTurnTime)>length(WaterMarks)
        break;
    else
        WaterMarkTurn = WaterMarkTurn + WaterMarks(TurnMarkerTime1(n)+1:TurnMarkerTime1(n)+fix(OneTurnTime));
    end
end
% disp(length(WaterMarkTurn));

WaterMarkTurn=(WaterMarkTurn/(length(TurnMarkerTime1)-1))*100;

% fig_WaterMark=figure;
% plot(WaterMarkTurn);axis([0 OneTurnTime 0 100]);
% saveas(fig_WaterMark,[DrName,' ','WaterMark.bmp']);