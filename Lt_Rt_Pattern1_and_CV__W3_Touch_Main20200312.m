function Lt_Rt_Pattern1_and_CV__W3_Touch_Main20200312
path=['C:\Users\C238\Desktop\touchcellLtRt_terashita'];
cd(path);

LS=ls;
PositiveTouchesPointArray=zeros(1,6);

FRCVLPWTouches=[];
FRCVRPWTouches=[];
MeanLt_FR_Session=[];
MeanRt_FR_Session=[];
MeanLt_CV_Session=[];
MeanRt_CV_Session=[];
Posi5L=[];
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
               
%                LtouchPosiNegaTimeUnit
%                RtouchPosiNegaTimeUnit
FRCVRPWTouches_everySession=[];
FRCVLPWTouches_everySession=[];
Ltouch_FRUnit_every=[];
Ltouch_CVUnit_every=[];
Rtouch_FRUnit_every=[];
Rtouch_CVUnit_every=[];
               %Ltouch
               PositiveLtouchUnit=LtouchPosiNegaTimeUnit(:,[2:6]);
               
               
               TouchesLtouchPosiTimeUnit=[];   %%%%%%W3のタッチしたときの時刻配列を保存　　　[発火数（要素１）、PW（要素２～６）、NW（要素７～１０）]
               for x=1:length(LtouchPosiNegaTimeUnit(:,1))
                   Row=LtouchPosiNegaTimeUnit(x,(2:10));
                   if LtouchPosiNegaTimeUnit(x,4)~=0 && length(Row(Row~=0))==5;
                       TouchesLtouchPosiTimeUnit=[TouchesLtouchPosiTimeUnit;LtouchPosiNegaTimeUnit(x,:)];
                   end
               end
               
               TouchesLtouchPosiTimeUnitUnique=unique(TouchesLtouchPosiTimeUnit(:,[2:10]),'rows');
               
               for x=1:length(TouchesLtouchPosiTimeUnitUnique(:,1))
                   TargetUnit=[];
                  for y=1:length(TouchesLtouchPosiTimeUnit(:,1))
                      if TouchesLtouchPosiTimeUnitUnique(x,:)==TouchesLtouchPosiTimeUnit(y,[2:10]);
                         TargetUnit=[TargetUnit;TouchesLtouchPosiTimeUnit(y,:)]; 
                      end
                  end
                  TargetFR=sum(TargetUnit(:,1))/(length(TargetUnit(:,1))*10);  %%%%%%%それぞれのタッチパターンにおける発火頻度
                  
                  TargetPositiveArray=TouchesLtouchPosiTimeUnitUnique(x,[1:5]);     %%%%%%%PWにタッチした時刻の配列
                  PositiveTouchesNum=length(TargetPositiveArray(TargetPositiveArray~=0));%%%%%それぞれのタッチパターンにおけるPWのタッチ数（これをもとにグラフ作成）
                  
                  TargetAllTouchesArray=TouchesLtouchPosiTimeUnitUnique(x,:);
                  AllTouchTimeArray=sort(TargetAllTouchesArray(TargetAllTouchesArray~=0),'ascend');
                  
                  TimeDifference=diff(AllTouchTimeArray);
                  CVLtouch=std(TimeDifference)/mean(TimeDifference);
                  
                  
                  FRCVLPWTouches=[FRCVLPWTouches;[TargetFR CVLtouch PositiveTouchesNum]];
                  FRCVLPWTouches_everySession=[FRCVLPWTouches_everySession;[TargetFR CVLtouch PositiveTouchesNum]];
                  
                  if PositiveTouchesNum==5
                      Posi5L=[Posi5L;TouchesLtouchPosiTimeUnitUnique(x,:)];
                  end
               end
               
               
               %Rtouch
               PositiveRtouchUnit=RtouchPosiNegaTimeUnit(:,[2:6]);
               
               
               TouchesRtouchPosiTimeUnit=[];   %%%%%%W3のタッチしたときの時刻配列を保存　　　[発火数（要素１）、PW（要素２～６）、NW（要素７～１０）]
               for x=1:length(RtouchPosiNegaTimeUnit(:,1))
                   Row=RtouchPosiNegaTimeUnit(x,(2:10));
                   if RtouchPosiNegaTimeUnit(x,4)~=0 && length(Row(Row~=0))==5;
                       TouchesRtouchPosiTimeUnit=[TouchesRtouchPosiTimeUnit;RtouchPosiNegaTimeUnit(x,:)];
                   end
               end
               
               TouchesRtouchPosiTimeUnitUnique=unique(TouchesRtouchPosiTimeUnit(:,[2:10]),'rows');
               
               for x=1:length(TouchesRtouchPosiTimeUnitUnique(:,1))
                   TargetUnit=[];
                  for y=1:length(TouchesRtouchPosiTimeUnit(:,1))
                      if TouchesRtouchPosiTimeUnitUnique(x,:)==TouchesRtouchPosiTimeUnit(y,[2:10]);
                         TargetUnit=[TargetUnit;TouchesRtouchPosiTimeUnit(y,:)]; 
                      end
                  end
                  TargetFR=sum(TargetUnit(:,1))/(length(TargetUnit(:,1))*10);  %%%%%%%それぞれのタッチパターンにおける発火頻度
                  
                  TargetPositiveArray=TouchesRtouchPosiTimeUnitUnique(x,[1:5]);     %%%%%%%PWにタッチした時刻の配列
                  PositiveTouchesNum=length(TargetPositiveArray(TargetPositiveArray~=0));%%%%%それぞれのタッチパターンにおけるPWのタッチ数（これをもとにグラフ作成）
                  
                  TargetAllTouchesArray=TouchesRtouchPosiTimeUnitUnique(x,:);
                  AllTouchTimeArray=sort(TargetAllTouchesArray(TargetAllTouchesArray~=0),'ascend');
                  
                  TimeDifference=diff(AllTouchTimeArray);
                  CVRtouch=std(TimeDifference)/mean(TimeDifference);
                  
                  
                  FRCVRPWTouches=[FRCVRPWTouches;[TargetFR CVRtouch PositiveTouchesNum]];
                  FRCVRPWTouches_everySession=[FRCVRPWTouches_everySession;[TargetFR CVRtouch PositiveTouchesNum]];
               end
               
                %Ltouch

