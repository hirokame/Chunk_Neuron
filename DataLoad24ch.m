function [RpegTimeArray,LpegTimeArray,RpegTimeArray2D,LpegTimeArray2D,OneTurnTime,TurnMarkerTime data]=DataLoad24ch(PegOffset,dpath,fname)

%1A：Info（date, mouseID, sessionNo,training condition, Num.Turns,TotalTouchTime, TotalWaterOn, Num.Stops, 1-10, 11-20, 21-30, 31-40,,,)
%2B:Start time array
%3C:Stop time array
%4D:TurnTime, cumulative
%5E:OneTurnTime
%6F:cumulativeTouchTime array; fall down
%7G:WaterOnTime array
%8H:WaterOffTime array
%9I:Stop Time array
%10J:Lpeg Time array
%11K:Rpeg Time array
%12L:CumulativeTouchTime; fall down
%13M:TotalTouchTime by 10;fall down 
%14N-25Y:RightTouchTime sensor 1-12
%28AB-39AM:RightDetachTime sensor 1-12
%26Z:Floor Touch sensor
%27AA:Spout Touch sensor//
%40AN:Floor Detach sensor
%41AU:Spout Detach sensor//

%42-53:LeftTouchTime sensor 1-12
%54-65:LeftDetachTime sensor 1-12

%65-69:光刺激タイミングなど


%     RightTouchData=[data(:,14),data(:,15),data(:,16),data(:,17),data(:,18),data(:,19),data(:,20),data(:,21),data(:,22),data(:,23),data(:,24),data(:,25)];
%     [R_PegTouchCell,R_PegTouchTurn]=PegTouch24ch(RightTouchData);
% 
%     LeftTouchData=[data(:,42),data(:,43),data(:,44),data(:,45),data(:,46),data(:,47),data(:,48),data(:,49),data(:,50),data(:,51),data(:,52),data(:,53)];
%     [L_PegTouchCell,L_PegTouchTurn]=PegTouch24ch(LeftTouchData);

%clear all
% %Eventデータの読み込み
% cd 'C:\Documents and Settings\kit\デスクトップ\WR LVdata';
% %dpath='C:\Documents and Settings\kit\デスクトップ\WR LVdata\';
% [fname,dpath] = uigetfile('*.xls');
% 

global data dpath fname TurnMarkerTime OneTurnTimeArray RpegTimeArray LpegTimeArray OneTurnTime...
    WaterOnArrayOriginal WaterOffArrayOriginal WaterOnArray WaterOffArray...
    RpegTimeArray2D LpegTimeArray2D RpegTimeArray2D_turn LpegTimeArray2D_turn MedPegTimeR MedPegTimeL StartTime FinishTime...
    SpikeNum WaterOn_percent DrinkOnArray DrinkOffArray FloorTouchArray FloorDetachArray DrinkOn_percent FloorTouch_percent DrName...
    fig_WaterMark fig_DrinkMark fig_FloorMark fig_WaterOn fig_DrinkOn fig_Floor FigureSave patternValue...
    TurnMarkerTime_L TurnMarkerTime_R MedPegTimeL_L MedPegTimeL_R MedPegTimeR_L MedPegTimeR_R TurnMarkerTimeB TurnMarkerTimeA...
    NumDrinkTurn NumDrinkTurnCum OnWater OnWaterLen OnWaterLenCum NumFloorTouchTurn NumFloorTouchTurnCum...
    fig_OnWater fig_DrinkMark fig_NumDrink fig_FloorMark fig_NumFloorTouch fig_WaterOnLen fig_DrinkOnCount fig_FloorTouchCount VoltAnalysis

if strfind(fname,' ')>0
    data=xlsread([dpath fname]);%'C:\Documents and Settings\kit\デスクトップ\WR LVdata\6 080811.xls');
elseif strfind(fname,'_')>0
%     cd(dpath)
%     A=[dpath fname];
try
    data=load([dpath fname],'-ascii');
catch exception
    data=load([dpath fname]);
end
    
else
    data=xlsread([dpath fname]);%'C:\Documents and Settings\kit\デスクトップ\WR LVdata\6 080811.xls');
end
%num_pegs=12;
SpikeNum=1;
% 
% if fname == '7011_180806_Bgra.mat'
%     data
% end
    
%Sessionの最初と最後を規定。複数セッションの解析のためには作り直す必要あり。
StartTime=data(1,2);
FinishTime=data(1,3);

disp('StartTime=');disp(StartTime);
disp('FinishTime=');disp(FinishTime);

%PegOffset: Peg　位置補正 TurnMarkerと重なったとき
RpegTimeArrayOriginal=data(:,11)-PegOffset;RpegTimeArrayOriginal(RpegTimeArrayOriginal==-PegOffset)=[];
LpegTimeArrayOriginal=data(:,10)-PegOffset;LpegTimeArrayOriginal(LpegTimeArrayOriginal==-PegOffset)=[];
RpegTimeArray=RpegTimeArrayOriginal(RpegTimeArrayOriginal>StartTime & RpegTimeArrayOriginal<FinishTime);
LpegTimeArray=LpegTimeArrayOriginal(LpegTimeArrayOriginal>StartTime & LpegTimeArrayOriginal<FinishTime);

