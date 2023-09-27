% 左右のTouchの位相とスパイクの関係を、発火頻度、ラスターで表示。
% 左右左タッチでの右タッチの位相を0～+1、右左右タッチでの左タッチの位相を（0～+1）-1とする。
% スパイクは、対象のタッチの前後にあるものを分類する。

function [MeancosLRLphase MeancosRLRphase MeanLRLphase MeanRLRphase cosLRLphase cosRLRphase LRLphase RLRphase MeanLRLphaseDif MeanRLRphaseDif FlgL FlgR]...
    =PhaseSpike(SpikeArray)

global  RpegTouchCell LpegTouchCell TurnMarkerTime OneTurnTime RmedianPTTM LmedianPTTM RpegTouchBypegCell  LpegTouchBypegCell...
    RTouchAll LTouchAll patternValue LRLpegTimeArray RLRpegTimeArray LRLpegphase RLRpegphase PhaseTimeS PhaseTimeF RpegTouchArray LpegTouchArray

if ~isempty(LTouchAll)==1 && ~isempty(RTouchAll)==1
    LpegTouchArray=LTouchAll;
    RpegTouchArray=RTouchAll;
else
RpegTouchArray=[RpegTouchCell{1};RpegTouchCell{2};RpegTouchCell{3};RpegTouchCell{4};RpegTouchCell{5};RpegTouchCell{6};...
    RpegTouchCell{7};RpegTouchCell{8};RpegTouchCell{9};RpegTouchCell{10};RpegTouchCell{11};RpegTouchCell{12}];
RpegTouchArray=sort(RpegTouchArray);
% RpegTouchDiff=diff(RpegTouchArray);
% RpegTouchDiff1=[0;RpegTouchDiff];
% RpegTouchDiff2=[RpegTouchDiff;0];

LpegTouchArray=[LpegTouchCell{1};LpegTouchCell{2};LpegTouchCell{3};LpegTouchCell{4};LpegTouchCell{5};LpegTouchCell{6};...
    LpegTouchCell{7};LpegTouchCell{8};LpegTouchCell{9};LpegTouchCell{10};LpegTouchCell{11};LpegTouchCell{12}];
LpegTouchArray=sort(LpegTouchArray);
% LpegTouchDiff=diff(LpegTouchArray);
% LpegTouchDiff1=[0;LpegTouchDiff];
% LpegTouchDiff2=[LpegTouchDiff;0];
end

RpegTouchArray(RpegTouchArray<TurnMarkerTime(1))=[];
RpegTouchArray(RpegTouchArray>TurnMarkerTime(end))=[];
LpegTouchArray(LpegTouchArray<TurnMarkerTime(1))=[];
LpegTouchArray(LpegTouchArray>TurnMarkerTime(end))=[];
for n=1:length(TurnMarkerTime)-1
    if TurnMarkerTime(n+1)-TurnMarkerTime(n)>OneTurnTime
        RpegTouchArray(RpegTouchArray>TurnMarkerTime(n)+OneTurnTime&RpegTouchArray<TurnMarkerTime(n+1))=[];
        LpegTouchArray(LpegTouchArray>TurnMarkerTime(n)+OneTurnTime&LpegTouchArray<TurnMarkerTime(n+1))=[];
    end
end

% RpegTouchDiff(RpegTouchDiff>1000)=[];
% LpegTouchDiff(LpegTouchDiff>1000)=[];
% TurnMarkerTime=[TurnMarkerTime;269442]; % 101013#37
% TurnMarkerTime=[TurnMarkerTime;264711]; % 101012#37
% TurnMarkerTime=[TurnMarkerTime;246615]; % 101006#371
% TurnMarkerTime=[TurnMarkerTime;242448]; % 101006#373
% TurnMarkerTime=[TurnMarkerTime;251692]; % 100830#331
% TurnMarkerTime=[TurnMarkerTime;252103]; % 101010#371
% TurnMarkerTime=[TurnMarkerTime;252825]; % 101010#372
% TurnMarkerTime=[TurnMarkerTime;241526]; % 101015#371
% TurnMarkerTime=[TurnMarkerTime;242649]; % 101005#371
% TurnMarkerTime=[TurnMarkerTime;246187]; % 101001#351