LtouchPW0_FR=[];   LtouchPW0_CV=[];
LtouchPW1_FR=[];   LtouchPW1_CV=[];
LtouchPW2_FR=[];   LtouchPW2_CV=[];
LtouchPW3_FR=[];   LtouchPW3_CV=[];
LtouchPW4_FR=[];   LtouchPW4_CV=[];
LtouchPW5_FR=[];   LtouchPW5_CV=[];

for i=1:length(FRCVLPWTouches_everySession(:,1))
    if FRCVLPWTouches_everySession(i,3)==0;
        LtouchPW0_FR=[LtouchPW0_FR FRCVLPWTouches_everySession(i,1)];
        LtouchPW0_CV=[LtouchPW0_CV FRCVLPWTouches_everySession(i,2)];
    end
    
    if FRCVLPWTouches_everySession(i,3)==1;
        LtouchPW1_FR=[LtouchPW1_FR FRCVLPWTouches_everySession(i,1)];
        LtouchPW1_CV=[LtouchPW1_CV FRCVLPWTouches_everySession(i,2)];
    end
    
    if FRCVLPWTouches_everySession(i,3)==2;
        LtouchPW2_FR=[LtouchPW2_FR FRCVLPWTouches_everySession(i,1)];
        LtouchPW2_CV=[LtouchPW2_CV FRCVLPWTouches_everySession(i,2)];
    end
    
    if FRCVLPWTouches_everySession(i,3)==3;
        LtouchPW3_FR=[LtouchPW3_FR FRCVLPWTouches_everySession(i,1)];
        LtouchPW3_CV=[LtouchPW3_CV FRCVLPWTouches_everySession(i,2)];
    end
    
    if FRCVLPWTouches_everySession(i,3)==4;
        LtouchPW4_FR=[LtouchPW4_FR FRCVLPWTouches_everySession(i,1)];
        LtouchPW4_CV=[LtouchPW4_CV FRCVLPWTouches_everySession(i,2)];
    end
    
    if FRCVLPWTouches_everySession(i,3)==5;
        LtouchPW5_FR=[LtouchPW5_FR FRCVLPWTouches_everySession(i,1)];
        LtouchPW5_CV=[LtouchPW5_CV FRCVLPWTouches_everySession(i,2)];
    end
end

