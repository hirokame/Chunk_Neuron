function RLt_Sum_20200303
%%%%%%%左右両方のウィンドウを動かす
global CCresultRtouchWon CCresultLtouchWon RpegTouchallWon LpegTouchallWon SpikeArrayWon RtouchSpikeOnUnit LtouchSpikeOnUnit RtouchSpikeOffUnit LtouchSpikeOffUnit...
    pegpatternum pegpatternname RTroughlocsInterval LTroughlocsInterval LlocsInterval RlocsInterval
 




%SpikeArrayでLPegTouchAll、RpegTouchallをアラインしたクロスコリオグラム
%SpikeArrayでLPegTouchAllをアラインする
duration=5000;
CrossCoL=[];
CrossCoR=[];
%両方向
for n=1:(length(SpikeArrayWon))
        Interval=LpegTouchallWon((LpegTouchallWon>SpikeArrayWon(n)-duration/2)&(SpikeArrayWon(n)>LpegTouchallWon-duration/2))-SpikeArrayWon(n);
        CrossCoL=[CrossCoL Interval];
end
    
CrossCoL=[-1*duration/2 CrossCoL duration/2];

CrossCoL(CrossCoL==0)=[];

bin=500;
% CCresultLtouchWonの更新に必要
CCresultLtouchWon=hist(CrossCoL,bin);
CCresultLtouchWon=CCresultLtouchWon/sum(CCresultLtouchWon);
CCresultLtouchWon=MovWindow(CCresultLtouchWon,10);


%SpikeArrayでRPegTouchAllをアラインする
for n=1:(length(SpikeArrayWon))
        Interval=RpegTouchallWon((RpegTouchallWon>SpikeArrayWon(n)-duration/2)&(SpikeArrayWon(n)>RpegTouchallWon-duration/2))-SpikeArrayWon(n);
        CrossCoR=[CrossCoR Interval];
end
    
CrossCoR=[-1*duration/2 CrossCoR duration/2];

CrossCoR(CrossCoR==0)=[];
% CCresultRtouchWonの更新に必要
CCresultRtouchWon=hist(CrossCoR,bin);
CCresultRtouchWon=CCresultRtouchWon/sum(CCresultRtouchWon);
CCresultRtouchWon=MovWindow(CCresultRtouchWon,10);

%%%%%%%%%%%%%%%%%%%%ピークとTroughの検出
% crosscorrelogramからピークとTroughを検出
%%Ltouch
%ピークを検出
[Lpks,Llocs,Lwidth,Lproms]=findpeaks(CCresultLtouchWon,'MinPeakDistance',20);
[Lpks,Llocs,Lwidth,Lproms]=findpeaks(CCresultLtouchWon,'MinPeakDistance',20,'MinPeakProminence',mean(Lproms)*0.3);%%%%%%%上で計算したプロミネンスの平均＊０．１以上のピークを検出
LlocsInterval=Llocs-250;
LlocsInterval1=LlocsInterval(LlocsInterval>=0);%%%%正方向のピーク抜出
Linterval1=sort(abs(LlocsInterval1),'ascend');
LlocsInterval2=LlocsInterval(LlocsInterval<0);%%%%負方向のピーク抜出
Linterval2=sort(LlocsInterval2,'descend');



%Troughの検出
CCresultLtouchWonTrough=(-1)*CCresultLtouchWon;

% %%%%off
% findpeaks(CCresultLtouchWonTrough,'MinPeakDistance',20);
% %%%%off

[LTroughpks,LTroughlocs,LTroughwidth,LTroughproms]=findpeaks(CCresultLtouchWonTrough,'MinPeakDistance',20);
[LTroughpks,LTroughlocs,LTroughwidth,LTroughproms]=findpeaks(CCresultLtouchWonTrough,'MinPeakDistance',20,'MinPeakProminence',mean(LTroughproms)*0.3);%%%%%%%上で計算したプロミネンスの平均＊０．１以上のピークを検出
LTroughlocsInterval=LTroughlocs-250;
LTroughlocsInterval1=LTroughlocsInterval(LTroughlocsInterval>=0);%%%%正方向のピーク抜出
LTroughinterval1=sort(abs(LTroughlocsInterval1),'ascend');
LTroughlocsInterval2=LTroughlocsInterval(LTroughlocsInterval<0);%%%%負方向のピーク抜出
LTroughinterval2=sort(LTroughlocsInterval2,'descend');

