function RasterData=raster(TimeStamp,TurnMarkerTime)

%TurnMarkerTimeをStartTime,FinishTime内に限定するか

RasterData=[];
for n=1:length(TurnMarkerTime)-1
    DataTemp=TimeStamp(TimeStamp>TurnMarkerTime(n) & TimeStamp<=TurnMarkerTime(n+1))-TurnMarkerTime(n);
    y_Temp=ones(length(DataTemp),1)*n;
    RasterDataTemp=[DataTemp y_Temp];
    RasterData=[RasterData;RasterDataTemp];
end
% size(RasterDataTemp)
% size(RasterData)
% plot(RasterData(:,1),RasterData(:,2),'rx');


% あるsin波に沿って'l'を表示する手順は、以下の記述のみで可能です。
% 途中の行は不要ですので、消去してください。
% 
% %-------------------------------------------------------------------%
%  X = [0:0.1:4*pi];
%  Y = sin(0.5*X);   % … 例えばこのようなsin波をプロットしたい
% 
%  text(X,Y,'l');
%  set(gca,'Xlim',[0 4*pi],'Ylim',[-1.2 1.2]); % x y 軸の範囲を適宜設定
% % %-------------------------------------------------------------------%