function [fig_touch PTpegHistoCell PegTouchBypegCell]=TouchAlignByPeg(PegTouchCell,pegTimeArray2D,yhight) 
%TouchAlignByPeg(PegTouchCell,pegTimeArray2D,100,30)
%Called by PegTouch,Detach
%Touch aligned By Pegs
global PTpegHistoCell ShowFig

PegTouchBypeg1=[];PegTouchBypeg2=[];PegTouchBypeg3=[];PegTouchBypeg4=[];PegTouchBypeg5=[];PegTouchBypeg6=[];PegTouchBypeg7=[];PegTouchBypeg8=[];PegTouchBypeg9=[];PegTouchBypeg10=[];PegTouchBypeg11=[];PegTouchBypeg12=[];
PegTouchBypegCell={PegTouchBypeg1,PegTouchBypeg2,PegTouchBypeg3,PegTouchBypeg4,PegTouchBypeg5,PegTouchBypeg6,PegTouchBypeg7,PegTouchBypeg8,PegTouchBypeg9,PegTouchBypeg10,PegTouchBypeg11,PegTouchBypeg12};
%disp(PegTouchCell);
if ~iscell(pegTimeArray2D)
    if iscell(PegTouchCell)
        for n=1:length(PegTouchCell) %ペグの前後2.5秒
            for m=1:length(pegTimeArray2D(:,n))
                A=PegTouchCell{n}((pegTimeArray2D(m,n)<PegTouchCell{n}+2500)&(pegTimeArray2D(m,n)>PegTouchCell{n}-2500))-pegTimeArray2D(m,n);
                PegTouchBypegCell{n}=[PegTouchBypegCell{n};A];
            end
        end
    else %SpikeArrayの場合
        for n=1:12 %ペグの前後2.5秒
            for m=1:length(pegTimeArray2D(:,n))
                A=PegTouchCell((pegTimeArray2D(m,n)<PegTouchCell+2500)&(pegTimeArray2D(m,n)>PegTouchCell-2500))-pegTimeArray2D(m,n);
                PegTouchBypegCell{n}=[PegTouchBypegCell{n};A'];
            end
        end
    end
else%タッチでアラインする場合
    if iscell(PegTouchCell)
%         for n=1:length(PegTouchCell) %ペグの前後2.5秒
%             for m=1:length(pegTimeArray2D(:,n))
%                 A=PegTouchCell{n}((pegTimeArray2D(m,n)<PegTouchCell{n}+2500)&(pegTimeArray2D(m,n)>PegTouchCell{n}-2500))-pegTimeArray2D(m,n);
%                 PegTouchBypegCell{n}=[PegTouchBypegCell{n};A];
%             end
%         end
    else %SpikeArrayの場合
        for n=1:12 %ペグの前後2.5秒
            for m=1:length(pegTimeArray2D{n})
                if ~isempty(pegTimeArray2D{n})
                    A=PegTouchCell((pegTimeArray2D{n}(m)<PegTouchCell+2500)&(pegTimeArray2D{n}(m)>PegTouchCell-2500))-pegTimeArray2D{n}(m);
                    PegTouchBypegCell{n}=[PegTouchBypegCell{n};A'];
                end
            end
            
        end
    end
    
end
xbins=200;
X_duration=1000;%表示する時間幅　片側
PTpegHisto1=zeros(xbins,1);PTpegHisto2=zeros(xbins,1);PTpegHisto3=zeros(xbins,1);PTpegHisto4=zeros(xbins,1);PTpegHisto5=zeros(xbins,1);PTpegHisto6=zeros(xbins,1);PTpegHisto7=zeros(xbins,1);PTpegHisto8=zeros(xbins,1);PTpegHisto9=zeros(xbins,1);PTpegHisto10=zeros(xbins,1);PTpegHisto11=zeros(xbins,1);PTpegHisto12=zeros(xbins,1);
PTpegHistoCell={PTpegHisto1,PTpegHisto2,PTpegHisto3,PTpegHisto4,PTpegHisto5,PTpegHisto6,PTpegHisto7,PTpegHisto8,PTpegHisto9,PTpegHisto10,PTpegHisto11,PTpegHisto12};
for n=1:length(PegTouchBypegCell)%ペグの前後1秒
    for p=1:xbins
        %X_duration*2/xbinsの幅のなかにあるデータ数が１ビンに入る。*２は、X_durationが片側の長さであることによる
        PTpegHistoCell{n}(p)=length(PegTouchBypegCell{n}(((p-1)*(X_duration*2/xbins)-X_duration<PegTouchBypegCell{n})&(PegTouchBypegCell{n}<=(p-1)*(X_duration*2/xbins)-X_duration+(X_duration*2/xbins))));
    end
end
yhight=15;
%ScSz=get(0,'ScreenSize');
if ShowFig==1
    fig_touch=figure%('Position',[1 1 1400 975]);%title('                                   +/- 1500ms, 15ms/bin');
    for n=1:length(PTpegHistoCell)
        subplot(12,1,n);bar(PTpegHistoCell{n});axis([0 xbins 0 yhight]);%axis off;
    end
else fig_touch=0;
end


%saveas(fig_touch,'TouchAlignRpeg.jpg');

% figure;
% subplot(12,1,1);bar(PTpegHistoCell{1});axis([0 50 0 20])
% subplot(12,1,2);bar(PTpegHistoCell{2});axis([0 50 0 20])
% subplot(12,1,3);bar(PTpegHistoCell{3});axis([0 50 0 20])
% subplot(12,1,4);bar(PTpegHistoCell{4});axis([0 50 0 20])
% subplot(12,1,5);bar(PTpegHistoCell{5});axis([0 50 0 20])
% subplot(12,1,6);bar(PTpegHistoCell{6});axis([0 50 0 20])
% subplot(12,1,7);bar(PTpegHistoCell{7});axis([0 50 0 20])
% subplot(12,1,8);bar(PTpegHistoCell{8});axis([0 50 0 20])
% subplot(12,1,9);bar(PTpegHistoCell{9});axis([0 50 0 20])
% subplot(12,1,10);bar(PTpegHistoCell{10});axis([0 50 0 20])
% subplot(12,1,11);bar(PTpegHistoCell{11});axis([0 50 0 20])
% subplot(12,1,12);bar(PTpegHistoCell{12});axis([0 50 0 20])