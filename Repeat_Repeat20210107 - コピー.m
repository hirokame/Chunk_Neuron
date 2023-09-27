function Repeat_Repeat20210107
global RpegTouchallWon LpegTouchallWon SpikeArrayWon tfile pegpatternname trimFolder2  pegpatternum ...
    LtPositiveFiringRate RtPositiveFiringRate LtPositiveFiringRateP1 RtPositiveFiringRateP1 Spikeposition Windowinterval ...

intnum=21;
phasenum=21;

LtPositiveFiringRateArray_gt4=zeros(intnum,phasenum);
LtPositiveFiringRateArray_lt3=zeros(intnum,phasenum);
RtPositiveFiringRateArray_gt4=zeros(intnum,phasenum);
RtPositiveFiringRateArray_lt3=zeros(intnum,phasenum);

LtPositiveFiringRateArrayP1_gt4=zeros(intnum,phasenum);
LtPositiveFiringRateArrayP1_lt3=zeros(intnum,phasenum);
RtPositiveFiringRateArrayP1_gt4=zeros(intnum,phasenum);
RtPositiveFiringRateArrayP1_lt3=zeros(intnum,phasenum);

LtPositiveFiringRateArray_devide=zeros(intnum,phasenum);
RtPositiveFiringRateArray_devide=zeros(intnum,phasenum);

LtPositiveFiringRateArrayP1_devide=zeros(intnum,phasenum);
RtPositiveFiringRateArrayP1_devide=zeros(intnum,phasenum);


% LtPositiveFiringRateArray_0=zeros(intnum,phasenum);
% RtPositiveFiringRateArray_0=zeros(intnum,phasenum);
% LtPositiveFiringRateArray_1=zeros(intnum,phasenum);
% RtPositiveFiringRateArray_1=zeros(intnum,phasenum);
% LtPositiveFiringRateArray_2=zeros(intnum,phasenum);
% RtPositiveFiringRateArray_2=zeros(intnum,phasenum);
% LtPositiveFiringRateArray_3=zeros(intnum,phasenum);
% RtPositiveFiringRateArray_3=zeros(intnum,phasenum);
% LtPositiveFiringRateArray_4=zeros(intnum,phasenum);
% RtPositiveFiringRateArray_4=zeros(intnum,phasenum);
% LtPositiveFiringRateArray_5=zeros(intnum,phasenum);
% RtPositiveFiringRateArray_5=zeros(intnum,phasenum);
% 
% LtPositiveFiringRateArrayP1_0=zeros(intnum,phasenum);
% RtPositiveFiringRateArrayP1_0=zeros(intnum,phasenum);
% LtPositiveFiringRateArrayP1_1=zeros(intnum,phasenum);
% RtPositiveFiringRateArrayP1_1=zeros(intnum,phasenum);
% LtPositiveFiringRateArrayP1_2=zeros(intnum,phasenum);
% RtPositiveFiringRateArrayP1_2=zeros(intnum,phasenum);
% LtPositiveFiringRateArrayP1_3=zeros(intnum,phasenum);
% RtPositiveFiringRateArrayP1_3=zeros(intnum,phasenum);
% LtPositiveFiringRateArrayP1_4=zeros(intnum,phasenum);
% RtPositiveFiringRateArrayP1_4=zeros(intnum,phasenum);
% LtPositiveFiringRateArrayP1_5=zeros(intnum,phasenum);
% RtPositiveFiringRateArrayP1_5=zeros(intnum,phasenum);

path='C:\Users\C238\CheetahWRLV20220213';
cd(path);
if not(exist('touchcellLtRt_Hirokane','dir'))
    mkdir('touchcellLtRt_Hirokane')
end
cellnum=0;
patternnum=1;

