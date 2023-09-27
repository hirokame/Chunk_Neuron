function [ShiftedArray]=ShiftArray(Array,TurnMarkerTime)
% global OneTurnTime

Array(Array==0)=[];%Excelからデータを直に持ってきている場合、0で埋められていることがある

%ArrayをTurnMarkerで切り取って処理
ShiftedArray=[];
for n=1:length(TurnMarkerTime)-1
    
    tempArray=Array(Array>TurnMarkerTime(n)&Array<TurnMarkerTime(n+1)); %-TurnMarkerTime(n);
    ShiftPoint=rand(1)*(TurnMarkerTime(n+1)-TurnMarkerTime(n))+TurnMarkerTime(n);%Trial内のランダムに選んだ点
    PreShift=tempArray(tempArray<ShiftPoint)+(TurnMarkerTime(n+1)-ShiftPoint);%ShiftPointより前のものを後ろへ
    PostShift=tempArray(tempArray>ShiftPoint)+(TurnMarkerTime(n)-ShiftPoint);%ShiftPointより後ろのものを前へ
    Shifted=[PostShift; PreShift];
    ShiftedArray=[ShiftedArray; Shifted];
end
    
%     tempArray=tempArray*(TurnMarkerTime(n+1)-TurnMarkerTime(n))/OneTurnTime%１trialの時間をOneTurnTimeに正規化

%     if Gsmooth==1;tempArray=instantArray(tempArray,10);end
