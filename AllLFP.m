function AllLFP
%WheelAnalyzer24chSpikeで解析を行い、結果がメモリに残っている状態で行う
%


global TurnMarkerTime OneTurnTime StartTime FinishTime fname RpegTimeArray LpegTimeArray RPegTouchAll LPegTouchAll DrinkOnArray WaterOnArrayOriginal WaterOffArrayOriginal filename
%2,3,6,8,9,13
CrossCorrValue=2
% CrossCorrValue=get(handles.popupmenu_CrossCorr,'Value');
if CrossCorrValue==1;CCselect=TurnMarkerTime';S='aligned by TurnMarker';
elseif CrossCorrValue==2;CCselect=WaterOnArrayOriginal';S='aligned by WaterOn';    
elseif CrossCorrValue==3;CCselect=WaterOffArrayOriginal';S='aligned by WaterOff';    
elseif CrossCorrValue==4;CCselect=SpikeArray1';S='aligned by Spike';
elseif (CrossCorrValue==5) CCselect=RpegTimeArray;S='aligned by Right peg';
elseif (CrossCorrValue==6) CCselect=LpegTimeArray;S='aligned by Left peg';
elseif (CrossCorrValue==7) RLpegTimeArray=sort([RpegTimeArray;LpegTimeArray]);CCselect=RLpegTimeArray;S='aligned by R&L peg';
elseif (CrossCorrValue==8) CCselect=RPegTouchAll;S='aligned by Right touch';
elseif (CrossCorrValue==9) CCselect=LPegTouchAll;S='aligned by Left touch';
elseif (CrossCorrValue==10) CCselect=RLPegTouchAll;S='aligned by R&L touch';
elseif (CrossCorrValue==11) CCselect=FloorTouchArray;S='aligned by FloorTouch';
elseif (CrossCorrValue==12) CCselect=FloorDetachArray;S='aligned by FloorDetach';
elseif (CrossCorrValue==13) CCselect=DrinkOnArray;S='aligned by DrinkOn';
elseif (CrossCorrValue==14) CCselect=DrinkOffArray;S='aligned by DrinkOff';
elseif (CrossCorrValue==15)CCselect=SpikeArray2';S='aligned by Spike2';
elseif (CrossCorrValue==16)CCselect=SpikeArray3';S='aligned by Spike3';
elseif (CrossCorrValue==17)CCselect=SpikeArray4';S='aligned by Spike4';
elseif (CrossCorrValue==18)CCselect=SpikeArray5';S='aligned by Spike5';
end
DurationB=FinishTime-StartTime;

[filepath1 fnameEV TimeStamps Evt]=GetCSC_1%A1など２文字のものを選ぶ

figure

for K=1:32
    
Fname=['A1  ';'A2  '; 'A3  '; 'A4  '; 'A5  '; 'A6  '; 'A7  '; 'A8  '; 'A9  '; 'A10 '; 'A11 '; 'A12 '; 'B1  ';'B2  '; 'B3  '; 'B4  '; 'B5  '; 'B6  '; 'B7  '; 'B8  ';'B9  '; 'B10 '; 'B11 '; 'B12 '; 'CSC1';'CSC2'; 'CSC3'; 'CSC4'; 'CSC5'; 'CSC6'; 'CSC7'; 'CSC8' ];
filepath=[filepath1(1:end-6),strtrim(Fname(K,:)),filepath1(end-3:end)];
    
LenE=length(TimeStamps);
StartT=[];
StopT=[];
for n=1:LenE
    if Evt(n,end-14)=='1'
        StartT=[StartT TimeStamps(n)];
    end
    if Evt(n,end-4)=='1'
        StopT=[StopT TimeStamps(n)];
    end
end
SpikeArray1=0;
for n=1:length(StartT)
    for m=1:length(StopT)
        DurationS=StopT(m)-StartT(n);
        if abs(DurationS-DurationB*1000)<5000
            SpikeArray1=1;
            SpikeStartTime=StartT(n);
            SpikeStopTime=StopT(m);