%dataを内容ごとに分離、要素０の場合要素を削除%最終的にStartTimeとFinishTimeの間のものだけを残す。
TurnMarkerTimeA=[];TurnMarkerTimeB=[];
if patternValue==15 % RLpegがBlikeで入ったときのTurnMarkerをTurnMarkerTimeとする。ただし、そのときマウスは逆位置でAlike。
    TurnMarkerTimeOriginal=data(:,4);TurnMarkerTimeOriginal(TurnMarkerTimeOriginal==0)=[];
    TurnMarkerTime=TurnMarkerTimeOriginal(TurnMarkerTimeOriginal>StartTime & TurnMarkerTimeOriginal<=FinishTime);
    for n=1:length(TurnMarkerTime)-1
        RTime=RpegTimeArray-TurnMarkerTime(n);
        LTime=LpegTimeArray-TurnMarkerTime(n);
        if abs(min(RTime(RTime>0))-min(LTime(LTime>0)))<20
            TurnMarkerTimeA=[TurnMarkerTimeA;TurnMarkerTime(n)];
        elseif abs(max(RTime(RTime<0))-max(LTime(LTime<0)))<20 
            TurnMarkerTimeB=[TurnMarkerTimeB;TurnMarkerTime(n)];
        end
    end
    OneTurnTimeArray=data(:,5);OneTurnTimeArray(find(OneTurnTimeArray==0))=[];%for n=length(OneTurnTimeArray):-1:1;if OneTurnTimeArray(n)==0;On nTimeArray(n)=[];end;end;
    OneTurnTime=median(OneTurnTimeArray)*2;
    TurnMarkerTime=TurnMarkerTimeA;
    else
    TurnMarkerTimeOriginal=data(:,4);TurnMarkerTimeOriginal(TurnMarkerTimeOriginal==0)=[];
    TurnMarkerTime=TurnMarkerTimeOriginal(TurnMarkerTimeOriginal>StartTime & TurnMarkerTimeOriginal<=FinishTime);
    OneTurnTimeArray=data(:,5);OneTurnTimeArray(find(OneTurnTimeArray==0))=[];%for n=length(OneTurnTimeArray):-1:1;if OneTurnTimeArray(n)==0;On nTimeArray(n)=[];end;end;

    %One turnの中央値を一周の時間とする
    OneTurnTime=median(OneTurnTimeArray);
end

%WaterEventの処理　Original:記録されたそのまま　-----------------------begin
WaterOnArrayOriginal=data(:,7);
WaterOffArrayOriginal=data(:,8);

%WaterOnArrayは、最初と最後やデータ抜けなどを修正したもの。
EventName='WaterOn';
[WaterOnArrayOriginal,WaterOffArrayOriginal,WaterOnArray,WaterOffArray]=Modify_Events(WaterOnArrayOriginal,WaterOffArrayOriginal,StartTime,FinishTime,EventName);
[WaterOn_percent]=Water_percentage(WaterOnArray,WaterOffArray,StartTime,FinishTime)
WaterMarkTurn=WaterMark(WaterOnArray, WaterOffArray, StartTime, FinishTime, TurnMarkerTime, OneTurnTime);

if WaterOnArray(1)<WaterOffArray(1)
    OnWater=zeros(1,FinishTime);
else
    OnWater=ones(1,FinishTime); 
end

a=1;b=1;

% if WaterOnArray(1)==1
%     OnWater(1)=1;
%     a=2;
% end

% ここでエラーが出たら上4行を操作（コメントイン or アウト）要、修正。
for n=2:length(OnWater)
    if n~=WaterOnArray(a) && n~=WaterOffArray(b)
        OnWater(n)=OnWater(n-1);
    elseif n==WaterOnArray(a)
        OnWater(n)=1;
        if a<length(WaterOnArray);a=a+1;end
    elseif n==WaterOffArray(b)
        OnWater(n)=0;
        if b<length(WaterOffArray);b=b+1;end
    end
end
length(OnWater(OnWater==1))

OnWaterLen=zeros(1,length(TurnMarkerTime)-1);
OnWaterLenCum=zeros(1,length(TurnMarkerTime)-1);
for n=1:length(TurnMarkerTime)-1
    TempOnW=OnWater(TurnMarkerTime(n):TurnMarkerTime(n+1));
    OnWaterLen(n)=sum(TempOnW(TempOnW==1));
    if n>=2
        OnWaterLenCum(n)=OnWaterLenCum(n-1)+OnWaterLen(n);
    end
end
fig_WaterOnLen=figure
plot(OnWaterLen);title('WaterOnLen/Turn');
fig_OnWater=figure
plot(OnWaterLenCum);title('Cumlative WaterOnLen/Turn');
if FigureSave==1;saveas(fig_OnWater,[DrName,' ','fig_OnWater.bmp']);end

fig_WaterMark=figure;
plot(WaterMarkTurn);axis([0 OneTurnTime 0 100]);title('WaterMark');
if FigureSave==1;saveas(fig_WaterMark,[DrName,' ','WaterMark.bmp']);end

