function [WaterOn_percent]=Water_percentage(WaterOnArray,WaterOffArray,StartTime,FinishTime)

% global WaterOnArray WaterOffArray StartTime FinishTime
if StartTime>0;TotalTime=FinishTime-StartTime;
else StartTime=0;TotalTime=FinishTime;end

% disp(['StartTime=' int2str(StartTime)]);
% disp(['TotalTime=' int2str(TotalTime)]);

if length(WaterOnArray)~=length(WaterOffArray);disp('!!! length(WaterOnArray)~=length(WaterOffArray) !!!');end

WaterOnTime=0;
for n=1:min(length(WaterOnArray),length(WaterOffArray))
    if WaterOffArray(n)<=WaterOnArray(n);disp('!!! WaterOffArray(n)<=WaterOnArray(n) !!!');break;end
    WaterOnTime=WaterOnTime + WaterOffArray(n)-WaterOnArray(n);
end

WaterOn_percent=(WaterOnTime/TotalTime)*100;