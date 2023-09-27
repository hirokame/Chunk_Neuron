function FourierAnalysis(SpikeTime,StartTime,FinishTime)

global fname dpath DrName TurnMarkerTime OneTurnTime TimestampArray...
    LFPsamples_Run AllTurnLFP AllTurnLFPplus fs ValidTurn
%timestampsは270336ずつ増加。270msと思われる。timestampsの数ｘ512個のサンプル。
%270336/512=528. サンプリングは0.528msごと。fs=10^6/528
%  振幅スペクトルとパワースペクトルの範囲を変更するには、dft_sizeの範囲を変える
%  spectrogramの範囲を変更するには、window_size、shift_sizeの範囲を変える

fs=10^6/528;%1秒間のサンプリング回数//サンプリング周波数
% contents = cellstr(get(handles.popupmenu_DFTsize,'String')); 
dft_size=8192;%str2double(contents{get(handles.popupmenu_DFTsize,'Value')});
% contents = cellstr(get(handles.popupmenu_Windowsize,'String')); 
% window_size=str2double(contents{get(handles.popupmenu_Windowsize,'Value')});
% contents = cellstr(get(handles.popupmenu_Shiftsize,'String')); 
% shift_size=str2double(contents{get(handles.popupmenu_Shiftsize,'Value')});

% LFP=LFPsamples_Run(TurnMarkerTime(1):TurnMarkerTime(end));

LFP=zeros(1,FinishTime-StartTime);
LFP(SpikeTime)=1;

Y=fft(LFP,dft_size);
k=1:dft_size/2+1;
A(k)=abs(Y(k));
P(k)=abs(Y(k)).^2;
frequency(k)=(k-1)*fs/dft_size;
figure
subplot(2,1,1)
plot(frequency,A)
axis([0 10 0 max(A)*1.1])
subplot(2,1,2)
plot(frequency,P)
axis([0 10 0 max(P)*1.1])

% Turnframe=floor(OneTurnTime/(shift_size*0.528))+window_size/shift_size-1;
% % 有効なTurnMarkerTimeからOneTurnTimeまでの区間のLFPを抽出
% ValidTurn=[];   
% AllTurnLFP=[];
% AllTurnLFPplus=[];
% for n=1:length(TurnMarkerTime)-1
%     if TurnMarkerTime(n+1)-TurnMarkerTime(n)<OneTurnTime*1.05
%         ValidTurn=[ValidTurn n];
%         Index=find(TimestampArray==min(TimestampArray(TimestampArray>TurnMarkerTime(n).*1000)));
%         L=LFPsamples_Run(Index:Index+floor(OneTurnTime/0.528)-1);
%         LL=LFPsamples_Run(Index:Index+floor(OneTurnTime/0.528)-1+window_size);
%         AllTurnLFP(length(ValidTurn),:)=L;   % TurnMarkerTimeからOneTurnTimeまでのLFPsamples
%         AllTurnLFPplus(length(ValidTurn),:)=LL;   % TurnMarkerTimeからOneTurnTime+window_sizeまでのLFPsamples
%     end
%     
% end