LRLphase=[];
LRLTouchArray=[];
RTrialTurn=[];
LRLTurnArray=[];
RLRphase=[];
RLRTouchArray=[];
LTrialTurn=[];
RLRTurnArray=[];
TurnTime=median(diff(TurnMarkerTime))*1.1;
LRLbefore=[];
RLRbefore=[];
LRLafter=[];
RLRafter=[];
% LRLphaseの計算
% LRLTouchArrayはLRLphaseのときのRpegTouchのTime
% LRLTurnはLRLTouchに一番近いTurnMarkerTime
for n=1:length(RpegTouchArray)
    Lbefore=max(LpegTouchArray(LpegTouchArray<RpegTouchArray(n) & RpegTouchArray(n)-800<LpegTouchArray));
    Lafter=min(LpegTouchArray(RpegTouchArray(n)<=LpegTouchArray & LpegTouchArray<RpegTouchArray(n)+800));
    
    if ~isempty(Lbefore) && ~isempty(Lafter) && Lafter-Lbefore<1000
        LRLbefore=[LRLbefore Lbefore]; 
        LRLafter=[LRLafter Lafter]; 
        LRL=(RpegTouchArray(n)-Lbefore)/(Lafter-Lbefore);
        LRLphase=[LRLphase LRL];
        LRLTouchArray=[LRLTouchArray RpegTouchArray(n)];
        LRLTurn=max(TurnMarkerTime(TurnMarkerTime<RpegTouchArray(n)));
        LRLTurnArray=[LRLTurnArray LRLTurn];
        IntervalR=LRLTouchArray-LRLbefore;
        IntervalLRL=LRLafter-LRLbefore;
    end
end
        
        % RLRphaseの計算
for n=1:length(LpegTouchArray)
    Rbefore=max(RpegTouchArray(RpegTouchArray<LpegTouchArray(n) & LpegTouchArray(n)-800<RpegTouchArray));
    Rafter=min(RpegTouchArray(LpegTouchArray(n)<=RpegTouchArray & RpegTouchArray<LpegTouchArray(n)+800));
    
    if ~isempty(Rbefore) && ~isempty(Rafter) && Rafter-Rbefore<1000
        RLRbefore=[RLRbefore Rbefore]; 
        RLRafter=[RLRafter Rafter];
        RLR=(LpegTouchArray(n)-Rbefore)/(Rafter-Rbefore);
        RLRphase=[RLRphase RLR];
        RLRTouchArray=[RLRTouchArray LpegTouchArray(n)];
        RLRTurn=max(TurnMarkerTime(TurnMarkerTime<LpegTouchArray(n)));
        RLRTurnArray=[RLRTurnArray RLRTurn];
        IntervalL=RLRTouchArray-RLRbefore;
        IntervalRLR=RLRafter-RLRbefore;
    end
end


% SpikeArray1=ts_spike;
% SpikeArray=(SpikeArray1-StartTime)*1000; %ラスターの中で選択できるようにする




size(LRLbefore)
% RPhaseIndex=[];
% RPhaseIndex=LRLTouchArray-LRLTurnArray;   
% LPhaseIndex=[];
% LPhaseIndex=RLRTouchArray-RLRTurnArray;

Spike_PhaseL=[];
Spike_PhaseR=[];
PhaseL=[];
PhaseR=[];
SpikeArray(SpikeArray==0)=[];
intervalSR=[];
intervalSL=[];
A=0;

