function MovWindow20210107(RorL)

global RpegTouchallWon LpegTouchallWon SpikeArrayWon RtouchSpikeOnUnit LtouchSpikeOnUnit RtouchSpikeOffUnit LtouchSpikeOffUnit...
    Windowinterval Spikeposition pegpatternum pegpatternname


%%%%%%%windowのstartとendを設定
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

%%%%スパイクウィンドウの設定％％％％50ms
SWS=PWS(3) + width/2 - 25 + Spikeposition;
SWE=SWS+50;
%%%%%%%%



%%%%%左脚ウィンドウ(positive)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%ウィンドウを動かす回数の計算

if ~isempty(strfind(RorL, 'L'));
    MoveWindowNum=fix((LpegTouchallWon(end)-LpegTouchallWon(1))/slide)+1;
    
    
    %%%%タッチ間のインターバルが2秒以上空いている部分を保存
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
    %%%%%Ltouchでウィンドウを動かしていく(20ms秒ずつ動かす)
    for n=1:MoveWindowNum
        LPWStart=PWS+LpegTouchallWon(1)+(n-1)*slide;
        LPWEnd=PWE+LpegTouchallWon(1)+(n-1)*slide;
        SWSart=SWS+LpegTouchallWon(1)+(n-1)*slide;
        SWEnd=SWE+LpegTouchallWon(1)+(n-1)*slide;
        
        SpikePoint=0;
        SpikeKaisu=0;
        WindowPointArray=zeros(1,WindowNum);  %%%% WindowPointArrayとSpikePointはウィンドウが動くたびにリセット
        PositiveWindowTimeArray=zeros(1,WindowNum);
        
        a=0;      %%%%a=0の時Won、a=1の時Woffのため数えない
        if ~isempty(LtouchWaterBreakRestartArray)
            for k=1:length(LtouchWaterBreakRestartArray(:,1))
                if (LtouchWaterBreakRestartArray(k,1)<LPWStart(1) && LPWStart(1)<LtouchWaterBreakRestartArray(k,1))...
                        || (LtouchWaterBreakRestartArray(k,2)<LPWEnd(end) && LPWEnd(end)<LtouchWaterBreakRestartArray(k,2)) %ウィンドウの一部でもWateroffゾーンに入ったらダメ
                    a=1;
                end
                
            end
        end
        
        if a==0;   %%%%a=0の時ウィンドウにタッチが当てはまるかカウント、a==1ならば、スルーしてウィンドウを動かす
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
                if ~isempty(LpegTouchallWon(LPWStart(i)<LpegTouchallWon & LpegTouchallWon<LPWEnd(i))) %%%% i番目のウィンドウの中にタッチがあれば、、、
                    WindowPointArray(i)=1;                                                       %%%%　WindowPointArrayが[0,0,0,0,0]→[1,0,0,0,0]になる
                    WindowTouch=LpegTouchallWon(LPWStart(i)<LpegTouchallWon & LpegTouchallWon<LPWEnd(i));
                    PositiveWindowTimeArray(i)=WindowTouch(1);
                end
            end
        end
        
        LtouchPosiNegaTimeUnit=[LtouchPosiNegaTimeUnit;[SpikeKaisu PositiveWindowTimeArray]];
        %     LtouchNegativeTimeUnit=[LtouchNegativeTimeUnit;NegativeWindowTimeArray];
        
        
        if SpikePoint==1;
            LtouchSpikeOnUnit=[LtouchSpikeOnUnit;[SpikeKaisu WindowPointArray]]; %%%%%%スパイクウィンドウ内にスパイクがあればスパイク回数とウィンドウ配列を保存（10×ウィンドウ動かす回数の行列）
        elseif SpikePoint==0;
            LtouchSpikeOffUnit=[LtouchSpikeOffUnit;WindowPointArray];  %%%%%%スパイクウィンドウ内にスパイクがなければウィンドウ配列を保存（9×ウィンドウ動かす回数の行列）
        end
    end
end