WaterOnRaster=raster(WaterOnArray,TurnMarkerTime);
WaterOffRaster=raster(WaterOffArray,TurnMarkerTime);

fig_WaterOn=figure;hold on
if length(WaterOnRaster)>1;plot(WaterOnRaster(:,1),WaterOnRaster(:,2),'go');end
if length(WaterOffRaster)>1;plot(WaterOffRaster(:,1),WaterOffRaster(:,2),'rx');end
title('WaterOn-Off');hold off;
if FigureSave==1;saveas(fig_WaterOn,[DrName,' ','WaterOn.bmp']);end

%WaterEvent処理--------------------------------------------------------end

%Drink解析　Water_percentage、WaterMarkを流用----------------------------
% % % % % if VoltAnalysis==0%VoltageAnalysis, Voltage dataからのDrinkを計算しない場合
% % % % %     DrinkOnArrayOriginal=data(:,27);
% % % % %     DrinkOffArrayOriginal=data(:,41);
% % % % % 
% % % % %     EventName='DrinkOn';
% % % % %     [DrinkOnArrayOriginal,DrinkOffArrayOriginal,DrinkOnArray,DrinkOffArray]=Modify_Events(DrinkOnArrayOriginal,DrinkOffArrayOriginal,StartTime,FinishTime,EventName);
% % % % % 
% % % % %     [DrinkOn_percent]=Water_percentage(DrinkOnArray,DrinkOffArray,StartTime,FinishTime);
% % % % %     DrinkMark=WaterMark(DrinkOnArray, DrinkOffArray, StartTime, FinishTime, TurnMarkerTime, OneTurnTime);
% % % % % 
% % % % %     fig_DrinkMark=figure;
% % % % %     plot(DrinkMark);axis([0 OneTurnTime 0 100]);title('DrinkMark');zoom xon
% % % % %     if FigureSave==1;saveas(fig_DrinkMark,[DrName,' ','DrinkMark.bmp']);end
% % % % % 
% % % % %     DrinkOnRaster=raster(DrinkOnArray,TurnMarkerTime);
% % % % %     DrinkOffRaster=raster(DrinkOffArray,TurnMarkerTime);
% % % % % 
% % % % %     NumDrinkTurn=zeros(1,length(TurnMarkerTime)-1);
% % % % %     NumDrinkTurnCum=zeros(1,length(TurnMarkerTime)-1);
% % % % %     for n=1:length(TurnMarkerTime)-1
% % % % %         NumDrinkTurn(n)=sum(DrinkOnRaster(:,2)==n);
% % % % %         if n>=2
% % % % %             NumDrinkTurnCum(n)=NumDrinkTurnCum(n-1)+NumDrinkTurn(n);
% % % % %         end
% % % % %     end
% % % % %     fig_DrinkOnCount=figure;
% % % % %     plot(NumDrinkTurn);title('DrinkOnCount/Turn');
% % % % %     fig_NumDrink=figure;
% % % % %     plot(NumDrinkTurnCum);title('Cumlative DrinkOnCount/Turn');
% % % % %     if FigureSave==1;saveas(fig_NumDrink,[DrName,' ','NumDrink.bmp']);end
% % % % % 
% % % % %     fig_DrinkOn=figure;hold on
% % % % %     if length(DrinkOnRaster)>1;plot(DrinkOnRaster(:,1),DrinkOnRaster(:,2),'go');end
% % % % %     if length(DrinkOffRaster)>1;plot(DrinkOffRaster(:,1),DrinkOffRaster(:,2),'rx');end
% % % % %     title('Drink');zoom xon;hold off;
% % % % %     if FigureSave==1;saveas(fig_DrinkOn,[DrName,' ','DrinkOn.bmp']);end
% % % % % end
%-----------------------------------------------------------------------

