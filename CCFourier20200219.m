function CCFourier20200219

global CCresultRtouchWon CCresultLtouchWon RpegTouchallWon LpegTouchallWon SpikeArrayWon

CCFourierLtUnit=[];
CCFourierRtUnit=[];
% %SpikeArray��LPegTouchAll�ARpegTouchall���A���C�������N���X�R���I�O����
% %SpikeArray��LPegTouchAll���A���C������
% duration=5000;
% CrossCoL=[];
% CrossCoR=[];
% %������
% for n=1:(length(SpikeArrayWon))
%         Interval=LpegTouchallWon((LpegTouchallWon>SpikeArrayWon(n)-duration/2)&(SpikeArrayWon(n)>LpegTouchallWon-duration/2))-SpikeArrayWon(n);
%         CrossCoL=[CrossCoL Interval];
% end
%     
% CrossCoL=[-1*duration/2 CrossCoL duration/2];
% 
% CrossCoL(CrossCoL==0)=[];
% 
% bin=500;
% % CCresultLtouchWon�̍X�V�ɕK�v
% CCresultLtouchWon=hist(CrossCoL,bin);
% CCresultLtouchWon=CCresultLtouchWon/sum(CCresultLtouchWon);
% CCresultLtouchWon=MovWindow(CCresultLtouchWon,10);
% 
% fig1=figure;
% subplot(2,2,[1,2]);
% plot(linspace(1,5000,bin),CCresultLtouchWon,'color','r','LineWidth',2);
% axis([0 5000 0 max(CCresultLtouchWon)*1.1]);
% hold on
% %SpikeArray��RPegTouchAll���A���C������
% for n=1:(length(SpikeArrayWon))
%         Interval=RpegTouchallWon((RpegTouchallWon>SpikeArrayWon(n)-duration/2)&(SpikeArrayWon(n)>RpegTouchallWon-duration/2))-SpikeArrayWon(n);
%         CrossCoR=[CrossCoR Interval];
% end
%     
% CrossCoR=[-1*duration/2 CrossCoR duration/2];
% 
% CrossCoR(CrossCoR==0)=[];
% % CCresultRtouchWon�̍X�V�ɕK�v
% CCresultRtouchWon=hist(CrossCoR,bin);
% CCresultRtouchWon=CCresultRtouchWon/sum(CCresultRtouchWon);
% CCresultRtouchWon=MovWindow(CCresultRtouchWon,10);
% 
% plot(linspace(1,5000,bin),CCresultRtouchWon,'color','b','LineWidth',2);
% axis([0 5000 0 max(CCresultLtouchWon)*1.1]);
% hold off

cd('C:\Users\C238\Desktop\touchcellLtRt_terashita')
load('CCRtLt.mat');
for x=1:length(CCresultLtouchWonUnit(:,1));
    CCresultLtouchWon=CCresultLtouchWonUnit(x,:);
