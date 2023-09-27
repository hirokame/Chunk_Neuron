function Repeat3touch_pre
global CCresultRtouchWon CCresultLtouchWon RpegTouchallWon LpegTouchallWon SpikeArrayWon tfile pegpatternname trimFolder2 Spike_TouchRate TouchCount pegpatternum RLRcount LRLcount Spike Spike_Bin SpikeFR_Bin


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

fig1=figure;
subplot(2,2,[1,2]);
plot(linspace(1,5000,bin),CCresultLtouchWon,'color','r','LineWidth',2);
axis([0 5000 0 max(CCresultLtouchWon)*1.1]);
hold on
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

plot(linspace(1,5000,bin),CCresultRtouchWon,'color','b','LineWidth',2);
axis([0 5000 0 max(CCresultLtouchWon)*1.1]);
hold off
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% RpegTouchallWon
% LpegTouchallWon


% �N���X�R���I�O��������s�[�N�����o
subplot(2,2,3);
% findpeaks(CCresultLtouchWon,'MinPeakDistance',20);
[Lpks,Llocs,Lwidth,Lproms]=findpeaks(CCresultLtouchWon,'MinPeakDistance',25);
findpeaks(CCresultLtouchWon,'MinPeakDistance',25);
LlocsInterval=Llocs-250;
LlocsInterval1=LlocsInterval(LlocsInterval>=0);
Linterval1=sort(abs(LlocsInterval1),'ascend');
LlocsInterval2=LlocsInterval(LlocsInterval<0);
Linterval2=sort(LlocsInterval2,'descend');
subplot(2,2,4);
% findpeaks(CCresultRtouchWon,'MinPeakDistance',20);
[Rpks,Rlocs,Rwidth,Rproms]=findpeaks(CCresultRtouchWon,'MinPeakDistance',25);
findpeaks(CCresultRtouchWon,'MinPeakDistance',25);
RlocsInterval=Rlocs-250;
RlocsInterval1=RlocsInterval(RlocsInterval>=0);
Rinterval1=sort(abs(RlocsInterval1),'ascend');
RlocsInterval2=RlocsInterval(RlocsInterval<0);
Rinterval2=sort(RlocsInterval2,'descend');
TouchArray=[LlocsInterval,RlocsInterval];
TouchArray1=sort(abs(TouchArray),'ascend');
% 
if length(Linterval1)>2 && length(Linterval2)>2 && length(Rinterval1)>2 && length(Rinterval2)>2;  

LWindowS1=Linterval2(1)*10-90;
LWindowE1=Linterval2(1)*10+90;
LWindowS2=Linterval1(1)*10-90;
LWindowE2=Linterval1(1)*10+90;

RWindowS1=Rinterval2(1)*10-90;
RWindowE1=Rinterval2(1)*10+90;
RWindowS2=Rinterval1(1)*10-90;
RWindowE2=Rinterval1(1)*10+90;

SpikeWindowS=-20;
SpikeWindowE=20;

trimtfile=strtrim(tfile);
figname=[trimFolder2,trimtfile,pegpatternum,pegpatternname,'.bmp'];
saveas(fig1,figname);
close(fig1);
%     for p=1:(length(RlocsInterval))    
%         for q=1:(length(RlocsInterval))
%             for r=1:(length(LlocsInterval))
Spike_Touch=[];
Spike_TouchRate=[];
Spike=[];
Spike_Bin=[];
SpikeFR_Bin=[];
RLRcount=0;
LRLcount=0;
    if Rinterval2(1) < Linterval2(1) && Linterval2(1) < Rinterval1(1) && Rinterval1(1) < Linterval1(1) && abs(Rinterval2(1)) < abs(Linterval1(1)) % �E�C���h�ERLR�̏�
        
        RLRcount=1;
        
        windowS1=RWindowS1;
        windowE1=RWindowE1;
        windowS2=LWindowS1;
        windowE2=LWindowE1;
        windowS3=RWindowS2;
        windowE3=RWindowE2;
            %
            %
        CountW0=0;
        CountW1=0;
        CountW2=0;
        CountW3=0;
        CountW12=0;
        CountW13=0;
        CountW23=0;
        CountW123=0;
        
        %�S�ẴX�p�C�N���ׂāA�E�C���h�E�Ƀ^�b�`�����Ă͂܂������̔��Εp�x�𒲂ׂ�
        for n=1:(length(SpikeArrayWon))
            W1=0;
            W2=0;
            W3=0;
            W1TouchTime=[];
            W2TouchTime=[];
            W3TouchTime=[];
            for i=1:(length(RpegTouchallWon))
                if  RpegTouchallWon(i)>SpikeArrayWon(n)+windowS1&SpikeArrayWon(n)+windowE1>RpegTouchallWon(i)
                    W1=1;
                    W1TouchTime=[W1TouchTime RpegTouchallWon(i)];
                end
                if  RpegTouchallWon(i)>SpikeArrayWon(n)+windowS3&SpikeArrayWon(n)+windowE3>RpegTouchallWon(i) 
                    W3=1;
                    W3TouchTime=[W3TouchTime RpegTouchallWon(i)];
                end
            end
            for j=1:(length(LpegTouchallWon))
                if  LpegTouchallWon(j)>SpikeArrayWon(n)+windowS2&SpikeArrayWon(n)+windowE2>LpegTouchallWon(j)
                    W2=1;
                    W2TouchTime=[W2TouchTime LpegTouchallWon(j)];
                end
            end
            if length(W1TouchTime)<2 && length(W2TouchTime)<2 && length(W3TouchTime)<2
                    if W1==0 & W2==0 & W3==0
                        CountW0=CountW0+1;
                    end
                    if W1==1 & W2==0 & W3==0
                        CountW1=CountW1+1;
                    end
                    if W1==0 & W2==1 & W3==0
                        CountW2=CountW2+1;
                    end
                    if W1==0 & W2==0 & W3==1
                        CountW3=CountW3+1;
                    end
                if length(W1TouchTime)==1 && length(W2TouchTime)==1 && W1TouchTime(1)<W2TouchTime(1)
                    if W1==1 & W2==1 & W3==0
                        CountW12=CountW12+1;
                    end
                end
                    if W1==1 & W2==0 & W3==1
                        CountW13=CountW13+1;
                    end
                if length(W2TouchTime)==1 && length(W3TouchTime)==1 && W2TouchTime(1)<W3TouchTime(1)
                    if W1==0 & W2==1 & W3==1
                        CountW23=CountW23+1;
                    end
                end
                if length(W1TouchTime)==1 && length(W2TouchTime)==1 && length(W3TouchTime)==1 && W1TouchTime(1)<W2TouchTime(1) && W2TouchTime(1)<W3TouchTime(1)
                    if W1==1 & W2==1 & W3==1
                        CountW123=CountW123+1;
                    end
                end
            end
        end
%         fig2=figure;
%         TouchCount=[TouchCountW0,TouchCountW1,TouchCountW2,TouchCountW3,TouchCountW12,TouchCountW123,TouchCountW13,TouchCountW23];
%         bar(TouchCount)
%         set(gca,'xticklabel',{'no','1','2','3','12','123','13','23'});
%         trimtfile=strtrim(tfile);
% %         �E�C���h�E�ɂǂꂾ���^�b�`���Ă͂܂������̖_�O���t
%         figname=['Repeat3TouchCountRLR',trimFolder2,trimtfile,pegpatternum,pegpatternname,'.bmp'];
%         saveas(fig2,figname);
%         close(fig2);  
%         �E�C���h�E�Ƀ^�b�`���Ă͂܂������̔��Ή�
        W123=[CountW0,CountW1,CountW2,CountW3,CountW12,CountW123,CountW13,CountW23];
        fig3=figure;
        subplot(3,1,1);
        bar(W123)
        set(gca,'xticklabel',{'no','1','2','3','12','123','13','23'});
        
        subplot(3,1,2);
        %�E�C���h�E���Ă͂܂����r�����ɁA�^�b�`���Ă͂܂����񐔂Ŋ���B���̃r���Ɉ�񓖂Ă͂܂������̔��Ή�
        for n=1:length(W123)
            if TouchCount(n)~=0;
                Spike_Touch=[Spike_Touch W123(n)/TouchCount(n)];
            else
                Spike_Touch=[Spike_Touch TouchCount(n)];
            end
        end
        %���r���ɓ��Ă͂܂������̑S�̂̔��Ή񐔂ɑ΂��銄��
        for n=1:length(W123)
            if Spike_Touch(n)~=0;
                Spike_TouchRate=[Spike_TouchRate Spike_Touch(n)/sum(Spike_Touch)];
            else
                Spike_TouchRate=[Spike_TouchRate Spike_Touch(n)];
            end
        end
        bar(Spike_Touch)
        set(gca,'xticklabel',{'no','1','2','3','12','123','13','23'});
        % xlabel('no L1 L2 R1 L1L2 L1R1 L2R1 L1L2R1')
        subplot(3,1,3);
        bar(Spike_TouchRate)
        set(gca,'xticklabel',{'no','1','2','3','12','123','13','23'});
        trimtfile=strtrim(tfile);
        figname=['Repeat3touchRLR_pre',trimFolder2,trimtfile,pegpatternum,pegpatternname,'.bmp'];
        saveas(fig3,figname);
        close(fig3);  
        %
        
    elseif Linterval2(1) < Rinterval2(1) && Rinterval2(1) < Linterval1(1) && Linterval1(1) < Rinterval1(1) && abs(Linterval2(1)) > abs(Rinterval1(1)) % �E�C���h�ERLR�̏�    
        
        RLRcount=1;
        
        windowS1=RWindowS1;
        windowE1=RWindowE1;
        windowS2=LWindowS2;
        windowE2=LWindowE2;
        windowS3=RWindowS2;
        windowE3=RWindowE2;
            %
            %
        CountW0=0;
        CountW1=0;
        CountW2=0;
        CountW3=0;
        CountW12=0;
        CountW13=0;
        CountW23=0;
        CountW123=0;
        
        %�S�ẴX�p�C�N���ׂāA�E�C���h�E�Ƀ^�b�`�����Ă͂܂������̔��Εp�x�𒲂ׂ�
        for n=1:(length(SpikeArrayWon))
            W1=0;
            W2=0;
            W3=0;
            W1TouchTime=[];
            W2TouchTime=[];
            W3TouchTime=[];
            for i=1:(length(RpegTouchallWon))
                if  RpegTouchallWon(i)>SpikeArrayWon(n)+windowS1&SpikeArrayWon(n)+windowE1>RpegTouchallWon(i)
                    W1=1;
                    W1TouchTime=[W1TouchTime RpegTouchallWon(i)];
                end
                if  RpegTouchallWon(i)>SpikeArrayWon(n)+windowS3&SpikeArrayWon(n)+windowE3>RpegTouchallWon(i) 
                    W3=1;
                    W3TouchTime=[W3TouchTime RpegTouchallWon(i)];
                end
            end
            for j=1:(length(LpegTouchallWon))
                if  LpegTouchallWon(j)>SpikeArrayWon(n)+windowS2&SpikeArrayWon(n)+windowE2>LpegTouchallWon(j)
                    W2=1;
                    W2TouchTime=[W2TouchTime LpegTouchallWon(j)];
                end
            end
            if length(W1TouchTime)<2 && length(W2TouchTime)<2 && length(W3TouchTime)<2
                    if W1==0 & W2==0 & W3==0
                        CountW0=CountW0+1;
                    end
                    if W1==1 & W2==0 & W3==0
                        CountW1=CountW1+1;
                    end
                    if W1==0 & W2==1 & W3==0
                        CountW2=CountW2+1;
                    end
                    if W1==0 & W2==0 & W3==1
                        CountW3=CountW3+1;
                    end
                if length(W1TouchTime)==1 && length(W2TouchTime)==1 && W1TouchTime(1)<W2TouchTime(1)
                    if W1==1 & W2==1 & W3==0
                        CountW12=CountW12+1;
                    end
                end
                    if W1==1 & W2==0 & W3==1
                        CountW13=CountW13+1;
                    end
                if length(W2TouchTime)==1 && length(W3TouchTime)==1 && W2TouchTime(1)<W3TouchTime(1)
                    if W1==0 & W2==1 & W3==1
                        CountW23=CountW23+1;
                    end
                end
                if length(W1TouchTime)==1 && length(W2TouchTime)==1 && length(W3TouchTime)==1 && W1TouchTime(1)<W2TouchTime(1) && W2TouchTime(1)<W3TouchTime(1)
                    if W1==1 & W2==1 & W3==1
                        CountW123=CountW123+1;
                    end
                end
            end
        end
%         fig2=figure;
%         TouchCount=[TouchCountW0,TouchCountW1,TouchCountW2,TouchCountW3,TouchCountW12,TouchCountW123,TouchCountW13,TouchCountW23];
%         bar(TouchCount)
%         set(gca,'xticklabel',{'no','1','2','3','12','123','13','23'});
%         trimtfile=strtrim(tfile);
% %         �E�C���h�E�ɂǂꂾ���^�b�`���Ă͂܂������̖_�O���t
%         figname=['Repeat3TouchCountRLR',trimFolder2,trimtfile,pegpatternum,pegpatternname,'.bmp'];
%         saveas(fig2,figname);
%         close(fig2);  
%         �E�C���h�E�Ƀ^�b�`���Ă͂܂������̔��Ή�
        W123=[CountW0,CountW1,CountW2,CountW3,CountW12,CountW123,CountW13,CountW23];
        fig3=figure;
        subplot(3,1,1);
        bar(W123)
        set(gca,'xticklabel',{'no','1','2','3','12','123','13','23'});
        
        subplot(3,1,2);
        %�E�C���h�E���Ă͂܂����r�����ɁA�^�b�`���Ă͂܂����񐔂Ŋ���B���̃r���Ɉ�񓖂Ă͂܂������̔��Ή�
        for n=1:length(W123)
            if TouchCount(n)~=0;
                Spike_Touch=[Spike_Touch W123(n)/TouchCount(n)];
            else
                Spike_Touch=[Spike_Touch TouchCount(n)];
            end
        end
        %���r���ɓ��Ă͂܂������̑S�̂̔��Ή񐔂ɑ΂��銄��
        for n=1:length(W123)
            if Spike_Touch(n)~=0;
                Spike_TouchRate=[Spike_TouchRate Spike_Touch(n)/sum(Spike_Touch)];
            else
                Spike_TouchRate=[Spike_TouchRate Spike_Touch(n)];
            end
        end
        bar(Spike_Touch)
        set(gca,'xticklabel',{'no','1','2','3','12','123','13','23'});
        % xlabel('no L1 L2 R1 L1L2 L1R1 L2R1 L1L2R1')
        subplot(3,1,3);
        bar(Spike_TouchRate)
        set(gca,'xticklabel',{'no','1','2','3','12','123','13','23'});
        trimtfile=strtrim(tfile);
        figname=['Repeat3touchRLR_pre',trimFolder2,trimtfile,pegpatternum,pegpatternname,'.bmp'];
        saveas(fig3,figname);
        close(fig3);  
    end
    if Rinterval2(1) < Linterval2(1) && Linterval2(1) < Rinterval1(1) && Rinterval1(1) < Linterval1(1) && abs(Rinterval2(1)) > abs(Linterval1(1)) % �E�C���h�ELRL�̏�
        
        LRLcount=1;
        
        windowS1=LWindowS1;
        windowE1=LWindowE1;
        windowS2=RWindowS2;
        windowE2=RWindowE2;
        windowS3=LWindowS2;
        windowE3=LWindowE2;
        
        CountW0=0;
        CountW1=0;
        CountW2=0;
        CountW3=0;
        CountW12=0;
        CountW13=0;
        CountW23=0;
        CountW123=0;
        
        for n=1:(length(SpikeArrayWon))
            W1=0;
            W2=0;
            W3=0;
            W1TouchTime=[];
            W2TouchTime=[];
            W3TouchTime=[];
            for i=1:(length(LpegTouchallWon))
                if  LpegTouchallWon(i)>SpikeArrayWon(n)+windowS1&SpikeArrayWon(n)+windowE1>LpegTouchallWon(i)
                    W1=1;
                    W1TouchTime=[W1TouchTime LpegTouchallWon(i)];
                end
                if  LpegTouchallWon(i)>SpikeArrayWon(n)+windowS3&SpikeArrayWon(n)+windowE3>LpegTouchallWon(i) 
                    W3=1;
                    W3TouchTime=[W3TouchTime LpegTouchallWon(i)];
                end
            end
            for j=1:(length(RpegTouchallWon))
                if  RpegTouchallWon(j)>SpikeArrayWon(n)+windowS2&SpikeArrayWon(n)+windowE2>RpegTouchallWon(j)
                    W2=1;
                    W2TouchTime=[W2TouchTime RpegTouchallWon(j)];
                end
            end
            if length(W1TouchTime)<2 && length(W2TouchTime)<2 && length(W3TouchTime)<2
                    if W1==0 & W2==0 & W3==0
                        CountW0=CountW0+1;
                    end
                    if W1==1 & W2==0 & W3==0
                        CountW1=CountW1+1;
                    end
                    if W1==0 & W2==1 & W3==0
                        CountW2=CountW2+1;
                    end
                    if W1==0 & W2==0 & W3==1
                        CountW3=CountW3+1;
                    end
                if length(W1TouchTime)==1 && length(W2TouchTime)==1 && W1TouchTime(1)<W2TouchTime(1)
                    if W1==1 & W2==1 & W3==0
                        CountW12=CountW12+1;
                    end
                end
                    if W1==1 & W2==0 & W3==1
                        CountW13=CountW13+1;
                    end
                if length(W2TouchTime)==1 && length(W3TouchTime)==1 && W2TouchTime(1)<W3TouchTime(1)
                    if W1==0 & W2==1 & W3==1
                        CountW23=CountW23+1;
                    end
                end
                if length(W1TouchTime)==1 && length(W2TouchTime)==1 && length(W3TouchTime)==1 && W1TouchTime(1)<W2TouchTime(1) && W2TouchTime(1)<W3TouchTime(1)
                    if W1==1 & W2==1 & W3==1
                        CountW123=CountW123+1;
                    end
                end
            end
        end
%         fig2=figure;
%         TouchCount=[TouchCountW0,TouchCountW1,TouchCountW2,TouchCountW3,TouchCountW12,TouchCountW123,TouchCountW13,TouchCountW23];
%         bar(TouchCount)
%         set(gca,'xticklabel',{'no','1','2','3','12','123','13','23'});
%         trimtfile=strtrim(tfile);
%         figname=['Repeat3TouchCountLRL',trimFolder2,trimtfile,pegpatternum,pegpatternname,'.bmp'];
%         saveas(fig2,figname);
%         close(fig2);  
        W123=[CountW0,CountW1,CountW2,CountW3,CountW12,CountW123,CountW13,CountW23];
        fig3=figure;
        subplot(3,1,1);
        bar(W123)
        set(gca,'xticklabel',{'no','1','2','3','12','123','13','23'});
        subplot(3,1,2);
        %�E�C���h�E���Ă͂܂����r�����ɁA�^�b�`���Ă͂܂����񐔂Ŋ���B���̃r���Ɉ�񓖂Ă͂܂������̔��Ή�
        for n=1:length(W123)
            if TouchCount(n)~=0;
                Spike_Touch=[Spike_Touch W123(n)/TouchCount(n)];
            else
                Spike_Touch=[Spike_Touch TouchCount(n)];
            end
        end
        %���r���ɓ��Ă͂܂������̑S�̂̔��Ή񐔂ɑ΂��銄��
        for n=1:length(W123)
            if Spike_Touch(n)~=0;
                Spike_TouchRate=[Spike_TouchRate Spike_Touch(n)/sum(Spike_Touch)];
            else
                Spike_TouchRate=[Spike_TouchRate Spike_Touch(n)];
            end
        end
        bar(Spike_Touch)
        set(gca,'xticklabel',{'no','1','2','3','12','123','13','23'});
        subplot(3,1,3);
        bar(Spike_TouchRate)
        set(gca,'xticklabel',{'no','1','2','3','12','123','13','23'});            
        trimtfile=strtrim(tfile);
        figname=['Repeat3touchLRL_pre',trimFolder2,trimtfile,pegpatternum,pegpatternname,'.bmp'];
        saveas(fig3,figname);
        close(fig3);
            %
%
     elseif Linterval2(1) < Rinterval2(1) && Rinterval2(1) < Linterval1(1) && Linterval1(1) < Rinterval1(1) && abs(Linterval2(1)) < abs(Rinterval1(1)) % �E�C���h�ELRL�̏�
         
         LRLcount=1;
         
        windowS1=LWindowS1;
        windowE1=LWindowE1;
        windowS2=RWindowS1;
        windowE2=RWindowE1;
        windowS3=LWindowS2;
        windowE3=LWindowE2;
        
        CountW0=0;
        CountW1=0;
        CountW2=0;
        CountW3=0;
        CountW12=0;
        CountW13=0;
        CountW23=0;
        CountW123=0;
        
        for n=1:(length(SpikeArrayWon))
            W1=0;
            W2=0;
            W3=0;
            W1TouchTime=[];
            W2TouchTime=[];
            W3TouchTime=[];
            for i=1:(length(LpegTouchallWon))
                if  LpegTouchallWon(i)>SpikeArrayWon(n)+windowS1&SpikeArrayWon(n)+windowE1>LpegTouchallWon(i)
                    W1=1;
                    W1TouchTime=[W1TouchTime LpegTouchallWon(i)];
                end
                if  LpegTouchallWon(i)>SpikeArrayWon(n)+windowS3&SpikeArrayWon(n)+windowE3>LpegTouchallWon(i) 
                    W3=1;
                    W3TouchTime=[W3TouchTime LpegTouchallWon(i)];
                end
            end
            for j=1:(length(RpegTouchallWon))
                if  RpegTouchallWon(j)>SpikeArrayWon(n)+windowS2&SpikeArrayWon(n)+windowE2>RpegTouchallWon(j)
                    W2=1;
                    W2TouchTime=[W2TouchTime RpegTouchallWon(j)];
                end
            end
            if length(W1TouchTime)<2 && length(W2TouchTime)<2 && length(W3TouchTime)<2
                    if W1==0 & W2==0 & W3==0
                        CountW0=CountW0+1;
                    end
                    if W1==1 & W2==0 & W3==0
                        CountW1=CountW1+1;
                    end
                    if W1==0 & W2==1 & W3==0
                        CountW2=CountW2+1;
                    end
                    if W1==0 & W2==0 & W3==1
                        CountW3=CountW3+1;
                    end
                if length(W1TouchTime)==1 && length(W2TouchTime)==1 && W1TouchTime(1)<W2TouchTime(1)
                    if W1==1 & W2==1 & W3==0
                        CountW12=CountW12+1;
                    end
                end
                    if W1==1 & W2==0 & W3==1
                        CountW13=CountW13+1;
                    end
                if length(W2TouchTime)==1 && length(W3TouchTime)==1 && W2TouchTime(1)<W3TouchTime(1)
                    if W1==0 & W2==1 & W3==1
                        CountW23=CountW23+1;
                    end
                end
                if length(W1TouchTime)==1 && length(W2TouchTime)==1 && length(W3TouchTime)==1 && W1TouchTime(1)<W2TouchTime(1) && W2TouchTime(1)<W3TouchTime(1)
                    if W1==1 & W2==1 & W3==1
                        CountW123=CountW123+1;
                    end
                end
            end
        end
%         fig2=figure;
%         TouchCount=[TouchCountW0,TouchCountW1,TouchCountW2,TouchCountW3,TouchCountW12,TouchCountW123,TouchCountW13,TouchCountW23];
%         bar(TouchCount)
%         set(gca,'xticklabel',{'no','1','2','3','12','123','13','23'});
%         trimtfile=strtrim(tfile);
%         figname=['Repeat3TouchCountLRL',trimFolder2,trimtfile,pegpatternum,pegpatternname,'.bmp'];
%         saveas(fig2,figname);
%         close(fig2);  
        W123=[CountW0,CountW1,CountW2,CountW3,CountW12,CountW123,CountW13,CountW23];
        fig3=figure;
        subplot(3,1,1);
        bar(W123)
        set(gca,'xticklabel',{'no','1','2','3','12','123','13','23'});
        subplot(3,1,2);
        %�E�C���h�E���Ă͂܂����r�����ɁA�^�b�`���Ă͂܂����񐔂Ŋ���B���̃r���Ɉ�񓖂Ă͂܂������̔��Ή�
        for n=1:length(W123)
            if TouchCount(n)~=0;
                Spike_Touch=[Spike_Touch W123(n)/TouchCount(n)];
            else
                Spike_Touch=[Spike_Touch TouchCount(n)];
            end
        end
        %���r���ɓ��Ă͂܂������̑S�̂̔��Ή񐔂ɑ΂��銄��
        for n=1:length(W123)
            if Spike_Touch(n)~=0;
                Spike_TouchRate=[Spike_TouchRate Spike_Touch(n)/sum(Spike_Touch)];
            else
                Spike_TouchRate=[Spike_TouchRate Spike_Touch(n)];
            end
        end
        bar(Spike_Touch)
        set(gca,'xticklabel',{'no','1','2','3','12','123','13','23'});
        subplot(3,1,3);
        bar(Spike_TouchRate)
        set(gca,'xticklabel',{'no','1','2','3','12','123','13','23'});            
        trimtfile=strtrim(tfile);
        figname=['Repeat3touchLRL_pre',trimFolder2,trimtfile,pegpatternum,pegpatternname,'.bmp'];
        saveas(fig3,figname);
        close(fig3);
    end
end
                
%                 if TouchArray1(1)==RlocsInterval(q) & TouchArray1(2)==LlocsInterval(r) & TouchArray1(3)==RlocsInterval(p)|...  %�E�C���h�ERLR�̏�
%                    -TouchArray1(1)==RlocsInterval(q) & -TouchArray1(2)==LlocsInterval(r) & -TouchArray1(3)==RlocsInterval(p)|...
%                    -TouchArray1(1)==LlocsInterval(r) & TouchArray1(2)==RlocsInterval(q) & -TouchArray1(3)==RlocsInterval(p)|...
%                    TouchArray1(1)==LlocsInterval(r) & TouchArray1(2)==RlocsInterval(q) & -TouchArray1(3)==RlocsInterval(p)|...
%                    TouchArray1(1)==RlocsInterval(q) & -TouchArray1(2)==LlocsInterval(r) & -TouchArray1(3)==RlocsInterval(p)|...
%                    -TouchArray1(1)==LlocsInterval(r) & -TouchArray1(2)==RlocsInterval(q) & TouchArray1(3)==RlocsInterval(p)|...
%                    TouchArray1(1)==LlocsInterval(r) & -TouchArray1(2)==RlocsInterval(q) & TouchArray1(3)==RlocsInterval(p)|...
%                    -TouchArray1(1)==RlocsInterval(q) & TouchArray1(2)==LlocsInterval(r) & TouchArray1(3)==RlocsInterval(p)
            
%                     windowS1=RWindowS1;
%                     windowE1=RWindowE1;
%                     windowS2=LWindowS1;
%                     windowE2=LWindowE1;
%                     windowS3=RWindowS2;
%                     windowE3=RWindowE2;
    
%                     W1=0;
%                     W2=0;
%                     W3=0;
%                     CountW0=0;
%                     CountW1=0;
%                     CountW2=0;
%                     CountW3=0;
%                     CountW12=0;
%                     CountW13=0;
%                     CountW23=0;
%                     CountW123=0;
%                     W0rate=0;
%                     W1rate=0;
%                     W2rate=0;
%                     W3rate=0;
%                     W12rate=0;
%                     w123rate=0;
%                     W13rate=0;
%                     W23rate=0;
%                     
%                         for n=1:(length(SpikeArrayWon))
%                             W1=0;
%                             W2=0;
%                             W3=0;
%                                 for i=1:(length(RpegTouchallWon))
%                                     if  RpegTouchallWon(i)>SpikeArrayWon(n)+windowS1&SpikeArrayWon(n)+windowE1>RpegTouchallWon(i)
%                                         W1=1;
%                                     end
%                                     if  RpegTouchallWon(i)>SpikeArrayWon(n)+windowS3&SpikeArrayWon(n)+windowE3>RpegTouchallWon(i) 
%                                         W3=1;
%                                     end
%                                 end
%                                 for j=1:(length(LpegTouchallWon))
%                                     if  LpegTouchallWon(j)>SpikeArrayWon(n)+windowS2&SpikeArrayWon(n)+windowE2>LpegTouchallWon(j)
%                                         W2=1;
%                                     end
%                                 end
%     
%                                 if W1==0 & W2==0 & W3==0
%                                     CountW0=CountW0+1;
%                                 end
%                                 if W1==1 & W2==0 & W3==0
%                                     CountW1=CountW1+1;
%                                 end
%                                 if W1==0 & W2==1 & W3==0
%                                     CountW2=CountW2+1;
%                                 end
%                                 if W1==0 & W2==0 & W3==1
%                                     CountW3=CountW3+1;
%                                 end
%                                 if W1==1 & W2==1 & W3==0
%                                     CountW12=CountW12+1;
%                                 end
%                                 if W1==1 & W2==0 & W3==1
%                                     CountW13=CountW13+1;
%                                 end
%                                 if W1==0 & W2==1 & W3==1
%                                     CountW23=CountW23+1;
%                                 end
%                                 if W1==1 & W2==1 & W3==1
%                                     CountW123=CountW123+1;
%                                 end
%                         end
%                         fig2=figure;
%                         subplot(2,1,1);
%                         W123=[CountW0,CountW1,CountW2,CountW3,CountW12,CountW123,CountW13,CountW23];
%                         bar(W123)
%                         set(gca,'xticklabel',{'no','1','2','3','12','123','13','23'});
%                         % xlabel('no L1 L2 R1 L1L2 L1R1 L2R1 L1L2R1')
%                         W0rate=CountW0/sum(W123);
%                         W1rate=CountW1/sum(W123);
%                         W2rate=CountW2/sum(W123);
%                         W3rate=CountW3/sum(W123);
%                         W12rate=CountW12/sum(W123);
%                         w123rate=CountW123/sum(W123);
%                         W13rate=CountW13/sum(W123);
%                         W23rate=CountW23/sum(W123);
%                         W123rate=[W0rate,W1rate,W2rate,W3rate,W12rate,w123rate,W13rate,W23rate];
%                         subplot(2,1,2);
%                         bar(W123rate)
%                         set(gca,'xticklabel',{'no','1','2','3','12','123','13','23'});
%                         
%                         trimtfile=strtrim(tfile);
%                         figname=['Repeat3touchRLR',trimFolder2,trimtfile,pegpatternname,'.bmp'];
%                         saveas(fig2,figname);
%                         close(fig2);
% %                 end
% %             end
% %         end
% %     end
%     for p=1:(length(LlocsInterval))    
%         for q=1:(length(LlocsInterval))
%             for r=1:(length(RlocsInterval))
%                 if TouchArray1(1)==LlocsInterval(q) & TouchArray1(2)==RlocsInterval(r) & TouchArray1(3)==LlocsInterval(p)|...  %�E�C���h�ELRL�̏�
%                    -TouchArray1(1)==LlocsInterval(q) & -TouchArray1(2)==RlocsInterval(r) & -TouchArray1(3)==LlocsInterval(p)|...
%                    -TouchArray1(1)==RlocsInterval(r) & TouchArray1(2)==LlocsInterval(q) & -TouchArray1(3)==LlocsInterval(p)|...
%                    TouchArray1(1)==RlocsInterval(r) & TouchArray1(2)==LlocsInterval(q) & -TouchArray1(3)==LlocsInterval(p)|...
%                    TouchArray1(1)==LlocsInterval(q) & -TouchArray1(2)==RlocsInterval(r) & -TouchArray1(3)==LlocsInterval(p)|...
%                    -TouchArray1(1)==RlocsInterval(r) & -TouchArray1(2)==LlocsInterval(q) & TouchArray1(3)==LlocsInterval(p)|...
%                    TouchArray1(1)==RlocsInterval(r) & -TouchArray1(2)==LlocsInterval(q) & TouchArray1(3)==LlocsInterval(p)|...
%                    -TouchArray1(1)==LlocsInterval(q) & TouchArray1(2)==RlocsInterval(r) & TouchArray1(3)==LlocsInterval(p)    
%                         
%                     windowS1=LWindowS1; 
%                     windowE1=LWindowE1;
%                     windowS2=RWindowS1;
%                     windowE2=RWindowE1;
%                     windowS3=LWindowS2;
%                     windowE3=LWindowE2;
%                     MoveTouchInterval=LWindowS2-LWindowE1;
% 
%                     MoveWindowArray_90=linspace(0,18000,101);
%                     MoveWindowL1=0;
%                     MoveWindowL2=0;
%                     TouchL0_90W12=0;
%                     TouchL1_90W12=0;
%                     TouchL2_90W12=0;
%                     TouchL12_90W12=0;
%                     
%                     for n=1:(length(MoveWindowArray_90))
%                         MoveWindowL1=0;
%                         MoveWindowL2=0;
%                         MoveL1Start=MoveWindowArray_90(n);
%                         MoveL1End=MoveL1Start+180;
%                         MoveL2Start=MoveL1End+MoveTouchInterval;
%                         MoveL2End=MoveL2Start+180;
%                         
%                         for i=1:(length(LpegTouchallWon))
%                             if  LpegTouchallWon(i)>MoveL1Start & MoveL1End>LpegTouchallWon(i)
%                                 MoveWindowL1=1;
%                             end 
%                             if  LpegTouchallWon(i)>preWS2_90 & preWE2_90>LpegTouchallWon(i) 
%                                 MoveWindowL2=1;
%                             end
%                         end
%                         if MoveWindowL1==0 & MoveWindowL2==0
%                            TouchL0_90W12=TouchL0_90W12+1;
%                         end
%                         if MoveWindowL1==1 & MoveWindowL2==0
%                            TouchL1_90W12=TouchL1_90W12+1;
%                         end
%                         if MoveWindowL1==0 & MoveWindowL2==1
%                            TouchL2_90W12=TouchL2_90W12+1;
%                         end
%                         if MoveWindowL1==1 & MoveWindowL2==1
%                            TouchL12_90W12=TouchL12_90W12+1;
%                         end 
%                         
%                         
%                     end
%                    
%                     
%                     
%                     W1=0;
%                     W2=0;
%                     W3=0;
%                     CountW0=0;
%                     CountW1=0;
%                     CountW2=0;
%                     CountW3=0;
%                     CountW12=0;
%                     CountW13=0;
%                     CountW23=0;
%                     CountW123=0;
%                     W0rate=0;
%                     W1rate=0;
%                     W2rate=0;
%                     W3rate=0;
%                     W12rate=0;
%                     w123rate=0;
%                     W13rate=0;
%                     W23rate=0;
%                         for n=1:(length(SpikeArrayWon))
%                             W1=0;
%                             W2=0;
%                             W3=0;
%                                 for i=1:(length(LpegTouchallWon))
%                                     if  LpegTouchallWon(i)>SpikeArrayWon(n)+windowS1&SpikeArrayWon(n)+windowE1>LpegTouchallWon(i)
%                                         W1=1;
%                                     end
%                                     if  LpegTouchallWon(i)>SpikeArrayWon(n)+windowS3&SpikeArrayWon(n)+windowE3>LpegTouchallWon(i) 
%                                         W3=1;
%                                     end
%                                 end
%                                 for j=1:(length(RpegTouchallWon))
%                                     if  RpegTouchallWon(j)>SpikeArrayWon(n)+windowS2&SpikeArrayWon(n)+windowE2>RpegTouchallWon(j)
%                                         W2=1;
%                                     end
%                                 end
% 
%                                 if W1==0 & W2==0 & W3==0
%                                     CountW0=CountW0+1;
%                                 end
%                                 if W1==1 & W2==0 & W3==0
%                                     CountW1=CountW1+1;
%                                 end
%                                 if W1==0 & W2==1 & W3==0
%                                     CountW2=CountW2+1;
%                                 end
%                                 if W1==0 & W2==0 & W3==1
%                                     CountW3=CountW3+1;
%                                 end
%                                 if W1==1 & W2==1 & W3==0
%                                     CountW12=CountW12+1;
%                                 end
%                                 if W1==1 & W2==0 & W3==1
%                                     CountW13=CountW13+1;
%                                 end
%                                 if W1==0 & W2==1 & W3==1
%                                     CountW23=CountW23+1;
%                                 end
%                                 if W1==1 & W2==1 & W3==1
%                                     CountW123=CountW123+1;
%                                 end
%                         end
%                     fig2=figure;
%                     subplot(2,1,1);
%                     W123=[CountW0,CountW1,CountW2,CountW3,CountW12,CountW123,CountW13,CountW23];
%                     bar(W123)
%                     set(gca,'xticklabel',{'no','1','2','3','12','123','13','23'});
%                     % xlabel('no L1 L2 R1 L1L2 L1R1 L2R1 L1L2R1')
%                     W0rate=CountW0/sum(W123);
%                     W1rate=CountW1/sum(W123);
%                     W2rate=CountW2/sum(W123);
%                     W3rate=CountW3/sum(W123);
%                     W12rate=CountW12/sum(W123);
%                     w123rate=CountW123/sum(W123);
%                     W13rate=CountW13/sum(W123);
%                     W23rate=CountW23/sum(W123);
%                     W123rate=[W0rate,W1rate,W2rate,W3rate,W12rate,w123rate,W13rate,W23rate];
%                     subplot(2,1,2);
%                     bar(W123rate)
%                     set(gca,'xticklabel',{'no','1','2','3','12','123','13','23'});
%                     
%                     trimtfile=strtrim(tfile);
%                     figname=['Repeat3touchLRL',trimFolder2,trimtfile,pegpatternname,'.bmp'];
%                     saveas(fig2,figname);
%                     close(fig2);
%                 end
%             end
%         end
%     end
% end