Ltouch_FRUnit_every=[nanmean(LtouchPW0_FR) nanmean(LtouchPW1_FR) nanmean(LtouchPW2_FR) nanmean(LtouchPW3_FR) nanmean(LtouchPW4_FR) nanmean(LtouchPW5_FR)...
    ;[nanstd(LtouchPW0_FR) nanstd(LtouchPW1_FR) nanstd(LtouchPW2_FR) nanstd(LtouchPW3_FR) nanstd(LtouchPW4_FR) nanstd(LtouchPW5_FR)]];

Ltouch_CVUnit_every=[nanmean(LtouchPW0_CV) nanmean(LtouchPW1_CV) nanmean(LtouchPW2_CV) nanmean(LtouchPW3_CV) nanmean(LtouchPW4_CV) nanmean(LtouchPW5_CV)...
    ;[nanstd(LtouchPW0_CV) nanstd(LtouchPW1_CV) nanstd(LtouchPW2_CV) nanstd(LtouchPW3_CV) nanstd(LtouchPW4_CV) nanstd(LtouchPW5_CV)]];


%Rtouch

RtouchPW0_FR=[];   RtouchPW0_CV=[];
RtouchPW1_FR=[];   RtouchPW1_CV=[];
RtouchPW2_FR=[];   RtouchPW2_CV=[];
RtouchPW3_FR=[];   RtouchPW3_CV=[];
RtouchPW4_FR=[];   RtouchPW4_CV=[];
RtouchPW5_FR=[];   RtouchPW5_CV=[];

for i=1:length(FRCVRPWTouches_everySession(:,1))
    if FRCVRPWTouches_everySession(i,3)==0;
        RtouchPW0_FR=[RtouchPW0_FR FRCVRPWTouches_everySession(i,1)];
        RtouchPW0_CV=[RtouchPW0_CV FRCVRPWTouches_everySession(i,2)];
    end
    
    if FRCVRPWTouches_everySession(i,3)==1;
        RtouchPW1_FR=[RtouchPW1_FR FRCVRPWTouches_everySession(i,1)];
        RtouchPW1_CV=[RtouchPW1_CV FRCVRPWTouches_everySession(i,2)];                        
    end
    
    if FRCVRPWTouches_everySession(i,3)==2;
        RtouchPW2_FR=[RtouchPW2_FR FRCVRPWTouches_everySession(i,1)];
        RtouchPW2_CV=[RtouchPW2_CV FRCVRPWTouches_everySession(i,2)];
    end
    
    if FRCVRPWTouches_everySession(i,3)==3;
        RtouchPW3_FR=[RtouchPW3_FR FRCVRPWTouches_everySession(i,1)];
        RtouchPW3_CV=[RtouchPW3_CV FRCVRPWTouches_everySession(i,2)];
    end
    
    if FRCVRPWTouches_everySession(i,3)==4;
        RtouchPW4_FR=[RtouchPW4_FR FRCVRPWTouches_everySession(i,1)];
        RtouchPW4_CV=[RtouchPW4_CV FRCVRPWTouches_everySession(i,2)];
    end
    
    if FRCVRPWTouches_everySession(i,3)==5;
        RtouchPW5_FR=[RtouchPW5_FR FRCVRPWTouches_everySession(i,1)];
        RtouchPW5_CV=[RtouchPW5_CV FRCVRPWTouches_everySession(i,2)];
    end
end


Rtouch_FRUnit_every=[nanmean(RtouchPW0_FR) nanmean(RtouchPW1_FR) nanmean(RtouchPW2_FR) nanmean(RtouchPW3_FR) nanmean(RtouchPW4_FR) nanmean(RtouchPW5_FR)...
    ;[nanstd(RtouchPW0_FR) nanstd(RtouchPW1_FR) nanstd(RtouchPW2_FR) nanstd(RtouchPW3_FR) nanstd(RtouchPW4_FR) nanstd(RtouchPW5_FR)]];

Rtouch_CVUnit_every=[nanmean(RtouchPW0_CV) nanmean(RtouchPW1_CV) nanmean(RtouchPW2_CV) nanmean(RtouchPW3_CV) nanmean(RtouchPW4_CV) nanmean(RtouchPW5_CV)...
    ;[nanstd(RtouchPW0_CV) nanstd(RtouchPW1_CV) nanstd(RtouchPW2_CV) nanstd(RtouchPW3_CV) nanstd(RtouchPW4_CV) nanstd(RtouchPW5_CV)]];


