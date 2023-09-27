function [OriginalArray1,OriginalArray2,ModifiedArray1,ModifiedArray2]=Modify_Events(WaterOnArrayOriginal,WaterOffArrayOriginal, StartTime, FinishTime, EventName)
%もともとWaterEventsのために作成したので変数がwater関係になっているが、他のEventにも使用。FloorTouch,Drink,,,

%WaterOnArrayは、最初と最後やデータ抜けなどを修正したものになる。
WaterOnArray=WaterOnArrayOriginal;
WaterOffArray=WaterOffArrayOriginal;

if StartTime==0;StartTime=1;end

% % %データがすべて0の場合。
% if WaterOnArray(1)==0;WaterOnArray(1)=StartTime;end
% if
% WaterOffArray(1)==0;WaterOffArray(1)=FinishTime;WaterOffArray=sort(WaterOffArray);end%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%最初から最後まで飲んでいた場合。
% if WaterOnArray(1)==0 & WaterOffArray(1)==0;WaterOnArray(1)=StartTime;WaterOffArray(1)=FinishTime;end %data(1,3)は終了タイム

WaterOnArrayOriginal(WaterOnArrayOriginal==0)=[];
WaterOffArrayOriginal(WaterOffArrayOriginal==0)=[];
WaterOnArrayOriginal=WaterOnArrayOriginal(WaterOnArrayOriginal>StartTime & WaterOnArrayOriginal<FinishTime);
WaterOffArrayOriginal=WaterOffArrayOriginal(WaterOffArrayOriginal>StartTime & WaterOffArrayOriginal<FinishTime);
% disp(EventName);
% length(WaterOnArrayOriginal)
% length(WaterOffArrayOriginal)

OriginalArray1=WaterOnArrayOriginal;
OriginalArray2=WaterOffArrayOriginal;

WaterOnArray(WaterOnArray==0)=[];
WaterOffArray(WaterOffArray==0)=[];

WaterOnArray(WaterOnArray<StartTime)=[];
WaterOffArray(WaterOffArray<StartTime)=[];

WaterOnArray(WaterOnArray>FinishTime)=[];
WaterOffArray(WaterOffArray>FinishTime)=[];

%最初から最後まで飲んでいた場合など、空配列になってしまった場合の処置
if isempty(WaterOnArray);WaterOnArray(1)=StartTime;end
if isempty(WaterOffArray);WaterOffArray(1)=FinishTime;end

%スタート時に飲んでいて、途中で離れた場合。
if WaterOnArray(1)>WaterOffArray(1)
    WaterOnArray=[StartTime;WaterOnArray];
end

% FinishTime
% WaterOnArray(end)
% WaterOffArray(end)

%終了時に飲んでいた場合
if WaterOnArray(end)>WaterOffArray(end) & WaterOnArray(end)<FinishTime
    WaterOffArray=[WaterOffArray;FinishTime];
end

% for n=1:min(length(WaterOnArray),length(WaterOffArray))
%    if WaterOnArray(n)>WaterOffArray(n);
%        disp(['!!! Strange Event at' int2str(WaterOnArray(n))]);
%        WaterOffArray=sort([WaterOffArray;(WaterOnArray(n)+1)]);
% %        disp([int2str(WaterOnArray(n)) 'erased']);
%    end
% end

n=1;
for n=1:min(length(WaterOnArray),length(WaterOffArray))
    if WaterOffArray(n)-WaterOnArray(n)<10 & WaterOffArray(n)>WaterOnArray(n);WaterOnArray(n)=-1;WaterOffArray(n)=-1;end
    n=n+1;
end
WaterOnArray(WaterOnArray==-1)=[];WaterOffArray(WaterOffArray==-1)=[];

%短いWaterOff時間を削除するときに使用
% for n=length(WaterOffArray):-1:2;
%     if WaterOnArray(n)+20>WaterOffArray(n);WaterOnArray(n)=0;WaterOffArray(n)=0;end
% end

ModifiedArray1=WaterOnArray;
ModifiedArray2=WaterOffArray;
% ModifiedArray=[WaterOnArray;WaterOffArray]