% SpikeのPhaseごとへの分類
% LR またはRLごとにスパイクを細かく分類するやり方（スパイクはLとR、またはRとLの間）
% for n=1:length(SpikeArray)
%     RSTouch= min(LRLTouchArray(LRLTouchArray>=SpikeArray(n)));
% %     RBindex=find(max(LRLbefore(LRLbefore<SpikeArray(n))));
%     LSTouch= min(RLRTouchArray(RLRTouchArray>=SpikeArray(n)));
% %     LBindex=find(max(RLRbefore(RLRbefore<SpikeArray(n))));
%     
%     if RSTouch<=LSTouch   % 右中心でプロットするので、＝の場合は右タッチでのカウントとする
%         Rindex=find(LRLTouchArray==RSTouch);
%         if LRLbefore(Rindex)<SpikeArray(n)&SpikeArray(n)<=RSTouch
% %         SpikePhaseR=[LRLphase(Rindex) SpikeArray(n)];
%            PhaseR=[PhaseR LRLphase(Rindex)]; % SpikeのあったときのPhase
%            Spike_PhaseR=[Spike_PhaseR SpikeArray(n)]; % Spike_PhaseRはRのPhaseに入ったSpike
%            intR=RSTouch-LRLbefore(Rindex);
%            intervalSR=[intervalSR intR];
%         A=1;
%         end
%     
%     elseif LSTouch<RSTouch
%         Lindex=find(RLRTouchArray==LSTouch);
%         if RLRbefore(Lindex)<SpikeArray(n)&&SpikeArray(n)<=LSTouch
% %         SpikePhaseL=[RLRphase(Lindex) SpikeArray(n)];
%            PhaseL=[PhaseL RLRphase(Lindex)]; % SpikeのあったときのPhase
%            Spike_PhaseL=[Spike_PhaseL SpikeArray(n)]; % Spike_PhaseLはLのPhaseに入ったSpike
%            intL=LSTouch-RLRbefore(Lindex);
%            intervalSL=[intervalSL intL];
%         A=1;
%         end
%     end
%     if A==0
%         non_processed=n;
%     end
%     A=0;
% end

intervalLRL=[];
intervalRLR=[];
% SpikeのPhaseごとへの分類
% LRLのphaseだけでスパイクを分類するやり方（スパイクはRTouchの前後）
for n=1:length(SpikeArray)
    LRLbeforeS=max(LRLbefore(LRLbefore<SpikeArray(n)));
    RLRbeforeS=max(RLRbefore(RLRbefore<SpikeArray(n)));
    if ~isempty(LRLbeforeS)==1
        RphaseLbefIndex= max(find(LRLbefore==LRLbeforeS));
%     RBindex=find(max(LRLbefore(LRLbefore<SpikeArray(n))));
        
%     LBindex=find(max(RLRbefore(RLRbefore<SpikeArray(n))));
    
    
%     if RSTouch<=LSTouch   % 右中心でプロットするので、＝の場合は右タッチでのカウントとする
%         Rindex=find(LRLTouchArray==RSTouch);
        if LRLbefore(RphaseLbefIndex)<SpikeArray(n)&SpikeArray(n)<=LRLafter(RphaseLbefIndex);
%         SpikePhaseR=[LRLphase(Rindex) SpikeArray(n)];
           PhaseR=[PhaseR LRLphase(RphaseLbefIndex)]; % SpikeのあったときのPhase
           Spike_PhaseR=[Spike_PhaseR SpikeArray(n)]; % Spike_PhaseRはRのPhaseに入ったSpike(Timestamp)
           intLRL=LRLafter(RphaseLbefIndex)-LRLbefore(RphaseLbefIndex);
           intervalLRL=[intervalLRL intLRL];
        A=1;
        end
    end
    if ~isempty(RLRbeforeS)==1
        LphaseRbefIndex= max(find(RLRbefore==RLRbeforeS));
%     elseif LSTouch<RSTouch
%         Lindex=find(RLRTouchArray==LSTouch);
        if RLRbefore(LphaseRbefIndex)<SpikeArray(n)&SpikeArray(n)<=RLRafter(LphaseRbefIndex)
