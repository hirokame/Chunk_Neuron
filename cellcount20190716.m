function cellcount20190716


path='C:\Users\C238\CheetahWRLV20220213';

cd(path)

LS1=ls;
Cellsum=0;%% 全ての細胞数
Rtcountsum=0;%% 右足のタッチに反応した細胞数
Ltcountsum=0;%% 左足のタッチに反応した細胞数
RtLtcountsum=0;%% 左右の足のタッチに反応した細胞数
Woncountsum=0;%% Water onのときに反応する細胞
Woffcountsum=0;%% Water offの時に反応する細胞
WonWoffcountsum=0;%% OnでもOffでも反応する細胞
Doncountsum=0;%% 水飲みしているときに反応する細胞
DonDRDLcountsum=0;
WoDoncountsum=0;%% water onと水飲みに反応する細胞
tDoncountsum=0;%% 足のタッチと水飲みに反応する細胞
Wotcountsum=0;%% water onとタッチに反応する細胞
tWoDoncountsum=0;%%  タッチとwater on と水飲みに反応する細胞
modBgracountsum=0;%% Bgraのモジュレーション強い細胞
mod98countsum=0;%% 98
modBgra98countsum=0;%% Bgraと98
for i=1:length(LS1(:,1)) %%それぞれのマウスごとにファイルを走査
    trimFolder=strtrim(LS1(i,:));
    if  ~strcmp(trimFolder,'.') && ~strcmp(trimFolder,'..') && isempty(strfind(trimFolder,'.mat')) && isempty(strfind(trimFolder,'.bmp'))...
            && isempty(strfind(trimFolder,'.fig')) && isempty(strfind(trimFolder,'CCSfigure')) && isempty(strfind(trimFolder,'.xlsx'))...
            && isempty(strfind(trimFolder,'Heatmap')) && isempty(strfind(trimFolder,'Hirokane')) && isempty(strfind(trimFolder,'Chunk'))...
            && isempty(strfind(trimFolder,'Window')) && isempty(strfind(trimFolder,'touchcell'));
        CDFolder=[path,'\',trimFolder];
        cd(CDFolder);
        LS2=ls;
        for j=1:length(LS2(:,1))%%マウス内のセッション日ごとにファイルを参照
            trimFolder2=strtrim(LS2(j,:));
            if length(trimFolder2)>4;
                CDFolder2=[CDFolder,'\',trimFolder2];
                cd(CDFolder2);
                CDFolder3=[CDFolder2,'\CellCell2'];
                cd(CDFolder3)
                count=['count.mat'];
                load(count) %%マウス番号/セッション日/CellCell/count.mat　ファイルを読み込む
                Cellsum=Cellsum+Cells; %%countファイル内にはCells, Rtcountなどの数字が入っている、これを足していく
                Rtcountsum=Rtcountsum+Rtcount;
                Ltcountsum=Ltcountsum+Ltcount;
                RtLtcountsum=RtLtcountsum+RtLtcount;
                Woncountsum=Woncountsum+Woncount;
                Woffcountsum=Woffcountsum+Woffcount;
                WonWoffcountsum=WonWoffcountsum+WonWoffcount;
                Doncountsum=Doncountsum+Doncount;
                DonDRDLcountsum=DonDRDLcountsum+DonDRDLcount;
                WoDoncountsum=WoDoncountsum+WoDoncount;
                tDoncountsum=tDoncountsum+tDoncount;
                Wotcountsum=Wotcountsum+Wotcount;
                tWoDoncountsum=tWoDoncountsum+tWoDoncount;
                modBgracountsum=modBgracountsum+modBgracount;
                mod98countsum=mod98countsum+mod98count;
                modBgra98countsum=modBgra98countsum+modBgra98count;
            end
        end
    end
    cd(path)
end
cd(path)
countArray=[Cellsum;Rtcountsum;Ltcountsum;RtLtcountsum;Woncountsum;Woffcountsum;WonWoffcountsum;Doncountsum;DonDRDLcountsum;WoDoncountsum;tDoncountsum;Wotcountsum;tWoDoncountsum;modBgracountsum;mod98countsum;modBgra98countsum];
filename=['Count.xlsx'];
xlswrite(filename,countArray);

