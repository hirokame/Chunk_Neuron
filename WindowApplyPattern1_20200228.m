function WindowApplyPattern1_20200228(RorL)

global render RtouchSpikeOnUnit LtouchSpikeOnUnit RtouchSpikeOffUnit LtouchSpikeOffUnit LtNegativeSpikeOffKaisuu RtNegativeSpikeOffKaisuu ...
    RtPositiveSpikeOffKaisuu LtPositiveSpikeOffKaisuu pegpatternum pegpatternname...
    LtPositiveFiringRate LtNegativeFiringRate RtPositiveFiringRate RtNegativeFiringRate...
    LtPositiveFiringRateP1 LtNegativeFiringRateP1 RtPositiveFiringRateP1 RtNegativeFiringRateP1...
    LtPositive_beta_histP1 LtNegative_beta_histP1 RtPositive_beta_histP1 RtNegative_beta_histP1 LtPositive_R_histP1 LtNegative_R_histP1 RtPositive_R_histP1 RtNegative_R_histP1 ...
    LtRsq1_P1 RtRsq1_P1 Ltbeta1_P1 Rtbeta1_P1

if ~isempty(strfind(RorL, 'L'));
    LtPositiveSpikeOnKaisuuP1=ones(1,5);%%%%%%%�E�B���h�E�ɉ��񓖂Ă͂܂�����
    LtPositiveHistogramXaxisP1=ones(1,5);  %%%%% Positive�q�X�g�O�������쐬����ۂ̔��Εp�x�i�����l�[���j�U�v�f�i0�A1�A2�A3�A4�A5�j
    %%%%%%Ltouch
    %%%%%positive
    LtouchPositive5windowPointSpikeOnP1=LtouchSpikeOnUnit(:,(1:6));%%%% ���ΐ���POsitive���������o��
    for i=1:length(LtouchPositive5windowPointSpikeOnP1(:,1))
        IndexSpikeOnPositive=find(LtouchPositive5windowPointSpikeOnP1(i,(2:6))==1);
        
        if length(IndexSpikeOnPositive)==5;  %%%%%�E�B���h�E�ɓ��Ă͂܂����񐔂�4��̏ꍇ
            LtPositiveSpikeOnKaisuuP1(5)=LtPositiveSpikeOnKaisuuP1(5)+1;
            LtPositiveHistogramXaxisP1(5)=LtPositiveHistogramXaxisP1(5)+LtouchPositive5windowPointSpikeOnP1(i,1);
        end
        
        if length(IndexSpikeOnPositive)==4;  %%%%%�E�B���h�E�ɓ��Ă͂܂����񐔂�3��̏ꍇ
            LtPositiveSpikeOnKaisuuP1(4)=LtPositiveSpikeOnKaisuuP1(4)+1;
            LtPositiveHistogramXaxisP1(4)=LtPositiveHistogramXaxisP1(4)+LtouchPositive5windowPointSpikeOnP1(i,1);
        end
        
        if length(IndexSpikeOnPositive)==3;  %%%%%�E�B���h�E�ɓ��Ă͂܂����񐔂�2��̏ꍇ
            LtPositiveSpikeOnKaisuuP1(3)=LtPositiveSpikeOnKaisuuP1(3)+1;
            LtPositiveHistogramXaxisP1(3)=LtPositiveHistogramXaxisP1(3)+LtouchPositive5windowPointSpikeOnP1(i,1);
        end
        
        if length(IndexSpikeOnPositive)==2;  %%%%%�E�B���h�E�ɓ��Ă͂܂����񐔂�1��̏ꍇ
            LtPositiveSpikeOnKaisuuP1(2)=LtPositiveSpikeOnKaisuuP1(2)+1;
            LtPositiveHistogramXaxisP1(2)=LtPositiveHistogramXaxisP1(2)+LtouchPositive5windowPointSpikeOnP1(i,1);
        end
        
        if length(IndexSpikeOnPositive)==1;  %%%%%�E�B���h�E�ɓ��Ă͂܂����񐔂�0��̏ꍇ
            LtPositiveSpikeOnKaisuuP1(1)=LtPositiveSpikeOnKaisuuP1(1)+1;
            LtPositiveHistogramXaxisP1(1)=LtPositiveHistogramXaxisP1(1)+LtouchPositive5windowPointSpikeOnP1(i,1);
        end
    end
    
    LtPositiveSpikeOffKaisuuP1=ones(1,5);
    
    
    
    %%%%%%%Positive  Spikeoff
    LtouchPositive5windowPointSpikeOffP1=LtouchSpikeOffUnit(:,(1:5));%%%% Positive���������o��
    for i=1:length(LtouchPositive5windowPointSpikeOffP1(:,1))
        IndexSpikeOffPositive=find(LtouchPositive5windowPointSpikeOffP1(i,(1:5))==1);
        
        if  length(IndexSpikeOffPositive)==5;%%%%�E�B���h�E�ɓ��Ă͂܂����񐔂�4��̏ꍇ
            LtPositiveSpikeOffKaisuuP1(5)=LtPositiveSpikeOffKaisuuP1(5)+1;
        end
        
        if length(IndexSpikeOffPositive)==4;%%%%�E�B���h�E�ɓ��Ă͂܂����񐔂�3��̏ꍇ
            LtPositiveSpikeOffKaisuuP1(4)=LtPositiveSpikeOffKaisuuP1(4)+1;
        end
        
        if length(IndexSpikeOffPositive)==3;%%%%�E�B���h�E�ɓ��Ă͂܂����񐔂�2��̏ꍇ
            LtPositiveSpikeOffKaisuuP1(3)=LtPositiveSpikeOffKaisuuP1(3)+1;
        end
        
        if length(IndexSpikeOffPositive)==2;%%%%�E�B���h�E�ɓ��Ă͂܂����񐔂�1��̏ꍇ
            LtPositiveSpikeOffKaisuuP1(2)=LtPositiveSpikeOffKaisuuP1(2)+1;
        end
        
        if length(IndexSpikeOffPositive)==1;%%%%�E�B���h�E�ɓ��Ă͂܂����񐔂�0��̏ꍇ
            LtPositiveSpikeOffKaisuuP1(1)=LtPositiveSpikeOffKaisuuP1(1)+1;
        end
    end
    
    
    
    % %%%%%%%Ltouch
    % %%%%%%%Negative  SpikeOn
    % LtNegativeSpikeOnKaisuuP1=zeros(1,5);
    % LtNegativeHistogramXaxisP1=zeros(1,5); %%%%% Negative�q�X�g�O�������쐬����ۂ̔��Εp�x�i�����l�[���j5�v�f�i0�A�ǂꂩ1�A�A���Q�����A�A��3�A�A��4�j
    % LtouchNegative5windowPointSpikeOnP1=[LtouchSpikeOnUnit(:,1) LtouchSpikeOnUnit(:,(7:10))];%%%% ���ΐ���Negative���������o��
    %
    %
    %
    % for i=1:length(LtouchNegative5windowPointSpikeOnP1(:,1))
    %     IndexSpikeOnNegative=find(LtouchNegative5windowPointSpikeOnP1(i,(2:5))==-1);
    %
    %     if length(IndexSpikeOnNegative)==4;  %%%%%NegativeWindow��4�񓖂Ă͂܂����ꍇ
    %        LtNegativeHistogramXaxisP1(5)=LtNegativeHistogramXaxisP1(5)+LtouchNegative5windowPointSpikeOnP1(i,1);
    %        LtNegativeSpikeOnKaisuuP1(5)=LtNegativeSpikeOnKaisuuP1(5)+1;
    %     end
    %
    %     if length(IndexSpikeOnNegative)==3;  %%%%%NegativeWindow��3�񓖂Ă͂܂����ꍇ
    %        LtNegativeHistogramXaxisP1(4)=LtNegativeHistogramXaxisP1(4)+LtouchNegative5windowPointSpikeOnP1(i,1);
    %        LtNegativeSpikeOnKaisuuP1(4)=LtNegativeSpikeOnKaisuuP1(4)+1;
    %     end
    %
    %     if length(IndexSpikeOnNegative)==2;  %%%%%NegativeWindow��2�񓖂Ă͂܂����ꍇ
    %        LtNegativeHistogramXaxisP1(3)=LtNegativeHistogramXaxisP1(3)+LtouchNegative5windowPointSpikeOnP1(i,1);
    %        LtNegativeSpikeOnKaisuuP1(3)=LtNegativeSpikeOnKaisuuP1(3)+1;
    %     end
    %
    %     if length(IndexSpikeOnNegative)==1;  %%%%%NegativeWindow��1�񓖂Ă͂܂����ꍇ
    %        LtNegativeHistogramXaxisP1(2)=LtNegativeHistogramXaxisP1(2)+LtouchNegative5windowPointSpikeOnP1(i,1);
    %        LtNegativeSpikeOnKaisuuP1(2)=LtNegativeSpikeOnKaisuuP1(2)+1;
    %     end
    %
    %     if length(IndexSpikeOnNegative)==0;  %%%%%NegativeWindow��0�񓖂Ă͂܂����ꍇ
    %        LtNegativeHistogramXaxisP1(1)=LtNegativeHistogramXaxisP1(1)+LtouchNegative5windowPointSpikeOnP1(i,1);
    %        LtNegativeSpikeOnKaisuuP1(1)=LtNegativeSpikeOnKaisuuP1(1)+1;
    %     end
    % end
    %
    %
    % %%%%%%%Negative  SpikeOff
    % LtNegativeSpikeOffKaisuuP1=zeros(1,5);
    % LtouchNegative5windowPointSpikeOffP1=[LtouchSpikeOffUnit(:,(6:9))];%%%% ���ΐ���Negative���������o��
    %
    %
    %
    % for i=1:length(LtouchNegative5windowPointSpikeOffP1(:,1))
    %     IndexSpikeOffNegative=find(LtouchNegative5windowPointSpikeOffP1(i,(1:4))==-1);
    %
    %     if length(IndexSpikeOffNegative)==4;  %%%%Negativewindow��4�񓖂Ă͂܂�����
    %        LtNegativeSpikeOffKaisuuP1(5)=LtNegativeSpikeOffKaisuuP1(5)+1;
    %     end
    %
    %     if length(IndexSpikeOffNegative)==3;  %%%%Negativewindow��3�񓖂Ă͂܂�����
    %        LtNegativeSpikeOffKaisuuP1(4)=LtNegativeSpikeOffKaisuuP1(4)+1;
    %     end
    %
    %     if length(IndexSpikeOffNegative)==2;  %%%%Negativewindow��2�񓖂Ă͂܂�����
    %        LtNegativeSpikeOffKaisuuP1(3)=LtNegativeSpikeOffKaisuuP1(3)+1;
    %     end
    %
    %     if length(IndexSpikeOffNegative)==1;  %%%%Negativewindow��1�񓖂Ă͂܂�����
    %        LtNegativeSpikeOffKaisuuP1(2)=LtNegativeSpikeOffKaisuuP1(2)+1;
    %     end
    %
    %     if length(IndexSpikeOffNegative)==0;  %%%%Negativewindow��0�񓖂Ă͂܂�����
    %        LtNegativeSpikeOffKaisuuP1(1)=LtNegativeSpikeOffKaisuuP1(1)+1;
    %     end
    % end
    % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%�X�p�C�N�����Ă͂܂�������Positive�E�B���h��figure
    % FRfigure_pattern1=figure;
    % subplot(2,2,1)
    LtPositiveFiringRateP1=LtPositiveHistogramXaxisP1./((LtPositiveSpikeOnKaisuuP1+LtPositiveSpikeOffKaisuuP1)*10);
end

%LtPositiveFiringRateP1=LtPositiveFiringRateP1/mean(LtPositiveFiringRateP1);
% bar(LtPositiveFiringRateP1); %%%%%���Εp�x�ɒ���
% title('SpikeOnPositiveFiringRateLt_Pattern1')
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%LtNegative�E�B���h�E�ɓ��Ă͂܂������Εp�x��\��
% subplot(2,2,2)
% LtNegativeFiringRateP1=LtNegativeHistogramXaxisP1./((LtNegativeSpikeOnKaisuuP1+LtNegativeSpikeOffKaisuuP1)*10);
% LtNegativeFiringRateP1=LtNegativeFiringRateP1/mean(LtNegativeFiringRateP1);
% bar(LtNegativeFiringRateP1); %%%%%���Εp�x�ɒ���
% title('SpikeOnNegativeFiringRateLt_Pattern1')



if ~isempty(strfind(RorL, 'R'));
    RtPositiveSpikeOnKaisuuP1=ones(1,5);%%%%%%%�E�B���h�E�ɉ��񓖂Ă͂܂�����
    RtPositiveHistogramXaxisP1=ones(1,5);  %%%%% Positive�q�X�g�O�������쐬����ۂ̔��Εp�x�i�����l�[���j�U�v�f�i0�A1�A2�A3�A4�A5�j
    %%%%%%Rtouch
    %%%%%positive
    RtouchPositive5windowPointSpikeOnP1=RtouchSpikeOnUnit(:,(1:6));%%%% ���ΐ���POsitive���������o��
    for i=1:length(RtouchPositive5windowPointSpikeOnP1(:,1))
        IndexSpikeOnPositive=find(RtouchPositive5windowPointSpikeOnP1(i,(2:6))==1);
        
        if length(IndexSpikeOnPositive)==5;  %%%%%�E�B���h�E�ɓ��Ă͂܂����񐔂�4��̏ꍇ
            RtPositiveSpikeOnKaisuuP1(5)=RtPositiveSpikeOnKaisuuP1(5)+1;
            RtPositiveHistogramXaxisP1(5)=RtPositiveHistogramXaxisP1(5)+RtouchPositive5windowPointSpikeOnP1(i,1);
        end
        
        if length(IndexSpikeOnPositive)==4;  %%%%%�E�B���h�E�ɓ��Ă͂܂����񐔂�3��̏ꍇ
            RtPositiveSpikeOnKaisuuP1(4)=RtPositiveSpikeOnKaisuuP1(4)+1;
            RtPositiveHistogramXaxisP1(4)=RtPositiveHistogramXaxisP1(4)+RtouchPositive5windowPointSpikeOnP1(i,1);
        end
        
        if length(IndexSpikeOnPositive)==3;  %%%%%�E�B���h�E�ɓ��Ă͂܂����񐔂�2��̏ꍇ
            RtPositiveSpikeOnKaisuuP1(3)=RtPositiveSpikeOnKaisuuP1(3)+1;
            RtPositiveHistogramXaxisP1(3)=RtPositiveHistogramXaxisP1(3)+RtouchPositive5windowPointSpikeOnP1(i,1);
        end
        
        if length(IndexSpikeOnPositive)==2;  %%%%%�E�B���h�E�ɓ��Ă͂܂����񐔂�1��̏ꍇ
            RtPositiveSpikeOnKaisuuP1(2)=RtPositiveSpikeOnKaisuuP1(2)+1;
            RtPositiveHistogramXaxisP1(2)=RtPositiveHistogramXaxisP1(2)+RtouchPositive5windowPointSpikeOnP1(i,1);
        end
        
        if length(IndexSpikeOnPositive)==1;  %%%%%�E�B���h�E�ɓ��Ă͂܂����񐔂�0��̏ꍇ
            RtPositiveSpikeOnKaisuuP1(1)=RtPositiveSpikeOnKaisuuP1(1)+1;
            RtPositiveHistogramXaxisP1(1)=RtPositiveHistogramXaxisP1(1)+RtouchPositive5windowPointSpikeOnP1(i,1);
        end
    end
    
    RtPositiveSpikeOffKaisuuP1=ones(1,5);
    
    
    %%%%%%%Positive  Spikeoff
    RtouchPositive5windowPointSpikeOffP1=RtouchSpikeOffUnit(:,(1:5));%%%% POsitive���������o��
    for i=1:length(RtouchPositive5windowPointSpikeOffP1(:,1))
        IndexSpikeOffPositive=find(RtouchPositive5windowPointSpikeOffP1(i,(1:5))==1);
        
        if  length(IndexSpikeOffPositive)==5;%%%%�E�B���h�E�ɓ��Ă͂܂����񐔂�4��̏ꍇ
            RtPositiveSpikeOffKaisuuP1(5)=RtPositiveSpikeOffKaisuuP1(5)+1;
        end
        
        if length(IndexSpikeOffPositive)==4;%%%%�E�B���h�E�ɓ��Ă͂܂����񐔂�3��̏ꍇ
            RtPositiveSpikeOffKaisuuP1(4)=RtPositiveSpikeOffKaisuuP1(4)+1;
        end
        
        if length(IndexSpikeOffPositive)==3;%%%%�E�B���h�E�ɓ��Ă͂܂����񐔂�2��̏ꍇ
            RtPositiveSpikeOffKaisuuP1(3)=RtPositiveSpikeOffKaisuuP1(3)+1;
        end
        
        if length(IndexSpikeOffPositive)==2;%%%%�E�B���h�E�ɓ��Ă͂܂����񐔂�1��̏ꍇ
            RtPositiveSpikeOffKaisuuP1(2)=RtPositiveSpikeOffKaisuuP1(2)+1;
        end
        
        if length(IndexSpikeOffPositive)==1;%%%%�E�B���h�E�ɓ��Ă͂܂����񐔂�0��̏ꍇ
            RtPositiveSpikeOffKaisuuP1(1)=RtPositiveSpikeOffKaisuuP1(1)+1;
        end
    end
    
    %%%%%%%Rtouch
    %%%%%%%Negative  SpikeOn
    % RtNegativeSpikeOnKaisuuP1=zeros(1,5);
    % RtNegativeHistogramXaxisP1=zeros(1,5); %%%%% Negative�q�X�g�O�������쐬����ۂ̔��Εp�x�i�����l�[���j5�v�f�i0�A�ǂꂩ1�A�A���Q�����A�A��3�A�A��4�j
    % RtouchNegative5windowPointSpikeOnP1=[RtouchSpikeOnUnit(:,1) RtouchSpikeOnUnit(:,(7:10))];%%%% ���ΐ���Negative���������o��
    %
    %
    %
    % for i=1:length(RtouchNegative5windowPointSpikeOnP1(:,1))
    %     IndexSpikeOnNegative=find(RtouchNegative5windowPointSpikeOnP1(i,(2:5))==-1);
    %
    %     if length(IndexSpikeOnNegative)==4;  %%%%%NegativeWindow��4�񓖂Ă͂܂����ꍇ
    %        RtNegativeHistogramXaxisP1(5)=RtNegativeHistogramXaxisP1(5)+RtouchNegative5windowPointSpikeOnP1(i,1);
    %        RtNegativeSpikeOnKaisuuP1(5)=RtNegativeSpikeOnKaisuuP1(5)+1;
    %     end
    %
    %     if length(IndexSpikeOnNegative)==3;  %%%%%NegativeWindow��3�񓖂Ă͂܂����ꍇ
    %        RtNegativeHistogramXaxisP1(4)=RtNegativeHistogramXaxisP1(4)+RtouchNegative5windowPointSpikeOnP1(i,1);
    %        RtNegativeSpikeOnKaisuuP1(4)=RtNegativeSpikeOnKaisuuP1(4)+1;
    %     end
    %
    %     if length(IndexSpikeOnNegative)==2;  %%%%%NegativeWindow��2�񓖂Ă͂܂����ꍇ
    %        RtNegativeHistogramXaxisP1(3)=RtNegativeHistogramXaxisP1(3)+RtouchNegative5windowPointSpikeOnP1(i,1);
    %        RtNegativeSpikeOnKaisuuP1(3)=RtNegativeSpikeOnKaisuuP1(3)+1;
    %     end
    %
    %     if length(IndexSpikeOnNegative)==1;  %%%%%NegativeWindow��1�񓖂Ă͂܂����ꍇ
    %        RtNegativeHistogramXaxisP1(2)=RtNegativeHistogramXaxisP1(2)+RtouchNegative5windowPointSpikeOnP1(i,1);
    %        RtNegativeSpikeOnKaisuuP1(2)=RtNegativeSpikeOnKaisuuP1(2)+1;
    %     end
    %
    %     if length(IndexSpikeOnNegative)==0;  %%%%%NegativeWindow��0�񓖂Ă͂܂����ꍇ
    %        RtNegativeHistogramXaxisP1(1)=RtNegativeHistogramXaxisP1(1)+RtouchNegative5windowPointSpikeOnP1(i,1);
    %        RtNegativeSpikeOnKaisuuP1(1)=RtNegativeSpikeOnKaisuuP1(1)+1;
    %     end
    % end
    %
    %
    % %%%%%%%Negative  SpikeOff
    % RtNegativeSpikeOffKaisuuP1=zeros(1,5);
    % RtouchNegative5windowPointSpikeOff=[LtouchSpikeOffUnit(:,(6:9))];%%%% ���ΐ���Negative���������o��
    %
    %
    %
    % for i=1:length(RtouchNegative5windowPointSpikeOff(:,1))
    %     IndexSpikeOffNegative=find(RtouchNegative5windowPointSpikeOff(i,(1:4))==-1);
    %
    %     if length(IndexSpikeOffNegative)==4;  %%%%Negativewindow��4�񓖂Ă͂܂�����
    %        RtNegativeSpikeOffKaisuuP1(5)=RtNegativeSpikeOffKaisuuP1(5)+1;
    %     end
    %
    %     if length(IndexSpikeOffNegative)==3;  %%%%Negativewindow��3�񓖂Ă͂܂�����
    %        RtNegativeSpikeOffKaisuuP1(4)=RtNegativeSpikeOffKaisuuP1(4)+1;
    %     end
    %
    %     if length(IndexSpikeOffNegative)==2;  %%%%Negativewindow��2�񓖂Ă͂܂�����
    %        RtNegativeSpikeOffKaisuuP1(3)=RtNegativeSpikeOffKaisuuP1(3)+1;
    %     end
    %
    %     if length(IndexSpikeOffNegative)==1;  %%%%Negativewindow��1�񓖂Ă͂܂�����
    %        RtNegativeSpikeOffKaisuuP1(2)=RtNegativeSpikeOffKaisuuP1(2)+1;
    %     end
    %
    %     if length(IndexSpikeOffNegative)==0;  %%%%Negativewindow��0�񓖂Ă͂܂�����
    %        RtNegativeSpikeOffKaisuuP1(1)=RtNegativeSpikeOffKaisuuP1(1)+1;
    %     end
    % end
    %
    % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%�X�p�C�N�����Ă͂܂�������Positive�E�B���h��figure
    % subplot(2,2,3)
    RtPositiveFiringRateP1=RtPositiveHistogramXaxisP1./((RtPositiveSpikeOnKaisuuP1+RtPositiveSpikeOffKaisuuP1)*10);
end

%RtPositiveFiringRateP1=RtPositiveFiringRateP1/mean(RtPositiveFiringRateP1);
% bar(RtPositiveFiringRateP1); %%%%%���Εp�x�ɒ���
% title('SpikeOnPositiveFiringRateRt_Pattern1')
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% subplot(2,2,4)
% RtNegativeFiringRateP1=RtNegativeHistogramXaxisP1./((RtNegativeSpikeOnKaisuuP1+RtNegativeSpikeOffKaisuuP1)*10);
% RtNegativeFiringRateP1=RtNegativeFiringRateP1/mean(RtNegativeFiringRateP1);
% bar(RtNegativeFiringRateP1); %%%%%���Εp�x�ɒ���
% title('SpikeOnNegativeFiringRateRt_Pattern1')
%
% %%%%%%%%fig�̕ۑ�%%%%%%%%%%%%%%%%%%
% figname=[pegpatternum,pegpatternname,'FRfigureRtLt_Pattern1.bmp'];
% saveas(FRfigure_pattern1,figname);
%
%
% %%%%%%%%%%%%��������͉�A����%%%%%%%%%%%
if ~isempty(strfind(RorL, 'L'));
    x=[1 2 3 4 5];
    y=LtPositiveFiringRateP1;
    y=y/mean(y);
    beta_P1=polyfit(x,y,1);
    Ltbeta0_P1=beta_P1(2);
    Ltbeta1_P1=beta_P1(1);
    yCalc=Ltbeta1_P1*x+Ltbeta0_P1;
    LtRsq1_P1=1-sum((y-yCalc).^2)/sum((y-mean(y)).^2);
    if render==1;
        FRfigure_wR_P1=figure;
        subplot(1,2,1)
        scatter(x,y); %%%%%���Εp�x�ɒ���
        hold on
        plot(x,yCalc)
        str=['R=',num2str(LtRsq1_P1)];
        title('SpikeOnPositiveFiringRateLt_withRegression_P1')
    end
end
% LtPositive_beta_histP1=[LtPositive_beta_histP1,beta1];
% LtPositive_R_histP1=[LtPositive_R_histP1,Rsq1];
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%LtNegative�E�B���h�E�ɓ��Ă͂܂������Εp�x��\��
% subplot(2,2,2)
% x=[0 1 2 3 4];
% y=LtNegativeFiringRateP1;
% beta=polyfit(x,y,1);
% beta0=beta(2);
% beta1=beta(1);
% yCalc=beta1*x+beta0;
% Rsq1=1-sum((y-yCalc).^2)/sum((y-mean(y)).^2);
% scatter(x,y); %%%%%���Εp�x�ɒ���
% hold on
% plot(x,yCalc)
% str=['R=',num2str(Rsq1)];
% title('SpikeOnNegativeFiringRateLt_withRegression_P1')
% LtNegative_beta_histP1=[LtNegative_beta_histP1,beta1];
% LtNegative_R_histP1=[LtNegative_R_histP1,Rsq1];
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%�X�p�C�N�����Ă͂܂�������Positive�E�B���h��figure
if ~isempty(strfind(RorL, 'R'));
    x=[1 2 3 4 5];
    y=RtPositiveFiringRateP1;
    y=y/mean(y);
    beta_P1=polyfit(x,y,1);
    Rtbeta0_P1=beta_P1(2);
    Rtbeta1_P1=beta_P1(1);
    yCalc=Rtbeta1_P1*x+Rtbeta0_P1;
    RtRsq1_P1=1-sum((y-yCalc).^2)/sum((y-mean(y)).^2);
    if render==1;
        subplot(1,2,2)
        scatter(x,y);
        hold on
        plot(x,yCalc)
        str=['R=',num2str(RtRsq1_P1)];
        title('SpikeOnPositiveFiringRateRt_withRegression_P1')
        %     figname=[pegpatternum,pegpatternname,'FRfigureRtLt_wR_P1.bmp'];
        %     saveas(FRfigure_wR_P1,figname);
    end
end
% RtPositive_beta_histP1=[RtPositive_beta_histP1,beta1];
% RtPositive_R_histP1=[RtPositive_R_histP1,Rsq1];%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% subplot(2,2,4)
% x=[0 1 2 3 4];
% y=RtNegativeFiringRateP1;
% beta=polyfit(x,y,1);
% beta0=beta(2);
% beta1=beta(1);
% yCalc=beta1*x+beta0;
% Rsq1=1-sum((y-yCalc).^2)/sum((y-mean(y)).^2);
% scatter(x,y);
% hold on
% plot(x,yCalc)
% str=['R=',num2str(Rsq1)];
% title('SpikeOnNegativeFiringRateRt_withRegression_P1')
% RtNegative_beta_histP1=[RtNegative_beta_histP1,beta1];
% RtNegative_R_histP1=[RtNegative_R_histP1,Rsq1];
%