%             pathnameCSC = 'C:\Users\kit\Documents\MATLABoriginal\CSC1.Ncs';
%             pathnameCSC = 'C:\Users\kit\Desktop\CheetahData\2016-2-12_19-3-56 6711\A1.Ncs';
            [Timestamp, ChanNum, SampleFrequency, NumValSamples, LFPsamples, header] = Nlx2MatCSC(filepath, [1, 1, 1, 1, 1], 1, 1);%この式を使うだけ。functionとして使う必要は無い。
            
%             AllTimestamp=[];
            AllTimestamp=zeros(1,length(Timestamp)*512);
            
            TimestampArray=[];

            for k=1:length(Timestamp)
                p=0:511;
%                 AllTimestamp=[AllTimestamp,Timestamp(k)+528*m];%528*512=270336
                AllTimestamp((k-1)*512+1:(k-1)*512+512)=Timestamp(k)+528*p;
            end
            AllTimestampLength=length(AllTimestamp);
%             AllTimestampA=Timestamp(1)+528*(0:511*length(Timestamp));

%             LFPRef=get(handles.text_cscref,'String');
%             if isnan(LFPRef)==0
%                 LFPsamples=LFPsamples1-LFPsamples_Ref;
%             else LFPsamples=LFPsamples1;
%             end

% % %             % SpikeStartTime(LabViewのStartボタンが押された時のNeurarynxの時間）と
% % %             % StartTime(LabView開始からStartボタンが押されるまでの時間)をそろえる必要がある。
% % %             % なのでTimestampからSpikeStartTimeを引いてStartTimeを加える。
% % %             % LFPは528μsecごとに記録されており、時間単位をマイクロ秒に揃えてで計算しないとずれが生じる。
% % % 
% % %             % disp('LFPTimestamp(1:10)=');disp(AllTimestamp(1:10));

            TimestampArray=AllTimestamp-SpikeStartTime+StartTime*1000;
            BeforeRec=length(TimestampArray(TimestampArray<0));
            TimestampArray(TimestampArray<0)=[];
            AfterRec=length(TimestampArray(TimestampArray>FinishTime*1000));
            TimestampArray(TimestampArray>FinishTime*1000)=[];
%             TimestampArray=TimestampArray/1000;%ms
%             TimestampArray=T(StartTime*1000<T&T<FinishTime*1000);

%             BeforeRec=length(AllTimestamp(SpikeStartTime-StartTime*1000>=AllTimestamp));%
%             AfterRec=length(AllTimestamp(SpikeStopTime<=AllTimestamp));
%             RecLength=length(AllTimestamp(SpikeStartTime<AllTimestamp&SpikeStopTime>AllTimestamp));
            TimestampArayLength=length(TimestampArray)

            LFPsamples_Run=LFPsamples(BeforeRec+1:end-AfterRec);%BeforeRec+RecLength);
            LFPsample_length=length(LFPsamples_Run)

            format short;
        end
    end
end



LFPsamples_RunCC=[];
% CSCref=get(handles.radiobutton_CSCref,'Value');
% if CSCref==1
%     LFPsamples_RunCC=LFPsamples_Run-LFPsamples_Ref;
% else
    LFPsamples_RunCC=LFPsamples_Run;
% end    


 
% contents_MovWindow = cellstr(get(handles.popupmenu_MovWindow,'String'));
% MovW=str2num(contents_MovWindow{get(handles.popupmenu_MovWindow,'Value')});
MovW=2;
% Direction=get(handles.radiobutton_direction,'Value');%Directionは両方向か片方向か
% GaussSmooth=get(handles.radiobutton_Gauss,'Value');
GaussSmooth=0;
 
% Dur=6000;

if CrossCorrValue==1
    duration=(OneTurnTime*1000)/528;
elseif CrossCorrValue==2 || CrossCorrValue==3 %WaterEvent
    Dur=12000;
    duration=(Dur*1000)/528;
elseif CrossCorrValue==13 || CrossCorrValue==14 %DrinkEvent
    Dur=3000;
    duration=(Dur*1000)/528;
