function Negative_Close_Window_or_All_pattern_1_20200309

path=['C:\Users\C238\Desktop\touchcellLtRt_terashita'];
cd(path);

LS=ls;
NegativeLtouchUnit=[];
NegativeRtouchUnit=[];

LtNWPointArray=zeros(1,4);
LtNWFireArray=zeros(1,4);
RtNWPointArray=zeros(1,4);
RtNWFireArray=zeros(1,4);
W23NegativeLtouchUnit=[];
W23NegativeRtouchUnit=[];
W23LtouchUnitNegative=[];
W23RtouchUnitNegative=[];
W23LtNWPointArray=zeros(1,4);
W23LtNWFireArray=zeros(1,4);
             
W23RtNWPointArray=zeros(1,4);
W23RtNWFireArray=zeros(1,4);
for i=1:length(LS(:,1))
    TrimFolder=strtrim(LS(i,:));
    if ~strcmp(TrimFolder,'.') && ~strcmp(TrimFolder,'..') && isempty(strfind(TrimFolder,'.mat')) && isempty(strfind(TrimFolder,'.bmp'));
       CdFolder=[path,'\',TrimFolder];
       cd(CdFolder);
       LS1=ls;
       for j=1:length(LS1(:,1))
           TrimFolder2=strtrim(LS1(j,:));
           if length(TrimFolder2)>22 && strcmp(TrimFolder2(end-21:end),'SpikeOnOffRtLtUnit.mat');
               load(TrimFolder2);
               LtouchUnit=[LtouchSpikeOnUnit;[zeros(length(LtouchSpikeOffUnit(:,1)),1) LtouchSpikeOffUnit]]; %%%% SpikeOffUnitの前列に発火数列を追加してSpikeOnUnitと連結。SpikeOff時の発火数をゼロに設定
               LtouchUnitNegative= LtouchUnit(:,[1 7:10]);                                         
               RtouchUnit=[RtouchSpikeOnUnit;[zeros(length(RtouchSpikeOffUnit(:,1)),1) RtouchSpikeOffUnit]];
               RtouchUnitNegative= RtouchUnit(:,[1 7:10]);
               
%                LlocsInterval LTroughlocsInterval RlocsInterval RTroughlocsInterval
                %Ltouh
                [LTroughlocsIntervalB,LTroughlocsIntervalIndex]=sort(abs(LTroughlocsInterval),'ascend');
                LtouchWindowTrough=sort(LTroughlocsInterval(LTroughlocsIntervalIndex(1:4)),'ascend');        %%%%WindowNum個分のTrough%Troughのwindowは実質4つ
                [CloseLtInterval,CloseLtWindowNum]=sort(abs(LtouchWindowTrough),'ascend');
                
                %Rtouch
                [RTroughlocsIntervalB,RTroughlocsIntervalIndex]=sort(abs(RTroughlocsInterval),'ascend');
                RtouchWindowTrough=sort(RTroughlocsInterval(RTroughlocsIntervalIndex(1:4)),'ascend');        %%%%WindowNum個分のピーク%Troughのwindowは実質4つ
                [CloseRtInterval,CloseRtWindowNum]=sort(abs(RtouchWindowTrough),'ascend');
                
              W23LtouchUnitNegative=[];
              W23RtouchUnitNegative=[];
               for x=1:length(LtouchUnitNegative(:,1));
                   if LtouchUnitNegative(x,CloseLtWindowNum(1)+1)==-1;
                      W23LtouchUnitNegative=[W23LtouchUnitNegative;LtouchUnitNegative(x,:)];
                   end
               end
               
               for x=1:length(RtouchUnitNegative(:,1));
                   if RtouchUnitNegative(x,CloseRtWindowNum(1)+1)==-1;
                      W23RtouchUnitNegative=[W23RtouchUnitNegative;RtouchUnitNegative(x,:)];
                   end
               end
               
               
               %%%% All
               %Ltouch 
               for x=1:length(LtouchUnitNegative(:,1));
                   TargetArray=LtouchUnitNegative(x,(2:5));
                   IndexLtouch=length(TargetArray(TargetArray~=0));
                   if IndexLtouch==1;
                      LtNWPointArray(1)=LtNWPointArray(1)+1;
                      LtNWFireArray(1)=LtNWFireArray(1)+LtouchUnitNegative(x,1);
                   end
                   
                    if IndexLtouch==2;
                      LtNWPointArray(2)=LtNWPointArray(2)+1;
                      LtNWFireArray(2)=LtNWFireArray(2)+LtouchUnitNegative(x,1);
                   end
                   
                   if IndexLtouch==3;
                      LtNWPointArray(3)=LtNWPointArray(3)+1;
                      LtNWFireArray(3)=LtNWFireArray(3)+LtouchUnitNegative(x,1);
                   end
                   
                   if IndexLtouch==4;
                      LtNWPointArray(4)=LtNWPointArray(4)+1;
                      LtNWFireArray(4)=LtNWFireArray(4)+LtouchUnitNegative(x,1);
                   end
                   
               end
               
               
             
               %Rtouch 
               for x=1:length(RtouchUnitNegative(:,1));
                   TargetArray=RtouchUnitNegative(x,(2:5));
                   IndexRtouch=length(TargetArray(TargetArray~=0));
                   if IndexRtouch==1;
                      RtNWPointArray(1)=RtNWPointArray(1)+1;
                      RtNWFireArray(1)=RtNWFireArray(1)+RtouchUnitNegative(x,1);
                   end
                   
                    if IndexRtouch==2;
                      RtNWPointArray(2)=RtNWPointArray(2)+1;
                      RtNWFireArray(2)=RtNWFireArray(2)+RtouchUnitNegative(x,1);
                   end
                   
                   if IndexRtouch==3;
                      RtNWPointArray(3)=RtNWPointArray(3)+1;
                      RtNWFireArray(3)=RtNWFireArray(3)+RtouchUnitNegative(x,1);
                   end
                   
                   if IndexRtouch==4;
                      RtNWPointArray(4)=RtNWPointArray(4)+1;
                      RtNWFireArray(4)=RtNWFireArray(4)+RtouchUnitNegative(x,1);
                   end
                   
               end
                
               NegativeLtouchFR=LtNWFireArray./(LtNWPointArray*10);     
               NegativeLtouchUnit=[NegativeLtouchUnit;NegativeLtouchFR];          
               
               NegativeRtouchFR=RtNWFireArray./(RtNWPointArray*10);     
               NegativeRtouchUnit=[NegativeRtouchUnit;NegativeRtouchFR];          
             
               
               
               
               
               
               
               %%%% W3orW2
               %Ltouch 
               for x=1:length(W23LtouchUnitNegative(:,1));
                   TargetArray=W23LtouchUnitNegative(x,(2:5));
                   IndexLtouch=length(TargetArray(TargetArray~=0));
                   if IndexLtouch==1;
                      W23LtNWPointArray(1)=W23LtNWPointArray(1)+1;
                      W23LtNWFireArray(1)=W23LtNWFireArray(1)+W23LtouchUnitNegative(x,1);
                   end
                   
                    if IndexLtouch==2;
                      W23LtNWPointArray(2)=W23LtNWPointArray(2)+1;
                      W23LtNWFireArray(2)=W23LtNWFireArray(2)+W23LtouchUnitNegative(x,1);
                   end
                   
                   if IndexLtouch==3;
                      W23LtNWPointArray(3)=W23LtNWPointArray(3)+1;
                      W23LtNWFireArray(3)=W23LtNWFireArray(3)+W23LtouchUnitNegative(x,1);
                   end
                   
                   if IndexLtouch==4;
                      W23LtNWPointArray(4)=W23LtNWPointArray(4)+1;
                      W23LtNWFireArray(4)=W23LtNWFireArray(4)+W23LtouchUnitNegative(x,1);
                   end
               end
               
               
             
               %Rtouch 
               for x=1:length(W23RtouchUnitNegative(:,1));
                   TargetArray=W23RtouchUnitNegative(x,(2:5));
                   IndexRtouch=length(TargetArray(TargetArray~=0));
                   if IndexRtouch==1;
                      W23RtNWPointArray(1)=W23RtNWPointArray(1)+1;
                      W23RtNWFireArray(1)=W23RtNWFireArray(1)+W23RtouchUnitNegative(x,1);
                   end
                   
                    if IndexRtouch==2;
                      W23RtNWPointArray(2)=W23RtNWPointArray(2)+1;
                      W23RtNWFireArray(2)=W23RtNWFireArray(2)+W23RtouchUnitNegative(x,1);
                   end
                   
                   if IndexRtouch==3;
                      W23RtNWPointArray(3)=W23RtNWPointArray(3)+1;
                      W23RtNWFireArray(3)=W23RtNWFireArray(3)+W23RtouchUnitNegative(x,1);
                   end
                   
                   if IndexRtouch==4;
                      W23RtNWPointArray(4)=W23RtNWPointArray(4)+1;
                      W23RtNWFireArray(4)=W23RtNWFireArray(4)+W23RtouchUnitNegative(x,1);
                   end
               end
                
               W23NegativeLtouchFR=W23LtNWFireArray./(W23LtNWPointArray*10);     
               W23NegativeLtouchUnit=[W23NegativeLtouchUnit;W23NegativeLtouchFR];          
               
               W23NegativeRtouchFR=W23RtNWFireArray./(W23RtNWPointArray*10);     
               W23NegativeRtouchUnit=[W23NegativeRtouchUnit;W23NegativeRtouchFR];      
           end
           
           
       end
    end
end

% PositiveLtouchUnit=[];
% PositiveRtouchUnit=[];
% 
% 
% W3LtouchUnitPositive=[];
% W3RtouchUnitPositive=[];
MeanNegativeLtouchUnit=nanmean(NegativeLtouchUnit);  %%%%%列ごとに平均、NaNはのぞく
StdNegativeLtouchUnit=nanstd(NegativeLtouchUnit);

MeanNegativeRtouchUnit=nanmean(NegativeRtouchUnit);  %%%%%列ごとに平均、NaNはのぞく
StdNegativeRtouchUnit=nanstd(NegativeRtouchUnit);

MeanW23LtouchUnitNegative=nanmean(W23NegativeLtouchUnit);  %%%%%列ごとに平均、NaNはのぞく
StdW23LtouchUnitNegative=nanstd(W23NegativeLtouchUnit);

MeanW23RtouchUnitNegative=nanmean(W23NegativeRtouchUnit);  %%%%%列ごとに平均、NaNはのぞく
StdW23RtouchUnitNegative=nanstd(W23NegativeRtouchUnit);

% MeanLtouchUnit=[MeanW3LtouchUnitPositive.';[MeanPositiveLtouchUnit 0].'];
% 
% MeanRtouchUnit=[MeanW3RtouchUnitPositive.';[MeanPositiveRtouchUnit 0].'];
% 

x=1:4;
LtW1FRUnit=figure;
subplot(1,2,1);
bar(x,MeanNegativeLtouchUnit,0.5);hold on
errorbar(x,MeanNegativeLtouchUnit,StdNegativeLtouchUnit,'o','MarkerSize',0.2);
title('ALL_Ltouch')

y=1:4;
subplot(1,2,2);
bar(y,MeanW23LtouchUnitNegative,0.5);hold on
errorbar(y,MeanW23LtouchUnitNegative,StdW23LtouchUnitNegative,'o','MarkerSize',0.2);
title('W23_Ltouch')

All_W23NegativeLtouch=[MeanNegativeLtouchUnit.' MeanW23LtouchUnitNegative.'];
LtFig=figure;
bar(All_W23NegativeLtouch);

RtW1FRUnit=figure;
subplot(1,2,1);
bar(x,MeanNegativeRtouchUnit,0.5);hold on
errorbar(x,MeanNegativeRtouchUnit,StdNegativeRtouchUnit,'o','MarkerSize',0.2);
title('ALL_Rtouch')


subplot(1,2,2);
bar(y,MeanW23RtouchUnitNegative,0.5);hold on
errorbar(y,MeanW23RtouchUnitNegative,StdW23RtouchUnitNegative,'o','MarkerSize',0.2);
title('W23_Rtouch')

All_W23NegativeRtouch=[MeanNegativeRtouchUnit.' MeanW23RtouchUnitNegative.'];



RtFig=figure;
bar(All_W23NegativeRtouch);





figname=['Lt_Negative_close_W23_or_ALL.bmp'];
figname2=['Rt_Negative_close_W23_or_ALL.bmp'];
figname3=['Lt_Negative_close_Set.bmp'];
figname4=['Rt_Negative_close_Set.bmp'];
cd(path)
saveas(LtW1FRUnit,figname);
saveas(RtW1FRUnit,figname2);
saveas(LtFig,figname3);
saveas(RtFig,figname4);