%         SpikePhaseL=[RLRphase(Lindex) SpikeArray(n)];
           PhaseL=[PhaseL RLRphase(LphaseRbefIndex)]; % SpikeのあったときのPhase
           Spike_PhaseL=[Spike_PhaseL SpikeArray(n)]; % Spike_PhaseLはLのPhaseに入ったSpike
           intRLR=RLRafter(LphaseRbefIndex)-RLRbefore(LphaseRbefIndex);
           intervalRLR=[intervalRLR intRLR];
        A=1;
        end
    end
    if A==0
        non_processed=n;
    end
    A=0;
end



Time0=0;Time1=0;Time2=0;Time3=0;Time4=0;Time5=0;Time6=0;Time7=0;Time8=0;Time9=0;Time10=0;
Time_1=0;Time_2=0;Time_3=0;Time_4=0;Time_5=0;Time_6=0;Time_7=0;Time_8=0;Time_9=0;Time_10=0;
% for n=1:length(LRLphase)
%     if -0.05<LRLphase(n) && LRLphase(n)<0.05;Time0=Time0+IntervalR(n);
%     elseif 0.05<=LRLphase(n) && LRLphase(n)<0.15; Time1=Time1+IntervalR(n);
%     elseif 0.15<=LRLphase(n) && LRLphase(n)<0.25; Time2=Time2+IntervalR(n);
%     elseif 0.25<=LRLphase(n) && LRLphase(n)<0.35; Time3=Time3+IntervalR(n);
%     elseif 0.35<=LRLphase(n) && LRLphase(n)<0.45; Time4=Time4+IntervalR(n);      
%     elseif 0.45<=LRLphase(n) && LRLphase(n)<0.55; Time5=Time5+IntervalR(n);       
%     elseif 0.55<=LRLphase(n) && LRLphase(n)<0.65; Time6=Time6+IntervalR(n);       
%     elseif 0.65<=LRLphase(n) && LRLphase(n)<0.75; Time7=Time7+IntervalR(n);        
%     elseif 0.75<=LRLphase(n) && LRLphase(n)<0.85; Time8=Time8+IntervalR(n);
%     elseif 0.85<=LRLphase(n) && LRLphase(n)<0.95; Time9=Time9+IntervalR(n);        
%     elseif 0.95<=LRLphase(n) && LRLphase(n)<1.05; Time10=Time10+IntervalR(n);        
%     end
% end


for n=1:length(LRLphase)
    if -0.05<LRLphase(n) && LRLphase(n)<0.05;Time0=Time0+IntervalLRL(n);
    elseif 0.05<=LRLphase(n) && LRLphase(n)<0.15; Time1=Time1+IntervalLRL(n);
    elseif 0.15<=LRLphase(n) && LRLphase(n)<0.25; Time2=Time2+IntervalLRL(n);
    elseif 0.25<=LRLphase(n) && LRLphase(n)<0.35; Time3=Time3+IntervalLRL(n);
    elseif 0.35<=LRLphase(n) && LRLphase(n)<0.45; Time4=Time4+IntervalLRL(n);      
    elseif 0.45<=LRLphase(n) && LRLphase(n)<0.55; Time5=Time5+IntervalLRL(n);       
    elseif 0.55<=LRLphase(n) && LRLphase(n)<0.65; Time6=Time6+IntervalLRL(n);       
    elseif 0.65<=LRLphase(n) && LRLphase(n)<0.75; Time7=Time7+IntervalLRL(n);        
    elseif 0.75<=LRLphase(n) && LRLphase(n)<0.85; Time8=Time8+IntervalLRL(n);
    elseif 0.85<=LRLphase(n) && LRLphase(n)<0.95; Time9=Time9+IntervalLRL(n);        
    elseif 0.95<=LRLphase(n) && LRLphase(n)<1.05; Time10=Time10+IntervalLRL(n);        
    end
end

