function RasterData=raster(TimeStamp,TurnMarkerTime)

%TurnMarkerTime��StartTime,FinishTime���Ɍ��肷�邩

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


% ����sin�g�ɉ�����'l'��\������菇�́A�ȉ��̋L�q�݂̂ŉ\�ł��B
% �r���̍s�͕s�v�ł��̂ŁA�������Ă��������B
% 
% %-------------------------------------------------------------------%
%  X = [0:0.1:4*pi];
%  Y = sin(0.5*X);   % �c �Ⴆ�΂��̂悤��sin�g���v���b�g������
% 
%  text(X,Y,'l');
%  set(gca,'Xlim',[0 4*pi],'Ylim',[-1.2 1.2]); % x y ���͈̔͂�K�X�ݒ�
% % %-------------------------------------------------------------------%