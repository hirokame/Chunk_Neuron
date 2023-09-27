function Chunk_analysis

global RpegTouchallWon LpegTouchallWon SpikeArrayWon tfile pegpatternname trimFolder2  pegpatternum ...
    Spikeposition Windowinterval

path="D:\CheetahWRLV20200411";
cd(path);
if not(exist('Chunk','dir'))
    mkdir('Chunk')
end
cellnum=0;
patternnum=0;
Touchcellnum = 0;
mod98=0;
modBgra=0;
Rtouchnum=0;
Ltouchnum=0;

LS1=ls;

for i=1:length(LS1(:,1)) %1列目で固定、行を動かす。各マウスでイテレーションを回す。
    trimFolder=strtrim(LS1(i,:));
    if ~strcmp(trimFolder,'.') && ~strcmp(trimFolder,'..') && isempty(strfind(trimFolder,'.bmp')) && isempty(strfind(trimFolder,'.xlsx')) && isempty(strfind(trimFolder,'.fig')) &&...
            ~strcmp(trimFolder,'CCSfigure') && isempty(strfind(trimFolder,'SpikeFormAnalysis')) && isempty(strfind(trimFolder,'widthPtoT')) && ~strcmp(trimFolder,'CCSfigure-Lt') &&...
            ~strcmp(trimFolder,'CCSfigure-RLt') && ~strcmp(trimFolder,'CCSfigure-Rt') &&isempty(strfind(trimFolder,'Hirokane')) &&isempty(strfind(trimFolder,'Window')) && isempty(strfind(trimFolder,'touchcell'))
        CDFolder=path+'\'+trimFolder; %cdフォルダ変更C:\Users\C238\Desktop\CheetahWRLV20180729Part1\trimfolder(mouseNo)
        cd(CDFolder);
        LS2=ls;
        for j=1:length(LS2(:,1))% 各トライアルでイテレーションを回す。
            trimFolder2=strtrim(LS2(j,:));
            if length(trimFolder2)>4 && ~strcmp(trimFolder2(end-3:end),'.mat');
                CDFolder2=CDFolder+'\'+trimFolder2;  %C:\Users\C238\Desktop\CheetahWRLV20180729Part1\119\2017-6-7_20-8-33 11901-51
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
                response_list=[];
                CDFolder3=CDFolder2+'\CellCell';%C:\Users\C238\Desktop\CheetahWRLV20180729Part1\119\2017-6-7_20-8-33 11901-51\CellCell
                cd(CDFolder3)
                LSC=ls;
                for x=1:length(LSC(:,1));
                    
                    trimCellFolder=strtrim(LSC(x,:));
                    if length(trimCellFolder)>4 && ~strcmp(trimCellFolder((end-3):end),'.mat');
                        CDFolder5=CDFolder3+'\'+trimCellFolder; %C:\Users\C238\Desktop\CheetahWRLV20180729Part1\119\2017-6-7_20-8-33 11901-51\CellCell\Sc2_SS_01
                        cd(CDFolder5)
                        load('response.mat')
                        if  ~isempty(strfind(response, 'MSN')); %MSN細胞見つける
                            TouchCellName=[TouchCellName;trimCellFolder];% 右左両方のタッチに反応する細胞のフォルダ番号を格納していく。各マウスごとに
                            Touchcellnum = Touchcellnum+1;
                            response_list = char(response_list, response);
                            
                        end
                    end
                end
                
                
                if ~isempty(TouchCellName);
                    for k=1:length(TouchCellName(:,1));%%両足のタッチに反応している細胞で回していく
                        response = response_list(k+1,:);
                        SpikeArray=[];
                        tfile=strcat(strtrim(TouchCellName(k,:)), '.t');%% .tファイル
                        %                     SpikeArray=GetSpikeAll(CDFolder2,tfile);
                        SpikeArrayWon=[];
                        cd("D:\CheetahWRLV20200411");
                        patterncount = 0;
                        for d=1:length(pegpattern(:,1));%保存したペグパターンごとに見ていく
                            if ~isempty(strfind(pegpattern(d,:),'_C')) || ~isempty(strfind(pegpattern(d,:),'_Bgra')) || ~isempty(strfind(pegpattern(d,:),'_98__')) || ~isempty(strfind(pegpattern(d,:),'_89__')) || ~isempty(strfind(pegpattern(d,:),'_Agra'));%_Cの配列を見つけたら
                                patternname = pegpattern(d,end-7:end-4);
                                patterncount = patterncount+1;
                                if patterncount == 1
                                    cellnum=cellnum+1;
                                end
                                Foldercell=num2str(cellnum); %num2strは数値を
                                
                                if not(exist(Foldercell,'dir'))
                                    mkdir(Foldercell); %%1~117の細胞番号順にディレクトリを作成
                                end
                              

                                %%%% Complex patternのデータを入れる
                                
                                CDFolder5=CDFolder2+'\'+pegpattern(d,(1:end-4));
                                cd(CDFolder5)
                                file='Bdata.mat';
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
                                Folder6='D:\CheetahWRLV20200411\Chunk\'+Foldercell;
                                cd(Folder6)
                                cellnum
                                filename = 'Cell'+num2str(cellnum)+'pattern'+num2str(patternname)+'data.mat';
                                save(filename, 'SpikeArray', 'SpikeArrayWon', 'RpegTouchall','RpegTouchallWon','LpegTouchall', 'LpegTouchallWon', 'response')
                                
                            end
                        end
                    end
                end
            end
        end
    end
end