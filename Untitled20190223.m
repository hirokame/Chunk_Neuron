function untitled20190223
global  ACresult ACresultW CCresultDrinkOn SpikeArray RpegTouchallWon LpegTouchallWon TurnMarkerTime RmedianPTTM RpegMedian LmedianPTTM LpegMedian...
    RpNum LpNum  OneTurnTime CCresultSpike RmedianPTTM LmedianPTTM pksA1 pksA2
bin1=15;
phaseR=zeros(1,bin1);
for i=1:length(RpegTouchallWon)-1
    for j=1:length(SpikeArray)-1
        if RpegTouchallWon(i)<SpikeArray(j)&&SpikeArray(j)<RpegTouchallWon(i+1);   %%�^�b�`�ԂŃX�p�C�N����������
           binarrayR=linspace(RpegTouchallWon(i),RpegTouchallWon(i+1),bin1+1);     %%�^�b�`�Ԃ�bin1�̐��ɕ���
           for k=1:length(phaseR)-1
               if binarrayR(k)<SpikeArray(j)&&SpikeArray(j)<binarrayR(k+1);        %%�ǂ̃r���ŃX�p�C�N����������
                   phaseR(k)=phaseR(k)+1;
               end
           end
        end
    end
end
phaseL=zeros(1,bin1);
for i=1:length(LpegTouchallWon)-1
    for j=1:length(SpikeArray)-1
        if LpegTouchallWon(i)<SpikeArray(j)&&SpikeArray(j)<LpegTouchallWon(i+1);   %%�^�b�`�ԂŃX�p�C�N����������
           binarrayL=linspace(LpegTouchallWon(i),LpegTouchallWon(i+1),bin1+1);   %%�^�b�`�Ԃ�bin1�̐��ɕ���
           for k=1:length(phaseL)-1
               if binarrayL(k)<SpikeArray(j)&&SpikeArray(j)<binarrayL(k+1);  %%�ǂ̃r���ŃX�p�C�N����������
                   phaseL(k)=phaseL(k)+1;
               end
           end
        end
    end
end

% �^�b�`�ŃA���C�������X�p�C�N
bin=1000;
[CrossCoRtouchWon]=CrossCorr(SpikeArray',RpegTouchallWon,10000,0,TurnMarkerTime);
CCresultRtouchWon=hist(CrossCoRtouchWon,bin);
CCresultRtouchWon=MovWindow(CCresultRtouchWon,10);
[CrossCoLtouchWon]=CrossCorr(SpikeArray',LpegTouchallWon,10000,0,TurnMarkerTime);
CCresultLtouchWon=hist(CrossCoLtouchWon,bin);
CCresultLtouchWon=MovWindow(CCresultLtouchWon,10);

% % 
M1=mean(CCresultRtouchWon);
CCresultRtouchWon=CCresultRtouchWon-M1;
M2=mean(CCresultLtouchWon);
CCresultLtouchWon=CCresultLtouchWon-M2;


fs=100;%%�T���v�����O���g��
dft_size=4096;
%�E���^�b�`�ŃA���C�������X�p�C�N�̃t�[���G�ϊ�
Y1=fft(CCresultRtouchWon,dft_size);
k=1:dft_size/2+1;
A1(k)=abs(Y1(k));
P1(k)=abs(Y1(k)).^2;
frequency(k)=(k-1)*fs/dft_size;

%�����^�b�`�ŃA���C�������X�p�C�N�̃t�[���G�ϊ�
Y2=fft(CCresultLtouchWon,dft_size);
A2(k)=abs(Y2(k));
P2(k)=abs(Y2(k)).^2;
frequency(k)=(k-1)*fs/dft_size;
% �U��
% �E��
[pksA1,locsA1]=findpeaks(A1,'sortstr','descend');  %%%�s�[�N�ɂȂ���g��
locsA1=(locsA1-1)*fs/dft_size;
locsA1time=1/locsA1(1)*100;
% ����
[pksA2,locsA2]=findpeaks(A2,'sortstr','descend');
locsA2=(locsA2-1)*fs/dft_size;
locsA2time=1/locsA2(1)*100;

%�U���̓��
% �E��
[pksP1,locsP1]=findpeaks(P1,'sortstr','descend');  %%%�s�[�N�ɂȂ���g��
locsP1=(locsP1-1)*fs/dft_size;
locsP1time=1/locsP1(1)*100;
% ����
[pksP2,locsP2]=findpeaks(P2,'sortstr','descend');
locsP2=(locsP2-1)*fs/dft_size;
locsP2time=1/locsP2(1)*100;

% �E�������̈ʑ��ɐU����������
phaseR=phaseR*pksA1(1);
phaseL=phaseL*pksA2(1);

% % oneturntouchCell=[];
% % for i=1:length(TurnMarkerTime)
% %     k=1;
% %     oneturntouch=[];
% %     for j=1:length(RpegTouchallWon)
% %         if TurnMarkerTime(i)<RpegTouchallWon(j) && RpegTouchallWon(j)<TurnMarkerTime(i+1);
% %             oneturntouch(k)=RpegTouchallWon(j)-TurnMarkerTime(i);
% %             k=k+1;
% %         end
% %     end
% %     oneturntouchCell=[oneturntouchCell;oneturntouch];
% % end
RmedianPTTM=sort(RmedianPTTM*10,'ascend');
LmedianPTTM=sort(LmedianPTTM*10,'ascend');
RmedianPTTM=RmedianPTTM(find(~isnan(RmedianPTTM)));
LmedianPTTM=LmedianPTTM(find(~isnan(LmedianPTTM)));