% %%%%%%%%%%%off
% figure
% plot(linspace(1,5000,bin),CCresultLtouchWon,'color','r','LineWidth',2);hold on
% plot(linspace(1,5000,bin),CCresultLtouchWonTrough,'color','r','LineWidth',2);
% figure
% findpeaks(CCresultLtouchWon,'MinPeakDistance',20,'MinPeakProminence',mean(Lproms)*0.3);
% figure
% findpeaks(CCresultLtouchWonTrough,'MinPeakDistance',20,'MinPeakProminence',mean(LTroughproms)*0.3);
% 
% %%%%%%%%%%%


%%Rtouch
%ピークを検出
[Rpks,Rlocs,Rwidth,Rproms]=findpeaks(CCresultRtouchWon,'MinPeakDistance',20);
[Rpks,Rlocs,Rwidth,Rproms]=findpeaks(CCresultRtouchWon,'MinPeakDistance',20,'MinPeakProminence',mean(Rproms)*0.3);%%%%%%%上で計算したプロミネンスの平均＊０．１以上のピークを検出
RlocsInterval=Rlocs-250;
RlocsInterval1=RlocsInterval(RlocsInterval>=0);
Rinterval1=sort(abs(RlocsInterval1),'ascend');
RlocsInterval2=RlocsInterval(RlocsInterval<0);
Rinterval2=sort(RlocsInterval2,'descend');
TouchArray=[LlocsInterval,RlocsInterval];
TouchArray1=sort(abs(TouchArray),'ascend');




%%%%%Troughの検出
CCresultRtouchWonTrough=(-1)*CCresultRtouchWon;

% %%%%%off
% findpeaks(CCresultRtouchWonTrough,'MinPeakDistance',20);
% %%%%%

[RTroughpks,RTroughlocs,RTroughwidth,RTroughproms]=findpeaks(CCresultRtouchWonTrough,'MinPeakDistance',20);   %%%%%%%一度prominenceを計算
[RTroughpks,RTroughlocs,RTroughwidth,RTroughproms]=findpeaks(CCresultRtouchWonTrough,'MinPeakDistance',20,'MinPeakProminence',mean(RTroughproms)*0.3); %%%%%%%上で計算したプロミネンスの平均＊０．１以上のピークを検出
RTroughlocsInterval=RTroughlocs-250;
RTroughlocsInterval1=RTroughlocsInterval(RTroughlocsInterval>=0);%%%%正方向のピーク抜出
RTroughinterval1=sort(abs(RTroughlocsInterval1),'ascend');
RTroughlocsInterval2=RTroughlocsInterval(RTroughlocsInterval<0);%%%%負方向のピーク抜出
RTroughinterval2=sort(RTroughlocsInterval2,'descend');


% %%%%%%%%%%%off
% figure
% plot(linspace(1,5000,bin),CCresultRtouchWon,'color','b','LineWidth',2);hold on
% plot(linspace(1,5000,bin),CCresultRtouchWonTrough,'color','b','LineWidth',2);
% figure
% findpeaks(CCresultRtouchWon,'MinPeakDistance',25,'MinPeakProminence',mean(Rproms)*0.3);
% figure
% findpeaks(CCresultRtouchWonTrough,'MinPeakDistance',25,'MinPeakProminence',mean(RTroughproms)*0.3);
% %%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
WindowNum=5;%使うwindowの数

