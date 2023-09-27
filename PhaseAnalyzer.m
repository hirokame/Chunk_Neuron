function [LRLphase,RLRphase]=PhaseAnalyzer(LTouchAll,RTouchAll)
global  RpegTouchCell LpegTouchCell TurnMarkerTime OneTurnTime LRLphase RLRphase LRLbefore RLRbefore IntervalR IntervalL...
        RatioAlikeLRL RatioAlikeRLR RatioBlikeLRL RatioBlikeRLR DrName FigureSave fig_LRLphase fig_RLRphase fig_Phasehist DrName...
        Interval_RL Interval_LR Rafter LTouchAll RTouchAll fig_LRLphaseMP fig_RLRphaseMP RpegTimeArray LpegTimeArray...
        LRLpegphase RLRpegphase WaterOnArray WaterOffArray LRLpegTimeArray RLRpegTimeArray fig_RLRpegphaseMP fig_LRLpegphaseMP RpegTouchArray LpegTouchArray
DrName

    LpegTouchArray=LTouchAll;
    RpegTouchArray=RTouchAll;
    if isempty(LTouchAll)==1 && isempty(RTouchAll)==1
        LpegTouchArray=[LpegTouchCell{1};LpegTouchCell{2};LpegTouchCell{3};LpegTouchCell{4};LpegTouchCell{5};LpegTouchCell{6};...
        LpegTouchCell{7};LpegTouchCell{8};LpegTouchCell{9};LpegTouchCell{10};LpegTouchCell{11};LpegTouchCell{12}];
        LpegTouchArray=sort(LpegTouchArray);
    
        RpegTouchArray=[RpegTouchCell{1};RpegTouchCell{2};RpegTouchCell{3};RpegTouchCell{4};RpegTouchCell{5};RpegTouchCell{6};...
        RpegTouchCell{7};RpegTouchCell{8};RpegTouchCell{9};RpegTouchCell{10};RpegTouchCell{11};RpegTouchCell{12}];
        RpegTouchArray=sort(RpegTouchArray);
    end

   RpegTimeArray=DataSelect(RpegTimeArray,TurnMarkerTime,OneTurnTime,WaterOnArray,WaterOffArray);
   LpegTimeArray=DataSelect(LpegTimeArray,TurnMarkerTime,OneTurnTime,WaterOnArray,WaterOffArray);
    
LRLphase=[];
LRLTouchArray=[];
RTrialTurn=[];

LRLTurnArray=[];
LRLbefore=[];LRLafter=[];
RLRbefore=[];RLRafter=[];

% LRLphase‚ÌŒvŽZ
% LRLTouchArray‚ÍLRLphase‚Ì‚Æ‚«‚ÌRpegTouch‚ÌTime
% LRLTurn‚ÍLRLTouch‚Éˆê”Ô‹ß‚¢TurnMarkerTime
for n=1:length(RpegTouchArray)
    Lbefore=max(LpegTouchArray(LpegTouchArray<RpegTouchArray(n) & RpegTouchArray(n)-800<LpegTouchArray));
    Lafter=min(LpegTouchArray(RpegTouchArray(n)<=LpegTouchArray & LpegTouchArray<RpegTouchArray(n)+800));  
    
    if ~isempty(Lbefore) && ~isempty(Lafter) && Lafter-Lbefore<1000
        
        LRL=(RpegTouchArray(n)-Lbefore)/(Lafter-Lbefore);
        LRLbefore=[LRLbefore Lbefore]; 
        LRLafter=[LRLafter Lafter]; 
        LRLphase=[LRLphase LRL];
        LRLTouchArray=[LRLTouchArray RpegTouchArray(n)];
%         LRLTurn=max(TurnMarkerTime(TurnMarkerTime<RpegTouchArray(n)));
%         LRLTurnArray=[LRLTurnArray LRLTurn];
        IntervalR=LRLTouchArray-LRLbefore;
        Interval_RL=LRLafter-LRLTouchArray;
    end
    
