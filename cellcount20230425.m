function cellcount20230425


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%Ç±Ç±Ç©ÇÁStriatum MSN%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
path=['E:\CheetahWRLV20200411'];

cd(path)

LS1=ls;
Cellsum=0;
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
rhythmcount_mt1sum=0;
rhythmcount_mt2sum=0;
rhythmcount_mt3sum=0;

for i=1:length(LS1(:,1))
   trimFolder=strtrim(LS1(i,:));
   if ~strcmp(trimFolder,'.') && ~strcmp(trimFolder,'..') && numel(trimFolder)<4;
      CDFolder=[path,'\',trimFolder];
      cd(CDFolder);
      LS2=ls;
      for j=1:length(LS2(:,1))
          trimFolder2=strtrim(LS2(j,:));
          if length(trimFolder2)>4;
              CDFolder2=[CDFolder,'\',trimFolder2];
              cd(CDFolder2);
              CDFolder3=[CDFolder2,'\CellCell'];
              cd(CDFolder3)
              count=['count.mat'];
              load(count)
              Cellsum=Cellsum+Cells;
              Rtcountsum=Rtcountsum+Rtcount;
              Ltcountsum=Ltcountsum+Ltcount;
              RtLtcountsum=RtLtcountsum+RtLtcount;
              Touchcountsum=Touchcountsum+Touchcount;
              Woncountsum=Woncountsum+Woncount;
              Woffcountsum=Woffcountsum+Woffcount;
              WonWoffcountsum=WonWoffcountsum+WonWoffcount;
              Doncountsum=Doncountsum+Doncount;
              WoDoncountsum=WoDoncountsum+WoDoncount;
              tDoncountsum=tDoncountsum+tDoncount;
              Wotcountsum=Wotcountsum+Wotcount;
              tWoDoncountsum=tWoDoncountsum+tWoDoncount;
              modBgracountsum=modBgracountsum+modBgracount;
              mod98countsum=mod98countsum+mod98count;
              repcountsum=repcountsum+repcount;
              Bgra98countsum=Bgra98countsum+Bgra98count;
              rep98countsum=rep98countsum+rep98count;
              repBgracountsum=repBgracountsum+repBgracount;
              rhythmcount_mt1sum=rhythmcount_mt1sum+rhythmcount_mt1;
              rhythmcount_mt2sum=rhythmcount_mt2sum+rhythmcount_mt2;
              rhythmcount_mt3sum=rhythmcount_mt3sum+rhythmcount_mt3;
          end
      end
   end
   cd(path)
end
cd(path)
namearray = {'Cell';'Rt';'Lt';'RtLt';'Touch';'Won';'Woff';'WonWoff';'Don';'WoDon';'tDon';'Wot';'tWoDon';'modBgra';'mod98';'rep';'Bgra98';'98rep'...
    ;'repBgra';'Rhythm(mt1)';'Rhythm(mt2)';'Rhythm(mt3)'};
countArray =[Cellsum;Rtcountsum;Ltcountsum;RtLtcountsum;Touchcountsum;Woncountsum;Woffcountsum;WonWoffcountsum;Doncountsum;WoDoncountsum;tDoncountsum;Wotcountsum;tWoDoncountsum...
    ;modBgracountsum;mod98countsum;repcountsum;Bgra98countsum;rep98countsum;repBgracountsum;rhythmcount_mt1sum;rhythmcount_mt2sum;rhythmcount_mt3sum];
T = table(namearray, countArray);
filename=['Count_str.xlsx'];
writetable(T, filename);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%Ç±Ç±Ç©ÇÁCortex%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
path=['E:\CheetahWRLV20230323_Ctx'];

cd(path)

LS1=ls;
Cellsum=0;
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
Rhythmcountsum=0;
Rhythmandcountsum=0;
Bgra98countsum=0;
rep98countsum=0;
repBgracountsum=0;
rhythmcount_mt1sum=0;
rhythmcount_mt2sum=0;
rhythmcount_mt3sum=0;

for i=1:length(LS1(:,1))
   trimFolder=strtrim(LS1(i,:));
   if ~strcmp(trimFolder,'.') && ~strcmp(trimFolder,'..') && numel(trimFolder)<4;
      CDFolder=[path,'\',trimFolder];
      cd(CDFolder);
      LS2=ls;
      for j=1:length(LS2(:,1))
          trimFolder2=strtrim(LS2(j,:));
          if length(trimFolder2)>4;
              CDFolder2=[CDFolder,'\',trimFolder2];
              cd(CDFolder2);
              CDFolder3=[CDFolder2,'\CellCell'];
              cd(CDFolder3)
              count=['count.mat'];
              load(count)
              Cellsum=Cellsum+Cells;
              Rtcountsum=Rtcountsum+Rtcount;
              Ltcountsum=Ltcountsum+Ltcount;
              RtLtcountsum=RtLtcountsum+RtLtcount;
              Touchcountsum=Touchcountsum+Touchcount;
              Woncountsum=Woncountsum+Woncount;
              Woffcountsum=Woffcountsum+Woffcount;
              WonWoffcountsum=WonWoffcountsum+WonWoffcount;
              Doncountsum=Doncountsum+Doncount;
              WoDoncountsum=WoDoncountsum+WoDoncount;
              tDoncountsum=tDoncountsum+tDoncount;
              Wotcountsum=Wotcountsum+Wotcount;
              tWoDoncountsum=tWoDoncountsum+tWoDoncount;
              modBgracountsum=modBgracountsum+modBgracount;
              mod98countsum=mod98countsum+mod98count;
              repcountsum=repcountsum+repcount;
              Bgra98countsum=Bgra98countsum+Bgra98count;
              rep98countsum=rep98countsum+rep98count;
              repBgracountsum=repBgracountsum+repBgracount;
              rhythmcount_mt1sum=rhythmcount_mt1sum+rhythmcount_mt1;
              rhythmcount_mt2sum=rhythmcount_mt2sum+rhythmcount_mt2;
              rhythmcount_mt3sum=rhythmcount_mt3sum+rhythmcount_mt3;
          end
      end
   end
   cd(path)
end
cd(path)
namearray = {'Cell';'Rt';'Lt';'RtLt';'Touch';'Won';'Woff';'WonWoff';'Don';'WoDon';'tDon';'Wot';'tWoDon';'modBgra';'mod98';'rep';'Bgra98';'98rep'...
    ;'repBgra';'Rhythm(mt1)';'Rhythm(mt2)';'Rhythm(mt3)'};
countArray =[Cellsum;Rtcountsum;Ltcountsum;RtLtcountsum;Touchcountsum;Woncountsum;Woffcountsum;WonWoffcountsum;Doncountsum;WoDoncountsum;tDoncountsum;Wotcountsum;tWoDoncountsum...
    ;modBgracountsum;mod98countsum;repcountsum;Bgra98countsum;rep98countsum;repBgracountsum;rhythmcount_mt1sum;rhythmcount_mt2sum;rhythmcount_mt3sum];
T = table(namearray, countArray);
filename=['Count_ctx.xlsx'];
writetable(T, filename);