LS1=ls;
for i=1:length(LS1(:,1)) %1列目で固定、行を動かす。各マウスでイテレーションを回す。
    trimFolder=strtrim(LS1(i,:));
    if ~strcmp(trimFolder,'.') && ~strcmp(trimFolder,'..') && isempty(strfind(trimFolder,'.bmp')) && ~strcmp(trimFolder,'CCSfigure') && isempty(strfind(trimFolder,'SpikeFormAnalysis')) && isempty(strfind(trimFolder,'Count')) && isempty(strfind(trimFolder,'widthPtoT')) && ~strcmp(trimFolder,'CCSfigure-Lt') && ~strcmp(trimFolder,'CCSfigure-RLt') && ~strcmp(trimFolder,'CCSfigure-Rt')
        CDFolder=[path,'\',trimFolder]; %cdフォルダ変更C:\Users\C238\Desktop\CheetahWRLV20180729Part1\trimfolder(mouseNo)
        cd(CDFolder);
        LS2=ls;
        for j=1:length(LS2(:,1))% 各トライアルでイテレーションを回す。
            trimFolder2=strtrim(LS2(j,:));
            if length(trimFolder2)>4 && ~strcmp(trimFolder2(end-3:end),'.mat');
                CDFolder2=[CDFolder,'\',trimFolder2];  %C:\Users\C238\Desktop\CheetahWRLV20180729Part1\119\2017-6-7_20-8-33 11901-51
                pegpattern=[];
                cd(CDFolder2)
                LS3=ls;
                for c=1:length(LS3(:,1))
                    trimLS3=strtrim(LS3(c,:));
                    if length(trimLS3)>10 && strcmp(trimLS3(end-3:end),'.mat');
                        pegpattern=[pegpattern;trimLS3]; %ペグパターンを読み込む(.matファイル)
                    end
                end
                TouchCellName=[];
                CDFolder3=[CDFolder2,'\CellCell2'];%C:\Users\C238\Desktop\CheetahWRLV20180729Part1\119\2017-6-7_20-8-33 11901-51\CellCell
                cd(CDFolder3)
                LSC=ls;
                for x=1:length(LSC(:,1));
                    
                    trimCellFolder=strtrim(LSC(x,:));
                    if length(trimCellFolder)>4 && ~strcmp(trimCellFolder((end-3):end),'.mat');
                        CDFolder5=[CDFolder3,'\',trimCellFolder]; %C:\Users\C238\Desktop\CheetahWRLV20180729Part1\119\2017-6-7_20-8-33 11901-51\CellCell\Sc2_SS_01
                        cd(CDFolder5)
                        load('response.mat')
                        if ~isempty(strfind(response,'Rt')) || ~isempty(strfind(response,'Lt')); %タッチに反応する細胞見つける
                            if ~isempty(strfind(response, 'MSN'));
                                TouchCellName=[TouchCellName;trimCellFolder];% 右左両方のタッチに反応する細胞のフォルダ番号を格納していく。各マウスごとに
                            end
                        end
                    end
                end
                
                
                if ~isempty(TouchCellName);
                    for k=1:length(TouchCellName(:,1));%%両足のタッチに反応している細胞で回していく
                        SpikeArray=[];
                        tfile=[strtrim(TouchCellName(k,:)),'.t'];%% .tファイル
                        %                     SpikeArray=GetSpikeAll(CDFolder2,tfile);
                        SpikeArrayWon=[];
                        cd('C:\Users\C238\CheetahWRLV20220213\touchcellLtRt_Hirokane');
                        for d=1:length(pegpattern(:,1));%保存したペグパターンごとに見ていく(最初のComplex patternを解析し終わったら break)
                            if ~isempty(strfind(pegpattern(d,:),'_C'));%_Cの配列を見つけたら
                                cellnum=cellnum+1;
                                Foldercell=num2str(cellnum); %num2strは数値を
                                mkdir(Foldercell); %%1~149の細胞番号順にディレクトリを作成
                              
                                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                                %%%%ここから、Bgraと98を使って、至適な周期と位相を発見していく。
                                
                                for f=1:length(pegpattern(:,1));%　ペグパターンごとに見ていく
                                    if ~isempty(strfind(pegpattern(f,:),'_98')); %まずは98の配列を見つけたら
                                        CDFolder98=[CDFolder2,'\',pegpattern(f,(1:end-4))];
                                        cd(CDFolder98)
                                        file=['Bdata.mat'];
                                        load(file);
                                        SpikeArray=GetSpikeAll(CDFolder2,tfile);
                                        SpikeArray(SpikeArray<StartTime | SpikeArray>FinishTime)=[];
                                        %WaterOnのときのみのスパイク
                                        if ~isempty(SpikeArray)
                                            SpikeWon=ones(1,length(SpikeArray));
                                            for l=1:length(SpikeArray)
                                                if OnWater(SpikeArray(l))==0
                                                    SpikeWon(l)=0;
                                                end
                                            end
                                            SpikeArrayWon=SpikeArray.*SpikeWon;
                                            SpikeArrayWon(SpikeArrayWon==0)=[];
                                            
                                        end
                                        %WaterOnのときのみのRpegTouchall
                                        if ~isempty(RpegTouchall)
                                            RTWon=ones(1,length(RpegTouchall));
                                            for l=1:length(RpegTouchall)
                                                if OnWater(RpegTouchall(l))==0
                                                    RTWon(l)=0;
                                                end
                                            end
                                            RpegTouchallWon=RpegTouchall.*RTWon;
                                            RpegTouchallWon(RpegTouchallWon==0)=[];
                                            RpegTouchallWoff=RpegTouchall.*not(RTWon);
                                            RpegTouchallWoff(RpegTouchallWoff==0)=[];
                                        else
                                            RpegTouchallWon=0;
                                            RpegTouchallWoff=0;
                                        end
                                        %WaterOnのときのみのLpegTouchall
                                        if ~isempty(LpegTouchall)
                                            LTWon=ones(1,length(LpegTouchall));
                                            for l=1:length(LpegTouchall)
                                                if OnWater(LpegTouchall(l))==0
                                                    LTWon(l)=0;
                                                end
                                            end
                                            LpegTouchallWon=LpegTouchall.*LTWon;
                                            LpegTouchallWon(LpegTouchallWon==0)=[];
                                            LpegTouchallWoff=LpegTouchall.*not(LTWon);
                                            LpegTouchallWoff(LpegTouchallWoff==0)=[];
                                        else
                                            LpegTouchallWon=0;
                                            LpegTouchallWoff=0;
                                        end
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
                                    end
                                    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                                    %ここから周期
                                    
                                    if ~isempty(strfind(pegpattern(f,:),'_Bgra')); %次にBgraの配列を見つけたら
                                        CDFolderBgra=[CDFolder2,'\',pegpattern(f,(1:end-4))];
                                        cd(CDFolderBgra)
                                        file=['Bdata.mat'];
                                        load(file);
                                        SpikeArray=GetSpikeAll(CDFolder2,tfile);
                                        SpikeArray(SpikeArray<StartTime | SpikeArray>FinishTime)=[];
                                        %WaterOnのときのみのスパイク
                                        if ~isempty(SpikeArray)
                                            SpikeWon=ones(1,length(SpikeArray));
                                            for l=1:length(SpikeArray)
                                                if OnWater(SpikeArray(l))==0
                                                    SpikeWon(l)=0;
                                                end
                                            end
                                            SpikeArrayWon=SpikeArray.*SpikeWon;
                                            SpikeArrayWon(SpikeArrayWon==0)=[];
                                            
                                        end
                                        %WaterOnのときのみのRpegTouchall
                                        if ~isempty(RpegTouchall)
                                            RTWon=ones(1,length(RpegTouchall));
                                            for l=1:length(RpegTouchall)
                                                if OnWater(RpegTouchall(l))==0
                                                    RTWon(l)=0;
                                                end
                                            end
                                            RpegTouchallWon=RpegTouchall.*RTWon;
                                            RpegTouchallWon(RpegTouchallWon==0)=[];
                                            RpegTouchallWoff=RpegTouchall.*not(RTWon);
                                            RpegTouchallWoff(RpegTouchallWoff==0)=[];
                                        else
                                            RpegTouchallWon=0;
                                            RpegTouchallWoff=0;
                                        end
                                        %WaterOnのときのみのLpegTouchall
                                        if ~isempty(LpegTouchall)
                                            LTWon=ones(1,length(LpegTouchall));
                                            for l=1:length(LpegTouchall)
                                                if OnWater(LpegTouchall(l))==0
                                                    LTWon(l)=0;
                                                end
                                            end
                                            LpegTouchallWon=LpegTouchall.*LTWon;
                                            LpegTouchallWon(LpegTouchallWon==0)=[];
                                            LpegTouchallWoff=LpegTouchall.*not(LTWon);
                                            LpegTouchallWoff(LpegTouchallWoff==0)=[];
                                        else
                                            LpegTouchallWon=0;
                                            LpegTouchallWoff=0;
                                        end
                                        bin2=20;
                                        intervalR=zeros(1,bin2);
                                        for g=1:length(RpegTouchallWon)-1
                                            for h=1:length(SpikeArrayWon)-1
                                                if RpegTouchallWon(g)<SpikeArrayWon(h)&&SpikeArrayWon(h)<=RpegTouchallWon(g+1);   %%タッチ間でスパイクがあったか
                                                    interval = RpegTouchallWon(g+1)-RpegTouchallWon(g);
                                                    for e=1:bin2;
                                                        if 280+e*20<interval&&interval<=300+e*20;
                                                            intervalR(e)=intervalR(e)+1/(280+e*20);
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
                                                            intervalL(e)=intervalL(e)+1/(280+e*20);
                                                        end
                                                    end
                                                end
                                            end
                                        end
                                    end
                                end
                                % 1歩のどの位相で最も発火しやすかったか
                                [MaxphR,IndexphR]=max(phaseR);
                                [MaxphL,IndexphL]=max(phaseL);
                                RphPeakIndexRatio=(IndexphR-1)/bin1;
                                LphPeakIndexRatio=(IndexphL-1)/bin1;
                                
                                [MaxintR,IndexintR]=max(intervalR);
                                [MaxintL,IndexintL]=max(intervalL);
                                RintPeak=IndexintR*20+280;
                                LintPeak=IndexintL*20+280;
                                
                                filename=['C:\Users\C238\CheetahWRLV20220213\touchcellLtRt_Hirokane\', Foldercell, '\', num2str(patternnum),'ph_int_fromBgra98.mat'];
                                save(filename,'RintPeak', 'LintPeak', 'RphPeakIndexRatio', 'LphPeakIndexRatio')
                                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                                %%%%下のヒートマップ解析用のComplex patternのデータを入れる
                                
                                CDFolder5=[CDFolder2,'\',pegpattern(d,(1:end-4))];
                                cd(CDFolder5)
                                file=['Bdata.mat'];
                                load(file);
                                SpikeArray=GetSpikeAll(CDFolder2,tfile);
                                SpikeArray(SpikeArray<StartTime | SpikeArray>FinishTime)=[];
                                %WaterOnのときのみのスパイク
                                if ~isempty(SpikeArray)
                                    SpikeWon=ones(1,length(SpikeArray));
                                    for l=1:length(SpikeArray)
                                        if OnWater(SpikeArray(l))==0
                                            SpikeWon(l)=0;
                                        end
                                    end
                                    SpikeArrayWon=SpikeArray.*SpikeWon;
                                    SpikeArrayWon(SpikeArrayWon==0)=[];
                                    
                                end
                                %WaterOnのときのみのRpegTouchall
                                if ~isempty(RpegTouchall)
                                    RTWon=ones(1,length(RpegTouchall));
                                    for l=1:length(RpegTouchall)
                                        if OnWater(RpegTouchall(l))==0
                                            RTWon(l)=0;
                                        end
                                    end
                                    RpegTouchallWon=RpegTouchall.*RTWon;
                                    RpegTouchallWon(RpegTouchallWon==0)=[];
                                    RpegTouchallWoff=RpegTouchall.*not(RTWon);
                                    RpegTouchallWoff(RpegTouchallWoff==0)=[];
                                else
                                    RpegTouchallWon=0;
                                    RpegTouchallWoff=0;
                                end
                                %WaterOnのときのみのLpegTouchall
                                if ~isempty(LpegTouchall)
                                    LTWon=ones(1,length(LpegTouchall));
                                    for l=1:length(LpegTouchall)
                                        if OnWater(LpegTouchall(l))==0
                                            LTWon(l)=0;
                                        end
                                    end
                                    LpegTouchallWon=LpegTouchall.*LTWon;
                                    LpegTouchallWon(LpegTouchallWon==0)=[];
                                    LpegTouchallWoff=LpegTouchall.*not(LTWon);
                                    LpegTouchallWoff(LpegTouchallWoff==0)=[];
                                else
                                    LpegTouchallWon=0;
                                    LpegTouchallWoff=0;
                                end
                                pegpatternname=pegpattern(d,(end-8:end-4));
                                pegpatternum=pegpattern(d,(1:5));
                                Folder6=['C:\Users\C238\CheetahWRLV20220213\touchcellLtRt_Hirokane','\',Foldercell];
                                cd(Folder6)
                                patternnum=patternnum+1;
                                cellnum
%                                 pegpatternname
%                                 pegpatternum
%                                 patternnum
                                
                                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                                h = waitbar(0, 'running');
                                loopnum = intnum*phasenum;
                                inc=0;
                                for b=1:intnum
                                    
                                    intbin=200/(intnum-1);
                                    Windowinterval=(300-intbin)+b*(intbin);
                                    for a=1:phasenum
                                        waitbar(inc/loopnum)
                                        inc=inc+1;
                                        phasebin=(phasenum-1)/2;
                                        Spikeposition=(a-1-phasebin)*Windowinterval/phasebin;
                                        MovWindow20210107          %%%%%%%ウィンドウを動かす
%                                         WindowApply20200225         %0~5の時はこっち
%                                         WindowApplyPattern1_20200228
                                        WindowApply20210107         %%%%%%%当てはまり方の計算 gt4/lt3はこっち
                                        WindowApplyPattern1_20210107
                                        
                                        LtPositiveFiringRateArray_gt4(b,a)=LtPositiveFiringRate(2);
                                        LtPositiveFiringRateArray_lt3(b,a)=LtPositiveFiringRate(1);
                                        RtPositiveFiringRateArray_gt4(b,a)=RtPositiveFiringRate(2);
                                        RtPositiveFiringRateArray_lt3(b,a)=RtPositiveFiringRate(1);
                                        
                                        LtPositiveFiringRateArrayP1_gt4(b,a)=LtPositiveFiringRateP1(2);
                                        LtPositiveFiringRateArrayP1_lt3(b,a)=LtPositiveFiringRateP1(1);
                                        RtPositiveFiringRateArrayP1_gt4(b,a)=RtPositiveFiringRateP1(2);
                                        RtPositiveFiringRateArrayP1_lt3(b,a)=RtPositiveFiringRateP1(1);
                                        
                                        LtPositiveFiringRateArray_devide(b,a)=LtPositiveFiringRate(2)./(LtPositiveFiringRate(1)+0.000001);
                                        RtPositiveFiringRateArray_devide(b,a)=RtPositiveFiringRate(2)./(RtPositiveFiringRate(1)+0.000001);
                                        LtPositiveFiringRateArrayP1_devide(b,a)=LtPositiveFiringRateP1(2)./(LtPositiveFiringRateP1(1)+0.000001);
                                        RtPositiveFiringRateArrayP1_devide(b,a)=RtPositiveFiringRateP1(2)./(RtPositiveFiringRateP1(1)+0.000001);

%                                         LtPositiveFiringRateArray_0(b,a)=LtPositiveFiringRate(1);
%                                         RtPositiveFiringRateArray_0(b,a)=RtPositiveFiringRate(1);
%                                         LtPositiveFiringRateArray_1(b,a)=LtPositiveFiringRate(2);
%                                         RtPositiveFiringRateArray_1(b,a)=RtPositiveFiringRate(2);
%                                         LtPositiveFiringRateArray_2(b,a)=LtPositiveFiringRate(3);
%                                         RtPositiveFiringRateArray_2(b,a)=RtPositiveFiringRate(3);
%                                         LtPositiveFiringRateArray_3(b,a)=LtPositiveFiringRate(4);
%                                         RtPositiveFiringRateArray_3(b,a)=RtPositiveFiringRate(4);
%                                         LtPositiveFiringRateArray_4(b,a)=LtPositiveFiringRate(5);
%                                         RtPositiveFiringRateArray_4(b,a)=RtPositiveFiringRate(5);
%                                         LtPositiveFiringRateArray_5(b,a)=LtPositiveFiringRate(6);
%                                         RtPositiveFiringRateArray_5(b,a)=RtPositiveFiringRate(6);
%                                         
%                                         LtPositiveFiringRateArrayP1_0(b,a)=LtPositiveFiringRate(1);
%                                         RtPositiveFiringRateArrayP1_0(b,a)=RtPositiveFiringRate(1);
%                                         LtPositiveFiringRateArrayP1_1(b,a)=LtPositiveFiringRate(2);
%                                         RtPositiveFiringRateArrayP1_1(b,a)=RtPositiveFiringRate(2);
%                                         LtPositiveFiringRateArrayP1_2(b,a)=LtPositiveFiringRate(3);
%                                         RtPositiveFiringRateArrayP1_2(b,a)=RtPositiveFiringRate(3);
%                                         LtPositiveFiringRateArrayP1_3(b,a)=LtPositiveFiringRate(4);
%                                         RtPositiveFiringRateArrayP1_3(b,a)=RtPositiveFiringRate(4);
%                                         LtPositiveFiringRateArrayP1_4(b,a)=LtPositiveFiringRate(5);
%                                         RtPositiveFiringRateArrayP1_4(b,a)=RtPositiveFiringRate(5);
%                                         LtPositiveFiringRateArrayP1_5(b,a)=LtPositiveFiringRate(6);
%                                         RtPositiveFiringRateArrayP1_5(b,a)=RtPositiveFiringRate(6);
                                        
                                    end
                                end
                                close(h)
                                
                                
                                h=HeatMap(LtPositiveFiringRateArray_gt4,'Colormap',jet);
                                h.plot
                                figname=[num2str(patternnum),'Heatmap_LP_gt4.bmp'];
                                saveas(gcf,figname)
                                
                                h=HeatMap(LtPositiveFiringRateArray_lt3,'Colormap',jet);
                                h.plot
                                figname=[num2str(patternnum),'Heatmap_LP_lt3.bmp'];
                                saveas(gcf,figname)
                                
                                h=HeatMap(RtPositiveFiringRateArray_gt4,'Colormap',jet);
                                h.plot
                                figname=[num2str(patternnum),'Heatmap_RP_gt4.bmp'];
                                saveas(gcf,figname)
                                
                                h=HeatMap(RtPositiveFiringRateArray_lt3,'Colormap',jet);
                                h.plot
                                figname=[num2str(patternnum),'Heatmap_RP_lt3.bmp'];
                                saveas(gcf,figname)
                                
                                
                                h=HeatMap(LtPositiveFiringRateArrayP1_gt4,'Colormap',jet);
                                h.plot
                                figname=[num2str(patternnum),'Heatmap_LP_gt4P1.bmp'];
                                saveas(gcf,figname)
                                
                                h=HeatMap(LtPositiveFiringRateArrayP1_lt3,'Colormap',jet);
                                h.plot
                                figname=[num2str(patternnum),'Heatmap_LP_lt3P1.bmp'];
                                saveas(gcf,figname)
                                
                                h=HeatMap(RtPositiveFiringRateArrayP1_gt4,'Colormap',jet);
                                h.plot
                                figname=[num2str(patternnum),'Heatmap_RP_gt4P1.bmp'];
                                saveas(gcf,figname)
                                
                                h=HeatMap(RtPositiveFiringRateArrayP1_lt3,'Colormap',jet);
                                h.plot
                                figname=[num2str(patternnum),'Heatmap_RP_lt3P1.bmp'];
                                saveas(gcf,figname)
                                
                                h=HeatMap(LtPositiveFiringRateArray_devide,'Colormap',jet);
                                h.plot
                                figname=[num2str(patternnum),'Heatmap_LP_devide.bmp'];
                                saveas(gcf,figname)
                                
                                h=HeatMap(RtPositiveFiringRateArray_devide,'Colormap',jet);
                                h.plot
                                figname=[num2str(patternnum),'Heatmap_RP_devide.bmp'];
                                saveas(gcf,figname)
                                
                                h=HeatMap(LtPositiveFiringRateArrayP1_devide,'Colormap',jet);
                                h.plot
                                figname=[num2str(patternnum),'Heatmap_LP_devideP1.bmp'];
                                saveas(gcf,figname)
                                
                                h=HeatMap(RtPositiveFiringRateArrayP1_devide,'Colormap',jet);
                                h.plot
                                figname=[num2str(patternnum),'Heatmap_RP_devideP1.bmp'];
                                saveas(gcf,figname)
                                
                                close all hidden
                                
                                filename=[num2str(patternnum),'heatmap.mat'];
                                save(filename,'LtPositiveFiringRateArray_gt4','LtPositiveFiringRateArray_lt3','RtPositiveFiringRateArray_gt4','RtPositiveFiringRateArray_lt3'...
                                    ,'LtPositiveFiringRateArrayP1_gt4','LtPositiveFiringRateArrayP1_lt3','RtPositiveFiringRateArrayP1_gt4','RtPositiveFiringRateArrayP1_lt3'...
                                    ,'LtPositiveFiringRateArray_devide','RtPositiveFiringRateArray_devide','LtPositiveFiringRateArrayP1_devide','RtPositiveFiringRateArrayP1_devide')
                                
%                                 h=HeatMap(LtPositiveFiringRateArray_0,'Colormap',jet);
%                                 h.plot
%                                 figname=[num2str(patternnum),'Heatmap_LP_0.bmp'];
%                                 saveas(gcf,figname)
%                                 
%                                 h=HeatMap(RtPositiveFiringRateArray_0,'Colormap',jet);
%                                 h.plot
%                                 figname=[num2str(patternnum),'Heatmap_RP_0.bmp'];
%                                 saveas(gcf,figname)
%                                 
%                                 h=HeatMap(LtPositiveFiringRateArray_1,'Colormap',jet);
%                                 h.plot
%                                 figname=[num2str(patternnum),'Heatmap_LP_1.bmp'];
%                                 saveas(gcf,figname)
%                                 
%                                 h=HeatMap(RtPositiveFiringRateArray_1,'Colormap',jet);
%                                 h.plot
%                                 figname=[num2str(patternnum),'Heatmap_RP_1.bmp'];
%                                 saveas(gcf,figname)
%                                 
%                                 h=HeatMap(LtPositiveFiringRateArray_2,'Colormap',jet);
%                                 h.plot
%                                 figname=[num2str(patternnum),'Heatmap_LP_2.bmp'];
%                                 saveas(gcf,figname)
%                                 
%                                 h=HeatMap(RtPositiveFiringRateArray_2,'Colormap',jet);
%                                 h.plot
%                                 figname=[num2str(patternnum),'Heatmap_RP_2.bmp'];
%                                 saveas(gcf,figname)
%                                 
%                                 h=HeatMap(LtPositiveFiringRateArray_3,'Colormap',jet);
%                                 h.plot
%                                 figname=[num2str(patternnum),'Heatmap_LP_3.bmp'];
%                                 saveas(gcf,figname)
%                                 
%                                 h=HeatMap(RtPositiveFiringRateArray_3,'Colormap',jet);
%                                 h.plot
%                                 figname=[num2str(patternnum),'Heatmap_RP_3.bmp'];
%                                 saveas(gcf,figname)
%                                 
%                                 h=HeatMap(LtPositiveFiringRateArray_4,'Colormap',jet);
%                                 h.plot
%                                 figname=[num2str(patternnum),'Heatmap_LP_4.bmp'];
%                                 saveas(gcf,figname)
%                                 
%                                 h=HeatMap(RtPositiveFiringRateArray_4,'Colormap',jet);
%                                 h.plot
%                                 figname=[num2str(patternnum),'Heatmap_RP_4.bmp'];
%                                 saveas(gcf,figname)
%                                 
%                                 h=HeatMap(LtPositiveFiringRateArray_5,'Colormap',jet);
%                                 h.plot
%                                 figname=[num2str(patternnum),'Heatmap_LP_5.bmp'];
%                                 saveas(gcf,figname)
%                                 
%                                 h=HeatMap(RtPositiveFiringRateArray_5,'Colormap',jet);
%                                 h.plot
%                                 figname=[num2str(patternnum),'Heatmap_RP_5.bmp'];
%                                 saveas(gcf,figname)
%                                 
%                                 h=HeatMap(LtPositiveFiringRateArrayP1_0,'Colormap',jet);
%                                 h.plot
%                                 figname=[num2str(patternnum),'Heatmap_LP1_0.bmp'];
%                                 saveas(gcf,figname)
%                                 
%                                 h=HeatMap(RtPositiveFiringRateArrayP1_0,'Colormap',jet);
%                                 h.plot
%                                 figname=[num2str(patternnum),'Heatmap_RP1_0.bmp'];
%                                 saveas(gcf,figname)
%                                 
%                                 h=HeatMap(LtPositiveFiringRateArrayP1_1,'Colormap',jet);
%                                 h.plot
%                                 figname=[num2str(patternnum),'Heatmap_LP1_1.bmp'];
%                                 saveas(gcf,figname)
%                                 
%                                 h=HeatMap(RtPositiveFiringRateArrayP1_1,'Colormap',jet);
%                                 h.plot
%                                 figname=[num2str(patternnum),'Heatmap_RP1_1.bmp'];
%                                 saveas(gcf,figname)
%                                 
%                                 h=HeatMap(LtPositiveFiringRateArrayP1_2,'Colormap',jet);
%                                 h.plot
%                                 figname=[num2str(patternnum),'Heatmap_LP1_2.bmp'];
%                                 saveas(gcf,figname)
%                                 
%                                 h=HeatMap(RtPositiveFiringRateArrayP1_2,'Colormap',jet);
%                                 h.plot
%                                 figname=[num2str(patternnum),'Heatmap_RP1_2.bmp'];
%                                 saveas(gcf,figname)
%                                 
%                                 h=HeatMap(LtPositiveFiringRateArrayP1_3,'Colormap',jet);
%                                 h.plot
%                                 figname=[num2str(patternnum),'Heatmap_LP1_3.bmp'];
%                                 saveas(gcf,figname)
%                                 
%                                 h=HeatMap(RtPositiveFiringRateArrayP1_3,'Colormap',jet);
%                                 h.plot
%                                 figname=[num2str(patternnum),'Heatmap_RP1_3.bmp'];
%                                 saveas(gcf,figname)
%                                 
%                                 h=HeatMap(LtPositiveFiringRateArrayP1_4,'Colormap',jet);
%                                 h.plot
%                                 figname=[num2str(patternnum),'Heatmap_LP1_4.bmp'];
%                                 saveas(gcf,figname)
%                                 
%                                 h=HeatMap(RtPositiveFiringRateArrayP1_4,'Colormap',jet);
%                                 h.plot
%                                 figname=[num2str(patternnum),'Heatmap_RP1_4.bmp'];
%                                 saveas(gcf,figname)
%                                 
%                                 h=HeatMap(LtPositiveFiringRateArrayP1_5,'Colormap',jet);
%                                 h.plot
%                                 figname=[num2str(patternnum),'Heatmap_LP1_5.bmp'];
%                                 saveas(gcf,figname)
%                                 
%                                 h=HeatMap(RtPositiveFiringRateArrayP1_5,'Colormap',jet);
%                                 h.plot
%                                 figname=[num2str(patternnum),'Heatmap_RP1_5.bmp'];
%                                 saveas(gcf,figname)
%                                 
%                                 close all hidden


                                
                                
%                                 filename=[num2str(cellnum),'heatmap_each.mat'];
%                                 save(filename,'LtPositiveFiringRateArray_0','RtPositiveFiringRateArray_0','LtPositiveFiringRateArray_1','RtPositiveFiringRateArray_1','LtPositiveFiringRateArray_2'...
%                                 ,'RtPositiveFiringRateArray_2','LtPositiveFiringRateArray_3','RtPositiveFiringRateArray_3','LtPositiveFiringRateArray_4','RtPositiveFiringRateArray_4'...
%                                 ,'LtPositiveFiringRateArray_5','RtPositiveFiringRateArray_5','LtPositiveFiringRateArrayP1_0','RtPositiveFiringRateArrayP1_0','LtPositiveFiringRateArrayP1_1'...
%                                 ,'RtPositiveFiringRateArrayP1_1','LtPositiveFiringRateArrayP1_2','RtPositiveFiringRateArrayP1_2','LtPositiveFiringRateArrayP1_3','RtPositiveFiringRateArrayP1_3'...
%                                 ,'LtPositiveFiringRateArrayP1_4','RtPositiveFiringRateArrayP1_4','LtPositiveFiringRateArrayP1_5','RtPositiveFiringRateArrayP1_5')
                                
                                
                                save('response.mat', 'response')
                            break
                            end
                        end
                    end
                end
            end
        end
    end
end