%%%%%%%右足ウィンドウ
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%ウィンドウを動かす回数の計算
if ~isempty(strfind(RorL,'R'));
    MoveWindowNum=fix((RpegTouchallWon(end)-RpegTouchallWon(1))/slide)+1;
    
    
    %%%%タッチ間のインターバルが1秒以上空いている部分を保存
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
    
    %%%%%Rtouchでウィンドウを動かしていく％％％％20ms秒ずつ動かす
    for n=1:MoveWindowNum
        RPWStart=PWS+RpegTouchallWon(1)+(n-1)*slide;
        RPWEnd=PWE+RpegTouchallWon(1)+(n-1)*slide;
        SWSart=SWS+RpegTouchallWon(1)+(n-1)*slide;
        SWEnd=SWE+RpegTouchallWon(1)+(n-1)*slide;
        
        SpikePoint=0;
        SpikeKaisu=0;
        WindowPointArray=zeros(1,WindowNum);  %%%% WindowPointArrayとSpikePointはウィンドウが動くたびにリセット
        PositiveWindowTimeArray=zeros(1,WindowNum);
        a=0;      %%%%a=0の時Won、a=1の時Woffのため数えない
        if ~isempty(RtouchWaterBreakRestartArray)
            for k=1:length(RtouchWaterBreakRestartArray(:,1))
                if (RtouchWaterBreakRestartArray(k,1)<RPWStart(1) && RPWStart(1)<RtouchWaterBreakRestartArray(k,1))...
                        || (RtouchWaterBreakRestartArray(k,2)<RPWEnd(end) && RPWEnd(end)<RtouchWaterBreakRestartArray(k,2)) %ウィンドウの一部でもWateroffゾーンに入ったらダメ
                    a=1;
                end
            end
        end
        
        if a==0;   %%%%a=0の時ウィンドウにタッチが当てはまるかカウント、a==1ならば、スルーしてウィンドウを動かす
            if ~isempty(SpikeArrayWon(SWSart<SpikeArrayWon & SpikeArrayWon<SWEnd));
                SpikePoint=1;
                SpikeKaisu=length(SpikeArrayWon(SWSart<SpikeArrayWon & SpikeArrayWon<SWEnd));
            elseif isempty(SpikeArrayWon(SWSart<SpikeArrayWon & SpikeArrayWon<SWEnd));
                SpikePoint=0;
                SpikeKaisu=0;
            end
            %%%%%%%%%%%%%%%%%
            for i=1:WindowNum
                if ~isempty(RpegTouchallWon(RPWStart(i)<RpegTouchallWon & RpegTouchallWon<RPWEnd(i))) %%%% i番目のウィンドウの中にタッチがあれば、、、
                    WindowPointArray(i)=1;                                                       %%%%　WindowPointArrayが[0,0,0,0,0]→[1,0,0,0,0]になる
                    WindowTouch=RpegTouchallWon(RPWStart(i)<RpegTouchallWon & RpegTouchallWon<RPWEnd(i));
                    PositiveWindowTimeArray(i)=WindowTouch(1);
                end
            end
        end
        
        RtouchPosiNegaTimeUnit=[RtouchPosiNegaTimeUnit;[SpikeKaisu PositiveWindowTimeArray]];%%%%%% WindowTimeArrayが[0,時刻,0,時刻,0]になる
        
        %     RtouchNegativeTimeUnit=[RtouchNegativeTimeUnit;NegativeWindowTimeArray];
        
        
        if SpikePoint==1;
            RtouchSpikeOnUnit=[RtouchSpikeOnUnit;[SpikeKaisu WindowPointArray]]; %%%%%%スパイクウィンドウ内にスパイクがあればスパイク回数とウィンドウ配列を保存（10×ウィンドウ動かす回数の行列）
        elseif SpikePoint==0;
            RtouchSpikeOffUnit=[RtouchSpikeOffUnit;WindowPointArray]; %%%%%%スパイクウィンドウ内にスパイクがなければウィンドウ配列を保存（9×ウィンドウ動かす回数の行列）
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



