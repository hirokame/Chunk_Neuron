function Peak_Variance_ALLTouch_20200303

path=['C:\Users\C238\Desktop\touchcellLtRt_terashita'];
cd(path);

LS=ls;
Seq5LtouchTime=[];
Seq5RtouchTime=[];

MeanCVLtouchArrayArray=[];
MeanRandomCVLtouchArrayArray=[];
MeanCVRtouchArrayArray=[];
MeanRandomCVRtouchArrayArray=[];

CVLtouchPeakArray=[];
CVRtouchPeakArray=[];

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
               
              %%%%%%%%%%%%%%%%%Ltouch%%%%%%%%%%%%%%%%%%%%%%%%%%% 
               random5seqUnitLtouch=[];
               random5seqUnitRtouch=[];
               CVLtouchArray=[];
               RandomCVLtouchArray=[];
               CVRtouchArray=[];
               RandomCVRtouchArray=[];
               Random5seqSetLtouch=[];
               Random5seqSetRtouch=[];
               
               
               WindowIntervalLtouch=abs(LPWS(1)-LPWE(end));
               WindowIntervalRtouch=abs(RPWS(1)-RPWE(end));
               
              for x=1:length(LtouchPosiNegaTimeUnit(:,1))
                  IndexPositive=find(LtouchPosiNegaTimeUnit(x,(2:6))~=0);
                  IndexNegative=find(LtouchPosiNegaTimeUnit(x,(7:10))~=0);
                  if length(IndexPositive)==5 && length(IndexNegative)==0;
                     Seq5LtouchTime=[Seq5LtouchTime;LtouchPosiNegaTimeUnit(x,(2:10))];
                  end
              end
              
              Seq5LtouchTimeunique=unique(Seq5LtouchTime,'rows');
              
              for n=1:length(LpegTouchallWon)-5
                  if LpegTouchallWon(n+4)-LpegTouchallWon(n)<WindowIntervalLtouch*10
                     Random5seqSetLtouch=[Random5seqSetLtouch;LpegTouchallWon(n:n+4)];     %%%%%%%LpegTouchallWonの中から条件に合う5連続タッチを抜き出す
                  end
              end
              %%%%%%%Random5seqSetの中からSeq5LtouchTimeuniqueの同じ数の4歩をランダムに抜き出す
              randomIndex= randi([1 length(Random5seqSetLtouch(:,1))],1,length(Seq5LtouchTimeunique(:,1)));   
              
              for n=1:length(randomIndex)
                  Array=Random5seqSetLtouch(randomIndex(n),:);
                  random5seqUnitLtouch=[random5seqUnitLtouch;Array];
              end
              
             for n=1:length(Seq5LtouchTimeunique(:,1))
                CVLtouch=std(diff(Seq5LtouchTimeunique(n,(1:5))))/mean(diff(Seq5LtouchTimeunique(n,(1:5))));
                CVLtouchArray=[CVLtouchArray CVLtouch];
                
                RandomCVLtouch=std(diff(random5seqUnitLtouch(n,:)))/mean(diff(random5seqUnitLtouch(n,:)));
                RandomCVLtouchArray=[RandomCVLtouchArray RandomCVLtouch];
             end
              
             MeanCVLtouchArray=mean(CVLtouchArray);
             MeanRandomCVLtouchArray=mean(RandomCVLtouchArray);
             
%              figure
%              bar([MeanCVLtouchArray MeanRandomCVLtouchArray],0.5);
              MeanCVLtouchArrayArray=[MeanCVLtouchArrayArray MeanCVLtouchArray];
              MeanRandomCVLtouchArrayArray=[MeanRandomCVLtouchArrayArray MeanRandomCVLtouchArray];
              
              
              %%%%%%%%%%%%%%%%%%%%%%%Rtouch%%%%%%%%%%%%%%%%%%%%%%%%
               for x=1:length(RtouchPosiNegaTimeUnit(:,1))
                  IndexPositive=find(RtouchPosiNegaTimeUnit(x,(2:6))~=0);
                  IndexNegative=find(RtouchPosiNegaTimeUnit(x,(7:10))~=0);
                  if length(IndexPositive)==5 && length(IndexNegative)==0;
                     Seq5RtouchTime=[Seq5RtouchTime;RtouchPosiNegaTimeUnit(x,(2:10))];
                  end
              end
              
               Seq5RtouchTimeunique=unique(Seq5RtouchTime,'rows');
              
               
              for n=1:length(RpegTouchallWon)-5
                  if RpegTouchallWon(n+4)-RpegTouchallWon(n)<WindowIntervalRtouch*10
                     Random5seqSetRtouch=[Random5seqSetRtouch;RpegTouchallWon(n:n+4)];     %%%%%%%LpegTouchallWonの中から条件に合う5連続タッチを抜き出す
                  end
              end
              %%%%%%%Random5seqSetの中からSeq5LtouchTimeuniqueの同じ数の5歩をランダムに抜き出す
              randomIndex= randi([1 length(Random5seqSetRtouch(:,1))],1,length(Seq5RtouchTimeunique(:,1)));   
              
              for n=1:length(randomIndex)
                  Array=Random5seqSetRtouch(randomIndex(n),:);
                  random5seqUnitRtouch=[random5seqUnitRtouch;Array];
              end
              
             for n=1:length(Seq5RtouchTimeunique(:,1))
                CVRtouch=std(diff(Seq5RtouchTimeunique(n,(1:5))))/mean(diff(Seq5RtouchTimeunique(n,(1:5))));
                CVRtouchArray=[CVRtouchArray CVRtouch];
                
                RandomCVRtouch=std(diff(random5seqUnitRtouch(n,:)))/mean(diff(random5seqUnitRtouch(n,:)));
                RandomCVRtouchArray=[RandomCVRtouchArray RandomCVRtouch];
             end
              
             MeanCVRtouchArray=mean(CVRtouchArray);
             MeanRandomCVRtouchArray=mean(RandomCVRtouchArray);
             
