function Lt_Rt_Pattern1_and_CV__5Touches_figure20200308


path=['C:\Users\C238\Desktop\touchcellLtRt_terashita'];
cd(path);
load('Lt_Rt_Pattern1_and_CV_5Touches.mat');

% %Ltouch
% 
% LtouchPW0_FR=[];   LtouchPW0_CV=[];
% LtouchPW1_FR=[];   LtouchPW1_CV=[];
% LtouchPW2_FR=[];   LtouchPW2_CV=[];
% LtouchPW3_FR=[];   LtouchPW3_CV=[];
% LtouchPW4_FR=[];   LtouchPW4_CV=[];
% LtouchPW5_FR=[];   LtouchPW5_CV=[];
% 
% for i=1:length(FRCVLPWTouches(:,1))
%     if FRCVLPWTouches(i,3)==0;
%         LtouchPW0_FR=[LtouchPW0_FR FRCVLPWTouches(i,1)];
%         LtouchPW0_CV=[LtouchPW0_CV FRCVLPWTouches(i,2)];
%     end
%     
%     if FRCVLPWTouches(i,3)==1;
%         LtouchPW1_FR=[LtouchPW1_FR FRCVLPWTouches(i,1)];
%         LtouchPW1_CV=[LtouchPW1_CV FRCVLPWTouches(i,2)];
%     end
%     
%     if FRCVLPWTouches(i,3)==2;
%         LtouchPW2_FR=[LtouchPW2_FR FRCVLPWTouches(i,1)];
%         LtouchPW2_CV=[LtouchPW2_CV FRCVLPWTouches(i,2)];
%     end
%     
%     if FRCVLPWTouches(i,3)==3;
%         LtouchPW3_FR=[LtouchPW3_FR FRCVLPWTouches(i,1)];
%         LtouchPW3_CV=[LtouchPW3_CV FRCVLPWTouches(i,2)];
%     end
%     
%     if FRCVLPWTouches(i,3)==4;
%         LtouchPW4_FR=[LtouchPW4_FR FRCVLPWTouches(i,1)];
%         LtouchPW4_CV=[LtouchPW4_CV FRCVLPWTouches(i,2)];
%     end
%     
%     if FRCVLPWTouches(i,3)==5;
%         LtouchPW5_FR=[LtouchPW5_FR FRCVLPWTouches(i,1)];
%         LtouchPW5_CV=[LtouchPW5_CV FRCVLPWTouches(i,2)];
%     end
% end
% 
% Ltouch_FRUnit=[nanmean(LtouchPW0_FR) nanmean(LtouchPW1_FR) nanmean(LtouchPW2_FR) nanmean(LtouchPW3_FR) nanmean(LtouchPW4_FR) nanmean(LtouchPW5_FR)...
%     ;[nanstd(LtouchPW0_FR) nanstd(LtouchPW1_FR) nanstd(LtouchPW2_FR) nanstd(LtouchPW3_FR) nanstd(LtouchPW4_FR) nanstd(LtouchPW5_FR)]];
% 
% Ltouch_CVUnit=[nanmean(LtouchPW0_CV) nanmean(LtouchPW1_CV) nanmean(LtouchPW2_CV) nanmean(LtouchPW3_CV) nanmean(LtouchPW4_CV) nanmean(LtouchPW5_CV)...
%     ;[nanstd(LtouchPW0_CV) nanstd(LtouchPW1_CV) nanstd(LtouchPW2_CV) nanstd(LtouchPW3_CV) nanstd(LtouchPW4_CV) nanstd(LtouchPW5_CV)]];
% 
% 
% %Rtouch
% 
% RtouchPW0_FR=[];   RtouchPW0_CV=[];
% RtouchPW1_FR=[];   RtouchPW1_CV=[];
% RtouchPW2_FR=[];   RtouchPW2_CV=[];
% RtouchPW3_FR=[];   RtouchPW3_CV=[];
% RtouchPW4_FR=[];   RtouchPW4_CV=[];
% RtouchPW5_FR=[];   RtouchPW5_CV=[];
% 
% for i=1:length(FRCVRPWTouches(:,1))
%     if FRCVRPWTouches(i,3)==0;
%         RtouchPW0_FR=[RtouchPW0_FR FRCVRPWTouches(i,1)];
%         RtouchPW0_CV=[RtouchPW0_CV FRCVRPWTouches(i,2)];
%     end
%     
%     if FRCVLPWTouches(i,3)==1;
%         RtouchPW1_FR=[RtouchPW1_FR FRCVRPWTouches(i,1)];
%         RtouchPW1_CV=[RtouchPW1_CV FRCVRPWTouches(i,2)];                        
%     end
%     
%     if FRCVLPWTouches(i,3)==2;
%         RtouchPW2_FR=[RtouchPW2_FR FRCVRPWTouches(i,1)];
%         RtouchPW2_CV=[RtouchPW2_CV FRCVRPWTouches(i,2)];
%     end
%     
%     if FRCVLPWTouches(i,3)==3;
%         RtouchPW3_FR=[RtouchPW3_FR FRCVRPWTouches(i,1)];
%         RtouchPW3_CV=[RtouchPW3_CV FRCVRPWTouches(i,2)];
%     end
%     
%     if FRCVLPWTouches(i,3)==4;
%         RtouchPW4_FR=[RtouchPW4_FR FRCVRPWTouches(i,1)];
%         RtouchPW4_CV=[RtouchPW4_CV FRCVRPWTouches(i,2)];
%     end
%     
%     if FRCVLPWTouches(i,3)==5;
%         RtouchPW5_FR=[RtouchPW5_FR FRCVRPWTouches(i,1)];
%         RtouchPW5_CV=[RtouchPW5_CV FRCVRPWTouches(i,2)];
%     end
% end
% 
% 
% Rtouch_FRUnit=[nanmean(RtouchPW0_FR) nanmean(RtouchPW1_FR) nanmean(RtouchPW2_FR) nanmean(RtouchPW3_FR) nanmean(RtouchPW4_FR) nanmean(RtouchPW5_FR)...
%     ;[nanstd(RtouchPW0_FR) nanstd(RtouchPW1_FR) nanstd(RtouchPW2_FR) nanstd(RtouchPW3_FR) nanstd(RtouchPW4_FR) nanstd(RtouchPW5_FR)]];
% 
% Rtouch_CVUnit=[nanmean(RtouchPW0_CV) nanmean(RtouchPW1_CV) nanmean(RtouchPW2_CV) nanmean(RtouchPW3_CV) nanmean(RtouchPW4_CV) nanmean(RtouchPW5_CV)...
%     ;[nanstd(RtouchPW0_CV) nanstd(RtouchPW1_CV) nanstd(RtouchPW2_CV) nanstd(RtouchPW3_CV) nanstd(RtouchPW4_CV) nanstd(RtouchPW5_CV)]];
% 


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
scatter(FRCVLPWTouches(:,2),FRCVLPWTouches(:,1));
xlabel('CV');
ylabel('FR');
figure
scatter(FRCVRPWTouches(:,2),FRCVRPWTouches(:,1));
xlabel('CV');
ylabel('FR');

FRCVLPWTouchesT5=[];
for i=1:length(FRCVLPWTouches)
    if FRCVLPWTouches(i,3)==5;
        FRCVLPWTouchesT5=[FRCVLPWTouchesT5;FRCVLPWTouches(i,:)];
    end
end


FRCVRPWTouchesT5=[];
for i=1:length(FRCVRPWTouches)
    if FRCVRPWTouches(i,3)==5;
        FRCVRPWTouchesT5=[FRCVRPWTouchesT5;FRCVRPWTouches(i,:)];
    end
end


figure
scatter(FRCVLPWTouchesT5(:,2),FRCVLPWTouchesT5(:,1));
xlabel('CV');
ylabel('FR');
figure
scatter(FRCVRPWTouchesT5(:,2),FRCVRPWTouchesT5(:,1));
xlabel('CV');
ylabel('FR');
