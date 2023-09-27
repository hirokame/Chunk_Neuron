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

[TimeStamps, EventStrings] = Nlx2MatEV(fnameEV,[1, 0, 0, 0, 1], 0, 1)

EventStrings1 = EventStrings;
CharStrings = char(EventStrings1);

putativedigits = CharStrings(:, end-3:end);

% firstdigits = hex2dec(putativedigits(:, 1));
% nosync = find(firstdigits < 8);

disp('Converting event IDs to binary form.');
Evt = dec2bin(hex2dec(putativedigits))


% if isempty(CharStrings)
%     error('lfp_readEvents:noevents', ...
%         'There are no events in the event file.' );
% else
%     % Test for and delete any defective events, with warnings.
%     % First, check for non-hex characters (including blank, which appears
%     % when there are fewer than four hex digits):
%     putativedigits = CharStrings(:, end-3:end);
%     [nondigitr nondigitc] = find( ...
%         ~ismember(putativedigits, '0123456789ABCDEF') );
%     if ~isempty(nondigitr)
%         rows = unique(nondigitr);
%         warning('lfp_readEvents:badID', ...
%             ['The events file contains %d corrupted ID strings in %d ' ...
%             'records total.\nThe first corrupted ID is record #%d.' ], ...
%             length(rows), length(TimeStamps), rows(1) );
%         TimeStamps(nondigitr) = [];
%         putativedigits(nondigitr,:) = [];
%     end
%     % Check for events that do not have the highest ("sync") bit set:
%     firstdigits = hex2dec(putativedigits(:, 1));
%     nosync = find(firstdigits < 8);
%     if ~isempty(nosync)
%         warning('lfp_readEvents:nosync', ...
%             'The events file contains event IDs with sync bit = 0.');
%         TimeStamps(nosync) = [];
%         putativedigits(nosync,:) = [];
%     end
%     disp('Converting event IDs to numeric form.');
%     Evt = hex2dec(putativedigits);
% end