% % % % % % %足の踏み外し解析　Water_percentage、WaterMarkを流用----------------------
% % % % % % FloorTouchArrayOriginal=data(:,26);
% % % % % % FloorDetachArrayOriginal=data(:,40);
% % % % % % 
% % % % % % % if FloorTouchArrayOriginal(1)==0;FloorTouchArrayOriginal(1)=1;end
% % % % % % % if FloorTouchArrayOriginal(end)>FloorDetachArrayOriginal(end);FloorDetachArrayOriginal(length(FloorDetachArrayOriginal))=FinishTime;end
% % % % % % 
% % % % % % if FloorTouchArrayOriginal(1)==0 & FloorTouchArrayOriginal(end)==0;
% % % % % %     FloorTouch_percent=0
% % % % % % else
% % % % % %     EventName='FloorTouch'
% % % % % %     [FloorTouchArrayOriginal,FloorDetachArrayOriginal,FloorTouchArray,FloorDetachArray]=Modify_Events(FloorTouchArrayOriginal,FloorDetachArrayOriginal,StartTime,FinishTime,EventName);
% % % % % %     [FloorTouch_percent]=Water_percentage(FloorTouchArray,FloorDetachArray,StartTime,FinishTime)
% % % % % %     FloorMark=WaterMark(FloorTouchArray, FloorDetachArray, StartTime, FinishTime, TurnMarkerTime, OneTurnTime);
% % % % % %     
% % % % % %     fig_FloorMark=figure;
% % % % % %     plot(FloorMark);axis([0 OneTurnTime 0 100]);
% % % % % %     if FigureSave==1;saveas(fig_FloorMark,[DrName,' ','FloorMark.bmp']);end
% % % % % % 
% % % % % %     FloorTouchRaster=raster(FloorTouchArray,TurnMarkerTime);
% % % % % %     FloorDetachRaster=raster(FloorDetachArray,TurnMarkerTime);
% % % % % % 
% % % % % %     DrinkOnRaster=raster(DrinkOnArray,TurnMarkerTime);
% % % % % %     DrinkOffRaster=raster(DrinkOffArray,TurnMarkerTime);
% % % % % % 
% % % % % %     NumFloorTouchTurn=zeros(1,length(TurnMarkerTime)-1);
% % % % % %     NumFloorTouchTurnCum=zeros(1,length(TurnMarkerTime)-1);
% % % % % %     for n=1:length(TurnMarkerTime)-1
% % % % % %         NumFloorTouchTurn(n)=sum(FloorTouchRaster(:,2)==n);
% % % % % %         if n>=2
% % % % % %             NumFloorTouchTurnCum(n)=NumFloorTouchTurnCum(n-1)+NumFloorTouchTurn(n);
% % % % % %         end
% % % % % %     end
% % % % % %     fig_FloorTouchCount=figure
% % % % % %     plot(NumFloorTouchTurn);title('FloorTouchCount/Turn');
% % % % % %     fig_NumFloorTouch=figure
% % % % % %     plot(NumFloorTouchTurnCum);title('Cumlative FloorTouchCount/Turn');
% % % % % %     if FigureSave==1;saveas(fig_NumFloorTouch,[DrName,' ','NumFloorTouch.bmp']);end
% % % % % %     
% % % % % %     fig_Floor=figure;hold on
% % % % % %     if length(FloorTouchRaster)>1;plot(FloorTouchRaster(:,1),FloorTouchRaster(:,2),'go');end
% % % % % %     if length(FloorDetachRaster)>1;plot(FloorDetachRaster(:,1),FloorDetachRaster(:,2),'rx');end
% % % % % %     title('FloorTouch');hold off;
% % % % % %     if FigureSave==1;saveas(fig_Floor,[DrName,' ','FloorTouch.bmp']);end
% % % % % % end
% % % % % % 
% % % % % % %-----------------------------------------------------------------------


%Rpeg番号
R_under=0;
R_over=0; 
TM=1;
RpegTimeArray2D=[];
RpegTimeArray2D_turn=[];
pegN=1;%pegN<=12 ペグ12本のとき
for n=1:length(RpegTimeArray)
    if pegN==13&&RpegTimeArray(n)>TurnMarkerTime(TM)&&RpegTimeArray(n)+50>TurnMarkerTime(TM+1)
        RpegTimeArray2D(TM+1,1)=RpegTimeArray(n);
        RpegTimeArray2D_turn(TM+1,1)=RpegTimeArray(n)-TurnMarkerTime(TM+1);
        pegN=2;
        TM=TM+1;
    elseif TM<length(TurnMarkerTime)&RpegTimeArray(n)>=TurnMarkerTime(TM)&RpegTimeArray(n)<TurnMarkerTime(TM+1)
        RpegTimeArray2D(TM,pegN)=RpegTimeArray(n);
        RpegTimeArray2D_turn(TM,pegN)=RpegTimeArray(n)-TurnMarkerTime(TM);
        pegN=pegN+1;
    elseif TM<(length(TurnMarkerTime)-1)&RpegTimeArray(n)>=TurnMarkerTime(TM+1)         
        RpegTimeArray2D(TM+1,1)=RpegTimeArray(n);
        RpegTimeArray2D_turn(TM+1,1)=RpegTimeArray(n)-TurnMarkerTime(TM+1);
        if pegN<12;R_under=R_under+1;end
        if pegN>13;R_over=R_over+1;end
        
        pegN=2;
        TM=TM+1;
    end
end
%Lpeg番号
L_under=0;
L_over=0;
TM=1;
LpegTimeArray2D=[];
LpegTimeArray2D_turn=[];
pegN=1;%pegN<=24 ペグ24本のとき
for n=1:length(LpegTimeArray)
    if pegN==13&&LpegTimeArray(n)>TurnMarkerTime(TM)&&LpegTimeArray(n)+50>TurnMarkerTime(TM+1)
        LpegTimeArray2D(TM+1,1)=LpegTimeArray(n);
        LpegTimeArray2D_turn(TM+1,1)=LpegTimeArray(n)-TurnMarkerTime(TM+1);
        pegN=2;
        TM=TM+1;
    elseif TM<length(TurnMarkerTime)&LpegTimeArray(n)>=TurnMarkerTime(TM)&LpegTimeArray(n)<TurnMarkerTime(TM+1)
        LpegTimeArray2D(TM,pegN)=LpegTimeArray(n);
        LpegTimeArray2D_turn(TM,pegN)=LpegTimeArray(n)-TurnMarkerTime(TM);
        pegN=pegN+1;
    elseif TM<(length(TurnMarkerTime)-1)&LpegTimeArray(n)>=TurnMarkerTime(TM+1)         
        LpegTimeArray2D(TM+1,1)=LpegTimeArray(n);
        LpegTimeArray2D_turn(TM+1,1)=LpegTimeArray(n)-TurnMarkerTime(TM+1);
        if pegN<12;L_under=L_under+1;end
        if pegN>13;L_over=L_over+1;end
        pegN=2;
        TM=TM+1;
    end
