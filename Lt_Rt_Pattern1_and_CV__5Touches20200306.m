function Lt_Rt_Pattern1_and_CV__5Touches20200306
path=['C:\Users\C238\Desktop\touchcellLtRt_terashita'];
cd(path);

LS=ls;
PositiveTouchesPointArray=zeros(1,6);

FRCVLPWTouches=[];
FRCVRPWTouches=[];
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
               %Ltouch
               PositiveLtouchUnit=LtouchPosiNegaTimeUnit(:,[2:6]);
               
               
               TouchesLtouchPosiTimeUnit=[];   %%%%%%5回タッチしたときの配列を保存
               for x=1:length(LtouchPosiNegaTimeUnit(:,1))
                   LtouchesTime=LtouchPosiNegaTimeUnit(x,[2:10]);
                   LtouchesNum=LtouchesTime(LtouchesTime~=0);
                   if length(LtouchesNum)==5;
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
               end
               
               
               %Rtouch
               PositiveRtouchUnit=RtouchPosiNegaTimeUnit(:,[2:6]);
               
               
               TouchesRtouchPosiTimeUnit=[];   %%%%%%5回タッチしたときの配列を保存
               for x=1:length(RtouchPosiNegaTimeUnit(:,1))
                   RtouchesTime=RtouchPosiNegaTimeUnit(x,[2:10]);
                   RtouchesNum=RtouchesTime(RtouchesTime~=0);
                   if length(RtouchesNum)==5;
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
               end
               
           
           end
       end
    end
end

%Ltouch

LtouchPW0_FR=[];   LtouchPW0_CV=[];
LtouchPW1_FR=[];   LtouchPW1_CV=[];
LtouchPW2_FR=[];   LtouchPW2_CV=[];
LtouchPW3_FR=[];   LtouchPW3_CV=[];
LtouchPW4_FR=[];   LtouchPW4_CV=[];
LtouchPW5_FR=[];   LtouchPW5_CV=[];

for i=1:length(FRCVLPWTouches(:,1))
    if FRCVLPWTouches(i,3)==0;
        LtouchPW0_FR=[LtouchPW0_FR FRCVLPWTouches(i,1)];
        LtouchPW0_CV=[LtouchPW0_CV FRCVLPWTouches(i,2)];
    end
    
    if FRCVLPWTouches(i,3)==1;
        LtouchPW1_FR=[LtouchPW1_FR FRCVLPWTouches(i,1)];
        LtouchPW1_CV=[LtouchPW1_CV FRCVLPWTouches(i,2)];
    end
    
    if FRCVLPWTouches(i,3)==2;
        LtouchPW2_FR=[LtouchPW2_FR FRCVLPWTouches(i,1)];
        LtouchPW2_CV=[LtouchPW2_CV FRCVLPWTouches(i,2)];
    end
    
    if FRCVLPWTouches(i,3)==3;
        LtouchPW3_FR=[LtouchPW3_FR FRCVLPWTouches(i,1)];
        LtouchPW3_CV=[LtouchPW3_CV FRCVLPWTouches(i,2)];
    end
    
    if FRCVLPWTouches(i,3)==4;
        LtouchPW4_FR=[LtouchPW4_FR FRCVLPWTouches(i,1)];
        LtouchPW4_CV=[LtouchPW4_CV FRCVLPWTouches(i,2)];
    end
    
    if FRCVLPWTouches(i,3)==5;
        LtouchPW5_FR=[LtouchPW5_FR FRCVLPWTouches(i,1)];
        LtouchPW5_CV=[LtouchPW5_CV FRCVLPWTouches(i,2)];
    end
end

Ltouch_FRUnit=[mean(LtouchPW0_FR) mean(LtouchPW1_FR) mean(LtouchPW2_FR) mean(LtouchPW3_FR) mean(LtouchPW4_FR) mean(LtouchPW5_FR)...
    ;[std(LtouchPW0_FR) std(LtouchPW1_FR) std(LtouchPW2_FR) std(LtouchPW3_FR) std(LtouchPW4_FR) std(LtouchPW5_FR)]];

Ltouch_CVUnit=[mean(LtouchPW0_CV) mean(LtouchPW1_CV) mean(LtouchPW2_CV) mean(LtouchPW3_CV) mean(LtouchPW4_CV) mean(LtouchPW5_CV)...
    ;std(LtouchPW0_CV) std(LtouchPW1_CV) std(LtouchPW2_CV) std(LtouchPW3_CV) std(LtouchPW4_CV) std(LtouchPW5_CV)];


%Rtouch

RtouchPW0_FR=[];   RtouchPW0_CV=[];
RtouchPW1_FR=[];   RtouchPW1_CV=[];
RtouchPW2_FR=[];   RtouchPW2_CV=[];
RtouchPW3_FR=[];   RtouchPW3_CV=[];
RtouchPW4_FR=[];   RtouchPW4_CV=[];
RtouchPW5_FR=[];   RtouchPW5_CV=[];

for i=1:length(FRCVRPWTouches(:,1))
    if FRCVRPWTouches(i,3)==0;
        RtouchPW0_FR=[RtouchPW0_FR FRCVRPWTouches(i,1)];
        RtouchPW0_CV=[RtouchPW0_CV FRCVRPWTouches(i,2)];
    end
    
    if FRCVLPWTouches(i,3)==1;
        RtouchPW1_FR=[RtouchPW1_FR FRCVRPWTouches(i,1)];
        RtouchPW1_CV=[RtouchPW1_CV FRCVRPWTouches(i,2)];                        
    end
    
    if FRCVLPWTouches(i,3)==2;
        RtouchPW2_FR=[RtouchPW2_FR FRCVRPWTouches(i,1)];
        RtouchPW2_CV=[RtouchPW2_CV FRCVRPWTouches(i,2)];
    end
    
    if FRCVLPWTouches(i,3)==3;
        RtouchPW3_FR=[RtouchPW3_FR FRCVRPWTouches(i,1)];
        RtouchPW3_CV=[RtouchPW3_CV FRCVRPWTouches(i,2)];
    end
    
    if FRCVLPWTouches(i,3)==4;
        RtouchPW4_FR=[RtouchPW4_FR FRCVRPWTouches(i,1)];
        RtouchPW4_CV=[RtouchPW4_CV FRCVRPWTouches(i,2)];
    end
    
    if FRCVLPWTouches(i,3)==5;
        RtouchPW5_FR=[RtouchPW5_FR FRCVRPWTouches(i,1)];
        RtouchPW5_CV=[RtouchPW5_CV FRCVRPWTouches(i,2)];
    end
end


Rtouch_FRUnit=[mean(RtouchPW0_FR) mean(RtouchPW1_FR) mean(RtouchPW2_FR) mean(RtouchPW3_FR) mean(RtouchPW4_FR) mean(RtouchPW5_FR)...
    ;[std(RtouchPW0_FR) std(RtouchPW1_FR) std(RtouchPW2_FR) std(RtouchPW3_FR) std(RtouchPW4_FR) std(RtouchPW5_FR)]];

Rtouch_CVUnit=[mean(RtouchPW0_CV) mean(RtouchPW1_CV) mean(RtouchPW2_CV) mean(RtouchPW3_CV) mean(RtouchPW4_CV) mean(RtouchPW5_CV)...
    ;[std(RtouchPW0_CV) std(RtouchPW1_CV) std(RtouchPW2_CV) std(RtouchPW3_CV) std(RtouchPW4_CV) std(RtouchPW5_CV)]];




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


