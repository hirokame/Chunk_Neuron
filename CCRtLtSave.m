function CCRtLtSave

global CCresultRtouchWon CCresultLtouchWon RpegTouchallWon LpegTouchallWon SpikeArrayWon



%SpikeArray��LPegTouchAll�ARpegTouchall���A���C�������N���X�R���I�O����
%SpikeArray��LPegTouchAll���A���C������
duration=5000;
CrossCoL=[];
CrossCoR=[];
%������
for n=1:(length(SpikeArrayWon))
        Interval=LpegTouchallWon((LpegTouchallWon>SpikeArrayWon(n)-duration/2)&(SpikeArrayWon(n)>LpegTouchallWon-duration/2))-SpikeArrayWon(n);
        CrossCoL=[CrossCoL Interval];
end
    
CrossCoL=[-1*duration/2 CrossCoL duration/2];

CrossCoL(CrossCoL==0)=[];

bin=500;
% CCresultLtouchWon�̍X�V�ɕK�v
CCresultLtouchWon=hist(CrossCoL,bin);
CCresultLtouchWon=CCresultLtouchWon/sum(CCresultLtouchWon);
CCresultLtouchWon=MovWindow(CCresultLtouchWon,10);

% fig1=figure;
% subplot(2,2,[1,2]);
% plot(linspace(1,5000,bin),CCresultLtouchWon,'color','r','LineWidth',2);
% axis([0 5000 0 max(CCresultLtouchWon)*1.1]);
% hold on
%SpikeArray��RPegTouchAll���A���C������
for n=1:(length(SpikeArrayWon))
        Interval=RpegTouchallWon((RpegTouchallWon>SpikeArrayWon(n)-duration/2)&(SpikeArrayWon(n)>RpegTouchallWon-duration/2))-SpikeArrayWon(n);
        CrossCoR=[CrossCoR Interval];
end
    
CrossCoR=[-1*duration/2 CrossCoR duration/2];

CrossCoR(CrossCoR==0)=[];
% CCresultRtouchWon�̍X�V�ɕK�v
CCresultRtouchWon=hist(CrossCoR,bin);
CCresultRtouchWon=CCresultRtouchWon/sum(CCresultRtouchWon);
CCresultRtouchWon=MovWindow(CCresultRtouchWon,10);

% plot(linspace(1,5000,bin),CCresultRtouchWon,'color','b','LineWidth',2);
% axis([0 5000 0 max(CCresultLtouchWon)*1.1]);
% hold off