CCFourier=[];
%CCLtouch�̃t�[���G�ϊ�
for i=1:81  %% CC�̒���81��t�[���G�ϊ�
    FourierArray=CCresultLtouchWon((1+(i-1)*5):(100+(i-1)*5));
    Bin=length(FourierArray);
    
    %%%%%%�t�[���G�ϊ���������������������
    fs=100;%%�T���v�����O���g��
    dft_size=2000;  
    %�E���^�b�`�ŃA���C�������X�p�C�N�̃t�[���G�ϊ�
    Y1=fft(FourierArray,dft_size)/Bin;
    k=1:dft_size/2+1;
    A1Lt(k)=2*abs(Y1(k));
    frequency(k)=(k-1)*fs/dft_size;
    
%     figure
%     plot(frequency,A1Lt,'color','b');    %off 
%     axis([0 5 0 max(max(A1Lt))*1.1])      %off
    
    IndexFreq=find(1.5<frequency & frequency<3);     %%%%%% 1.5Hz����3Hz�̂Ƃ����Index������
    [MaxA1Lt locsA1Lt]=max(A1Lt(IndexFreq(1):IndexFreq(end)));%%%%%% 1.5Hz����3Hz�̂Ƃ���̍ő�l��T��

    CCFourier=[CCFourier MaxA1Lt];
end
CCFourierLtUnit=[CCFourierLtUnit;CCFourier];
end

% 
% % figure�\��
% for i=1:length(CCFourierLtUnit)
%     figure
%     plot(linspace(0,1,17),CCFourierLtUnit(i,:));
%     
% end
% 




for x=1:length(CCresultRtouchWonUnit(:,1));
    CCresultRtouchWon=CCresultRtouchWonUnit(x,:);
CCFourier=[];
%CCRtouch�̃t�[���G�ϊ�
for i=1:81  %% CC�̒���81��t�[���G�ϊ�
    FourierArray=CCresultRtouchWon((1+(i-1)*5):(100+(i-1)*5));
    Bin=length(FourierArray);
    
    %%%%%%�t�[���G�ϊ���������������������
    fs=100;%%�T���v�����O���g��
    dft_size=2000;  
    %�E���^�b�`�ŃA���C�������X�p�C�N�̃t�[���G�ϊ�
    Y1=fft(FourierArray,dft_size)/Bin;
    k=1:dft_size/2+1;
    A1Rt(k)=2*abs(Y1(k));
    frequency(k)=(k-1)*fs/dft_size;
    
%     figure
%     plot(frequency,A1Rt,'color','b');    %off 
%     axis([0 5 0 max(max(A1Rt))*1.1])      %off
    
    IndexFreq=find(1.5<frequency & frequency<3);     %%%%%% 1.5Hz����3Hz�̂Ƃ����Index������
    [MaxA1Rt locsA1Rt]=max(A1Rt(IndexFreq(1):IndexFreq(end)));%%%%%% 1.5Hz����3Hz�̂Ƃ���̍ő�l��T��

    CCFourier=[CCFourier MaxA1Rt];
end
CCFourierRtUnit=[CCFourierRtUnit;CCFourier];
end


% % figure�\��
% for i=1:length(CCFourierRtUnit)
%     figure
%     plot(linspace(0,1,17),CCFourierRtUnit(i,:));
%     
% end

CCFourierRtUnitZscore=zscore(CCFourierRtUnit.');
CCFourierRtUnitZscore=CCFourierRtUnitZscore.';
figure
clims = [-3 3];
imagesc(CCFourierRtUnitZscore,clims);
colorbar
xlabel('Rtouch')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
CCFourierLtUnitZscore=zscore(CCFourierLtUnit.');
CCFourierLtUnitZscore=CCFourierLtUnitZscore.';
figure
clims = [-3 3];
imagesc(CCFourierLtUnitZscore,clims);
colorbar
xlabel('Ltouch')


%%%%%Rt�̕��ёւ�
CCFourierRtUnitZscoreSort1=[];
SortArray=[];
for i=1:length(CCFourierRtUnitZscore(1,:))
    for j=1:length(CCFourierRtUnitZscore(:,1))
        Row=CCFourierRtUnitZscore(j,:);
        [PeakRow,IndexRow]=max(Row);
        if IndexRow(1)==i;
            SortArray=[SortArray j];
        CCFourierRtUnitZscoreSort1=[CCFourierRtUnitZscoreSort1;Row];
        end
    end
end



%%%%Lt�̕��ёւ�
CCFourierLtUnitZscoreSort1=[];
SortArray=[];
for i=1:length(CCFourierLtUnitZscore(1,:))
    for j=1:length(CCFourierLtUnitZscore(:,1))
        Row=CCFourierLtUnitZscore(j,:);
        [PeakRow,IndexRow]=max(Row);
        if IndexRow(1)==i;
            SortArray=[SortArray j];
        CCFourierLtUnitZscoreSort1=[CCFourierLtUnitZscoreSort1;Row];
        end
    end
end

figure
clims = [-3 3];
imagesc(CCFourierRtUnitZscoreSort1,clims);
colorbar
title('Rtouch')


figure
clims = [-3 3];
imagesc(CCFourierLtUnitZscoreSort1,clims);
colorbar
title('Ltouch')