% function [params, events, fnameEV] = lfp_readEvents(read_mode, Filename1, Filename2)
% % <events> is in same format as lfp_Events, except timestamps are in
% % microseconds.
% % Sets lfp_DataDir as a side-effect if lfp_UseFileSelect.
% % Note that Filename1 and Filename2 are only required if
% % ~lfp_UseFileSelect.  In that case, if read_mode is 'preset', only
% % Filename1 is attempted anyway.
% % All returned values will be empty if the user cancels the operation via
% % the GUI.
% 
% lfp_declareGlobals;
% 
% events = [];
% params = [];
% fnameEV = [];
% 
% if lfp_UseFileSelect
%     selectedfile = lfp_fileselect('evt', 'Please select an events file:');
%     if isempty(selectedfile)
%         return
%     else
%         if exist('lfp_fileselect.mat') == 2
%             load('lfp_fileselect.mat');
%         else
%             error('lfp_readEvents:nofsfile', ...
%                 'lfp_fileselect.mat does not exist.' );
%         end
%         switch char(lfp_fileselect_FileTypesPopup_string)
%             case 'Events (saved - *.EVTSAV)'
%                 ev_read_mode = 'evtsav';
%             case 'Events (new - *.NEV)'
%                 ev_read_mode = 'nlx';
%             case 'Events (old - *.DAT)'
%                 ev_read_mode = 'nlx';
%             case 'Events (Matlab - *.MAT)'
%                 ev_read_mode = 'mat';
%         end
%     end
%     fnameEV = fullfile(lfp_DataDir, char(selectedfile));
% else
%     % Automatically find Events file.
%     switch read_mode
%         case 'mat'
%             % Filename1 is first preference, but change to .MAT
%             fnameEV=[lfp_DataDir '\' Filename1];
%             [pathstr,name,ext,versn] = fileparts(fnameEV);
%             fnameEV = fullfile(pathstr,[name,'.MAT',versn]);
%         otherwise
%             % Filename1 is first preference
%             fnameEV=[lfp_DataDir '\' Filename1];
%     end
%     if ~(exist(fnameEV, 'file'))
%         switch read_mode
%             case 'preset'
%                 error('lfp_readEvents:badPreset1', ...
%                     'Could not find events file "%s".\n', fnameEV );
%             otherwise
%                 % In desperation, try Filename2
%                 fnameEV=[lfp_DataDir '\' Filename2];
%                 if strcmp(read_mode, 'mat')
%                     [pathstr,name,ext,versn] = fileparts(fnameEV);
%                     fnameEV = fullfile(pathstr,[name,'.MAT',versn]);
%                 end
%                 if ~(exist(fnameEV, 'file'))
%                     error('lfp_readEvents:notfound', ...
%                         'Could not find alternate events file "%s".\n', ...
%                         fnameEV );
%                 end
%         end
%     end
%     ev_read_mode = read_mode;
% end
% fprintf(1, 'Opening events file "%s".\n', fnameEV);
% if strcmp(ev_read_mode, 'preset')
%     [pathstr,name,ext,versn] = fileparts(fnameEV);
%     switch lower(ext)
%         case {'.nev' '.dat'}
%             ev_read_mode = 'nlx';
%         case '.mat'
%             ev_read_mode = 'mat';
%         case '.evtsav'
%             ev_read_mode = 'evtsav';
%         otherwise
%             error('lfp_readEvents:badPreset', ...
%                 'Preset events files must be .NEV, .DAT, .EVTSAV, or .MAT' );
%     end
% end
% if strcmp(ev_read_mode, 'evtsav')
%     load(fnameEV, '-mat');
%     events = lfp_save_events;
%     clear lfp_save_events;
%     events(:,1) = round(1e6 * events(:,1));
%     params = lfp_save_params;
%     clear lfp_save_params;
% else
%     switch ev_read_mode
%         case 'nlx'
%             [TimeStamps, EventStrings] = Nlx2MatEV(fnameEV, ...
%                 [1, 0, 0, 0, 1], 0, 1);
%         case 'mat'
%             load(fnameEV);
%             TimeStamps = dg_Nlx2Mat_Timestamps;
%             clear dg_Nlx2Mat_Timestamps;
%             EventStrings = dg_Nlx2Mat_EventStrings;
%             clear dg_Nlx2Mat_EventStrings;
%     end
%     EventStrings1 = EventStrings;
%     CharStrings = char(EventStrings1);
%     if isempty(CharStrings)
%         error('lfp_readEvents:noevents', ...
%             'There are no events in the event file.' );
%     else
%         % Test for and delete any defective events, with warnings.
%         % First, check for non-hex characters (including blank, which appears
%         % when there are fewer than four hex digits):
%         putativedigits = CharStrings(:, end-3:end);
%         [nondigitr nondigitc] = find( ...
%             ~ismember(putativedigits, '0123456789ABCDEF') );
%         if ~isempty(nondigitr)
%             rows = unique(nondigitr);
%             warning('lfp_readEvents:badID', ...
%                 ['The events file contains %d corrupted ID strings in %d ' ...
%                 'records total.\nThe first corrupted ID is record #%d.' ], ...
%                 length(rows), length(TimeStamps), rows(1) );
%             TimeStamps(nondigitr) = [];
%             putativedigits(nondigitr,:) = [];
%         end
%         % Check for events that do not have the highest ("sync") bit set:
%         firstdigits = hex2dec(putativedigits(:, 1));
%         nosync = find(firstdigits < 8);
%         if ~isempty(nosync)
%             warning('lfp_readEvents:nosync', ...
%                 'The events file contains event IDs with sync bit = 0.');
%             TimeStamps(nosync) = [];
%             putativedigits(nosync,:) = [];
%         end
%         disp('Converting event IDs to numeric form.');
%         Evt = hex2dec(putativedigits);
%         switch lfp_SetupType
%             case 'naotaka2'
%                 % Use this setupType when NOT adding Naotaka's *.DWD files,
%                 % because there are often false positives on all bits of
%                 % his high order byte; however, better agreement with his
%                 % *.DWD is obtained by letting lfp_monkeyPreprocess get rid
%                 % of the BD fragments that result when you include the high
%                 % order byte garbage.
%                 Evt = bitand(Evt, hex2dec('7F')); % kill high byte
%             otherwise
%                 Evt = bitand(Evt, hex2dec('7FFF')); % kill strobe bit
%         end
%     end
%     
%     events = [TimeStamps' Evt];
%     
%     switch lfp_SetupType
%         case {'monkey' 'theresa' 'naotaka'}
%             [params, events] = lfp_monkeyPreprocess(events);
%         case 'rodent'
%             events = lfp_rodentPreprocess(events);
%             params = {};
%     end
% end
% lfp_log(sprintf('Read events file "%s"', fnameEV));
% 
% 