if length(LlocsInterval)>WindowNum && length(RlocsInterval)>WindowNum...
        length(LTroughlocsInterval)>WindowNum && length(RlocsInterval)>WindowNum
    
     %%%%%%%%ピーク間にトラフが二回以上もしくはトラフ間にピークが二回以上あるかを調べる
    %%%%あった場合、隣なうピークどうしもしくはトラフの中間地点を新たなピーク（トラフ）とする
   %%%%%%%%左脚のピークとトラフの関係を調べる
   %トラフ間のピークが複数ある場合の修正
    for i=1:length(LTroughlocsInterval)-1
        if length(LlocsInterval(LTroughlocsInterval(i)<LlocsInterval & LlocsInterval<LTroughlocsInterval(i+1)))>=2;
           Index=find(LTroughlocsInterval(i)<LlocsInterval & LlocsInterval<LTroughlocsInterval(i+1));  %%%% トラフ間にある複数のピークを検出
           NewPeak=mean(LlocsInterval(Index));                                                          %%%%%複数のピークの中間地点を新たなピークに設定
           LlocsInterval(Index)=NaN;                                                                    %%%%%%もともと複数のピークがあった値をNaNに置き換え
           LlocsInterval(Index(1))=NewPeak;                                                             %%%%%%NaNのうちの一つを新たなピークに設定
           LlocsInterval = LlocsInterval(find(~isnan(LlocsInterval))) ;                                 %%%%%%%Nanを取り除いた配列に変換
        end
    end
    %ピーク間のトラフが複数ある場合の修正
    for i=1:length(LlocsInterval)-1
        if length(LTroughlocsInterval(LlocsInterval(i)<LTroughlocsInterval & LTroughlocsInterval<LlocsInterval(i+1)))>=2;
           Index=find(LlocsInterval(i)<LTroughlocsInterval & LTroughlocsInterval<LlocsInterval(i+1));  %%%% ピーク間にある複数のトラフを検出
           NewPeak=mean(LTroughlocsInterval(Index));                                                          %%%%%複数のトラフの中間地点を新たなトラフに設定
           LTroughlocsInterval(Index)=NaN;                                                                    %%%%%%もともと複数のトラフがあった値をNaNに置き換え
           LTroughlocsInterval(Index(1))=NewPeak;                                                             %%%%%%NaNのうちの一つを新たなトラフに設定
           LTroughlocsInterval = LTroughlocsInterval(find(~isnan(LTroughlocsInterval))) ;                                 %%%%%%%Nanを取り除いた配列に変換
        end
    end
    
     %%%%%%%%右脚のピークとトラフの関係を調べる
   %トラフ間のピークが複数ある場合の修正
    for i=1:length(RTroughlocsInterval)-1
        if length(RlocsInterval(RTroughlocsInterval(i)<RlocsInterval & RlocsInterval<RTroughlocsInterval(i+1)))>=2;
           Index=find(RTroughlocsInterval(i)<RlocsInterval & RlocsInterval<RTroughlocsInterval(i+1));  %%%% トラフ間にある複数のピークを検出
           NewPeak=mean(RlocsInterval(Index));                                                          %%%%%複数のピークの中間地点を新たなピークに設定
           RlocsInterval(Index)=NaN;                                                                    %%%%%%もともと複数のピークがあった値をNaNに置き換え
           RlocsInterval(Index(1))=NewPeak;                                                             %%%%%%NaNのうちの一つを新たなピークに設定
           RlocsInterval = RlocsInterval(find(~isnan(RlocsInterval))) ;                                 %%%%%%%Nanを取り除いた配列に変換
        end
    end
    %ピーク間のトラフが複数ある場合の修正
    for i=1:length(RlocsInterval)-1
        if length(RTroughlocsInterval(RlocsInterval(i)<RTroughlocsInterval & RTroughlocsInterval<RlocsInterval(i+1)))>=2;
           Index=find(RlocsInterval(i)<RTroughlocsInterval & RTroughlocsInterval<RlocsInterval(i+1));  %%%% ピーク間にある複数のトラフを検出
           NewPeak=mean(RTroughlocsInterval(Index));                                                          %%%%%複数のトラフの中間地点を新たなトラフに設定
           RTroughlocsInterval(Index)=NaN;                                                                    %%%%%%もともと複数のトラフがあった値をNaNに置き換え
           RTroughlocsInterval(Index(1))=NewPeak;                                                             %%%%%%NaNのうちの一つを新たなトラフに設定
           RTroughlocsInterval = RTroughlocsInterval(find(~isnan(RTroughlocsInterval))) ;                                 %%%%%%%Nanを取り除いた配列に変換
        end
    end
    
%左右されぞれのピークとTroughの配列から絶対値が小さい順にWindowNum個分のピーク（Trough）を選ぶ
%peakの検出
%Ltouh
[LlocsIntervalB LlocsIntervalIndex]=sort(abs(LlocsInterval),'ascend');
LtouchWindowPeak=sort(LlocsInterval(LlocsIntervalIndex-2:LlocsIntervalIndex+2),'ascend');        %%%%WindowNum個分のピーク

