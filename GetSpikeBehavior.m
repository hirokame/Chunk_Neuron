function SpikeArray1=GetSpikeBehavior(spikes,TimeStamps, EventStrings, Evt,StartTime, FinishTime)

% global StartTime FinishTime %fname

% StartTime
% FinishTime
DurationB=FinishTime-StartTime;

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
%             [spikes] = readTfile(filepath);
            SpikeArray1=ceil((spikes-StartT(n)/100)/10)+StartTime;
            SpikeArray1(SpikeArray1<-10000)=[];
            SpikeArray1(SpikeArray1>FinishTime)=[];
            SpikeArray1=SpikeArray1';
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


% 
% function [spikes] = readTfile(filepath) %[header, spikes] = readTfile('C:\CheetahData\2008-11-6_18-7-10\Sc7_SS_01.t')
% % slCharacterEncoding('US-ASCII')
% % slCharacterEncoding('Shift_JIS')
% 
% % filepath='C:\Users\kit\Desktop\2008-9-25_20-28-25\Sc1_SS_01.t';
% % filepath='C:\Users\kit\Documents\MATLABoriginal\Sc2_03.t';
% % filepath='C:\Users\kit\Desktop\CheetahData\2015-11-5_17-6-42\Sc6_SS_01.t';
% % filepath='C:\Users\kit\Desktop\CheetahData\2016-2-1_13-35-1\Sc6_SS_01.t';
% 
% fid = fopen(filepath, 'r', 'b');
% 
% line = fgetl(fid);
% if ~strcmp(line, '%%BEGINHEADER')
%     error('lfp_readTfile:badfile', '%s is not a T-file', filepath);
% end
% header = [];
% linebreak = sprintf('\n');
% 
% line = fgetl(fid);
% while ~strcmp(line, '%%ENDHEADER')
%     header = [ header line linebreak ];
%     
%     line = fgetl(fid);
% end
% % line = fgetl(fid);
% [spikes, count] = fread(fid, inf, 'uint32');
% fprintf(1, 'Read %d spikes from %s\n', count, filepath);
% % spikes = spikes * 100;
% 
% fclose(fid);
% 
% % header
% % spikes
% 
% 
% function [TimeStamps EventStrings Evt]=readEvents(fnameEV)
% 
% % cd('C:\Users\kit\Documents\MATLAB\WR LV')
% % fnameEV='C:\Users\kit\Desktop\2015-7-1_15-32-53\Events.Nev';
% % fnameEV='C:\Users\kit\Desktop\2008-9-25_20-28-25\Events.Nev';
% % fnameEV='C:\Users\kit\Documents\MATLABoriginal\Events.Nev';
% % fnameEV='C:\CheetahData\2008-11-14_19-40-1\Events.Nev';
% % fnameEV='C:\Users\kit\Desktop\CheetahData\2015-11-5_17-6-42\Events.Nev';
% 
% % fnameEV='C:\Users\kit\Desktop\CheetahData\2016-2-1_13-35-1\Events.Nev';
% % fnameEV='C:\Users\B133\Desktop\CheetaData\2016-2-18_18-13-11 6721\Events.Nev';
% % fnameEV='C:\Users\B133\Desktop\CheetaData\2016-2-23_15-52-2\Events.Nev';
% 
% [TimeStamps, EventStrings] = Nlx2MatEV(fnameEV,[1, 0, 0, 0, 1], 0, 1);
% 
% EventStrings1 = EventStrings;
% CharStrings = char(EventStrings1);
% 
% putativedigits = CharStrings(:, end-3:end);
% 
% % firstdigits = hex2dec(putativedigits(:, 1));
% % nosync = find(firstdigits < 8);
% 
% disp('Converting event IDs to binary form.');
% Evt = dec2bin(hex2dec(putativedigits));
% 
