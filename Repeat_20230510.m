function Repeat_20230510

global dpath fname tfile render RpegTouchallWon LpegTouchallWon SpikeArrayWon tfile pegpatternname trimFolder2  pegpatternum ...
    LtPositiveFiringRate RtPositiveFiringRate LtPositiveFiringRateP1 RtPositiveFiringRateP1 LtStep4FiringRate RtStep4FiringRate Spikeposition Windowinterval ...
    LtStep3FiringRate RtStep3FiringRate ...
    LtRsq1 RtRsq1 Ltbeta1 Rtbeta1 LtRsq1_P1 RtRsq1_P1 Ltbeta1_P1 Rtbeta1_P1 ...
    LtRsq RtRsq Ltbeta Rtbeta LtRsq_P1 RtRsq_P1 Ltbeta_P1 Rtbeta_P1

LS1=ls;

%%%%%%%%%% 1歩の中の位相反応性を同定
bin1=20;
phaseR=zeros(1,bin1);
for g=1:length(RpegTouchallWon)-1
    for h=1:length(SpikeArrayWon)-1
        if RpegTouchallWon(g)<SpikeArrayWon(h)&&SpikeArrayWon(h)<=RpegTouchallWon(g+1);   %%タッチ間でスパイクがあったか
            binarrayR=linspace(RpegTouchallWon(g),RpegTouchallWon(g+1),bin1+1);     %%タッチ間をbin1の数に分割
            for e=1:bin1;
                if binarrayR(e)<SpikeArrayWon(h)&&SpikeArrayWon(h)<=binarrayR(e+1);        %%どのビンでスパイクがあったか
                    phaseR(e)=phaseR(e)+1;
                end
            end
        end
    end
end
phaseL=zeros(1,bin1);
for g=1:length(LpegTouchallWon)-1
    for h=1:length(SpikeArrayWon)-1
        if LpegTouchallWon(g)<SpikeArrayWon(h)&&SpikeArrayWon(h)<=LpegTouchallWon(g+1);   %%タッチ間でスパイクがあったか
            binarrayL=linspace(LpegTouchallWon(g),LpegTouchallWon(g+1),bin1+1);   %%タッチ間をbin1の数に分割
            for e=1:length(phaseL)-1
                if binarrayL(e)<SpikeArrayWon(h)&&SpikeArrayWon(h)<=binarrayL(e+1);  %%どのビンでスパイクがあったか
                    phaseL(e)=phaseL(e)+1;
                end
            end
        end
    end
end

%%%%%%%%%%%%%%%%ここから1歩の中の周期
bin2=20;
intervalR=zeros(1,bin2);
for g=1:length(RpegTouchallWon)-1
    for h=1:length(SpikeArrayWon)-1
        if RpegTouchallWon(g)<SpikeArrayWon(h)&&SpikeArrayWon(h)<=RpegTouchallWon(g+1);   %%タッチ間でスパイクがあったか
            interval = RpegTouchallWon(g+1)-RpegTouchallWon(g);
            for e=1:bin2;
                if 280+e*20<interval&&interval<=300+e*20;
                    intervalR(e)=intervalR(e)+1000/(280+e*20);
                end
            end
        end
    end
end
intervalL=zeros(1,bin2);
for g=1:length(LpegTouchallWon)-1
    for h=1:length(SpikeArrayWon)-1
        if LpegTouchallWon(g)<SpikeArrayWon(h)&&SpikeArrayWon(h)<=LpegTouchallWon(g+1);   %%タッチ間でスパイクがあったか
            interval = LpegTouchallWon(g+1)-LpegTouchallWon(g);
            for e=1:bin2;
                if 280+e*20<interval&&interval<=300+e*20;
                    intervalL(e)=intervalL(e)+1000/(280+e*20);
                end
            end
        end
    end
end

[MaxphR,IndexphR]=max(phaseR);
[MaxphL,IndexphL]=max(phaseL);
RphPeakIndexRatio=(IndexphR-1)/bin1; %% 0-1のどこで一番発火したか
LphPeakIndexRatio=(IndexphL-1)/bin1;

[MaxintR,IndexintR]=max(intervalR);
[MaxintL,IndexintL]=max(intervalL);
RintPeak=IndexintR*20+280; %% 300-700のどこで一番発火したか
LintPeak=IndexintL*20+280;


%%%%%%%%%%%%%%%%%%%%%%%% for R
RtRsq = 0;
Rtbeta = 0;
RtRsq_P1 = 0;
Rtbeta_P1 = 0;
if strcmp(fname(end-8:end-7),'_C');
    for a=1:2
        for b=1:2
            %         Windowinterval=RintPeak+10;  %% 一番反応するintervalでwindowを作成する
            %         Spikeposition=(IndexphR-10)/20*Windowinterval;  %% 一番反応する位置にスパイクのwindowを作成する
            
            Windowinterval=400+(a-1)*200;  %% 400,600の2種類
            Spikeposition=(b-1)*Windowinterval*0.5; %% 0, piの2種類
            
            MovWindow20210107('R')          %ウィンドウを動かす
            WindowApply20200225('R')
            WindowApplyPattern1_20200228('R')
            
            %%% Rsq1とかbeta1などがWindowApplyから帰ってくる変数、Rsqとかbetaがその細胞にとっての最大のもの
            if (abs(RtRsq) + abs(Rtbeta)) < (abs(RtRsq1) + abs(Rtbeta1))   %%%%%%% 足し算して高いやつをとってくる(大体Rsqに引っ張られるはず、、、)
                RtRsq = RtRsq1;
                Rtbeta = Rtbeta1;
            end
            if (abs(RtRsq_P1) + abs(Rtbeta_P1)) < (RtRsq1_P1 + Rtbeta1_P1)
                RtRsq_P1 = RtRsq1_P1;
                Rtbeta_P1 = Rtbeta1_P1;
            end
        end
    end