end

% Pegのカウントミスを補正
% 抜けた部分をnanにして一つずらす
if patternValue<9
for n=1:length(RpegTimeArray2D_turn(1,:))
    for m=1:length(RpegTimeArray2D_turn(:,1))
        A=RpegTimeArray2D_turn(:,n);
        if RpegTimeArray2D_turn(m,n)-median(A(A>0))>100
            RpegTimeArray2D_turn(m,:)=[RpegTimeArray2D_turn(m,1:n-1) nan RpegTimeArray2D_turn(m,n:end-1)];
            RpegTimeArray2D(m,:)=[RpegTimeArray2D(m,1:n-1) nan RpegTimeArray2D(m,n:end-1)];
        end
    end
end

for n=1:length(LpegTimeArray2D_turn(1,:))
    for m=1:length(LpegTimeArray2D_turn(:,1))
        A=LpegTimeArray2D_turn(:,n);
        if LpegTimeArray2D_turn(m,n)-median(A(A>0))>100
            LpegTimeArray2D_turn(m,:)=[LpegTimeArray2D_turn(m,1:n-1) nan LpegTimeArray2D_turn(m,n:end-1)];
            LpegTimeArray2D(m,:)=[LpegTimeArray2D(m,1:n-1) nan LpegTimeArray2D(m,n:end-1)];
        end
    end
end
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%% Rpeg6を抜いて右ペグ11本で測定したとき %%%%%%%%%%%%%%%%%%%%%%%%%%%%
if patternValue==8
Ins=nan(length(RpegTimeArray2D(:,11)),1);
RpegTimeArray2D=[RpegTimeArray2D(:,1:5) Ins RpegTimeArray2D(:,6:11)];
RpegTimeArray2D_turn=[RpegTimeArray2D_turn(:,1:5) Ins RpegTimeArray2D_turn(:,6:11)];
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%% Rpeg6,Lpeg6を各ターンで交互に抜いて左右ペグ11.5本で測定したとき %%%%%%%%%%%%%%%%%%%%%%%%%%%%
if patternValue==9
    if length(RpegTimeArray2D(1,:))>9
       RpegTimeArray2D(:,10:length(RpegTimeArray2D(1,:)))=[];
       RpegTimeArray2D_turn(:,10:length(RpegTimeArray2D_turn(1,:)))=[];
    end
    if length(LpegTimeArray2D(1,:))>9
       LpegTimeArray2D(:,10:length(LpegTimeArray2D(1,:)))=[];
       LpegTimeArray2D_turn(:,10:length(LpegTimeArray2D_turn(1,:)))=[];
    end

    for n=1:length(RpegTimeArray2D)
        if RpegTimeArray2D(n,9)==0 && RpegTimeArray2D(n,5)-RpegTimeArray2D(n,4)>500
            RpegTimeArray2D(n,:)=[RpegTimeArray2D(n,1:4) nan RpegTimeArray2D(n,5:8)];
            RpegTimeArray2D_turn(n,:)=[RpegTimeArray2D_turn(n,1:4) nan RpegTimeArray2D_turn(n,5:8)];
        end
        if LpegTimeArray2D(n,9)==0 && LpegTimeArray2D(n,5)-LpegTimeArray2D(n,4)>500
            LpegTimeArray2D(n,:)=[LpegTimeArray2D(n,1:4) nan LpegTimeArray2D(n,5:8)];
            LpegTimeArray2D_turn(n,:)=[LpegTimeArray2D_turn(n,1:4) nan LpegTimeArray2D_turn(n,5:8)];
        end
    end
% Pegのカウントミスを補正
% 抜けた部分をnanにして一つずらす
    for n=1:length(RpegTimeArray2D_turn(1,:))
        for m=1:length(RpegTimeArray2D_turn(:,1))
            A=RpegTimeArray2D_turn(:,n);
            if RpegTimeArray2D_turn(m,n)-median(A(A>0))>100
                RpegTimeArray2D_turn(m,:)=[RpegTimeArray2D_turn(m,1:n-1) nan RpegTimeArray2D_turn(m,n:end-1)];
                RpegTimeArray2D(m,:)=[RpegTimeArray2D(m,1:n-1) nan RpegTimeArray2D(m,n:end-1)];
            end
        end
    end

    for n=1:length(LpegTimeArray2D_turn(1,:))
        for m=1:length(LpegTimeArray2D_turn(:,1))
            A=LpegTimeArray2D_turn(:,n);
            if LpegTimeArray2D_turn(m,n)-median(A(A>0))>100
                LpegTimeArray2D_turn(m,:)=[LpegTimeArray2D_turn(m,1:n-1) nan LpegTimeArray2D_turn(m,n:end-1)];
                LpegTimeArray2D(m,:)=[LpegTimeArray2D(m,1:n-1) nan LpegTimeArray2D(m,n:end-1)];
            end
        end
    end
