function [LFPsamples_Run TimestampArray filepath]=GetCSC
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
if SpikeArray1==0
    disp('No Matched File');
    SpikeArray1=0; 
end


% for n=1:LenE
%     if Evt(n,end-14)=='1'
%         StartT=[StartT TimeStamps(n)];
%     end
%     if Evt(n,end-4)=='1'
%         StopT=[StopT TimeStamps(n)];
%     end
% end
% if length(StartT)==1 && length(StopT)==1
%     DurationS=StopT(1)-StartT(1);
% else
%     disp('StartTime? StopTime?');
% end
% 
% if abs(DurationS-DurationB*1000)<5000
% 
%     [spikes] = readTfile(filepath);
% 
%     SpikeArray1=ceil((spikes-StartT(1)/100)/10)+StartTime;
%     SpikeArray1=SpikeArray1';
%     
%     
%     
% else
%     disp('File Mismatch');
% end



function [spikes] = readTfile(filepath) %[header, spikes] = readTfile('C:\CheetahData\2008-11-6_18-7-10\Sc7_SS_01.t')
% slCharacterEncoding('US-ASCII')
% slCharacterEncoding('Shift_JIS')

% filepath='C:\Users\kit\Desktop\2008-9-25_20-28-25\Sc1_SS_01.t';
% filepath='C:\Users\kit\Documents\MATLABoriginal\Sc2_03.t';
% filepath='C:\Users\kit\Desktop\CheetahData\2015-11-5_17-6-42\Sc6_SS_01.t';
% filepath='C:\Users\kit\Desktop\CheetahData\2016-2-1_13-35-1\Sc6_SS_01.t';

fid = fopen(filepath, 'r', 'b');

line = fgetl(fid);
if ~strcmp(line, '%%BEGINHEADER')
    error('lfp_readTfile:badfile', '%s is not a T-file', filepath);
end
header = [];
linebreak = sprintf('\n');

line = fgetl(fid);
while ~strcmp(line, '%%ENDHEADER')
    header = [ header line linebreak ];
    
    line = fgetl(fid);
end
% line = fgetl(fid);
[spikes, count] = fread(fid, inf, 'uint32');
fprintf(1, 'Read %d spikes from %s\n', count, filepath);
% spikes = spikes * 100;

fclose(fid);

% header
% spikes


function [TimeStamps EventStrings Evt]=readEvents(fnameEV)

% cd('C:\Users\kit\Documents\MATLAB\WR LV')
% fnameEV='C:\Users\kit\Desktop\2015-7-1_15-32-53\Events.Nev';
% fnameEV='C:\Users\kit\Desktop\2008-9-25_20-28-25\Events.Nev';
% fnameEV='C:\Users\kit\Documents\MATLABoriginal\Events.Nev';
% fnameEV='C:\CheetahData\2008-11-14_19-40-1\Events.Nev';
% fnameEV='C:\Users\kit\Desktop\CheetahData\2015-11-5_17-6-42\Events.Nev';

% fnameEV='C:\Users\kit\Desktop\CheetahData\2016-2-1_13-35-1\Events.Nev';
% fnameEV='C:\Users\B133\Desktop\CheetaData\2016-2-18_18-13-11 6721\Events.Nev';
% fnameEV='C:\Users\B133\Desktop\CheetaData\2016-2-23_15-52-2\Events.Nev';

[TimeStamps, EventStrings] = Nlx2MatEV(fnameEV,[1, 0, 0, 0, 1], 0, 1);

EventStrings1 = EventStrings;
CharStrings = char(EventStrings1);

putativedigits = CharStrings(:, end-3:end);

% firstdigits = hex2dec(putativedigits(:, 1));
% nosync = find(firstdigits < 8);

disp('Converting event IDs to binary form.');
Evt = dec2bin(hex2dec(putativedigits));