else
    Dur=3000;
    duration=(Dur*1000)/528;
%     duration=(OneTurnTime*1000)/528;
%     Dur=duration*528/1000;
end
SuperImpose=0;%get(handles.radiobutton_CCsuperimpose,'Value');
Direction=0;
subplot(8,4,K);%(ceil(K/4)-1)*4+mod((K-(ceil(K/4)-1)),5));
if SuperImpose==0
    [LFParray LFP_aligned]=LFPCrossCorr(LFPsamples_RunCC,CCselect,GaussSmooth,MovW,Direction,TimestampArray,duration);
%     figure
    plot(LFParray);
    axis([0 ceil(duration) min(mean(LFP_aligned)) max(mean(LFP_aligned))]);
else
    [LFParray1 LFP_aligned1]=LFPCrossCorr(LFPsamples_Run,CCselect,GaussSmooth,MovW,Direction,TimestampArray,duration);
    [LFParray2 LFP_aligned2]=LFPCrossCorr(LFPsamples_Ref,CCselect,GaussSmooth,MovW,Direction,TimestampArray,duration);
    [LFParray3 LFP_aligned3]=LFPCrossCorr(LFPsamples_RunCC,CCselect,GaussSmooth,MovW,Direction,TimestampArray,duration);  
%     figure
    plot(LFParray1,'b');hold on
    plot(LFParray2,'c');plot(LFParray3,'r');
%     axis([0 ceil(duration) min(mean(LFP_aligned1)) max(mean(LFP_aligned1))]);
end

if CrossCorrValue==1
    set(gca,'xtick',0:ceil(duration)/8:ceil(duration)+1,'xticklabel',0:round(OneTurnTime*0.1/8)*10:round(OneTurnTime*0.1/8)*80);
else
%     set(gca,'xtick',0:ceil(duration)/8:ceil(duration)+1,'xticklabel',-round(OneTurnTime*0.1/8)*40:round(OneTurnTime*0.1/8)*10:round(OneTurnTime*0.1/8)*40);
 
    set(gca,'xtick',0:ceil(duration)/8:ceil(duration)+1,'xticklabel',-round(Dur*0.1/8)*40:round(Dur*0.1/8)*10:round(Dur*0.1/8)*40);
end
%  
% cscfile=get(handles.text_cscfile,'String');
% if CSCref==0
%     Title=char(strcat({'LFP '},{S},{' '},cscfile(end-8:end),'__',filename(1:end-4)));
% else
%     cscref=get(handles.text_cscref,'String');
%     Title=char(strcat({'LFP '},{S},{' '},cscfile(end-8:end),{' - '},cscref(end-8:end),'__',filename(1:end-4)));
% end
 
% title(Title);
end
xlabel([filename,'  ',S]);



function [filepath fnameEV TimeStamps Evt]=GetCSC_1
%timestampsは270336ずつ増加。270msと思われる。timestampsの数ｘ512個のサンプル。
%270336/512=528. サンプリングは0.528msごと。fs=10^6/528
global StartTime FinishTime fname

% StartTime
% FinishTime
DurationB=FinishTime-StartTime;

% cd C:\Users\B133\Desktop\WR_LVdata\6721_160218
% load 6721_160218.mat

cd C:\Users\B133_2\Desktop\CheetahData
%dpath='C:\Documents and Settings\kit\デスクトップ\WR LVdata\';
% [fname,dpath] = uigetfile('*.xls');
[fname,dpath] = uigetfile('*');
disp(fname);

eval(['fnameEV=','''',dpath,'Events.Nev''']);
[TimeStamps EventStrings Evt]=readEvents(fnameEV);
% fnameEV='C:\Users\B133\Desktop\CheetaData\2016-2-18_18-13-11 6721\Events.Nev';

% filepath='C:\Users\B133\Desktop\CheetaData\2016-2-18_18-13-11 6721\Sc1_SS_01.t';
eval(['filepath=','''',dpath,fname,'''']);