% for n=1:length(RLRphase)
%     if -0.05<RLRphase(n)-1 && RLRphase(n)-1<0.05;Time0=Time0+IntervalL(n);
%     elseif -0.05>=RLRphase(n)-1 && RLRphase(n)-1>-0.15; Time_1=Time_1+IntervalL(n);
%     elseif -0.15>=RLRphase(n)-1 && RLRphase(n)-1>-0.25; Time_2=Time_2+IntervalL(n);
%     elseif -0.25>=RLRphase(n)-1 && RLRphase(n)-1>-0.35; Time_3=Time_3+IntervalL(n);
%     elseif -0.35>=RLRphase(n)-1 && RLRphase(n)-1>-0.45; Time_4=Time_4+IntervalL(n);      
%     elseif -0.45>=RLRphase(n)-1 && RLRphase(n)-1>-0.55; Time_5=Time_5+IntervalL(n);       
%     elseif -0.55>=RLRphase(n)-1 && RLRphase(n)-1>-0.65; Time_6=Time_6+IntervalL(n);        
%     elseif -0.65>=RLRphase(n)-1 && RLRphase(n)-1>-0.75; Time_7=Time_7+IntervalL(n);        
%     elseif -0.75>=RLRphase(n)-1 && RLRphase(n)-1>-0.85; Time_8=Time_8+IntervalL(n);
%     elseif -0.85>=RLRphase(n)-1 && RLRphase(n)-1>-0.95; Time_9=Time_9+IntervalL(n);        
%     elseif -0.95>=RLRphase(n)-1 && RLRphase(n)-1>-1.05; Time_10=Time_10+IntervalL(n);        
%     end
% end    
% Timebin=[Time_10 Time_9 Time_8 Time_7 Time_6 Time_5 Time_4 Time_3 Time_2 Time_1 Time0...
%      Time1 Time2 Time3 Time4 Time5 Time6 Time7 Time8 Time9 Time10 ];
Timebin=[Time0 Time1 Time2 Time3 Time4 Time5 Time6 Time7 Time8 Time9 Time10 ];
Timebin(Timebin<1000)=0;   %%%実際のphaseで走った時間が少ないのはカット

% PhaseRL=[PhaseR PhaseL-1];
% h=hist(PhaseRL,-1:0.1:1)
% figure
% hist(PhaseRL,-1:0.1:1);
% set(gca,'Xlim',[-1.1 1.1]);
h=hist(PhaseR,0:0.1:1)
Firingrate=h./(Timebin*0.001);
figure
bar(0:0.1:1,Firingrate,1); set(gca,'Xlim',[-0.1 1.1]);
ylabel('FiringRate');xlabel('LRLPhase   ');

%%% 一歩ごとのIntervalの大きさとスパイクの関係
% figure
% subplot(2,1,1)
% hist(intervalSR)
% set(gca,'Xlim',[min(IntervalR) max(IntervalR)]);
% subplot(2,1,2)
% hist(IntervalR)
% set(gca,'Xlim',[min(IntervalR) max(IntervalR)]);
% figure
% subplot(2,1,1)
% hist(intervalSL)
% set(gca,'Xlim',[min(IntervalL) max(IntervalL)]);
% subplot(2,1,2)
% hist(IntervalL)
% set(gca,'Xlim',[min(IntervalL) max(IntervalL)]);

if patternValue<10

RasterTempXR=[];
RasterTempXL=[];
% TurnMarkerTimeからの時間（ラスターX軸に合わせる）
for n=1:length(TurnMarkerTime)-1
    TempXR=Spike_PhaseR(Spike_PhaseR>TurnMarkerTime(n) & Spike_PhaseR<=TurnMarkerTime(n+1))-TurnMarkerTime(n);
    TempXL=Spike_PhaseL(Spike_PhaseL>TurnMarkerTime(n) & Spike_PhaseL<=TurnMarkerTime(n+1))-TurnMarkerTime(n);
    RasterTempXR=[RasterTempXR TempXR];
    RasterTempXL=[RasterTempXL TempXL];
end
size(Spike_PhaseR)
size(RasterTempXR)
size(Spike_PhaseL)  
size(RasterTempXL)  