end


LRLpegphase=[];LRLpegTimeArray=[];
for n=1:length(RpegTimeArray)
    Lpegbefore=max(LpegTimeArray(LpegTimeArray<RpegTimeArray(n) & RpegTimeArray(n)-500<LpegTimeArray));
    Lpegafter=min(LpegTimeArray(RpegTimeArray(n)<=LpegTimeArray & LpegTimeArray<RpegTimeArray(n)+500));   
    if ~isempty(Lpegbefore) && ~isempty(Lpegafter) && Lpegafter-Lpegbefore<1000
        
        LRL=(RpegTimeArray(n)-Lpegbefore)/(Lpegafter-Lpegbefore); 
        LRLpegphase=[LRLpegphase LRL];
        LRLpegTimeArray=[LRLpegTimeArray RpegTimeArray(n)];

    end
    
end

% RPhaseIndex=[];
% RPhaseIndex=LRLTouchArray-LRLTurnArray;   % ŠeTurnMarkerTime‚©‚çRTouch‚Ü‚Å‚ÌŽžŠÔ(‰¡Ž²‚Å‚ÌˆÊ’u)

SizeLRLTouchArray=size(LRLTouchArray)
% SizeRTrialTurn=size(RTrialTurn)
SizeLRLphase=size(LRLphase)
% SizeRPhaseIndex=size(RPhaseIndex)

LRLphaseShift=diff(LRLphase);
LRLpegphaseShift=diff(LRLpegphase);

fig_LRLphaseMP=figure('Position',[500 200 600 900]);hold on;
subplot(4,1,1);
plot(LRLTouchArray*0.001,LRLphase,'-o');
ylim([0,1]);
title('LRLphase')
subplot(4,1,2);
plot(LRLTouchArray(2:end)*0.001,LRLphaseShift,'-x');
ylim([-1,1]);title('LRLphaseShift');

% fig_LRLpegphaseMP=figure;
subplot(4,1,3);
plot(LRLpegTimeArray*0.001,LRLpegphase,'-o');
ylim([0,1]);
title('LRLpegphase')
subplot(4,1,4);
plot(LRLpegTimeArray(2:end)*0.001,LRLpegphaseShift,'-x');
ylim([-1,1]);title('LRLpegphaseShift');hold off;
% figure
% plot(IntervalR+Interval_RL,LRLphase,'x');
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
%     set(im,'alphadata',del) %NaN‚Ì‚Æ‚±‚ë‚ð“§–¾‚É‚·‚éB 
%     set(gca,'color',[1 1 1]);hold off  %”wŒiF‚ÌŽw’è
% end
% if FigureSave==1;saveas(fig_LRLphase,[DrName,' ','LRLphase.bmp']);end

% RLRphase‚ÌŒvŽZ


RLRphase=[];
RLRdif=[];

RLRTouchArray=[];


for n=1:length(LpegTouchArray)
    Rbefore=max(RpegTouchArray(RpegTouchArray<LpegTouchArray(n) & LpegTouchArray(n)-800<RpegTouchArray));
    Rafter=min(RpegTouchArray(LpegTouchArray(n)<=RpegTouchArray & RpegTouchArray<LpegTouchArray(n)+800));
    
    
    if ~isempty(Rbefore) && ~isempty(Rafter) && Rafter-Rbefore<1000
        
        RLR=(LpegTouchArray(n)-Rbefore)/(Rafter-Rbefore);
        RLRbefore=[RLRbefore Rbefore]; 
        RLRafter=[RLRafter Rafter]; 
        RLRphase=[RLRphase RLR];
        RLRTouchArray=[RLRTouchArray LpegTouchArray(n)];
%         RLRTurn=max(TurnMarkerTime(TurnMarkerTime<LpegTouchArray(n)));
%         RLRTurnArray=[RLRTurnArray RLRTurn];
        IntervalL=RLRTouchArray-RLRbefore;
        Interval_LR=RLRafter-RLRTouchArray;

    end
    
end

