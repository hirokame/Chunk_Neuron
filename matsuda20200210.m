function matsuda20200210
global CCresultRtouchWon CCresultLtouchWon RpegTouchallWon LpegTouchallWon SpikeArrayWon tfile pegpatternname trimFolder2 Spike_TouchRate TouchCount pegpatternum RLRcount LRLcount Spike Spike_Bin SpikeFR_Bin TouchCountW12345 SpikeFR_5Touch_Bin RLRLRcount LRLRLcount


%SpikeArrayでLPegTouchAll、RpegTouchallをアラインしたクロスコリオグラム
%SpikeArrayでLPegTouchAllをアラインする
duration=5000;
CrossCoL=[];
CrossCoR=[];
%両方向
for n=1:(length(SpikeArrayWon))
        Interval=LpegTouchallWon((LpegTouchallWon>SpikeArrayWon(n)-duration/2)&(SpikeArrayWon(n)>LpegTouchallWon-duration/2))-SpikeArrayWon(n);
        CrossCoL=[CrossCoL Interval];
end
    
CrossCoL=[-1*duration/2 CrossCoL duration/2];

CrossCoL(CrossCoL==0)=[];

bin=500;
% CCresultLtouchWonの更新に必要
CCresultLtouchWon=hist(CrossCoL,bin);
CCresultLtouchWon=CCresultLtouchWon/sum(CCresultLtouchWon);
CCresultLtouchWon=MovWindow(CCresultLtouchWon,10);

fig1=figure;
plot(linspace(1,5000,bin),CCresultLtouchWon,'color','r','LineWidth',2);
axis([0 5000 0 max(CCresultLtouchWon)*1.1]);

trimtfile=strtrim(tfile);
figname=['Left',trimFolder2,trimtfile,pegpatternum,pegpatternname,'.bmp'];
saveas(fig1,figname);
close(fig1);
%SpikeArrayでRPegTouchAllをアラインする
for n=1:(length(SpikeArrayWon))
        Interval=RpegTouchallWon((RpegTouchallWon>SpikeArrayWon(n)-duration/2)&(SpikeArrayWon(n)>RpegTouchallWon-duration/2))-SpikeArrayWon(n);
        CrossCoR=[CrossCoR Interval];
end
    
CrossCoR=[-1*duration/2 CrossCoR duration/2];

CrossCoR(CrossCoR==0)=[];
% CCresultRtouchWonの更新に必要
CCresultRtouchWon=hist(CrossCoR,bin);
CCresultRtouchWon=CCresultRtouchWon/sum(CCresultRtouchWon);
CCresultRtouchWon=MovWindow(CCresultRtouchWon,10);

fig2=figure;
plot(linspace(1,5000,bin),CCresultRtouchWon,'color','b','LineWidth',2);
axis([0 5000 0 max(CCresultLtouchWon)*1.1]);

trimtfile=strtrim(tfile);
figname=['Right',trimFolder2,trimtfile,pegpatternum,pegpatternname,'.bmp'];
saveas(fig2,figname);
close(fig2);