% Ins=nan(length(RpegTimeArray2D(:,11)),1);
% RpegTimeArray2D=[RpegTimeArray2D(:,1:5) Ins RpegTimeArray2D(:,6:11)];
% RpegTimeArray2D_turn=[RpegTimeArray2D_turn(:,1:5) Ins RpegTimeArray2D_turn(:,6:11)];
% Ins=nan(length(LpegTimeArray2D(:,11)),1);
% LpegTimeArray2D=[LpegTimeArray2D(:,1:5) Ins LpegTimeArray2D(:,6:11)];
% LpegTimeArray2D_turn=[LpegTimeArray2D_turn(:,1:5) Ins LpegTimeArray2D_turn(:,6:11)];
% for n=1:length(RpegTimeArray2D_turn(1,:))
%     for m=1:length(RpegTimeArray2D_turn(:,1))
%         A=RpegTimeArray2D_turn(:,n);
%         if RpegTimeArray2D_turn(m,n)-median(A(isnan(A)==0))>100
%             RpegTimeArray2D_turn(m,:)=[RpegTimeArray2D_turn(m,1:n-1) nan RpegTimeArray2D_turn(m,n:end-1)];
%             RpegTimeArray2D(m,:)=[RpegTimeArray2D(m,1:n-1) nan RpegTimeArray2D(m,n:end-1)];
%         end
%     end
% end
% 
% for n=1:length(LpegTimeArray2D_turn(1,:))
%     for m=1:length(LpegTimeArray2D_turn(:,1))
%         A=LpegTimeArray2D_turn(:,n);
%         if LpegTimeArray2D_turn(m,n)-median(A(isnan(A)==0))>100
%             LpegTimeArray2D_turn(m,:)=[LpegTimeArray2D_turn(m,1:n-1) nan LpegTimeArray2D_turn(m,n:end-1)];
%             LpegTimeArray2D(m,:)=[LpegTimeArray2D(m,1:n-1) nan LpegTimeArray2D(m,n:end-1)];
%         end
%     end
% end
TurnMarkerTime_R=[];TurnMarkerTime_L=[];
LpegTimeArray2D_turn_R=[];RpegTimeArray2D_turn_R=[];
LpegTimeArray2D_turn_L=[];RpegTimeArray2D_turn_L=[];
for n=1:length(TurnMarkerTime)-1
    if isnan(LpegTimeArray2D(n,5))==1 && isnan(RpegTimeArray2D(n,5))==0 %photobeam Lpegなし=Rpeg for Touchなし
        TMR=TurnMarkerTime(n);
        TurnMarkerTime_R=[TurnMarkerTime_R; TMR];
        LpegTimeArray2D_turn_R=[LpegTimeArray2D_turn_R;LpegTimeArray2D_turn(n,:)]; % Lpeg(6)=nan
        RpegTimeArray2D_turn_R=[RpegTimeArray2D_turn_R;RpegTimeArray2D_turn(n,:)];
    elseif isnan(LpegTimeArray2D(n,5))==0 && isnan(RpegTimeArray2D(n,5))==1 %photobeam Rpegなし=Lpeg for Touchなし
        TML=TurnMarkerTime(n);
        TurnMarkerTime_L=[TurnMarkerTime_L; TML];
        LpegTimeArray2D_turn_L=[LpegTimeArray2D_turn_L;LpegTimeArray2D_turn(n,:)]; 
        RpegTimeArray2D_turn_L=[RpegTimeArray2D_turn_L;RpegTimeArray2D_turn(n,:)]; % Rpeg(6)=nan
    end
end


% AA-1パターンにおいては、マウスにとって右ペグがないとき(_Rで示す)フォトビームでは左ペグがないことになる（実時間記録上において）。
% 従って右ペグ抜きときの2D_turn（フォトビームには右ペグがあって左ペグがない）は左ペグがなかったときの2D_turnとして扱うのが妥当である。
% つまり実際に走ったペグによる時間情報・ペグ情報を利用する。これはすべての各TurnMarkerTimeが正確にカウントされている限り有効。
%１周のなかでRペグが来るタイミング
MedPegTimeR_L=[];MedPegTimeR_R=[];
for n=1:length(RpegTimeArray2D_turn(1,:))
    MedPegTimeR_L(n)=nanmedian(RpegTimeArray2D_turn_R(:,n)); % 実時間上からのあてはめ
    MedPegTimeR_R(n)=nanmedian(RpegTimeArray2D_turn_L(:,n)); % 実時間上からのあてはめ
end

%１周のなかでLペグが来るタイミング
MedPegTimeL_L=[];MedPegTimeL_R=[];
for n=1:length(LpegTimeArray2D_turn(1,:))
    MedPegTimeL_L(n)=nanmedian(LpegTimeArray2D_turn_R(:,n)); % 実時間上からのあてはめ
    MedPegTimeL_R(n)=nanmedian(LpegTimeArray2D_turn_L(:,n)); % 実時間上からのあてはめ
