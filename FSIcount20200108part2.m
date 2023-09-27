function FSIcount20200108part2



path=['E:\CheetahWRLV20200411'];


FSIsum=0;
Rtcountsum=0;
Ltcountsum=0;
RtLtcountsum=0;
Touchcountsum=0;
Woncountsum=0;
Woffcountsum=0;
WonWoffcountsum=0;
Doncountsum=0;
WoDoncountsum=0;
tDoncountsum=0;
Wotcountsum=0;
tWoDoncountsum=0;
modBgracountsum=0;
mod98countsum=0;
repcountsum=0;
Bgra98countsum=0;
rep98countsum=0;
repBgracountsum=0;
rhythmcount_mt3sum=0;


cd(path)
LS1=ls;


for i=1:length(LS1(:,1))
    trimFolder1=strtrim(LS1(i,:));
    if  ~strcmp(trimFolder1,'.') && ~strcmp(trimFolder1,'..') && isempty(strfind(trimFolder1,'.mat')) && isempty(strfind(trimFolder1,'.bmp'))...
            && isempty(strfind(trimFolder1,'.fig')) && isempty(strfind(trimFolder1,'CCSfigure')) && isempty(strfind(trimFolder1,'.xlsx'))...
            && isempty(strfind(trimFolder1,'Heatmap')) && isempty(strfind(trimFolder1,'Hirokane')) && isempty(strfind(trimFolder1,'Chunk'))...
            && isempty(strfind(trimFolder1,'Window')) && isempty(strfind(trimFolder1,'touchcell'));
        cd([path,'\',trimFolder1]);%%%%%%%%%%%%%%%%%%%%%%マウスfolder
        LS2=ls;
        for j=1:length(LS2(:,1))
            trimFolder2=strtrim(LS2(j,:));
            if length(trimFolder2)>4;
                dpath3=[path,'\',trimFolder1,'\',trimFolder2];
                cd(dpath3)%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%日にちfolder
                
                %%%%%%%%%%%%Cellのtfile保存％％％％％％％％％％％％％％％％％
                CellCellpath=[dpath3,'\','CellCell'];
                cd(CellCellpath)%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%CellCellfolder
                
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%CellCellフォルダ内の一つ一つの細胞からresponseファイルを読み込む％％％％％％％％％％％％％％％％％％％
                LS=ls;
                
                for k=1:length(LS(:,1));
                    trimFolder=strtrim(LS(k,:));
                    cd(CellCellpath)
                    if length(trimFolder)>4 && ~strcmp(trimFolder(end-3:end),'.mat');
                        cd(trimFolder);
                        load('response.mat');
                        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%細胞を数える
                        if ~isempty(strfind(response,'FSI')) ;
                            FSIsum=FSIsum+1;
                            if ~isempty(strfind(response,'Rt'));
                                Rtcountsum=Rtcountsum+1;
                            end
                            if ~isempty(strfind(response,'Lt'));
                                Ltcountsum=Ltcountsum+1;
                            end
                            if ~isempty(strfind(response,'RtLt'));
                                RtLtcountsum=RtLtcountsum+1;
                            end
                            if ~isempty(strfind(response,'Rt')) || ~isempty(strfind(response,'Lt'));
                                Touchcountsum=Touchcountsum+1;
                            end
                            if ~isempty(strfind(response,'Won'));
                                Woncountsum=Woncountsum+1;
                            end
                            if ~isempty(strfind(response,'Woff'));
                                Woffcountsum=Woffcountsum+1;
                            end
                            if ~isempty(strfind(response,'WonWoff'));
                                WonWoffcountsum=WonWoffcountsum+1;
                            end
                            if ~isempty(strfind(response,'Don'));
                                Doncountsum=Doncountsum+1;
                            end
                            if ~isempty(strfind(response,'Don')) && (~isempty(strfind(response,'DR')) || ~isempty(strfind(response,'DL')));
                                DonDRDLcountsum=DonDRDLcountsum+1;
                            end
                            if ~isempty(strfind(response,'Wo')) && ~isempty(strfind(response,'Don'));
                                WoDoncountsum=WoDoncountsum+1;
                            end
                            if ~isempty(strfind(response,'t')) && ~isempty(strfind(response,'Don'));
                                tDoncountsum=tDoncountsum+1;
                            end
                            if ~isempty(strfind(response,'t')) && ~isempty(strfind(response,'Wo'));
                                Wotcountsum=Wotcountsum+1;
                            end
                            if ~isempty(strfind(response,'t')) && ~isempty(strfind(response,'Wo')) && ~isempty(strfind(response,'Don'));
                                tWoDoncountsum=tWoDoncountsum+1;
                            end
                            if ~isempty(strfind(response,'modBgra'));
                                modBgracountsum=modBgracountsum+1;
                            end
                            if ~isempty(strfind(response,'mod98'));
                                mod98countsum=mod98countsum+1;
                            end
                            if ~isempty(strfind(response,'Rep'));
                                repcountsum=repcountsum+1;
                            end
                            if ~isempty(strfind(response,'modBgra')) && ~isempty(strfind(response,'mod98'));
                                Bgra98countsum=Bgra98countsum+1;
                            end
                            if (~isempty(strfind(response,'mod98')) && ~isempty(strfind(response,'Rep')))
                                rep98countsum=rep98countsum+1;
                            end
                            if (~isempty(strfind(response,'Rep')) && ~isempty(strfind(response,'modBgra')))
                                repBgracountsum=repBgracountsum+1;
                            end
                            if ~isempty(strfind(response,'mod98')) && ~isempty(strfind(response,'modBgra')) && ~isempty(strfind(response,'Rep'));
                                rhythmcount_mt3sum=rhythmcount_mt3sum+1;
                            end
                        end
                    end
                end
            end
        end
    end
end

rhythmcount_mt1sum = modBgracountsum + mod98countsum + repcountsum - Bgra98countsum - rep98countsum - repBgracountsum + rhythmcount_mt3sum;
rhythmcount_mt2sum = Bgra98countsum + rep98countsum + repBgracountsum - 2*rhythmcount_mt3sum;

pathdesktop=['E:\CheetahWRLV20200411'];
cd(pathdesktop)
namearray = {'FSI';'Rt';'Lt';'RtLt';'Touch';'Won';'Woff';'WonWoff';'Don';'WoDon';'tDon';'Wot';'tWoDon';'modBgra';'mod98';'rep';'Bgra98';'98rep'...
    ;'repBgra';'Rhythm(mt1)';'Rhythm(mt2)';'Rhythm(mt3)'};
countArray =[FSIsum;Rtcountsum;Ltcountsum;RtLtcountsum;Touchcountsum;Woncountsum;Woffcountsum;WonWoffcountsum;Doncountsum;WoDoncountsum;tDoncountsum;Wotcountsum;tWoDoncountsum...
    ;modBgracountsum;mod98countsum;repcountsum;Bgra98countsum;rep98countsum;repBgracountsum;rhythmcount_mt1sum;rhythmcount_mt2sum;rhythmcount_mt3sum];
T = table(namearray, countArray);
filename=['Count_FSI.xlsx'];
writetable(T, filename);