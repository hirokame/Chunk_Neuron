function Positive_W3_or_All_Pattern_1_20200302
path=['C:\Users\C238\Desktop\touchcellLtRt_terashita'];
cd(path);

LS=ls;
PositiveLtouchUnit=[];
PositiveRtouchUnit=[];

LtPWPointArray=zeros(1,5);
LtPWFireArray=zeros(1,5);
RtPWPointArray=zeros(1,5);
RtPWFireArray=zeros(1,5);
W3PositiveLtouchUnit=[];
W3PositiveRtouchUnit=[];
W3LtouchUnitPositive=[];
W3RtouchUnitPositive=[];
W3LtPWPointArray=zeros(1,5);
W3LtPWFireArray=zeros(1,5);
             
W3RtPWPointArray=zeros(1,5);
W3RtPWFireArray=zeros(1,5);
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
               LtouchUnitPositive= LtouchUnit(:,[1:6]);                                         
               RtouchUnit=[RtouchSpikeOnUnit;[zeros(length(RtouchSpikeOffUnit(:,1)),1) RtouchSpikeOffUnit]];
               RtouchUnitPositive= RtouchUnit(:,[1:6]);
               
               
              W3LtouchUnitPositive=[];
              W3RtouchUnitPositive=[];
               for x=1:length(LtouchUnitPositive(:,1));
                   if LtouchUnitPositive(x,4)==1;
                      W3LtouchUnitPositive=[W3LtouchUnitPositive;LtouchUnitPositive(x,:)];
                   end
               end
               
               for x=1:length(RtouchUnitPositive(:,1));
                   if RtouchUnitPositive(x,4)==1;
                      W3RtouchUnitPositive=[W3RtouchUnitPositive;RtouchUnitPositive(x,:)];
                   end
               end
               
               
               %%%% All
               %Ltouch 
               for x=1:length(LtouchUnitPositive(:,1));
                   TargetArray=LtouchUnitPositive(x,(2:6));
                   IndexLtouch=length(TargetArray(TargetArray~=0));
                   if IndexLtouch==1;
                      LtPWPointArray(1)=LtPWPointArray(1)+1;
                      LtPWFireArray(1)=LtPWFireArray(1)+LtouchUnitPositive(x,1);
                   end
                   
                    if IndexLtouch==2;
                      LtPWPointArray(2)=LtPWPointArray(2)+1;
                      LtPWFireArray(2)=LtPWFireArray(2)+LtouchUnitPositive(x,1);
                   end
                   
                   if IndexLtouch==3;
                      LtPWPointArray(3)=LtPWPointArray(3)+1;
                      LtPWFireArray(3)=LtPWFireArray(3)+LtouchUnitPositive(x,1);
                   end
                   
                   if IndexLtouch==4;
                      LtPWPointArray(4)=LtPWPointArray(4)+1;
                      LtPWFireArray(4)=LtPWFireArray(4)+LtouchUnitPositive(x,1);
                   end
                   
                   if IndexLtouch==5;
                      LtPWPointArray(5)=LtPWPointArray(5)+1;
                      LtPWFireArray(5)=LtPWFireArray(5)+LtouchUnitPositive(x,1);
                   end
               end
               
               
             
               %Rtouch 
               for x=1:length(RtouchUnitPositive(:,1));
                   TargetArray=RtouchUnitPositive(x,(2:6));
                   IndexRtouch=length(TargetArray(TargetArray~=0));
                   if IndexRtouch==1;
                      RtPWPointArray(1)=RtPWPointArray(1)+1;
                      RtPWFireArray(1)=RtPWFireArray(1)+RtouchUnitPositive(x,1);
                   end
                   
                    if IndexRtouch==2;
                      RtPWPointArray(2)=RtPWPointArray(2)+1;
                      RtPWFireArray(2)=RtPWFireArray(2)+RtouchUnitPositive(x,1);
                   end
                   
                   if IndexRtouch==3;
                      RtPWPointArray(3)=RtPWPointArray(3)+1;
                      RtPWFireArray(3)=RtPWFireArray(3)+RtouchUnitPositive(x,1);
                   end
                   
                   if IndexRtouch==4;
                      RtPWPointArray(4)=RtPWPointArray(4)+1;
                      RtPWFireArray(4)=RtPWFireArray(4)+RtouchUnitPositive(x,1);
                   end
                   
                   if IndexRtouch==5;
                      RtPWPointArray(5)=RtPWPointArray(5)+1;
                      RtPWFireArray(5)=RtPWFireArray(5)+RtouchUnitPositive(x,1);
                   end
               end
                
               PositiveLtouchFR=LtPWFireArray./(LtPWPointArray*10);     
               PositiveLtouchUnit=[PositiveLtouchUnit;PositiveLtouchFR];          
               
               PositiveRtouchFR=RtPWFireArray./(RtPWPointArray*10);     
               PositiveRtouchUnit=[PositiveRtouchUnit;PositiveRtouchFR];          
             
               
               
               
               
               
               
                %%%% W3
               %Ltouch 
               for x=1:length(W3LtouchUnitPositive(:,1));
                   TargetArray=W3LtouchUnitPositive(x,(2:6));
                   IndexLtouch=length(TargetArray(TargetArray~=0));
                   if IndexLtouch==1;
                      W3LtPWPointArray(1)=W3LtPWPointArray(1)+1;
                      W3LtPWFireArray(1)=W3LtPWFireArray(1)+W3LtouchUnitPositive(x,1);
                   end
                   
                    if IndexLtouch==2;
                      W3LtPWPointArray(2)=W3LtPWPointArray(2)+1;
                      W3LtPWFireArray(2)=W3LtPWFireArray(2)+W3LtouchUnitPositive(x,1);
                   end
                   
                   if IndexLtouch==3;
                      W3LtPWPointArray(3)=W3LtPWPointArray(3)+1;
                      W3LtPWFireArray(3)=W3LtPWFireArray(3)+W3LtouchUnitPositive(x,1);
                   end
                   
                   if IndexLtouch==4;
                      W3LtPWPointArray(4)=W3LtPWPointArray(4)+1;
                      W3LtPWFireArray(4)=W3LtPWFireArray(4)+W3LtouchUnitPositive(x,1);
                   end
                   
                   if IndexLtouch==5;
                      W3LtPWPointArray(5)=W3LtPWPointArray(5)+1;
                      W3LtPWFireArray(5)=W3LtPWFireArray(5)+W3LtouchUnitPositive(x,1);
                   end
               end
               
               
             
               %Rtouch 
               for x=1:length(W3RtouchUnitPositive(:,1));
                   TargetArray=W3RtouchUnitPositive(x,(2:6));
                   IndexRtouch=length(TargetArray(TargetArray~=0));
                   if IndexRtouch==1;
                      W3RtPWPointArray(1)=W3RtPWPointArray(1)+1;
                      W3RtPWFireArray(1)=W3RtPWFireArray(1)+W3RtouchUnitPositive(x,1);
                   end
                   
                    if IndexRtouch==2;
                      W3RtPWPointArray(2)=W3RtPWPointArray(2)+1;
                      W3RtPWFireArray(2)=W3RtPWFireArray(2)+W3RtouchUnitPositive(x,1);
                   end
                   
                   if IndexRtouch==3;
                      W3RtPWPointArray(3)=W3RtPWPointArray(3)+1;
                      W3RtPWFireArray(3)=W3RtPWFireArray(3)+W3RtouchUnitPositive(x,1);
                   end
                   
                   if IndexRtouch==4;
                      W3RtPWPointArray(4)=W3RtPWPointArray(4)+1;
                      W3RtPWFireArray(4)=W3RtPWFireArray(4)+W3RtouchUnitPositive(x,1);
                   end
                   
                   if IndexRtouch==5;
                      W3RtPWPointArray(5)=W3RtPWPointArray(5)+1;
                      W3RtPWFireArray(5)=W3RtPWFireArray(5)+W3RtouchUnitPositive(x,1);
                   end
               end
                
               W3PositiveLtouchFR=W3LtPWFireArray./(W3LtPWPointArray*10);     
               W3PositiveLtouchUnit=[W3PositiveLtouchUnit;W3PositiveLtouchFR];          
               
               W3PositiveRtouchFR=W3RtPWFireArray./(W3RtPWPointArray*10);     
               W3PositiveRtouchUnit=[W3PositiveRtouchUnit;W3PositiveRtouchFR];      
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
MeanPositiveLtouchUnit=nanmean(PositiveLtouchUnit);  %%%%%列ごとに平均、NaNはのぞく
StdPositiveLtouchUnit=nanstd(PositiveLtouchUnit);