RLRpegphase=[];RLRpegTimeArray=[];
for n=1:length(LpegTimeArray)
    Rpegbefore=max(RpegTimeArray(RpegTimeArray<LpegTimeArray(n) & LpegTimeArray(n)-500<RpegTimeArray));
    Rpegafter=min(RpegTimeArray(LpegTimeArray(n)<=RpegTimeArray & RpegTimeArray<LpegTimeArray(n)+500));   
    if ~isempty(Rpegbefore) && ~isempty(Rpegafter) && Rpegafter-Rpegbefore<1000
        
        RLR=(LpegTimeArray(n)-Rpegbefore)/(Rpegafter-Rpegbefore); 
        RLRpegphase=[RLRpegphase RLR];
        RLRpegTimeArray=[RLRpegTimeArray LpegTimeArray(n)];

    end
    
end
% LPhaseIndex=[];
% LPhaseIndex=RLRTouchArray-RLRTurnArray;

SizeRLRTouchArray=size(RLRTouchArray)

SizeRLRphase=size(RLRphase)

RLRphaseShift=diff(RLRphase);
RLRpegphaseShift=diff(RLRpegphase);

fig_RLRphaseMP=figure('Position',[500 200 600 900]);hold on;
subplot(4,1,1)
plot(RLRTouchArray*0.001,RLRphase,'-o');
ylim([0,1]);
title('RLRphase')
subplot(4,1,2)
plot(RLRTouchArray(2:end)*0.001,RLRphaseShift,'-x');
ylim([-1,1]);
title('RLRphaseShift')
% fig_RLRpegphaseMP=figure;
subplot(4,1,3);
plot(RLRpegTimeArray*0.001,RLRpegphase,'-o');
ylim([0,1]);
title('RLRpegphase')
subplot(4,1,4);
plot(RLRpegTimeArray(2:end)*0.001,RLRpegphaseShift,'-x');
ylim([-1,1]);title('RLRpegphaseShift');hold off;
% figure
% plot(IntervalL+Interval_LR,RLRphase,'x');
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
%    set(im,'alphadata',del) %NaN‚Ì‚Æ‚±‚ë‚ð“§–¾‚É‚·‚éB 
%    set(gca,'color',[1 1 1]);hold off;  %”wŒiF‚ÌŽw’è
% end
% if FigureSave==1;saveas(fig_RLRphase,[DrName,' ','RLRphase.bmp']);end
%    
% if ShowFig==1
   fig_Phasehist=figure;hold on;
     subplot(2,2,1)
   hist(LRLphase,0:0.05:1)
   set(gca,'Xlim',[-0.05 1.05]);
   title('LRLphase');
   subplot(2,2,2)
   hist(RLRphase,0:0.05:1)
   set(gca,'Xlim',[-0.05 1.05]);
   title('RLRphase');
     subplot(2,2,3)
   hist(LRLpegphase,0:0.05:1)
   set(gca,'Xlim',[-0.05 1.05]);
   title('LRLpegphase');
   subplot(2,2,4)
   hist(RLRpegphase,0:0.05:1)
   set(gca,'Xlim',[-0.05 1.05]);
   title('RLRpegphase');hold off;
% end
% if FigureSave==1;saveas(fig_Phasehist,[DrName,' ','Phasehist.bmp']);end


   

AlikeLRL=length(LRLphase(LRLphase>=0.3&LRLphase<=0.7));
AlikeRLR=length(RLRphase(RLRphase>=0.3&RLRphase<=0.7));
BlikeLRL=length(LRLphase(LRLphase<=0.2|LRLphase>=0.8));
BlikeRLR=length(RLRphase(RLRphase<=0.2|RLRphase>=0.8));
RatioAlikeLRL=AlikeLRL/length(LRLphase)
RatioAlikeRLR=AlikeRLR/length(RLRphase)
RatioBlikeLRL=BlikeLRL/length(LRLphase)
RatioBlikeRLR=BlikeRLR/length(RLRphase)