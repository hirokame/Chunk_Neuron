function MakeDistribution20200227
%%%%%%%%%分布のfigureを作るfunction 

% global W3distanceArray LtWindowintervaLArray RtWindowintervaLArray




path=['C:\Users\C238\Desktop\touchcellLtRt_terashita'];
cd(path);

LS=ls;

IntervalPhaseUnit=[];

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
               
               LtouchWindowPeak
               RtouchWindowPeak
               
               %%%%%Ltouchのピークを正負に分ける
               LeftLtouchWindowPeak=LtouchWindowPeak(LtouchWindowPeak<0);
               RightLtouchWindowPeak=LtouchWindowPeak(LtouchWindowPeak>0);
               
               LeftLtPeak=max(LeftLtouchWindowPeak);
               RightLtPeak=min(RightLtouchWindowPeak);
               
              %%%%%Ltouchのインターバルを計算
              LtouchInterval=abs(RightLtPeak-LeftLtPeak);
               
              %%%%%Ltouch の位相を計算（左から数える）
              Ltouchphase=abs(0-LeftLtPeak)/abs(RightLtPeak-LeftLtPeak);
              
               %%%%%Rtouchのピークを正負に分ける
               LeftRtouchWindowPeak=RtouchWindowPeak(RtouchWindowPeak<0);
               RightRtouchWindowPeak=RtouchWindowPeak(RtouchWindowPeak>0);
               
               LeftRtPeak=max(LeftRtouchWindowPeak);
               RightRtPeak=min(RightRtouchWindowPeak);
               
               %%%%%Rtouchのインターバルを計算
               RtouchInterval=abs(RightRtPeak-LeftRtPeak);
               
               %%%%%Rtouch の位相を計算（左から数える）
               Rtouchphase=abs(0-LeftRtPeak)/abs(RightRtPeak-LeftRtPeak);
               
               
               %%%%%左足の中の右足の位相（左右差）
               RtPeakinLt=RtouchWindowPeak(RtouchWindowPeak>LeftLtPeak & RtouchWindowPeak<RightLtPeak);
               RtPhaseinLt=abs(RtPeakinLt-LeftLtPeak)/abs(RightLtPeak-LeftLtPeak);
               
               
               
               %%%%左右のインターバル、左右の位相、左右差（5要素）を保存
               Array=[LtouchInterval Ltouchphase RtouchInterval Rtouchphase RtPhaseinLt];
               if length(Array)==5;
               IntervalPhaseUnit=[IntervalPhaseUnit;Array];
               end
           end
           
              
       end
    end
end


%%%%%LtouchInterval
figure
histogram(IntervalPhaseUnit(:,1));
title('LtouchInterval');
%%%%LtouchPahse
figure
histogram(IntervalPhaseUnit(:,2));
title('LtouchPahse');
%%%%%%%RtouchInterval
figure
histogram(IntervalPhaseUnit(:,3));
title('RtouchInterval');

%%%%%%RtouchPhase
figure
histogram(IntervalPhaseUnit(:,4));
title('RtouchPhase');

%%%%RtPhaseinLt
figure
histogram(IntervalPhaseUnit(:,5));
title('RtPhaseinLt');
















% W3distanceFig=figure;
% histogram(W3distanceArray);
% title('RLW3distance');
% 
% LtWindowintervaLFig=figure;
% histogram(LtWindowintervaLArray)
% title('LtouchInterval_AllCell');
% 
% RtWindowintervaLFig=figure;
% histogram(RtWindowintervaLArray)
% title('RtouchInterval_AllCell');
% 
% 
% 
% cd('C:\Users\C238\Desktop\touchcellLtRt_terashita');
% figname1=['RLW3distance.bmp'];
% figname2=['LtouchInterval_AllCell.bmp'];
% figname3=['RtouchInterval_AllCell.bmp'];
% 
% saveas(W3distanceFig,figname1);
% saveas(LtWindowintervaLFig,figname2);
% saveas(RtWindowintervaLFig,figname3);