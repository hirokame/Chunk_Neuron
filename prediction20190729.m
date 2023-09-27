function prediction20190729
%予測値と実測値のピークのX軸方向のずれと包絡線のJSDを計算する

global EnveRLPhaseTM EnveCCresultSpikePro tfile meanXaxiserror Envedist


meanXaxiserror=NaN;
Envedist=NaN;


nanEnveRLTM=isnan(EnveRLPhaseTM);
K=find(nanEnveRLTM==1);
if length(K)<100;                                                             %%%%%%%%%%%%%%%%%%      
[pksRL locsRL]=findpeaks(EnveRLPhaseTM,'Minpeakdistance',40);
[pksCC locsCC]=findpeaks(EnveCCresultSpikePro,'Minpeakdistance',40);
ArrayRL=[];
ErrorArray=[];
for j=1:length(locsCC);
    S=locsRL-locsCC(j);
    [minS indexS]=min(abs(S));
    ArrayRL=[ArrayRL locsRL(indexS)];
    ErrorArray=[ErrorArray minS];
end

pksRL=EnveCCresultSpikePro(ArrayRL);

% locsPeakdiff=ArrayRL-locsCC;
meanXaxiserror=mean(ErrorArray);

figure
findpeaks(EnveRLPhaseTM,'Minpeakdistance',40);
close;
figure
findpeaks(EnveCCresultSpikePro,'Minpeakdistance',40);
close;
figure
plot(linspace(0,1,length(pksRL)),pksRL,'color','b');hold on
plot(linspace(0,1,length(pksCC)),pksCC,'color','r');
close;
if length(pksRL)==length(pksCC) & pksRL~=0 & pksCC~=0;
   Envedist=JSDiv(pksRL,pksCC);
   
else
    Envedist=NaN;
end
% DistributionArrayRL=[];
% for i=1:length(locsCC)
%     Start=locsCC(i)-20;
%     End=locsCC(i)+20;
%     if locsCC(i)-20<=0
%         Distribution=EnveRLPhaseTM(1:End);
%        Distribution=[zeros(1,(41-length(Distribution))) Distribution];
%     elseif locsCC(i)+20>=length(EnveRLPhaseTM);
%         Distribution=EnveRLPhaseTM(Start:length(EnveRLPhaseTM));
%         Distribution=[Distribution zeros(1,(41-length(Distribution)))];
%     else
%         Distribution=EnveRLPhaseTM(Start:End);
%     end
%     DistributionArrayRL=[DistributionArrayRL;Distribution];
% end
% DistributionArrayRL
% 
% DistributionArrayCC=[];
% for i=1:length(locsCC)
%     Start=locsCC(i)-20;
%     End=locsCC(i)+20;
%     if locsCC(i)-20<=0;
%         Distribution=EnveCCresultSpikePro(1:End);
%        Distribution=[zeros(1,(41-length(Distribution))) Distribution];
%     elseif locsCC(i)+20>=length(EnveCCresultSpikePro);
%         Distribution=EnveCCresultSpikePro(Start:length(EnveCCresultSpikePro));
%         Distribution=[Distribution zeros(1,(41-length(Distribution)))];
%     else
%         Distribution=EnveCCresultSpikePro(Start:End);
%     end
%     DistributionArrayCC=[DistributionArrayCC;Distribution];
% end
% DistributionArrayCC
% distArray=[];
% 
% for i=1:length(DistributionArrayRL(:,1))
%    dist=KLDiv(DistributionArrayRL(i,:),DistributionArrayCC(i,:));
%    distArray=[distArray dist];
% end
% for i=1:length(distArray)
%     if distArray(i)==Inf 
%         distArray(i)=0;
%     end
% end
% 
% Old2=cd;
% cd('C:\Users\C238\Desktop\CheetahWRLV20180729\119\2017-6-7_20-8-33 11901-51\11931_170607_98__')
% FLNAME=[strtrim(tfile),'touchfile.mat'];
% load(FLNAME,'RpegTouchallWon98','LpegTouchallWon98','TurnMarkerTime98','OneTurnTime98','FinishTime98','SpikeArray98');
% meandist=mean(distArray);
% indexmean=find(distArray>meandist);
% figure
% for k=1:length(indexmean)
%     p=area([(locsCC(indexmean(k))-20)*8 (locsCC(indexmean(k))+20)*8],[max(max(EnveRLPhaseTM),max(EnveCCresultSpikePro)) max(max(EnveRLPhaseTM),max(EnveCCresultSpikePro))]);hold on
%    p.FaceColor = [0 0.75 0.75];
% 
% end
% 
% plot(linspace(0,OneTurnTime98*2,length(EnveRLPhaseTM)),EnveRLPhaseTM,'color','b');hold on 
% plot(linspace(0,OneTurnTime98*2,length(EnveCCresultSpikePro)),EnveCCresultSpikePro,'color','r');hold on 
% if max(EnveRLPhaseTM)>0;
% axis([0 OneTurnTime98*2 0 max(max(EnveRLPhaseTM),max(EnveCCresultSpikePro))*1.1]);
% end
% meandist=mean(distArray);
% indexmean=find(distArray>meandist);
% 
% % for k=1:length(indexmean)
% %     p=area([(locsCC(indexmean(k))-20)*8 (locsCC(indexmean(k))+20)*8],[max(max(EnveRLPhaseTM),max(EnveCCresultSpikePro)) max(max(EnveRLPhaseTM),max(EnveCCresultSpikePro))]);
% %     set(p,'FaceAlpha',0.1);
% % 
% % end
% cd(Old2);
% close;
end