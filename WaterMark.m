function WaterMarkTurn=WaterMark(WaterOnArray, WaterOffArray, StartTime, FinishTime, TurnMarkerTime, OneTurnTime)
%StartTime����FinishTime�̊Ԃ́A�ŏ���TurnMarkerTime����Ō��TurnMarkerTime�܂ł̐��̂݊������Z�o�B

global DrName %WaterOnArray WaterOffArray StartTime FinishTime TurnMarkerTime OneTurnTime 

TurnMarkerTime1=TurnMarkerTime(TurnMarkerTime>StartTime & TurnMarkerTime<FinishTime);
% TurnMarkerTime1=TurnMarkerTime1-TurnMarkerTime1(1);
WaterMarks=size(1,TurnMarkerTime1(end)-TurnMarkerTime1(1));
% disp(TurnMarkerTime1(1));
%WaterOn�̕���(ms)�ɂP�������B�S���ŏ����Bturn���Ƃɂ킯�Ă��Ȃ��B
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