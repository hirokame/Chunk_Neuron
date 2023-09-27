function SpikeRhythm
%21行目にBreakPointを置いて使用する
close all;
clear all;

cd('C:\Users\kit\Desktop\WR_LVdata');
% dpath = uigetdir('C:\Users\kit\Desktop\WR LVdata');
[fname2,dpath] = uigetfile('*');%最初のファイルを指定

cd C:\Users\kit\Desktop\CheetahData
Spath=uigetdir;

eval(['fnameEV=''',Spath,'\Events.Nev''']);
[TimeStamps EventStrings Evt]=readEvents(fnameEV);

cd(Spath);
h1=ls;
for f=1:length(h1)
    TrimFile=strtrim(h1(f,:));
    if strcmp(TrimFile(end),'t')
        close all;
        SpName=TrimFile;
        eval(['filepath=''',Spath,'\',SpName,'''']);
        [spikes] = readTfile(filepath);
        
        cd('C:\Users\kit\Desktop\WR_LVdata');
        TrimStr1=strtrim(fname2);
        h=ls;
        disp('h=');
        disp(h);
        U=0;
        for n=1:length(h(:,1))
            TrimStr=strtrim(h(n,:));
            if length(TrimStr)>2 
            if strcmp(TrimStr(1:2),TrimStr1(1:2)) && strcmp(TrimStr(end-9:end),TrimStr1(end-9:end)) && strcmp(TrimStr(end-3:end),'.mat')
                load([dpath,TrimStr(1:end-4),'\',TrimStr]);%,'-ascii');
                
                %%%
                RpegPattern=cell(1,length(TurnMarkerTime)-1);
                LpegPattern=cell(1,length(TurnMarkerTime)-1);
                for n=1:length(TurnMarkerTime)-1
                    RpegPattern{n}=RpegTimeArray(RpegTimeArray>TurnMarkerTime(n) & RpegTimeArray<=TurnMarkerTime(n+1));
                    LpegPattern{n}=LpegTimeArray(LpegTimeArray>TurnMarkerTime(n) & LpegTimeArray<=TurnMarkerTime(n+1));
                end
                RPegTouchAll=[];LPegTouchAll=[];
                RpegTime=[];LpegTime=[];
                RpegTimeTurn=[];
                LpegTimeTurn=[];
                for k=1:length(TurnMarkerTime)-1
%                     if length(RpegPattern{k})==12 & length(LpegPattern{k})==12
                        SpikeA=[SpikeA SpikeArray(SpikeArray>TurnMarkerTime(k) & SpikeArray<=TurnMarkerTime(k+1))];
                        RPegTouchAllA=[RPegTouchAllA; RPegTouchAll(RPegTouchAll>TurnMarkerTime(k) & RPegTouchAll<=TurnMarkerTime(k+1))];
                        LPegTouchAllA=[LPegTouchAllA; LPegTouchAll(LPegTouchAll>TurnMarkerTime(k) & LPegTouchAll<=TurnMarkerTime(k+1))];
                        RpegTimeA=[RpegTimeA RpegTimeArray(RpegTimeArray>TurnMarkerTime(k) & RpegTimeArray<=TurnMarkerTime(k+1))];
                        LpegTimeA=[LpegTimeA LpegTimeArray(LpegTimeArray>TurnMarkerTime(k) & LpegTimeArray<=TurnMarkerTime(k+1))];
                        RpegTimeTurnA=[RpegTimeTurnA RpegTimeArray(RpegTimeArray>TurnMarkerTime(k) & RpegTimeArray<=TurnMarkerTime(k+1))-TurnMarkerTime(k)];
                        LpegTimeTurnA=[LpegTimeTurnA LpegTimeArray(LpegTimeArray>TurnMarkerTime(k) & LpegTimeArray<=TurnMarkerTime(k+1))-TurnMarkerTime(k)];
%                     elseif length(RpegPattern{k})==9 & length(LpegPattern{k})==9
%                         SpikeB=[SpikeB SpikeArray(SpikeArray>TurnMarkerTime(k) & SpikeArray<=TurnMarkerTime(k+1))];
%                         RPegTouchAllB=[RPegTouchAllB; RPegTouchAll(RPegTouchAll>TurnMarkerTime(k) & RPegTouchAll<=TurnMarkerTime(k+1))];
%                         LPegTouchAllB=[LPegTouchAllB; LPegTouchAll(LPegTouchAll>TurnMarkerTime(k) & LPegTouchAll<=TurnMarkerTime(k+1))];
%                         RpegTimeB=[RpegTimeB RpegTimeArray(RpegTimeArray>TurnMarkerTime(k) & RpegTimeArray<=TurnMarkerTime(k+1))];
%                         LpegTimeB=[LpegTimeB LpegTimeArray(LpegTimeArray>TurnMarkerTime(k) & LpegTimeArray<=TurnMarkerTime(k+1))];
%                         RpegTimeTurnB=[RpegTimeTurnB RpegTimeArray(RpegTimeArray>TurnMarkerTime(k) & RpegTimeArray<=TurnMarkerTime(k+1))-TurnMarkerTime(k)];
%                         LpegTimeTurnB=[LpegTimeTurnB LpegTimeArray(LpegTimeArray>TurnMarkerTime(k) & LpegTimeArray<=TurnMarkerTime(k+1))-TurnMarkerTime(k)];
%                     end
                end
                MedPegTimeRA=median(RpegTimeTurnA,2);
                MedPegTimeLA=median(LpegTimeTurnA,2);
                MedPegTimeRB=median(RpegTimeTurnB,2);
                MedPegTimeLB=median(LpegTimeTurnB,2);
                %%%
                
                SpikeArray=GetSpikeBehavior(spikes,TimeStamps, EventStrings, Evt,StartTime, FinishTime);

                bin=500;%bin=floor(duration/10);
                [AutoCo]=AutoCorr(SpikeArray',5000,0);
                ACresult=hist(AutoCo,500)/length(SpikeArray);
                ACresult=MovWindow(ACresult,5);
                figure
                subplot(2,2,1);
                plot(linspace(1,5000,bin),ACresult,'color','b');

                [CrossCoRtouch]=CrossCorr(RPegTouchAll,SpikeArray',5000,0,TurnMarkerTime);
                CCresultRtouch=hist(CrossCoRtouch,bin)/length(SpikeArray);
                CCresultRtouch=MovWindow(CCresultRtouch,5);
                [CrossCoLtouch]=CrossCorr(LPegTouchAll,SpikeArray',5000,0,TurnMarkerTime);
                CCresultLtouch=hist(CrossCoLtouch,bin)/length(SpikeArray);
                CCresultLtouch=MovWindow(CCresultLtouch,5);
        %         figure
                subplot(2,2,2);
                plot(linspace(1,5000,bin),CCresultRtouch,'color','g');hold on
                plot(linspace(1,5000,bin),CCresultLtouch,'color','r');
                xlabel('Touch/Spike');

                [CrossCoSpike]=CrossCorr(SpikeArray',TurnMarkerTime,OneTurnTime,0,TurnMarkerTime);
                CCresultSpike=hist(CrossCoSpike,floor(OneTurnTime/10))/length(TurnMarkerTime);
                CCresultSpike=MovWindow(CCresultSpike,5);
                [CrossCoRtouch2]=CrossCorr(RPegTouchAll,TurnMarkerTime,OneTurnTime,0,TurnMarkerTime);
                CCresultRtouch2=hist(CrossCoRtouch2,floor(OneTurnTime/10))/length(TurnMarkerTime);
                CCresultRtouch2=MovWindow(CCresultRtouch2,5);
                [CrossCoLtouch2]=CrossCorr(LPegTouchAll,TurnMarkerTime,OneTurnTime,0,TurnMarkerTime);
                CCresultLtouch2=hist(CrossCoLtouch2,floor(OneTurnTime/10))/length(TurnMarkerTime);
                CCresultLtouch2=MovWindow(CCresultLtouch2,5);
        %         figure
                subplot(2,2,3:4);
                plot(linspace(1,OneTurnTime,floor(OneTurnTime/10)),CCresultSpike,'color','k');hold on
                plot(linspace(1,OneTurnTime,floor(OneTurnTime/10)),CCresultRtouch2,'color','g');hold on
                plot(linspace(1,OneTurnTime,floor(OneTurnTime/10)),CCresultLtouch2,'color','r');

                Max=max([max(CCresultSpike),max(CCresultRtouch2),max(CCresultLtouch2)]);
                XR=floor(OneTurnTime*MedPegTimeR(1:end)/OneTurnTime);
                YR=ones(1,length(MedPegTimeR))'*Max*1.05;%0.85;
                XL=floor(OneTurnTime*MedPegTimeL(1:end)/OneTurnTime);
                YL=ones(1,length(MedPegTimeL))'*Max*1.13;%0.95;        
                text(XR,YR,'l','FontSize',10,'color',[0 1 0]);
                text(XL,YL,'l','FontSize',10,'color',[1 0 0]);
                title(h(n,:));
                axis([0 OneTurnTime 0 Max*1.2]);
        %         if ~isnan(Max);axis([0 OneTurnTime 0 Max*1.2]);end

        %         for n=1:length(MedPegTimeR)
        %             text(XR(n),YR(n)*1.06,int2str(n),'FontSize',12,'color',[0 1 0]);
        %         end
        %         for n=1:length(MedPegTimeL)
        %             text(XL(n),YL(n)*1.06,int2str(n),'FontSize',12,'color',[1 0 0]);
        %         end
                title([SpName,'  ',h(n,:),'  ',int2str(length(SpikeArray)),' spikes']);

            else disp('not a .t file');
            end
        end
    end
    end
end