end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%% ABパターン(7peg)のとき %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% if patternValue==10
% Ins=nan(length(RpegTimeArray2D(:,9)),3);
% RpegTimeArray2D=[RpegTimeArray2D Ins];
% RpegTimeArray2D_turn=[RpegTimeArray2D_turn Ins];
% Ins=nan(length(LpegTimeArray2D(:,8)),4);
% LpegTimeArray2D=[LpegTimeArray2D Ins];
% LpegTimeArray2D_turn=[LpegTimeArray2D_turn Ins];
% end

if patternValue==15
%Rpeg番号
R_under=0;
R_over=0; 
TM=1;
RpegTimeArray2D=[];
RpegTimeArray2D_turn=[];
pegN=1;%pegN<=12 ペグ12本のとき
for n=1:length(RpegTimeArray)
    if pegN==15&&RpegTimeArray(n)>TurnMarkerTimeB(TM)&&RpegTimeArray(n)+50>TurnMarkerTimeB(TM+1)
        RpegTimeArray2D(TM+1,1)=RpegTimeArray(n);
        RpegTimeArray2D_turn(TM+1,1)=RpegTimeArray(n)-TurnMarkerTimeB(TM+1);
        pegN=2;
        TM=TM+1;
    elseif TM<length(TurnMarkerTimeB)&RpegTimeArray(n)>=TurnMarkerTimeB(TM)&RpegTimeArray(n)<TurnMarkerTimeB(TM+1)
        RpegTimeArray2D(TM,pegN)=RpegTimeArray(n);
        RpegTimeArray2D_turn(TM,pegN)=RpegTimeArray(n)-TurnMarkerTimeB(TM);
        pegN=pegN+1;
    elseif TM<(length(TurnMarkerTimeB)-1)&RpegTimeArray(n)>=TurnMarkerTimeB(TM+1)         
        RpegTimeArray2D(TM+1,1)=RpegTimeArray(n);
        RpegTimeArray2D_turn(TM+1,1)=RpegTimeArray(n)-TurnMarkerTimeB(TM+1);
        if pegN<14;R_under=R_under+1;end
        if pegN>14;R_over=R_over+1;end
        
        pegN=2;
        TM=TM+1;
    end
end
%Lpeg番号
L_under=0;
L_over=0;
TM=1;
LpegTimeArray2D=[];
LpegTimeArray2D_turn=[];
pegN=1;%pegN<=12 ペグ12本のとき
for n=1:length(LpegTimeArray)
    if pegN==15&&LpegTimeArray(n)>TurnMarkerTimeB(TM)&&LpegTimeArray(n)+50>TurnMarkerTimeB(TM+1)
        LpegTimeArray2D(TM+1,1)=LpegTimeArray(n);
        LpegTimeArray2D_turn(TM+1,1)=LpegTimeArray(n)-TurnMarkerTimeB(TM+1);
        pegN=2;
        TM=TM+1;
    elseif TM<length(TurnMarkerTimeB)&LpegTimeArray(n)>=TurnMarkerTimeB(TM)&LpegTimeArray(n)<TurnMarkerTimeB(TM+1)
        LpegTimeArray2D(TM,pegN)=LpegTimeArray(n);
        LpegTimeArray2D_turn(TM,pegN)=LpegTimeArray(n)-TurnMarkerTimeB(TM);
        pegN=pegN+1;
    elseif TM<(length(TurnMarkerTimeB)-1)&LpegTimeArray(n)>=TurnMarkerTimeB(TM+1)         
        LpegTimeArray2D(TM+1,1)=LpegTimeArray(n);
        LpegTimeArray2D_turn(TM+1,1)=LpegTimeArray(n)-TurnMarkerTimeB(TM+1);
        if pegN<14;L_under=L_under+1;end
        if pegN>14;L_over=L_over+1;end
        pegN=2;
        TM=TM+1;
    end
end


    if length(RpegTimeArray2D(1,:))>14
       RpegTimeArray2D(:,15:length(RpegTimeArray2D(1,:)))=[];
       RpegTimeArray2D_turn(:,15:length(RpegTimeArray2D_turn(1,:)))=[];
    end
    if length(LpegTimeArray2D(1,:))>14
       LpegTimeArray2D(:,15:length(LpegTimeArray2D(1,:)))=[];
       LpegTimeArray2D_turn(:,15:length(LpegTimeArray2D_turn(1,:)))=[];
    end


% Ins=nan(length(RpegTimeArray2D(:,11)),1);
% RpegTimeArray2D=[RpegTimeArray2D(:,1:5) Ins RpegTimeArray2D(:,6:11)];
% RpegTimeArray2D_turn=[RpegTimeArray2D_turn(:,1:5) Ins RpegTimeArray2D_turn(:,6:11)];
% Ins=nan(length(LpegTimeArray2D(:,11)),1);
% LpegTimeArray2D=[LpegTimeArray2D(:,1:5) Ins LpegTimeArray2D(:,6:11)];
% LpegTimeArray2D_turn=[LpegTimeArray2D_turn(:,1:5) Ins LpegTimeArray2D_turn(:,6:11)];
for n=1:length(RpegTimeArray2D_turn(1,:))
    for m=1:length(RpegTimeArray2D_turn(:,1))
        A=RpegTimeArray2D_turn(:,n);
        if RpegTimeArray2D_turn(m,n)-median(A(isnan(A)==0))>150
            RpegTimeArray2D_turn(m,:)=[RpegTimeArray2D_turn(m,1:n-1) nan RpegTimeArray2D_turn(m,n:end-1)];
            RpegTimeArray2D(m,:)=[RpegTimeArray2D(m,1:n-1) nan RpegTimeArray2D(m,n:end-1)];
        end
    end
