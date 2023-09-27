function [StdRLRTouch,StdRLRTouchDiff,StdLRLTouch,StdLRLTouchDiff,StdRLTouchInterval,StdLRLphase,StdRLRphase,StdLRLdiff,StdRLRdiff]=TouchVariance

global  RpegTouchCell LpegTouchCell TurnMarkerTime OneTurnTime LRLphase RLRphase LRLbefore RLRbefore IntervalR IntervalL...
        RatioAlikeLRL RatioAlikeRLR RatioBlikeLRL RatioBlikeRLR DrName FigureSave fig_LRLphase fig_RLRphase fig_Phasehist DrName...
        Interval_RL Interval_LR Rafter RLpegTouchCell DrName LTouchAll RTouchAll ShowFig LRLafter RLRafter IntervalLRL IntervalRLR
    
MP=0;
if ~isempty(LTouchAll) && ~isempty(RTouchAll)
    MP=1;
else
RpegTouchArray=[RpegTouchCell{1};RpegTouchCell{2};RpegTouchCell{3};RpegTouchCell{4};RpegTouchCell{5};RpegTouchCell{6};...
    RpegTouchCell{7};RpegTouchCell{8};RpegTouchCell{9};RpegTouchCell{10};RpegTouchCell{11};RpegTouchCell{12}];
RpegTouchArray=sort(RpegTouchArray);

LpegTouchArray=[LpegTouchCell{1};LpegTouchCell{2};LpegTouchCell{3};LpegTouchCell{4};LpegTouchCell{5};LpegTouchCell{6};...
    LpegTouchCell{7};LpegTouchCell{8};LpegTouchCell{9};LpegTouchCell{10};LpegTouchCell{11};LpegTouchCell{12}];
LpegTouchArray=sort(LpegTouchArray);

end

if MP==1
    LpegTouchArray=LTouchAll;
    RpegTouchArray=RTouchAll;
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

LRLphase=[];
LRLTouchArray=[];
RTrialTurn=[];
TurnTime=median(diff(TurnMarkerTime))*1.1;
LRLTurnArray=[];
LRLbefore=[];LRLafter=[];
RLRbefore=[];RLRafter=[];
% LRLphaseの計算
% LRLTouchArrayはLRLphaseのときのRpegTouchのTime
% LRLTurnはLRLTouchに一番近いTurnMarkerTime
for n=1:length(RpegTouchArray)
    Lbefore=max(LpegTouchArray(LpegTouchArray<RpegTouchArray(n) & RpegTouchArray(n)-800<LpegTouchArray));
    Lafter=min(LpegTouchArray(RpegTouchArray(n)<=LpegTouchArray & LpegTouchArray<RpegTouchArray(n)+800));
    
    
    if ~isempty(Lbefore) && ~isempty(Lafter) && Lafter-Lbefore<1000
        
        LRL=(RpegTouchArray(n)-Lbefore)/(Lafter-Lbefore);
        LRLbefore=[LRLbefore Lbefore]; 
        LRLafter=[LRLafter Lafter]; 
        LRLphase=[LRLphase LRL];
        LRLTouchArray=[LRLTouchArray RpegTouchArray(n)];
        LRLTurn=max(TurnMarkerTime(TurnMarkerTime<RpegTouchArray(n)));
        LRLTurnArray=[LRLTurnArray LRLTurn];
        IntervalR=LRLTouchArray-LRLbefore;
        Interval_RL=LRLafter-LRLTouchArray;
        IntervalLRL=LRLafter-LRLbefore;
    end
    
end


% LRLTurnArrayがTurnMarkerTimeでの何ターン目のトライアルにあたるか
% これをRTrialTurnとして、ラスターの縦軸にする
n=1;
for x=1:length(LRLTurnArray)
    
      if LRLTurnArray(x)==TurnMarkerTime(n)
          RTrialTurn=[RTrialTurn n];
      else n=n+1;
          switch LRLTurnArray(x)
              case TurnMarkerTime(n)
                   RTrialTurn=[RTrialTurn n];
              case TurnMarkerTime(n+1)
                   RTrialTurn=[RTrialTurn n+1];
                   n=n+1;
              case TurnMarkerTime(n+2)
                   RTrialTurn=[RTrialTurn n+2];
                   n=n+2;
              case TurnMarkerTime(n+3)
                   RTrialTurn=[RTrialTurn n+3];
                   n=n+3;
              case TurnMarkerTime(n+4)
                   RTrialTurn=[RTrialTurn n+4];
                   n=n+4;
              case TurnMarkerTime(n+5)
                   RTrialTurn=[RTrialTurn n+5];
                   n=n+5;
              case TurnMarkerTime(n+6)
                   RTrialTurn=[RTrialTurn n+6];
                   n=n+6;
              case TurnMarkerTime(n+7)
                   RTrialTurn=[RTrialTurn n+7];
                   n=n+7;
              case TurnMarkerTime(n+8)
                   RTrialTurn=[RTrialTurn n+8];
                   n=n+8;
          end
      end
end