x1=1:length(Ltouch_FRUnit_every(1,:));
RLtouch_FR_CV_figure=figure;
subplot(2,2,1);
bar(x1,Ltouch_FRUnit_every(1,:),0.5);hold on
errorbar(x1,Ltouch_FRUnit_every(1,:),Ltouch_FRUnit_every(2,:),'o','MarkerSize',0.2);
title('Ltouch_FRUnit')


subplot(2,2,2);
x2=1:length(Ltouch_FRUnit_every(1,:));
bar(x2,Rtouch_FRUnit_every(1,:),0.5);hold on
errorbar(x2,Rtouch_FRUnit_every(1,:),Rtouch_FRUnit_every(2,:),'o','MarkerSize',0.2);
title('Rtouch_FRUnit')


subplot(2,2,3);
x3=1:length(Ltouch_FRUnit_every(1,:));
bar(x3,Ltouch_CVUnit_every(1,:),0.5);hold on
errorbar(x3,Ltouch_CVUnit_every(1,:),Ltouch_CVUnit_every(2,:),'o','MarkerSize',0.2);
title('Ltouch_CVUnit')


subplot(2,2,4);
x4=1:length(Ltouch_FRUnit_every(1,:));
bar(x4,Rtouch_CVUnit_every(1,:),0.5);hold on
errorbar(x4,Rtouch_CVUnit_every(1,:),Rtouch_CVUnit_every(2,:),'o','MarkerSize',0.2);
title('Rtouch_CVUnit')

fignameFRCV=['FR_CV',TrimFolder2(1:end-22),'.bmp'];
saveas(RLtouch_FR_CV_figure,fignameFRCV);


MeanLt_FR_Session=[MeanLt_FR_Session;Ltouch_FRUnit_every(1,:)];
MeanRt_FR_Session=[MeanRt_FR_Session;Rtouch_FRUnit_every(1,:)];
MeanLt_CV_Session=[MeanLt_CV_Session;Ltouch_CVUnit_every(1,:)];
MeanRt_CV_Session=[MeanRt_CV_Session;Rtouch_CVUnit_every(1,:)];
           end
       end
    end
end

%Ltouch


Ltouch_FRUnit=[nanmean(MeanLt_FR_Session(:,1)) nanmean(MeanLt_FR_Session(:,2)) nanmean(MeanLt_FR_Session(:,3)) nanmean(MeanLt_FR_Session(:,4))...
    nanmean(MeanLt_FR_Session(:,5)) nanmean(MeanLt_FR_Session(:,6))...
    ;[nanstd(MeanLt_FR_Session(:,1)) nanstd(MeanLt_FR_Session(:,2)) nanstd(MeanLt_FR_Session(:,3)) nanstd(MeanLt_FR_Session(:,4))...
    nanstd(MeanLt_FR_Session(:,5)) nanstd(MeanLt_FR_Session(:,6))]];

Ltouch_CVUnit=[nanmean(MeanLt_CV_Session(:,1)) nanmean(MeanLt_CV_Session(:,2)) nanmean(MeanLt_CV_Session(:,3)) nanmean(MeanLt_CV_Session(:,4))... 
    nanmean(MeanLt_CV_Session(:,5)) nanmean(MeanLt_CV_Session(:,6))...
    ;[nanstd(MeanLt_CV_Session(:,1)) nanstd(MeanLt_CV_Session(:,2)) nanstd(MeanLt_CV_Session(:,3)) nanstd(MeanLt_CV_Session(:,4))...
    nanstd(MeanLt_CV_Session(:,5)) nanstd(MeanLt_CV_Session(:,6))]];


%Rtouch



Rtouch_FRUnit=[nanmean(MeanRt_FR_Session(:,1)) nanmean(MeanRt_FR_Session(:,2)) nanmean(MeanRt_FR_Session(:,3)) nanmean(MeanRt_FR_Session(:,4))...
    nanmean(MeanRt_FR_Session(:,5)) nanmean(MeanRt_FR_Session(:,6))...
    ;[nanstd(MeanRt_FR_Session(:,1)) nanstd(MeanRt_FR_Session(:,2)) nanstd(MeanRt_FR_Session(:,3)) nanstd(MeanRt_FR_Session(:,4))...
    nanstd(MeanRt_FR_Session(:,5)) nanstd(MeanRt_FR_Session(:,6))]];

