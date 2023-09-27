function [RTouchAll,LTouchAll]=TouchExtract(PegTouchCell)

global SliderTouch OneTurnTime RefPeriod RpegMedian LpegMedian RLpegMedian RLpegName DrName fig_touchR fig_touchL fig_touchR_TM fig_touchL_TM fig_TMpegs...
    PtouchHistoCell_R PtouchHistoCell_L WaterOn_percent RLPegTouchAll RPegTouchAll LPegTouchAll FigureSave RpegTimeArray2D LpegTimeArray2D modif...
    RpegTouchBypegCell  LpegTouchBypegCell RmedianPTTM LmedianPTTM ShowFig patternValue PegTouchCell RTouchAll LTouchAll

Rpegtouch1=[];Rpegtouch2=[];Rpegtouch3=[];Rpegtouch4=[];Rpegtouch5=[];Rpegtouch6=[];
RpegTouchCell={Rpegtouch1,Rpegtouch2,Rpegtouch3,Rpegtouch4,Rpegtouch5,Rpegtouch6};
Lpegtouch1=[];Lpegtouch2=[];Lpegtouch3=[];Lpegtouch4=[];Lpegtouch5=[];Lpegtouch6=[];
LpegTouchCell={Lpegtouch1,Lpegtouch2,Lpegtouch3,Lpegtouch4,Lpegtouch5,Lpegtouch6};


for n=1:6%PegTouchCell 1-6ÇÕRpeg 7-12ÇÕLpeg
        RpegTouchCell{n}=[RpegTouchCell{n};PegTouchCell{n}];
        LpegTouchCell{n}=[LpegTouchCell{n};PegTouchCell{n+6}];
end

% RPegTouchAll=sort([RpegTouchCell{1}; RpegTouchCell{2}; RpegTouchCell{3}; RpegTouchCell{4}; RpegTouchCell{5}; RpegTouchCell{6}]);
% LPegTouchAll=sort([LpegTouchCell{1}; LpegTouchCell{2}; LpegTouchCell{3}; LpegTouchCell{4}; LpegTouchCell{5}; LpegTouchCell{6}]);
% RLPegTouchAll=sort([RpegTouchCell{1}; RpegTouchCell{2}; RpegTouchCell{3}; RpegTouchCell{4}; RpegTouchCell{5}; RpegTouchCell{6};...
%     LpegTouchCell{1}; LpegTouchCell{2}; LpegTouchCell{3}; LpegTouchCell{4}; LpegTouchCell{5}; LpegTouchCell{6}]);
% RpegTouch(n)=cell2mat(RpegTouchCell(n));
% max(length)Ç≈àÍî‘í∑Ç¢îzóÒÇ…çáÇÌÇπÇƒ0ÇÇ¬ÇØÇƒcell2matÇ≈Ç‹Ç∆ÇﬂÇƒÇ‚ÇÈ

lenRTouchC=zeros([1,6]);
lenLTouchC=zeros([1,6]);
for n=1:6
lenRTouchC(n)=length(RpegTouchCell{n});
lenLTouchC(n)=length(LpegTouchCell{n});
end
Rzero=max(lenRTouchC)
Lzero=max(lenLTouchC)
for n=1:6
RpegTouchCell{1,n}=[RpegTouchCell{1,n};zeros([max(lenRTouchC)-lenRTouchC(n),1])];
LpegTouchCell{1,n}=[LpegTouchCell{1,n};zeros([max(lenLTouchC)-lenLTouchC(n),1])];
end

% 800msec
RTouchArray=cell2mat(RpegTouchCell);
LTouchArray=cell2mat(LpegTouchCell);
for n=1:length(RTouchArray(n,:))
    for m=length(RTouchArray(:,n)):-1:2
        if RTouchArray(m,n)<(RTouchArray(m-1,n)+800);RTouchArray(m,n)=0;end%touch

    end
end
for n=1:length(LTouchArray(n,:))
    for m=length(LTouchArray(:,n)):-1:2
        if LTouchArray(m,n)<(LTouchArray(m-1,n)+800);LTouchArray(m,n)=0;end%touch

    end
end
RPegTouch1=RTouchArray(:,1);RPegTouch1(find(RPegTouch1==0))=[];
RPegTouch2=RTouchArray(:,2);RPegTouch2(find(RPegTouch2==0))=[];
RPegTouch3=RTouchArray(:,3);RPegTouch3(find(RPegTouch3==0))=[];
RPegTouch4=RTouchArray(:,4);RPegTouch4(find(RPegTouch4==0))=[];
RPegTouch5=RTouchArray(:,5);RPegTouch5(find(RPegTouch5==0))=[];
RPegTouch6=RTouchArray(:,6);RPegTouch6(find(RPegTouch6==0))=[];
RTouchAll=[RPegTouch1;RPegTouch2;RPegTouch3;RPegTouch4;RPegTouch5;RPegTouch6];RTouchAll=sort(RTouchAll);
LPegTouch1=LTouchArray(:,1);LPegTouch1(find(LPegTouch1==0))=[];
LPegTouch2=LTouchArray(:,2);LPegTouch2(find(LPegTouch2==0))=[];
LPegTouch3=LTouchArray(:,3);LPegTouch3(find(LPegTouch3==0))=[];
LPegTouch4=LTouchArray(:,4);LPegTouch4(find(LPegTouch4==0))=[];
LPegTouch5=LTouchArray(:,5);LPegTouch5(find(LPegTouch5==0))=[];
LPegTouch6=LTouchArray(:,6);LPegTouch6(find(LPegTouch6==0))=[];
LTouchAll=[LPegTouch1;LPegTouch2;LPegTouch3;LPegTouch4;LPegTouch5;LPegTouch6];LTouchAll=sort(LTouchAll);

RPegTouchAll=RTouchAll;
LPegTouchAll=LTouchAll;