Raster1=[RasterTempXR;PhaseR];
Raster2=[RasterTempXL;PhaseL-1];
figure('Position',[1 1 1000 700]);hold on;
text(Raster1(1,:),Raster1(2,:),'l','FontSize',14,'color',[0 0 0]);
text(Raster2(1,:),Raster2(2,:),'l','FontSize',14,'color',[0 0 0]);

    for  n=1:12
        if length(RpegTouchBypegCell{n})>5
            RfromPeg(n)=mean(RpegTouchBypegCell{n});
        else
            RfromPeg(n)=NaN;
        end
        if length(LpegTouchBypegCell{n})>5
            LfromPeg(n)=mean(LpegTouchBypegCell{n});
        else
            LfromPeg(n)=NaN;
        end
    end
    RtouchPlace=MedPegTimeR(1:12)+RfromPeg;
    LtouchPlace=MedPegTimeL(1:12)+LfromPeg;
    RtouchPlace(RtouchPlace<0)=RtouchPlace(RtouchPlace<0)+OneTurnTime;RtouchPlace(RtouchPlace>OneTurnTime)=RtouchPlace(RtouchPlace>OneTurnTime)-OneTurnTime;
    LtouchPlace(LtouchPlace<0)=LtouchPlace(LtouchPlace<0)+OneTurnTime;LtouchPlace(LtouchPlace>OneTurnTime)=LtouchPlace(LtouchPlace>OneTurnTime)-OneTurnTime;
    
    XRplace=floor(duration*RtouchPlace(1:12)/OneTurnTime);
    XLplace=floor(duration*LtouchPlace(1:12)/OneTurnTime);
    
    YRplace=ones(1,12)'*Max*0.6;
    YLplace=ones(1,12)'*Max*0.7;
%     RmedianPTTM LmedianPTTM
    text(RmedianPTTM*10,YRplace,'l','FontSize',18,'color',[0 1 1]);
    text(LmedianPTTM*10,YLplace,'l','FontSize',18,'color',[1 0 1]);
    for n=1:12
        text(XRplace(n),YRplace(n)*1.08,int2str(n),'FontSize',12,'color',[0 1 1]);
        text(XLplace(n),YLplace(n)*1.08,int2str(n),'FontSize',12,'color',[1 0 1]);
    end
    
set(gca,'Xlim',[0 OneTurnTime+100],'Ylim',[-1 1]);hold off % x y 軸の範囲を適宜設定

Raster3=[intervalSR;PhaseR];
Raster4=[intervalSL;PhaseL-1];
figure;hold on;% figure('Position',[1 1 1000 700]);
text(Raster3(1,:),Raster3(2,:),'x','FontSize',14,'color',[0 1 0]);
text(Raster4(1,:),Raster4(2,:),'x','FontSize',14,'color',[1 0 0]);
set(gca,'Xlim',[0 640],'Ylim',[-1 1]);hold off % x y 軸の範囲を適宜設定
% if ~isempty(R1select);Raster1=raster(R1select,TurnMarkerTime);if length(Raster1)>1;text(Raster1(:,1),Raster1(:,2),'l','FontSize',14,'color',[0 1 0]);end;end
end
Time02S=[];Time02F=[];Time04S=[];Time04F=[];Time06S=[];Time06F=[];
Time08S=[];Time08F=[];Time10S=[];Time10F=[];
index02=find(LRLpegphase>=0 & LRLpegphase<0.2);
for n=2:length(index02)-1
    
     if n==length(index02)-1 && index02(n+1)-index02(n)==1
            Time02F=[Time02F LRLpegTimeArray(index02(n+1))];
    elseif index02(n+1)-index02(n)>1 && index02(n)-index02(n-1)==1
        Time02F=[Time02F LRLpegTimeArray(index02(n))];
     end
    if index02(n)-index02(n-1)>1 && index02(n+1)-index02(n)==1
        Time02S=[Time02S LRLpegTimeArray(index02(n))];
    elseif n==2 && index02(n)-index02(n-1)==1
        Time02S=[Time02S LRLpegTimeArray(index02(n-1))];
    
    end
end
        