end
%%%%%%%%%%%%%%%%%%%%%%%%%% for L

LtRsq = 0;
Ltbeta = 0;
LtRsq_P1 = 0;
Ltbeta_P1 = 0;
if strcmp(fname(end-8:end-7),'_C');
    for a=1:2
        for b=1:2
            %         Windowinterval=LintPeak+10;  %% 一番反応するintervalでwindowを作成する
            %         Spikeposition=(IndexphL-10)/20*Windowinterval;  %% 一番反応する位置にスパイクのwindowを作成するS
            
            Windowinterval=400+(a-1)*200;  %% 400,600の2種類
            Spikeposition=(b-1)*Windowinterval*0.5; %% 0, piの2種類
            
            MovWindow20210107('L')          %ウィンドウを動かす
            WindowApply20200225('L')
            WindowApplyPattern1_20200228('L')
            
            if (abs(LtRsq) + abs(Ltbeta)) < (abs(LtRsq1) + abs(Ltbeta1))   %%%%%%% 足し算して高いやつをとってくる(大体Rsqに引っ張られるはず、、、)
                LtRsq = LtRsq1;
                Ltbeta = Ltbeta1;
            end
            if (abs(LtRsq_P1) + abs(Ltbeta_P1)) < (abs(LtRsq1_P1) + abs(Ltbeta1_P1))
                LtRsq_P1 = LtRsq1_P1;
                Ltbeta_P1 = Ltbeta1_P1;
            end
        end
    end
end

%%% 繰り返しのFigure（連続）
if render==1;
    figure('Name','Left repeat FR','NumberTitle','off');
    data = [LtpositiveFRarray1; LtpositiveFRarray2; LtpositiveFRarray3; LtpositiveFRarray4; LtpositiveFRarray5];
    x = [1 2 3 4 5];
    y = mean(data,2);
    SEM = std(data,0,2)./sqrt(length(data));
    bar(x,y);
    hold on
    err = errorbar(y,SEM);
    err.LineStyle = 'None';
    err.Color = 'k';
    hold off
%     saveas(gcf, 'Left_repeat_FR.bmp')
%     [p,~,stats] = anova1(data.');
%     [results,means] = multcompare(stats,'CType','bonferroni');
    
    figure('Name','Right repeat FR','NumberTitle','off');
    data = [RtpositiveFRarray1; RtpositiveFRarray2; RtpositiveFRarray3; RtpositiveFRarray4; RtpositiveFRarray5];
    y = mean(data,2);
    SEM = std(data,0,2)./sqrt(length(data));
    bar(x,y);
    hold on
    err = errorbar(y,SEM);
    err.LineStyle = 'None';
    err.Color = 'k';
    hold off
%     saveas(gcf, 'Right_repeat_FR.bmp')
%     [p,~,stats] = anova1(data.');
%     [results,means] = multcompare(stats,'CType','bonferroni');
    
    
    %%% 繰り返しのFigure（連続じゃない）
    figure('Name','Left repeat FR_P1','NumberTitle','off');
    data = [LtpositiveFRarray1_P1; LtpositiveFRarray2_P1; LtpositiveFRarray3_P1; LtpositiveFRarray4_P1; LtpositiveFRarray5_P1];
    y = mean(data,2);
    SEM = std(data,0,2)./sqrt(length(data));
    bar(x,y);
    hold on
    err = errorbar(y,SEM);
    err.LineStyle = 'None';
    err.Color = 'k';
    hold off
%     saveas(gcf, 'Left_repeat_FR_P1.bmp')
%     [p,~,stats] = anova1(data.');
%     [results,means] = multcompare(stats,'CType','bonferroni');
    
    figure('Name','Right repeat FR_P1','NumberTitle','off');
    data = [RtpositiveFRarray1_P1; RtpositiveFRarray2_P1; RtpositiveFRarray3_P1; RtpositiveFRarray4_P1; RtpositiveFRarray5_P1];
    y = mean(data,2);
    SEM = std(data,0,2)./sqrt(length(data));
    bar(x,y);
    hold on
    err = errorbar(y,SEM);
    err.LineStyle = 'None';
    err.Color = 'k';
    hold off
%     saveas(gcf, 'Right_repeat_FR_P1.bmp')
%     [p,~,stats] = anova1(data.');
%     [results,means] = multcompare(stats,'CType','bonferroni');
end

