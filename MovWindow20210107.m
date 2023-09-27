function MovWindow20210107(RorL)

global RpegTouchallWon LpegTouchallWon SpikeArrayWon RtouchSpikeOnUnit LtouchSpikeOnUnit RtouchSpikeOffUnit LtouchSpikeOffUnit...
    Windowinterval Spikeposition pegpatternum pegpatternname


%%%%%%%window��start��end��ݒ�
WindowNum=5;
width=Windowinterval/2;
slide=50;
%%%%%%%%%%PositiveWindow%%%%%%%%%%%%%%

PWS=zeros(1,WindowNum);
PWE=zeros(1,WindowNum);
for n=1:WindowNum
    PWS(n)=(n-1)*Windowinterval;
    PWE(n)=PWS(n)+width;
end

%%%%�X�p�C�N�E�B���h�E�̐ݒ聓������50ms
SWS=PWS(3) + width/2 - 25 + Spikeposition;
SWE=SWS+50;
%%%%%%%%



%%%%%���r�E�B���h�E(positive)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%�E�B���h�E�𓮂����񐔂̌v�Z

if ~isempty(strfind(RorL, 'L'));
    MoveWindowNum=fix((LpegTouchallWon(end)-LpegTouchallWon(1))/slide)+1;
    
    
    %%%%�^�b�`�Ԃ̃C���^�[�o����2�b�ȏ�󂢂Ă��镔����ۑ�
    LtouchWaterBreakTime=[];
    LtouchWaterRestartTime=[];
    for n=1:length(LpegTouchallWon)-1
        LpegTouchWonInterval1=LpegTouchallWon(n+1)-LpegTouchallWon(n);
        if LpegTouchWonInterval1>1000
            LtouchWaterBreakTime=[LtouchWaterBreakTime;LpegTouchallWon(n)];
            LtouchWaterRestartTime=[LtouchWaterRestartTime;LpegTouchallWon(n+1)];
        end
    end
    LtouchWaterBreakRestartArray=[LtouchWaterBreakTime,LtouchWaterRestartTime];
    %%%%%%%
    
    
    LtouchSpikeOnUnit=[];
    LtouchSpikeOffUnit=[];
    LtouchPosiNegaTimeUnit=[];
    %%%%%Ltouch�ŃE�B���h�E�𓮂����Ă���(20ms�b��������)
    for n=1:MoveWindowNum
        LPWStart=PWS+LpegTouchallWon(1)+(n-1)*slide;
        LPWEnd=PWE+LpegTouchallWon(1)+(n-1)*slide;
        SWSart=SWS+LpegTouchallWon(1)+(n-1)*slide;
        SWEnd=SWE+LpegTouchallWon(1)+(n-1)*slide;
        
        SpikePoint=0;
        SpikeKaisu=0;
        WindowPointArray=zeros(1,WindowNum);  %%%% WindowPointArray��SpikePoint�̓E�B���h�E���������тɃ��Z�b�g
        PositiveWindowTimeArray=zeros(1,WindowNum);
        
        a=0;      %%%%a=0�̎�Won�Aa=1�̎�Woff�̂��ߐ����Ȃ�
        if ~isempty(LtouchWaterBreakRestartArray)
            for k=1:length(LtouchWaterBreakRestartArray(:,1))
                if (LtouchWaterBreakRestartArray(k,1)<LPWStart(1) && LPWStart(1)<LtouchWaterBreakRestartArray(k,1))...
                        || (LtouchWaterBreakRestartArray(k,2)<LPWEnd(end) && LPWEnd(end)<LtouchWaterBreakRestartArray(k,2)) %�E�B���h�E�̈ꕔ�ł�Wateroff�]�[���ɓ�������_��
                    a=1;
                end
                
            end
        end
        
        if a==0;   %%%%a=0�̎��E�B���h�E�Ƀ^�b�`�����Ă͂܂邩�J�E���g�Aa==1�Ȃ�΁A�X���[���ăE�B���h�E�𓮂���
            %%%%%%%%%%%%%%%%
            if ~isempty(SpikeArrayWon(SWSart<SpikeArrayWon & SpikeArrayWon<SWEnd));
                SpikePoint=1;
                SpikeKaisu=length(SpikeArrayWon(SWSart<SpikeArrayWon & SpikeArrayWon<SWEnd));
            elseif isempty(SpikeArrayWon(SWSart<SpikeArrayWon & SpikeArrayWon<SWEnd));
                SpikePoint=0;
                SpikeKaisu=0;
            end
            %%%%%%%%%%%%%%%%%Positewindow
            for i=1:WindowNum
                if ~isempty(LpegTouchallWon(LPWStart(i)<LpegTouchallWon & LpegTouchallWon<LPWEnd(i))) %%%% i�Ԗڂ̃E�B���h�E�̒��Ƀ^�b�`������΁A�A�A
                    WindowPointArray(i)=1;                                                       %%%%�@WindowPointArray��[0,0,0,0,0]��[1,0,0,0,0]�ɂȂ�
                    WindowTouch=LpegTouchallWon(LPWStart(i)<LpegTouchallWon & LpegTouchallWon<LPWEnd(i));
                    PositiveWindowTimeArray(i)=WindowTouch(1);
                end
            end
        end
        
        LtouchPosiNegaTimeUnit=[LtouchPosiNegaTimeUnit;[SpikeKaisu PositiveWindowTimeArray]];
        %     LtouchNegativeTimeUnit=[LtouchNegativeTimeUnit;NegativeWindowTimeArray];
        
        
        if SpikePoint==1;
            LtouchSpikeOnUnit=[LtouchSpikeOnUnit;[SpikeKaisu WindowPointArray]]; %%%%%%�X�p�C�N�E�B���h�E���ɃX�p�C�N������΃X�p�C�N�񐔂ƃE�B���h�E�z���ۑ��i10�~�E�B���h�E�������񐔂̍s��j
        elseif SpikePoint==0;
            LtouchSpikeOffUnit=[LtouchSpikeOffUnit;WindowPointArray];  %%%%%%�X�p�C�N�E�B���h�E���ɃX�p�C�N���Ȃ���΃E�B���h�E�z���ۑ��i9�~�E�B���h�E�������񐔂̍s��j
        end
    end
end



%%%%%%%�E���E�B���h�E
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%�E�B���h�E�𓮂����񐔂̌v�Z
if ~isempty(strfind(RorL,'R'));
    MoveWindowNum=fix((RpegTouchallWon(end)-RpegTouchallWon(1))/slide)+1;
    
    
    %%%%�^�b�`�Ԃ̃C���^�[�o����1�b�ȏ�󂢂Ă��镔����ۑ�
    RtouchWaterBreakTime=[];
    RtouchWaterRestartTime=[];
    for n=1:length(RpegTouchallWon)-1
        RpegTouchWonInterval1=RpegTouchallWon(n+1)-RpegTouchallWon(n);
        if RpegTouchWonInterval1>1000
            RtouchWaterBreakTime=[RtouchWaterBreakTime;RpegTouchallWon(n)];
            RtouchWaterRestartTime=[RtouchWaterRestartTime;RpegTouchallWon(n+1)];
        end
    end
    RtouchWaterBreakRestartArray=[RtouchWaterBreakTime,RtouchWaterRestartTime];
    %%%%%%%
    
    RtouchSpikeOnUnit=[];
    RtouchSpikeOffUnit=[];
    RtouchPosiNegaTimeUnit=[];
    
    %%%%%Rtouch�ŃE�B���h�E�𓮂����Ă�����������20ms�b��������
    for n=1:MoveWindowNum
        RPWStart=PWS+RpegTouchallWon(1)+(n-1)*slide;
        RPWEnd=PWE+RpegTouchallWon(1)+(n-1)*slide;
        SWSart=SWS+RpegTouchallWon(1)+(n-1)*slide;
        SWEnd=SWE+RpegTouchallWon(1)+(n-1)*slide;
        
        SpikePoint=0;
        SpikeKaisu=0;
        WindowPointArray=zeros(1,WindowNum);  %%%% WindowPointArray��SpikePoint�̓E�B���h�E���������тɃ��Z�b�g
        PositiveWindowTimeArray=zeros(1,WindowNum);
        a=0;      %%%%a=0�̎�Won�Aa=1�̎�Woff�̂��ߐ����Ȃ�
        if ~isempty(RtouchWaterBreakRestartArray)
            for k=1:length(RtouchWaterBreakRestartArray(:,1))
                if (RtouchWaterBreakRestartArray(k,1)<RPWStart(1) && RPWStart(1)<RtouchWaterBreakRestartArray(k,1))...
                        || (RtouchWaterBreakRestartArray(k,2)<RPWEnd(end) && RPWEnd(end)<RtouchWaterBreakRestartArray(k,2)) %�E�B���h�E�̈ꕔ�ł�Wateroff�]�[���ɓ�������_��
                    a=1;
                end
            end
        end
        
        if a==0;   %%%%a=0�̎��E�B���h�E�Ƀ^�b�`�����Ă͂܂邩�J�E���g�Aa==1�Ȃ�΁A�X���[���ăE�B���h�E�𓮂���
            if ~isempty(SpikeArrayWon(SWSart<SpikeArrayWon & SpikeArrayWon<SWEnd));
                SpikePoint=1;
                SpikeKaisu=length(SpikeArrayWon(SWSart<SpikeArrayWon & SpikeArrayWon<SWEnd));
            elseif isempty(SpikeArrayWon(SWSart<SpikeArrayWon & SpikeArrayWon<SWEnd));
                SpikePoint=0;
                SpikeKaisu=0;
            end
            %%%%%%%%%%%%%%%%%
            for i=1:WindowNum
                if ~isempty(RpegTouchallWon(RPWStart(i)<RpegTouchallWon & RpegTouchallWon<RPWEnd(i))) %%%% i�Ԗڂ̃E�B���h�E�̒��Ƀ^�b�`������΁A�A�A
                    WindowPointArray(i)=1;                                                       %%%%�@WindowPointArray��[0,0,0,0,0]��[1,0,0,0,0]�ɂȂ�
                    WindowTouch=RpegTouchallWon(RPWStart(i)<RpegTouchallWon & RpegTouchallWon<RPWEnd(i));
                    PositiveWindowTimeArray(i)=WindowTouch(1);
                end
            end
        end
        
        RtouchPosiNegaTimeUnit=[RtouchPosiNegaTimeUnit;[SpikeKaisu PositiveWindowTimeArray]];%%%%%% WindowTimeArray��[0,����,0,����,0]�ɂȂ�
        
        %     RtouchNegativeTimeUnit=[RtouchNegativeTimeUnit;NegativeWindowTimeArray];
        
        
        if SpikePoint==1;
            RtouchSpikeOnUnit=[RtouchSpikeOnUnit;[SpikeKaisu WindowPointArray]]; %%%%%%�X�p�C�N�E�B���h�E���ɃX�p�C�N������΃X�p�C�N�񐔂ƃE�B���h�E�z���ۑ��i10�~�E�B���h�E�������񐔂̍s��j
        elseif SpikePoint==0;
            RtouchSpikeOffUnit=[RtouchSpikeOffUnit;WindowPointArray]; %%%%%%�X�p�C�N�E�B���h�E���ɃX�p�C�N���Ȃ���΃E�B���h�E�z���ۑ��i9�~�E�B���h�E�������񐔂̍s��j
        end
    end
end

%%%%%%%LtouchSpikeOnUnit
if ~isempty(strfind(RorL,'L'));
    XArray=[];
    if ~isempty(LtouchSpikeOnUnit)
        for x=1:length(LtouchSpikeOnUnit(:,1))
            IndexLtPositive=find(LtouchSpikeOnUnit(x,[2:6])==1);
            if length(IndexLtPositive)<1;
                XArray=[XArray x];
            end
        end
        LtouchSpikeOnUnit(XArray(1:end),:)=[];
    else
        LtouchSpikeOnUnit=[0 0 0 0 0 0];
    end
    %%%%%%%LtouchSpikeOffUnit
    XArray=[];
    for x=1:length(LtouchSpikeOffUnit(:,1))
        IndexLtPositive=find(LtouchSpikeOffUnit(x,[1:5])==1);
        if length(IndexLtPositive)<1;
            XArray=[XArray x];
        end
    end
    LtouchSpikeOffUnit(XArray,:)=[];
end

%%%%%%%RtouchSpikeOnUnit
if ~isempty(strfind(RorL,'R'));
    XArray=[];
    if ~isempty(RtouchSpikeOnUnit)
        for x=1:length(RtouchSpikeOnUnit(:,1))
            IndexRtPositive=find(RtouchSpikeOnUnit(x,[2:6])==1);
            if length(IndexRtPositive)<1;
                XArray=[XArray x];
            end
        end
        RtouchSpikeOnUnit(XArray,:)=[];
    else
        RtouchSpikeOnUnit=[0 0 0 0 0 0];
    end
    
    %%%%%%%RtouchSpikeOffUnit
    XArray=[];
    for x=1:length(RtouchSpikeOffUnit(:,1))
        IndexRtPositive=find(RtouchSpikeOffUnit(x,[1:5])==1);
        if length(IndexRtPositive)<1;
            XArray=[XArray x];
        end
    end
    RtouchSpikeOffUnit(XArray,:)=[];
end