%Rtouch
[RlocsIntervalB RlocsIntervalIndex]=sort(abs(RlocsInterval),'ascend');
RtouchWindowPeak=sort(RlocsInterval(RlocsIntervalIndex-2:RlocsIntervalIndex+2),'ascend');        %%%%WindowNum個分のピーク

%%%%

%Troughの検出
%Ltouh
[LTroughlocsIntervalB LTroughlocsIntervalIndex]=sort(abs(LTroughlocsInterval),'ascend');
LtouchWindowTrough=sort(LTroughlocsInterval(LTroughlocsIntervalIndex(1:WindowNum+1)),'ascend');        %%%%WindowNum個分のTrough%Troughのwindowは実質4つ

%Rtouch
[RTroughlocsIntervalB RTroughlocsIntervalIndex]=sort(abs(RTroughlocsInterval),'ascend');
RtouchWindowTrough=sort(RTroughlocsInterval(RTroughlocsIntervalIndex(1:WindowNum+1)),'ascend');        %%%%WindowNum個分のピーク%Troughのwindowは実質4つ


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%ピークとTroughの位置検出終わり
[RLPeakPosition IndexRLPeak]=sort([LtouchWindowPeak RtouchWindowPeak]);
IndexLPeak=find(IndexRLPeak<=5);
IndexRPeak=find(IndexRLPeak>=6);

LTrough=LtouchWindowTrough(LtouchWindowTrough>min(LtouchWindowPeak) & max(LtouchWindowPeak)>LtouchWindowTrough);
RTrough=RtouchWindowTrough(RtouchWindowTrough>min(RtouchWindowPeak) & max(RtouchWindowPeak)>RtouchWindowTrough);

[RLTroughPosition IndexRLTrough]=sort([LTrough RTrough]);
IndexLTrough=find(IndexRLTrough<=4);
IndexRTrough=find(IndexRLTrough>=5);


%%%%%%%windowのstartとendを設定

%%%%%%%%%%PositiveWindow%%%%%%%%%%%%%%Ltouch%%%%%

LPWS=zeros(1,WindowNum);
LPWE=zeros(1,WindowNum);
for n=1:WindowNum
    [DistancefromPeakN LocsDistancefromPeakN]=sort((LTroughlocsInterval-LtouchWindowPeak(n)),'ascend');%Peakから最も近いTroughを二選ぶ（Peak(n)の両隣にあるTrough）
    DistancefromPeakNLeft=DistancefromPeakN(DistancefromPeakN<0);
    DistancefromPeakNRight=DistancefromPeakN(DistancefromPeakN>0);                                         
    LPWS(n)=LtouchWindowPeak(n)-abs(max(DistancefromPeakNLeft))/2;%Peakの左隣にあるTroughとの半分の距離をwindowの端（windowstart）に設定
    LPWE(n)=LtouchWindowPeak(n)+abs(min(DistancefromPeakNRight))/2;%Peakの右隣にあるTroughとの半分の距離をwindowの端に(windowEnd)に設定
end

%%%%%%%%%%PositiveWindow%%%%%%%%%%%%%%Ltouch%%%%%
RPWS=zeros(1,WindowNum);
RPWE=zeros(1,WindowNum);
for n=1:WindowNum
    [DistancefromPeakN LocsDistancefromPeakN]=sort((RTroughlocsInterval-RtouchWindowPeak(n)),'ascend');%Peakから最も近いTroughを二選ぶ（Peak(n)の両隣にあるTrough）
    DistancefromPeakNLeft=DistancefromPeakN(DistancefromPeakN<0);
    DistancefromPeakNRight=DistancefromPeakN(DistancefromPeakN>0);           
    RPWS(n)=RtouchWindowPeak(n)-abs(max(DistancefromPeakNLeft))/2;%Peakの左隣にあるTroughとの半分の距離をwindowの端（windowstart）に設定
    RPWE(n)=RtouchWindowPeak(n)+abs(min(DistancefromPeakNRight))/2;%Peakの右隣にあるTroughとの半分の距離をwindowの端に(windowEnd)に設定