MeanPositiveRtouchUnit=nanmean(PositiveRtouchUnit);  %%%%%列ごとに平均、NaNはのぞく
StdPositiveRtouchUnit=nanstd(PositiveRtouchUnit);

MeanW3LtouchUnitPositive=nanmean(W3PositiveLtouchUnit);  %%%%%列ごとに平均、NaNはのぞく
StdW3LtouchUnitPositivte=nanstd(W3PositiveLtouchUnit);

MeanW3RtouchUnitPositive=nanmean(W3PositiveRtouchUnit);  %%%%%列ごとに平均、NaNはのぞく
StdW3RtouchUnitPositive=nanstd(W3PositiveRtouchUnit);

% MeanLtouchUnit=[MeanW3LtouchUnitPositive.';[MeanPositiveLtouchUnit 0].'];
% 
% MeanRtouchUnit=[MeanW3RtouchUnitPositive.';[MeanPositiveRtouchUnit 0].'];
% 

x=1:5;
LtW1FRUnit=figure
subplot(1,2,1);
bar(x,MeanPositiveLtouchUnit,0.5);hold on
errorbar(x,MeanPositiveLtouchUnit,StdPositiveLtouchUnit,'o','MarkerSize',0.2);
title('ALL_Ltouch')

y=1:5
subplot(1,2,2);
bar(y,MeanW3LtouchUnitPositive,0.5);hold on
errorbar(y,MeanW3LtouchUnitPositive,StdW3LtouchUnitPositivte,'o','MarkerSize',0.2);
title('W3_Ltouch')



RtW1FRUnit=figure
subplot(1,2,1);
bar(x,MeanPositiveRtouchUnit,0.5);hold on
errorbar(x,MeanPositiveRtouchUnit,StdPositiveRtouchUnit,'o','MarkerSize',0.2);
title('ALL_Rtouch')


subplot(1,2,2);
bar(y,MeanW3RtouchUnitPositive,0.5);hold on
errorbar(y,MeanW3RtouchUnitPositive,StdW3RtouchUnitPositive,'o','MarkerSize',0.2);
title('W3_Rtouch')

figname=['Lt_Positive_W3_or_ALL.bmp'];
figname2=['Rt_Positive_W3_or_ALL.bmp'];
cd(path)
saveas(LtW1FRUnit,figname);
saveas(RtW1FRUnit,figname2);