RPhaseIndex=[];
RPhaseIndex=LRLTouchArray-LRLTurnArray;   % 各TurnMarkerTimeからRTouchまでの時間(横軸での位置)

% SizeLRLTouchArray=size(LRLTouchArray)
% SizeRTrialTurn=size(RTrialTurn)
% SizeLRLphase=size(LRLphase)
% SizeRPhaseIndex=size(RPhaseIndex)
% 
% if SizeRPhaseIndex==SizeRTrialTurn
% bin = 50;
% N_Trial = max(RTrialTurn(:));
% 
% xaxis = 0: bin: TurnTime;  %軸をつくる
% raster = NaN([N_Trial length(xaxis)]); % ラスターの受け皿
% X_index = ceil(RPhaseIndex / bin); % 時刻データをrasterの座標に変換
% for n = 1:length(LRLphase);
%    raster(RTrialTurn(n), X_index(n)) = LRLphase(n);
% end
% 
% ShowFig=get(handles.radiobutton_ShowFigure,'Value');
% if ShowFig==1
%     fig_LRLphase=figure;hold on;
%     im=imagesc(xaxis,1:N_Trial,raster);colormap(jet);
%     axis xy
%     set(gca,'Xlim',[-100 OneTurnTime*1.05]);
%     colorbar
%     caxis(gca,[0 1]);
%     title('LRLPhaseRaster')
% 
%     del=~isnan(raster); 
%     set(im,'alphadata',del) %NaNのところを透明にする。 
%     set(gca,'color',[1 1 1]);hold off  %背景色の指定
% end
% if FigureSave==1;saveas(fig_LRLphase,[DrName,' ','LRLphase.bmp']);end
% end
% RLRphaseの計算


RLRphase=[];
RLRdif=[];

RLRTouchArray=[];
LTrialTurn=[];
RLRTurnArray=[];

for n=1:length(LpegTouchArray)
    Rbefore=max(RpegTouchArray(RpegTouchArray<LpegTouchArray(n) & LpegTouchArray(n)-800<RpegTouchArray));
    Rafter=min(RpegTouchArray(LpegTouchArray(n)<=RpegTouchArray & RpegTouchArray<LpegTouchArray(n)+800));
    
    
    if ~isempty(Rbefore) && ~isempty(Rafter) && Rafter-Rbefore<1000
        
        RLR=(LpegTouchArray(n)-Rbefore)/(Rafter-Rbefore);
        RLRbefore=[RLRbefore Rbefore]; 
        RLRafter=[RLRafter Rafter]; 
        RLRphase=[RLRphase RLR];
        RLRTouchArray=[RLRTouchArray LpegTouchArray(n)];
        RLRTurn=max(TurnMarkerTime(TurnMarkerTime<LpegTouchArray(n)));
        RLRTurnArray=[RLRTurnArray RLRTurn];
        IntervalL=RLRTouchArray-RLRbefore;
        Interval_LR=RLRafter-RLRTouchArray;
        IntervalRLR=RLRafter-RLRbefore;

    end
    
end

n=1;
for x=1:length(RLRTurnArray)
    
      if RLRTurnArray(x)==TurnMarkerTime(n)
          LTrialTurn=[LTrialTurn n];
      else n=n+1;
          switch RLRTurnArray(x)
              case TurnMarkerTime(n)
                   LTrialTurn=[LTrialTurn n];
              case TurnMarkerTime(n+1)
                   LTrialTurn=[LTrialTurn n+1];
                   n=n+1;
              case TurnMarkerTime(n+2)
                   LTrialTurn=[LTrialTurn n+2];
                   n=n+2;
              case TurnMarkerTime(n+3)
                   LTrialTurn=[LTrialTurn n+3];
                   n=n+3;
              case TurnMarkerTime(n+4)
                   LTrialTurn=[LTrialTurn n+4];
                   n=n+4;
              case TurnMarkerTime(n+5)
                   LTrialTurn=[LTrialTurn n+5];
                   n=n+5;
              case TurnMarkerTime(n+6)
                   LTrialTurn=[LTrialTurn n+6];
                   n=n+6;
              case TurnMarkerTime(n+7)
                   LTrialTurn=[LTrialTurn n+7];
                   n=n+7;
              case TurnMarkerTime(n+8)
                   LTrialTurn=[LTrialTurn n+8];
                   n=n+8;
          end
      end
end