end
%%%%%%NegativeTroughWindow%%%%%Ltouch
LPWS
LPWE
LNWS=zeros(1,WindowNum-1);
LNWE=zeros(1,WindowNum-1)
for n=1:WindowNum-1
    LNWS(n)=LPWE(n)
    LNWE(n)=LPWS(n+1)
end


%%%%%%NegativeTroughWindow%%%%%Rtouch
RPWS
RPWE
RNWS=zeros(1,WindowNum-1);
RNWE=zeros(1,WindowNum-1);
for n=1:WindowNum-1
    RNWS(n)=RPWE(n)
    RNWE(n)=RPWS(n+1)
end



% %%%%%%%%%off%%%%ウィンドウの位置確かめる
% LNWSsort=sort(LNWS);%kuro
% LNWEsort=sort(LNWE);%kurofilled
% LPWSsort=sort(LPWS);%green 
% LPWEsort=sort(LPWE);%greenfilled
% fig1=figure;
% subplot(2,2,[1,2]);
% plot(linspace(1,5000,bin),CCresultLtouchWon,'color','r','LineWidth',2);
% axis([0 5000 0 max(CCresultLtouchWon)*1.1]);
% hold on
% scatter(LNWSsort*10+2500,[mean(CCresultLtouchWon)*1.1,mean(CCresultLtouchWon)*1.1,mean(CCresultLtouchWon)*1.1,mean(CCresultLtouchWon)*1.1],'k');hold on 
% scatter(LNWEsort*10+2500,[mean(CCresultLtouchWon)*1.1,mean(CCresultLtouchWon)*1.1,mean(CCresultLtouchWon)*1.1,mean(CCresultLtouchWon)*1.1],'k','filled');hold on 
% scatter(LPWSsort*10+2500,[mean(CCresultLtouchWon),mean(CCresultLtouchWon),mean(CCresultLtouchWon),mean(CCresultLtouchWon),mean(CCresultLtouchWon)],'g');
% scatter(LPWEsort*10+2500,[mean(CCresultLtouchWon),mean(CCresultLtouchWon),mean(CCresultLtouchWon),mean(CCresultLtouchWon),mean(CCresultLtouchWon)],'g','filled');
% %%%%%%%%%%
% RNWSsort=sort(RNWS);%kuro
% RNWEsort=sort(RNWE);%kurofilled
% RPWSsort=sort(RPWS);%green 
% RPWEsort=sort(RPWE);%greenfilled
% subplot(2,2,[3,4]);
% plot(linspace(1,5000,bin),CCresultRtouchWon,'color','b','LineWidth',2);
% axis([0 5000 0 max(CCresultRtouchWon)*1.1]);
% hold on
% scatter(RNWSsort*10+2500,[mean(CCresultRtouchWon)*1.1,mean(CCresultRtouchWon)*1.1,mean(CCresultRtouchWon)*1.1,mean(CCresultRtouchWon)*1.1],'k');hold on 
% scatter(RNWEsort*10+2500,[mean(CCresultRtouchWon)*1.1,mean(CCresultRtouchWon)*1.1,mean(CCresultRtouchWon)*1.1,mean(CCresultRtouchWon)*1.1],'k','filled');hold on 
% scatter(RPWSsort*10+2500,[mean(CCresultRtouchWon),mean(CCresultRtouchWon),mean(CCresultRtouchWon),mean(CCresultRtouchWon),mean(CCresultRtouchWon)],'g');
% scatter(RPWEsort*10+2500,[mean(CCresultRtouchWon),mean(CCresultRtouchWon),mean(CCresultRtouchWon),mean(CCresultRtouchWon),mean(CCresultRtouchWon)],'g','filled');
% 
% 
% %%%%%%%%off


%%%%%%ウィンドウ１のスターとの位置を０ｓとする値に変換（LPWS(1)orRPWS(1)分、値をずらす）
LPWS1=LPWS;
LPWE1=LPWE;
LNWS1=LNWS;
LNWE1=LNWE;
RPWS1=RPWS;
RPWE1=RPWE;
RNWS1=RNWS;
RNWE1=RNWE;


%%%%スパイクウィンドウの設定％％％％40ms幅
LSWS1=-2;
LSWE1=LSWS1+4;


%%%%%%%%



%%%%%左脚ウィンドウ(positive)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%ウィンドウを動かす回数の計算
 MoveWindowNum=fix((LpegTouchallWon(end)-LpegTouchallWon(1))/10)+1;

 
