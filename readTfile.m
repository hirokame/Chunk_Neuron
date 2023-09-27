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

header
spikes



% % % % % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % % % % % Filename = 'C:\Users\kit\Documents\MATLABoriginal\Sc2_03.t';
% % % % % Filename = 'C:\Users\kit\Documents\MATLAB\Sc1_SS_03.t';
% % % % % FieldSelection(1) = 1;
% % % % % 
% % % % %         ExtractHeader = 1;
% % % % %         
% % % % %         ExtractMode = 3;
% % % % % % ModeArray=[];
% % % % %         ModeArray(1) = 0;
% % % % %         ModeArray(2) = 4;
% % % % %         ModeArray(3) = 9;
% % % % % 
% % % % % [TimestampVariable, HeaderVariable] = Nlx2MatTS( Filename, FieldSelection, ExtractHeader, ExtractMode, ModeArray );


% %Dan's program
% function [header, spikes] = lfp_readTfile(filepath)
% % LFP_READTFILE reads an MClust/BubbleClust T-file containing timestamps in
% % units of 100 us (MClust's out-of-the-box loading engines use 10 us units).
% % [header, spikes] = lfp_readTfile(filepath)
% %   The <header> output does not include the delimiters '%%BEGINHEADER',
% %   '%%ENDHEADER', nor their terminating line breaks.
% 
% fid = fopen(filepath, 'r', 'b');
% line = dg_ReadLn(fid);
% if ~strcmp(line, '%%BEGINHEADER')
%     error('lfp_readTfile:badfile', '%s is not a T-file', filepath);
% end
% header = [];
% linebreak = sprintf('\n');
% line = dg_ReadLn(fid);
% while ~strcmp(line, '%%ENDHEADER')
%     header = [ header line linebreak ];
%     line = dg_ReadLn(fid);
% end
% [spikes, count] = fread(fid, inf, 'uint32');
% fprintf(1, 'Read %d spikes from %s\n', count, filepath);
% spikes = spikes * 100;
% fclose(fid);