index04=find(LRLpegphase>=0.2 & LRLpegphase<0.4);
for n=2:length(index04)-1
    
     if n==length(index04)-1 && index04(n+1)-index04(n)==1
            Time04F=[Time04F LRLpegTimeArray(index04(n+1))];
    elseif index04(n+1)-index04(n)>1 && index04(n)-index04(n-1)==1
        Time04F=[Time04F LRLpegTimeArray(index04(n))];
     end
    if index04(n)-index04(n-1)>1 && index04(n+1)-index04(n)==1
        Time04S=[Time04S LRLpegTimeArray(index04(n))];
    elseif n==2 && index04(n)-index04(n-1)==1
        Time04S=[Time04S LRLpegTimeArray(index04(n-1))];
    
    end
end

index06=find(LRLpegphase>=0.4 & LRLpegphase<0.6);
for n=2:length(index06)-1
    
     if n==length(index06)-1 && index06(n+1)-index06(n)==1
            Time06F=[Time06F LRLpegTimeArray(index06(n+1))];
    elseif index06(n+1)-index06(n)>1 && index06(n)-index06(n-1)==1
        Time06F=[Time06F LRLpegTimeArray(index06(n))];
     end
    if index06(n)-index06(n-1)>1 && index06(n+1)-index06(n)==1
        Time06S=[Time06S LRLpegTimeArray(index06(n))];
    elseif n==2 && index06(n)-index06(n-1)==1
        Time06S=[Time06S LRLpegTimeArray(index06(n-1))];
    
    end
end
index08=find(LRLpegphase>=0.6 & LRLpegphase<0.8);
for n=2:length(index08)-1
    
     if n==length(index08)-1 && index08(n+1)-index08(n)==1
            Time08F=[Time08F LRLpegTimeArray(index08(n+1))];
    elseif index08(n+1)-index08(n)>1 && index08(n)-index08(n-1)==1
        Time08F=[Time08F LRLpegTimeArray(index08(n))];
     end
    if index08(n)-index08(n-1)>1 && index08(n+1)-index08(n)==1
        Time08S=[Time08S LRLpegTimeArray(index08(n))];
    elseif n==2 && index08(n)-index08(n-1)==1
        Time08S=[Time08S LRLpegTimeArray(index08(n-1))];
    
    end
end
index10=find(LRLpegphase>=0.8 & LRLpegphase<=1);
for n=2:length(index10)-1
    
     if n==length(index10)-1 && index10(n+1)-index10(n)==1
            Time10F=[Time10F LRLpegTimeArray(index10(n+1))];
    elseif index10(n+1)-index10(n)>1 && index10(n)-index10(n-1)==1
        Time10F=[Time10F LRLpegTimeArray(index10(n))];
     end
    if index10(n)-index10(n-1)>1 && index10(n+1)-index10(n)==1
        Time10S=[Time10S LRLpegTimeArray(index10(n))];
    elseif n==2 && index10(n)-index10(n-1)==1
        Time10S=[Time10S LRLpegTimeArray(index10(n-1))];
    
    end
end

PhaseTimeS={Time02S Time04S Time06S Time08S Time10S};
PhaseTimeF={Time02F Time04F Time06F Time08F Time10F};
TimeSection=[Time02F-Time02S Time04F-Time04S Time06F-Time06S Time08F-Time08S Time10F-Time10S];
if ~isempty(find(TimeSection<0, 1))==1
    disp('Phase-Time section is wrong!!! There may be some short-stops.');
end



% for n=1:length(LRLTouchArray)
%     if n>2&&LRLbefore(n)==LRLbefore(n-1)
%         InterPoint=LRLTouchArray(n-1)+1:LRLTouchArray(n);
%     else interval=LRLbefore(n)+1:LRLTouchArray(n);
%     end
% end
% for n=1:length(RLRTouchArray)
%     if n>2&&RLRbefore(n)==RLRbefore(n-1)
%         interval=RLRTouchArray(n-1)+1:RLRTouchArray(n);
%     else interval=RLRbefore(n)+1:RLRTouchArray(n);
%     end
% end

