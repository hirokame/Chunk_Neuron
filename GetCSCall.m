function [LFPsamples_Run TimestampArray filepath]=GetCSCall

global StartTime FinishTime fname

% StartTime
% FinishTime
DurationB=FinishTime-StartTime;

% cd C:\Users\B133\Desktop\WR_LVdata\6721_160218
% load 6721_160218.mat

cd C:\Users\kit\Desktop\CheetahData
%dpath='C:\Documents and Settings\kit\デスクトップ\WR LVdata\';
% [fname,dpath] = uigetfile('*.xls');
[fname,dpath] = uigetfile('*');
disp(fname);

eval(['fnameEV=','''',dpath,'Events.Nev''']);
[TimeStamps EventStrings Evt]=readEvents(fnameEV);
% fnameEV='C:\Users\B133\Desktop\CheetaData\2016-2-18_18-13-11 6721\Events.Nev';

% filepath='C:\Users\B133\Desktop\CheetaData\2016-2-18_18-13-11 6721\Sc1_SS_01.t';
% eval(['filepath=','''',dpath,fname,'''']);

% CSCfile=['A1.Nts';'A5.Nts';'A9.Nts';'B1.Nts';'B5.Nts';'B9.Nts';'CSC1.Nts';'CSC5.Nts'];

CSCfile=['A1.Ncs  ';'A5.Ncs  ';'A9.Ncs  ';'B1.Ncs  ';'B5.Ncs  ';'B9.Ncs  ';'CSC1.Ncs';'CSC5.Ncs'];

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

            for Cfile=1:length(CSCfile)
                File=strtrim(CSCfile(Cfile,:));
                eval(['filepath=','''',dpath,File,'''']);
%                 filepath
%                 filepath=strtrim(filepath);
%                 filepath='C:\Users\kit\Desktop\CheetahData\2016-4-12_16-41-21 6701-03\A1.Ncs'
                [Timestamp, ChanNum, SampleFrequency, NumValSamples, LFPsamples, header] = Nlx2MatCSC(filepath, [1, 1, 1, 1, 1], 1, 1);%この式を使うだけ。functionとして使う必要は無い。


                AllTimestamp=zeros(1,length(Timestamp)*512);

                TimestampArray=[];

                for k=1:length(Timestamp)
                    p=0:511;
                    AllTimestamp((k-1)*512+1:(k-1)*512+512)=Timestamp(k)+528*p;
                end
                AllTimestampLength=length(AllTimestamp);


                TimestampArray=AllTimestamp-SpikeStartTime+StartTime*1000;
                BeforeRec=length(TimestampArray(TimestampArray<0));
                TimestampArray(TimestampArray<0)=[];
                AfterRec=length(TimestampArray(TimestampArray>FinishTime*1000));
                TimestampArray(TimestampArray>FinishTime*1000)=[];

                TimestampArayLength=length(TimestampArray)

                LFPsamples_Run=LFPsamples(BeforeRec+1:end-AfterRec);%BeforeRec+RecLength);
                LFPsample_length=length(LFPsamples_Run)

                format short;
            end
        end
    end
end
if SpikeArray1==0
    disp('No Matched File');
    SpikeArray1=0; 
end


function [spikes] = readTfile(filepath) %[header, spikes] = readTfile('C:\CheetahData\2008-11-6_18-7-10\Sc7_SS_01.t')

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

fclose(fid);


function [TimeStamps EventStrings Evt]=readEvents(fnameEV)

[TimeStamps, EventStrings] = Nlx2MatEV(fnameEV,[1, 0, 0, 0, 1], 0, 1);

EventStrings1 = EventStrings;
CharStrings = char(EventStrings1);

putativedigits = CharStrings(:, end-3:end);

disp('Converting event IDs to binary form.');
Evt = dec2bin(hex2dec(putativedigits));