%%%%タッチ間のインターバルが1秒以上空いている部分を保存
LtouchWaterBreakTime=[];
LtouchWaterRestartTime=[];
for n=1:length(LpegTouchallWon)-1
    LpegTouchWonInterval1=LpegTouchallWon(n+1)-LpegTouchallWon(n);
    if LpegTouchWonInterval1>1000
        LtouchWaterBreakTime=[LtouchWaterBreakTime;LpegTouchallWon(n)];
        LtouchWaterRestartTime=[LtouchWaterRestartTime;LpegTouchallWon(n+1)];
    end
end
LtouchWaterBreakRestartArray=[LtouchWaterBreakTime,LtouchWaterRestartTime];
%%%%%%%
%%%%タッチ間のインターバルが1秒以上空いている部分を保存
RtouchWaterBreakTime=[];
RtouchWaterRestartTime=[];
for n=1:length(RpegTouchallWon)-1
    RpegTouchWonInterval1=RpegTouchallWon(n+1)-RpegTouchallWon(n);
    if RpegTouchWonInterval1>1000
        RtouchWaterBreakTime=[RtouchWaterBreakTime;RpegTouchallWon(n)];
        RtouchWaterRestartTime=[RtouchWaterRestartTime;RpegTouchallWon(n+1)];
    end
end
RtouchWaterBreakRestartArray=[RtouchWaterBreakTime,RtouchWaterRestartTime];
%%%%%%%

WindowPoint=0;
NegativeWindowPoint=0;
Positive_NegativeUnit=[];
NegativeUnit=[];
%%%%%Ltouchでウィンドウを動かしていく％％％％10ms秒ずつ動かす
for n=1:MoveWindowNum
    LPWStart=LPWS1*10+SpikeArrayWon(1)+(n-1)*10;
    LPWEnd=LPWE1*10+SpikeArrayWon(1)+(n-1)*10;
    LNWStart=LNWS1*10+SpikeArrayWon(1)+(n-1)*10;
    LNWEnd=LNWE1*10+SpikeArrayWon(1)+(n-1)*10;
    
    RPWStart=RPWS1*10+SpikeArrayWon(1)+(n-1)*10;
    RPWEnd=RPWE1*10+SpikeArrayWon(1)+(n-1)*10;
    RNWStart=RNWS1*10+SpikeArrayWon(1)+(n-1)*10;
    RNWEnd=RNWE1*10+SpikeArrayWon(1)+(n-1)*10;
    
    SWSart=LSWS1*10+SpikeArrayWon(1)+(n-1)*10;
    SWEnd=LSWE1*10+SpikeArrayWon(1)+(n-1)*10;
    
    SpikePoint=0;                                                   
    WindowPointArray=zeros(1,(WindowNum)*2);  %%%% WindowPointArrayとSpikePointはウィンドウが動くたびにリセット                               
    NegativeWindowPointArray=zeros(1,(WindowNum-1)*2);
    a=0;      %%%%a=0の時Won、a=1の時Woffのため数えない
    b=0;
    if ~isempty(LtouchWaterBreakRestartArray) 
        for k=1:length(LtouchWaterBreakRestartArray(:,1))
            if LtouchWaterBreakRestartArray(k,1)<LPWStart(1) && LPWEnd(end)<LtouchWaterBreakRestartArray(k,2)
               a=1;
            end
        end
    end
    if ~isempty(RtouchWaterBreakRestartArray) 
        for k=1:length(RtouchWaterBreakRestartArray(:,1))
            if RtouchWaterBreakRestartArray(k,1)<RPWStart(1) && RPWEnd(end)<RtouchWaterBreakRestartArray(k,2)
               b=1;
            end
        end
    end
    if a==0 && b==0;   %%%%a=0の時ウィンドウにタッチが当てはまるかカウント、a==1ならば、スルーしてウィンドウを動かす
        %%%%%%%%%%%%%%%%
       if ~isempty(SpikeArrayWon(SWSart<SpikeArrayWon & SpikeArrayWon<SWEnd));
           SpikePoint=1;
           SpikeKaisu=length(SpikeArrayWon(SWSart<SpikeArrayWon & SpikeArrayWon<SWEnd));
       elseif isempty(SpikeArrayWon(SWSart<SpikeArrayWon & SpikeArrayWon<SWEnd));
           SpikePoint=0; 
           SpikeKaisu=0;
       end
       %%%Ltouch
       %%%%%%%%%%%%%%%%%Positewindow
       for i=1:WindowNum
           if ~isempty(LpegTouchallWon(LPWStart(i)<LpegTouchallWon & LpegTouchallWon<LPWEnd(i))) %%%% i番目のウィンドウの中にタッチがあれば、、、
               WindowPointArray(IndexLPeak(i))=1;                                                       %%%%　WindowPointArrayが[0,0,0,0,0]→[1,0,0,0,0]になる                                                
           end    
       end
       %%%%%%%%%%%%%%%%%Negativewindow
       for i=1:WindowNum-1
           if ~isempty(LpegTouchallWon(LNWStart(i)<LpegTouchallWon & LpegTouchallWon<LNWEnd(i))) %%%% i番目のウィンドウの中にタッチがあれば、、、
               NegativeWindowPointArray(IndexLTrough(i))=-1;                                                       %%%%　WindowPointArrayが[0,0,0,0,0]→[1,0,0,0,0]になる                                                
           end    
       end
       
       %%%%%Rtouch
       %%%%%%%%%%%%%%%%Positive
       for i=1:WindowNum
           if ~isempty(RpegTouchallWon(RPWStart(i)<RpegTouchallWon & RpegTouchallWon<RPWEnd(i))) %%%% i番目のウィンドウの中にタッチがあれば、、、
               WindowPointArray(IndexRPeak(i))=1;                                                       %%%%　WindowPointArrayが[0,0,0,0,0]→[1,0,0,0,0]になる                                                
           end
       end
       %%%%%%%%%%%%%%%%%Negative
       for i=1:WindowNum-1
           if ~isempty(RpegTouchallWon(RNWStart(i)<RpegTouchallWon & RpegTouchallWon<RNWEnd(i))) %%%% i番目のウィンドウの中にタッチがあれば、、、
               NegativeWindowPointArray(IndexRTrough(i))=-1;                                                       %%%%　WindowPointArrayが[0,0,0,0,0]→[1,0,0,0,0]になる                                                
           end
       end
    end
    

       Positive_NegativeUnit=[Positive_NegativeUnit;[SpikeKaisu WindowPointArray NegativeWindowPointArray]]; %%%%%%スパイクウィンドウ内にスパイクがあればスパイク回数とウィンドウ配列を保存（10×ウィンドウ動かす回数の行列）
       