% LPhaseIndex=[];
% LPhaseIndex=RLRTouchArray-RLRTurnArray;
% 
% SizeRLRTouchArray=size(RLRTouchArray)
% SizeLTrialTurn=size(LTrialTurn)
% SizeRLRphase=size(RLRphase)
% SizeLPhaseIndex=size(LPhaseIndex)
% 
% if SizeLTrialTurn==SizeLPhaseIndex
% bin = 50;
% L_Trial = max(LTrialTurn(:));
% 
% xaxis = 0: bin: TurnTime;  %軸をつくる
% raster = NaN([L_Trial length(xaxis)]); % ラスターの受け皿
% X_index = ceil(LPhaseIndex / bin); % 時刻データをrasterの座標に変換
% for n = 1:length(RLRphase);
%    raster(LTrialTurn(n), X_index(n)) = RLRphase(n);
% end
% 
% ShowFig=get(handles.radiobutton_ShowFigure,'Value');
% if ShowFig==1
%    fig_RLRphase=figure;hold on;
%    im=imagesc(xaxis,1:L_Trial,raster);colormap(jet);
%    axis xy
%    set(gca,'Xlim',[-100 OneTurnTime*1.05]);
%    colorbar
%    caxis(gca,[0 1]);
%    title('RLRPhaseRaster')
% 
%    del=~isnan(raster); 
%    set(im,'alphadata',del) %NaNのところを透明にする。 
%    set(gca,'color',[1 1 1]);hold off;  %背景色の指定
% end
% if FigureSave==1;saveas(fig_RLRphase,[DrName,' ','RLRphase.bmp']);end
 if ShowFig==1
   fig_Phasehist=figure;hold on;
   subplot(2,1,1)
   hist(LRLphase)
   title('LRLphase');
   subplot(2,1,2)
   hist(RLRphase)
   title('RLRphase');hold off;
 end


   

% AlikeLRL=length(LRLphase(LRLphase>=0.3&LRLphase<=0.7));
% AlikeRLR=length(RLRphase(RLRphase>=0.3&RLRphase<=0.7));
% BlikeLRL=length(LRLphase(LRLphase<=0.2|LRLphase>=0.8));
% BlikeRLR=length(RLRphase(RLRphase<=0.2|RLRphase>=0.8));
% RatioAlikeLRL=AlikeLRL/length(LRLphase)
% RatioAlikeRLR=AlikeRLR/length(RLRphase)
% RatioBlikeLRL=BlikeLRL/length(LRLphase)
% RatioBlikeRLR=BlikeRLR/length(RLRphase)


%    fig_interval=figure;
%    subplot(2,1,1)
%    hist(IntervalR,0:20:600)
%    title('Lbefore to Rtouch');
%    set(gca,'Xlim',[-20 620]);
%    subplot(2,1,2)
%    hist(IntervalL,0:20:600)
%    title('Rbefore to Ltouch');xlabel('Interval')
%    set(gca,'Xlim',[-20 620]);
   
   IntRL=[Interval_RL Interval_LR];
   IntervalRL=sort(IntRL);
   IntervalRL(IntervalRL<50 | IntervalRL>(OneTurnTime*1.6)/24)=[];   

if ~isempty(RLpegTouchCell)
   RLpegTouch=[RLpegTouchCell{:,1};RLpegTouchCell{:,2};RLpegTouchCell{:,3};RLpegTouchCell{:,4};RLpegTouchCell{:,5};RLpegTouchCell{:,6};...
       RLpegTouchCell{:,7}; RLpegTouchCell{:,8}; RLpegTouchCell{:,9}; RLpegTouchCell{:,10}; RLpegTouchCell{:,11}; RLpegTouchCell{:,12};...
       RLpegTouchCell{:,13}; RLpegTouchCell{:,14}; RLpegTouchCell{:,15}; RLpegTouchCell{:,16}; RLpegTouchCell{:,17}; RLpegTouchCell{:,18};...
       RLpegTouchCell{:,19}; RLpegTouchCell{:,20}; RLpegTouchCell{:,21}; RLpegTouchCell{:,22}; RLpegTouchCell{:,23}; RLpegTouchCell{:,24}]; 
else RLpegTouch=sort([RpegTouchArray;LpegTouchArray]);
end
   
   IntervalRLsize=size(IntervalRL)
   RLpegTouchsize=size(RLpegTouch)

   RLTouchArray=diff(sort(RLpegTouch));
   RLTouchArray(RLTouchArray<50 | RLTouchArray>(OneTurnTime*1.6)/24)=[];
if ShowFig==1
   fig_IntervalRL=figure;
%    subplot(2,2,1)
%    hist(IntervalRL,0:20:380);
%    title('IntervalRL');
%    set(gca,'Xlim',[-20 400]);
%    subplot(2,2,2)
   hist(RLTouchArray,0:20:380);
   title('RLTouchInterval');
   set(gca,'Xlim',[-20 400]);
   figure
   subplot(2,1,1)
   hist(Interval_RL,0:20:600)
   title('Rtouch to Lafter');
   set(gca,'Xlim',[-20 620]);
   subplot(2,1,2)
   hist(Interval_LR,0:20:600)
   title('Ltouch to Rafter');xlabel('Interval')
   set(gca,'Xlim',[-20 620]);
end

StdRLRTouch=std(IntervalRLR)
StdRLRTouchDiff=std(diff(IntervalRLR))
StdLRLTouch=std(IntervalLRL)
StdLRLTouchDiff=std(diff(IntervalLRL))
StdLRLphase=std(LRLphase)
StdRLRphase=std(RLRphase)
StdLRLdiff=std(diff(LRLphase))
StdRLRdiff=std(diff(RLRphase))
StdIntervalRL=std(IntervalRL)
StdRLTouchInterval=std(RLTouchArray)