Rtouch_CVUnit=[nanmean(MeanRt_CV_Session(:,1)) nanmean(MeanRt_CV_Session(:,2)) nanmean(MeanRt_CV_Session(:,3)) nanmean(MeanRt_CV_Session(:,4))...
    nanmean(MeanRt_CV_Session(:,5)) nanmean(MeanRt_CV_Session(:,6))...
    ;[nanstd(MeanRt_CV_Session(:,1)) nanstd(MeanRt_CV_Session(:,2)) nanstd(MeanRt_CV_Session(:,3)) nanstd(MeanRt_CV_Session(:,4))...
    nanstd(MeanRt_CV_Session(:,5)) nanstd(MeanRt_CV_Session(:,6))]];




%%%%%%%Ltouch
% %%%%FR
% MeanLtouch_FRUnit=[];
% StdLtouch_FRUnit=[];
% for i=1:length(Ltouch_FRUnit(1,:))
%     MeanLtouch_FRUnit=[MeanLtouch_FRUnit nanmean(Ltouch_FRUnit(:,i))];
%     StdLtouch_FRUnit=[StdLtouch_FRUnit nanstd(Ltouch_FRUnit(:,i))];
% end
% %%%%%CV
% MeanLtouch_CVUnit=[];
% StdLtouch_CVUnit=[];
% for i=1:length(Ltouch_CVUnit(1,:))
%     MeanLtouch_CVUnit=[MeanLtouch_CVUnit nanmean(Ltouch_CVUnit(:,i))];
%     StdLtouch_CVUnit=[StdLtouch_CVUnit nanstd(Ltouch_CVUnit(:,i))];
% end



%%%%%%Rtouch
%%%%%%FR
% MeanRtouch_FRUnit=[];
% StdRtouch_FRUnit=[];
% for i=1:length(Rtouch_FRUnit(1,:))
%     MeanRtouch_FRUnit=[MeanRtouch_FRUnit nanmean(Rtouch_FRUnit(:,i))];
%     StdRtouch_FRUnit=[StdRtouch_FRUnit nanstd(Rtouch_FRUnit(:,i))];
% end
% %%%%%%CV
% MeanRtouch_CVUnit=[];
% StdRtouch_CVUnit=[];
% for i=1:length(Rtouch_CVUnit(1,:))
%     MeanRtouch_CVUnit=[MeanRtouch_CVUnit nanmean(Rtouch_CVUnit(:,i))];
%     StdRtouch_CVUnit=[StdRtouch_CVUnit nanstd(Rtouch_CVUnit(:,i))];
% end

cd(path);
filename=['Lt_Rt_Pattern1_and_CV_5Touches.mat'];
save(filename,'Ltouch_FRUnit','Ltouch_CVUnit','Rtouch_FRUnit','Rtouch_CVUnit'...
    ,'FRCVLPWTouches','FRCVRPWTouches');

x1=1:length(Ltouch_FRUnit(1,:));
RLtouch_FR_CVUnit=figure;
subplot(2,2,1);
bar(x1,Ltouch_FRUnit(1,:),0.5);hold on
errorbar(x1,Ltouch_FRUnit(1,:),Ltouch_FRUnit(2,:),'o','MarkerSize',0.2);
title('Ltouch_FRUnit')


subplot(2,2,2);
x2=1:length(Ltouch_FRUnit(1,:));
bar(x2,Rtouch_FRUnit(1,:),0.5);hold on
errorbar(x2,Rtouch_FRUnit(1,:),Rtouch_FRUnit(2,:),'o','MarkerSize',0.2);
title('Rtouch_FRUnit')


subplot(2,2,3);
x3=1:length(Ltouch_FRUnit(1,:));
bar(x3,Ltouch_CVUnit(1,:),0.5);hold on
errorbar(x3,Ltouch_CVUnit(1,:),Ltouch_CVUnit(2,:),'o','MarkerSize',0.2);
title('Ltouch_CVUnit')


subplot(2,2,4);
x4=1:length(Ltouch_FRUnit(1,:));
bar(x4,Rtouch_CVUnit(1,:),0.5);hold on
errorbar(x4,Rtouch_CVUnit(1,:),Rtouch_CVUnit(2,:),'o','MarkerSize',0.2);
title('Rtouch_CVUnit')

figname=['Lt_Rt_Pattern1_and_CV__5Touches.bmp'];
cd(path)
saveas(RLtouch_FR_CVUnit,figname);


figure
scatter(FRCVLPWTouches(:,1),FRCVLPWTouches(:,2));
scatter(FRCVRPWTouches(:,1),FRCVRPWTouches(:,2));