%        NegativeUnit=[NegativeUnit;[SpikeKaisu NegativeWindowPointArray]];  %%%%%%スパイクウィンドウ内にスパイクがなければウィンドウ配列を保存（9×ウィンドウ動かす回数の行列）
       
end
end
%%%%%%%PositiveUnit
XArray=[];
for x=1:length(Positive_NegativeUnit(:,1))
    IndexRLt=find(Positive_NegativeUnit(x,[2:10])==1 | Positive_NegativeUnit(x,[2:10])==-1);
    if length(IndexRLt)<4;
        XArray=[XArray x];
    end
end
Positive_NegativeUnit(XArray(1:end),:)=[];

% %%%%%%%NegativeUnit
% XArray=[];
% for x=1:length(NegativeUnit(:,1))
%     IndexRLt=find(NegativeUnit(x,[2:9])==-1);
%     if length(IndexRLt)<4;
%          XArray=[XArray x];
%     end
% end
% NegativeUnit(XArray,:)=[];




Positive_NegativeUnit
NegativeUnit

% figname=[pegpatternum,pegpatternname,'CC.bmp'];
% saveas(fig1,figname);
filename=[pegpatternum,pegpatternname,'Both_LtRt_Unit.mat'];
save(filename,'IndexLPeak','IndexLTrough','IndexRPeak','IndexRTrough','Positive_NegativeUnit'...
    ,'SpikeArrayWon','RpegTouchallWon','LpegTouchallWon','CCresultRtouchWon','CCresultLtouchWon'...
    ,'LPWS','LPWE','LNWS','LNWE','RPWS','RPWE','RNWS','RNWE','LtouchWindowPeak','RtouchWindowPeak','LTrough','RTrough');