end

for n=1:length(LpegTimeArray2D_turn(1,:))
    for m=1:length(LpegTimeArray2D_turn(:,1))
        A=LpegTimeArray2D_turn(:,n);
        if LpegTimeArray2D_turn(m,n)-median(A(isnan(A)==0))>150
            LpegTimeArray2D_turn(m,:)=[LpegTimeArray2D_turn(m,1:n-1) nan LpegTimeArray2D_turn(m,n:end-1)];
            LpegTimeArray2D(m,:)=[LpegTimeArray2D(m,1:n-1) nan LpegTimeArray2D(m,n:end-1)];
        end
    end
end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%% ABパターン(9,8peg)のとき %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if patternValue==10
    
    if length(RpegTimeArray2D(1,:))>9
       RpegTimeArray2D(:,10:length(RpegTimeArray2D(1,:)))=[];
       RpegTimeArray2D_turn(:,10:length(RpegTimeArray2D_turn(1,:)))=[];
    end
    if length(LpegTimeArray2D(1,:))>9
       LpegTimeArray2D(:,10:length(LpegTimeArray2D(1,:)))=[];
       LpegTimeArray2D_turn(:,10:length(LpegTimeArray2D_turn(1,:)))=[];
    end
% Pegのカウントミスを補正
% 抜けた部分をnanにして一つずらす
for n=1:length(RpegTimeArray2D_turn(1,:))
    for m=1:length(RpegTimeArray2D_turn(:,1))
        A=RpegTimeArray2D_turn(:,n);
        if RpegTimeArray2D_turn(m,n)-median(A(A>0))>100
            RpegTimeArray2D_turn(m,:)=[RpegTimeArray2D_turn(m,1:n-1) nan RpegTimeArray2D_turn(m,n:end-1)];
            RpegTimeArray2D(m,:)=[RpegTimeArray2D(m,1:n-1) nan RpegTimeArray2D(m,n:end-1)];
        end
    end
end

for n=1:length(LpegTimeArray2D_turn(1,:))
    for m=1:length(LpegTimeArray2D_turn(:,1))
        A=LpegTimeArray2D_turn(:,n);
        if LpegTimeArray2D_turn(m,n)-median(A(A>0))>100
            LpegTimeArray2D_turn(m,:)=[LpegTimeArray2D_turn(m,1:n-1) nan LpegTimeArray2D_turn(m,n:end-1)];
            LpegTimeArray2D(m,:)=[LpegTimeArray2D(m,1:n-1) nan LpegTimeArray2D(m,n:end-1)];
        end
    end
end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%




if patternValue<9
    if length(RpegTimeArray2D(1,:))>12
       RpegTimeArray2D(:,13:length(RpegTimeArray2D(1,:)))=[];
       RpegTimeArray2D_turn(:,13:length(RpegTimeArray2D_turn(1,:)))=[];
    end
    if length(LpegTimeArray2D(1,:))>12
       LpegTimeArray2D(:,13:length(LpegTimeArray2D(1,:)))=[];
       LpegTimeArray2D_turn(:,13:length(LpegTimeArray2D_turn(1,:)))=[];
    end
end

patternValue
if patternValue~=9
%１周のなかでRペグが来るタイミング
MedPegTimeR=[];
for n=1:length(RpegTimeArray2D_turn(1,:))
    MedPegTimeR(n)=nanmedian(RpegTimeArray2D_turn(:,n));
end
%Rペグのタイミングを適正な位置に調整
for n=1:length(MedPegTimeR)
    MedPegTimeR(n)=MedPegTimeR(n);%-OneTurnTime*0.1;
    if MedPegTimeR(n)<0;MedPegTimeR(n)=MedPegTimeR(n)+OneTurnTime;end;
end
%１周のなかでLペグが来るタイミング
MedPegTimeL=[];
for n=1:length(LpegTimeArray2D_turn(1,:))
    MedPegTimeL(n)=nanmedian(LpegTimeArray2D_turn(:,n));
end
%Lペグのタイミングを適正な位置に調整
for n=1:length(MedPegTimeL)
    MedPegTimeL(n)=MedPegTimeL(n);%-OneTurnTime*0.1;
    if MedPegTimeL(n)<0;MedPegTimeL(n)=MedPegTimeL(n)+OneTurnTime;end;
end
disp('Rpeg<12');disp(R_under);
disp('Rpeg>12');disp(R_over);
disp('Lpeg<12');disp(L_under);
disp('Lpeg>12');disp(L_over);
end

% RPegTouchAll