%              figure
%              bar([MeanCVRtouchArray MeanRandomCVRtouchArray],0.5);
              MeanCVRtouchArrayArray=[MeanCVRtouchArrayArray MeanCVRtouchArray];
              MeanRandomCVRtouchArrayArray=[MeanRandomCVRtouchArrayArray MeanRandomCVRtouchArray];
              
              %%%%%%%%CCのピーク間インターバルのCVの計算
              
             DiffLtouchPeak=diff(LtouchWindowPeak);
             DiffRtouchPeak=diff(RtouchWindowPeak);
             CVLtouchPeak=std(DiffLtouchPeak)/mean(DiffLtouchPeak);
             CVRtouchPeak=std(DiffRtouchPeak)/mean(DiffRtouchPeak);
             
             CVLtouchPeakArray=[CVLtouchPeakArray CVLtouchPeak];
             CVRtouchPeakArray=[CVRtouchPeakArray CVRtouchPeak];
           end   
       end
    end
end

% Seq5LtouchTimeunique=unique(Seq5LtouchTime,'rows');
% 
% Seq5RtouchTimeunique=unique(Seq5RtouchTime,'rows');
% % 
% for x=1:length(Seq5LtouchTime)-1
%     if Seq5LtouchTime(x,:)==Seq5LtouchTime(x+1,:)
%         SameRows=[SameRows x];
%     end
% end


MeanMeanCVLtouchArrayArray=mean(MeanCVLtouchArrayArray);
StdMeanCVLtouchArrayArray=std(MeanCVLtouchArrayArray)/sqrt(length(MeanCVLtouchArrayArray));

MeanMeanRandomCVLtouchArrayArray=mean(MeanRandomCVLtouchArrayArray);
StdMeanRandomCVLtouchArrayArray=std(MeanRandomCVLtouchArrayArray)/sqrt(length(MeanRandomCVLtouchArrayArray));

MeanMeanCVRtouchArrayArray=mean(MeanCVRtouchArrayArray);
StdMeanCVRtouchArrayArray=std(MeanCVRtouchArrayArray)/sqrt(length(MeanCVRtouchArrayArray));

MeanMeanRandomCVRtouchArrayArray=mean(MeanRandomCVRtouchArrayArray);
StdMeanRandomCVRtouchArrayArray=std(MeanRandomCVRtouchArrayArray)/sqrt(length(MeanRandomCVRtouchArrayArray));


MeanCVLtouchPeakArray=mean(CVLtouchPeakArray);
StdCVLtouchPeakArray=std(CVLtouchPeakArray)/sqrt(length(CVLtouchPeakArray));
MeanCVRtouchPeakArray=mean(CVRtouchPeakArray);
StdCVRtouchPeakArray=std(CVRtouchPeakArray)/sqrt(length(CVRtouchPeakArray));

x=1:3;
figure
bar(x,[MeanCVLtouchPeakArray MeanMeanCVLtouchArrayArray MeanMeanRandomCVLtouchArrayArray],0.5);hold on
errorbar(x,[MeanCVLtouchPeakArray MeanMeanCVLtouchArrayArray MeanMeanRandomCVLtouchArrayArray],[ StdCVLtouchPeakArray StdMeanCVLtouchArrayArray StdMeanRandomCVLtouchArrayArray],'o','MarkerSize',0.2);
set(gca,'xticklabel',{'PeakCV','CVLtouch','RandomCV'});

figure
bar(x,[MeanCVRtouchPeakArray MeanMeanCVRtouchArrayArray MeanMeanRandomCVRtouchArrayArray],0.5);hold on
errorbar(x,[MeanCVRtouchPeakArray MeanMeanCVRtouchArrayArray MeanMeanRandomCVRtouchArrayArray],[StdCVRtouchPeakArray StdMeanCVRtouchArrayArray StdMeanRandomCVRtouchArrayArray],'o','MarkerSize',0.2);
set(gca,'xticklabel',{'PeakCV','CVRtouch','RandomCV'});

cd(path);
filename=['CV_3Patterns.mat'];
save(filename,'MeanCVLtouchPeakArray','MeanMeanCVLtouchArrayArray','MeanMeanRandomCVLtouchArrayArray'...
    ,'StdCVLtouchPeakArray','StdMeanCVLtouchArrayArray','StdMeanRandomCVLtouchArrayArray'...
    ,'MeanCVRtouchPeakArray','MeanMeanCVRtouchArrayArray','MeanMeanRandomCVRtouchArrayArray'...
    ,'StdCVRtouchPeakArray','StdMeanCVRtouchArrayArray','StdMeanRandomCVRtouchArrayArray');

% Seq5LtouchTimeunique
% Seq5RtouchTimeunique