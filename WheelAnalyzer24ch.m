function varargout = WheelAnalyzer24ch(varargin)
% WHEELANALYZER M-file for WheelAnalyzer.fig
%      WHEELANALYZER, by itself, creates a new WHEELANALYZER or raises the existing
%      singleton*.
%
%      H = WHEELANALYZER returns the handle to a new WHEELANALYZER or the handle to
%      the existing singleton*.
%
%      WHEELANALYZER('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in WHEELANALYZER.M with the given input arguments.
%

%      WHEELANALYZER('Property','Value',...) creates a new WHEELANALYZER or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before WheelAnalyzer_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to WheelAnalyzer_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help WheelAnalyzer

% Last Modified by GUIDE v2.5 18-Jun-2013 15:08:01

% Begin initialization code - DO NOT EDIT
gui_Singleton = 0;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @WheelAnalyzer_OpeningFcn, ...
                   'gui_OutputFcn',  @WheelAnalyzer_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before WheelAnalyzer is made visible.
function WheelAnalyzer_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to WheelAnalyzer (see VARARGIN)

% Choose default command line output for WheelAnalyzerfigure1_WindowButtonDownFcn
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);



function varargout = WheelAnalyzer_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;


function Dataload_pushbutton_Callback(hObject, eventdata, handles)

global dpath fname PegOffset RpegTimeArray LpegTimeArray OneTurnTime TurnMarkerTime RpegTimeArray2D LpegTimeArray2D ...
    WaterOnArray WaterOffArray WaterOnArrayOriginal WaterOffArrayOriginal SpikeNum data DrName ShowFig FigureSave modif patternValue...
    NumDrinkTurn NumDrinkTurnCum OnWaterLen OnWaterLenCum NumFloorTouchTurn NumFloorTouchTurnCum
%SpikeNumはDataLoadでSpikeNum=1と設定され、あとはSpikeAnalysis内で実行のたびに１ずつ増加する。
ShowFig=get(handles.radiobutton_ShowFigure,'Value');
FigureSave=get(handles.radiobutton_SaveFigure,'Value');
patternValue=get(handles.popupmenu_pattern,'Value');
% PegOffsetCell=get(handles.popupmenu_offset,'String');
% PegOffset=str2double(PegOffsetCell(get(handles.popupmenu_offset,'Value')))
PegOffset=0;%使用しない。なくしてもいいが、Dataloadの引数になっているので注意。
[RpegTimeArray,LpegTimeArray,RpegTimeArray2D,LpegTimeArray2D,OneTurnTime TurnMarkerTime]=DataLoad24ch(PegOffset,dpath,fname);
%disp(RpegTimeArray);
%disp(LpegTimeArray);

modif=0;
disp('loaded');

TurnMarkerTime
Turn20=TurnMarkerTime(20)


function PegPattern_pushbutton_Callback(hObject, eventdata, handles)

PlotPegPattern;


function popupmenu_RefPeriod_Callback(hObject, eventdata, handles)


function popupmenu_RefPeriod_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function pushbutton_TouchAnalysis_Callback(hObject, eventdata, handles)
global data R_PegTouchCell L_PegTouchCell

disp('PegTouch');
global RefPeriod OneTurnTime PegTouchCell fname DrName FTselect PegTouchTurn FigureSave SliderTouch patternValue Turn20
RefPeriodCell=get(handles.popupmenu_RefPeriod,'String');

RefPeriod=str2double(RefPeriodCell(get(handles.popupmenu_RefPeriod,'Value')));
RefPeriodStr=int2str(RefPeriod);
% [PegTouchCell,PegTouchTurn]=PegTouch;

RightTouchData=[data(:,14),data(:,15),data(:,16),data(:,17),data(:,18),data(:,19),data(:,20),data(:,21),data(:,22),data(:,23),data(:,24),data(:,25)];
[R_PegTouchCell,R_PegTouchTurn]=PegTouch24ch(RightTouchData);

LeftTouchData=[data(:,42),data(:,43),data(:,44),data(:,45),data(:,46),data(:,47),data(:,48),data(:,49),data(:,50),data(:,51),data(:,52),data(:,53)];
[L_PegTouchCell,L_PegTouchTurn]=PegTouch24ch(LeftTouchData);

%Peg－patternの選択
patternValue=get(handles.popupmenu_pattern,'Value');
if patternValue == 1;% 一般的なパターン用(新ホイール)
    SliderTouch=[0.9300 0.0200 0.1100 0.1900 0.2800 0.3600 0.44500 0.5200 0.6100 0.6900 0.77500 0.8600...
        0.9300 0.0200 0.1100 0.1900 0.2800 0.3600 0.44500 0.5200 0.6100 0.6900 0.77500 0.8600];
%        SliderTouch=[0.9300 0.0200 0.1100 0.1900 0.2800 0.3600 0.9600 0.0500 0.1400 0.2200 0.3100 0.3900];
   elseif patternValue == 2;% 一般的なパターン用(旧ホイール)
       SliderTouch=[0.8900 0.9600 0.0400 0.1300 0.1900 0.2800 0.8600 0.9600 0.0500 0.120 0.2100 0.2800];
%    elseif patternValue == 2;%20090312のパターン用
%        SliderTouch=[0.8400 0.8900 0.9500 0.0800 0.1100 0.1700 0.7700 0.8000 0.9300 0.9700 0.09100 0.1100];
   elseif patternValue == 3;%20090220のパターン用 Pattern4 new wheel
       SliderTouch=[0.9600 0.0300 0.1150 0.1650 0.2500 0.3600 0.9000 0.9800 0.0800 0.1900 0.2800 0.3300];
   elseif patternValue == 4;%20090220のパターン用 (pattern4,old wheel)
       SliderTouch=[0.8600 0.9400 0.0200 0.06500 0.1500 0.2800 0.9300 0.0000 0.0000 0.1100 0.1900 0.2500];        
%    elseif patternValue == 4;%20090414のパターン用 (pattern6)
%        SliderTouch=[0.8600 0.9400 0.0200 0.1100 0.1700 0.2800 0.8600
%        0.9400 0.0000 0.1100 0.1900 0.2300];
   elseif patternValue == 5;%20090710-Bのパターン用
       SliderTouch=[0.8000 0.7600 0.96 0.0600 0.15 0.225 0.8200 0.9400 0.00 0.1200 0.1700 0.2400];
   elseif patternValue == 6;%20090710-Aのパターン用
       SliderTouch=[0.000 0.0700 0.1400 0.1900 0.2800 0.3600 0.9600 0.0500 0.1400 0.2200 0.3100 0.3900];   
%    elseif patternValue == 7;%20090904のパターン用
%        SliderTouch=[0.9100 0.9800 0.0200 0.1400 0.2300 0.2800 0.8100 0.8200 0.8830 0.990 0.0800 0.1900];
   elseif patternValue == 7;%5秒/turnの一般的なパターン用
       SliderTouch=[0.8500 0.9300 0.0160 0.0880 0.1520 0.2300 0.8400 0.9000 0.0160 0.0820 0.1520 0.2600];  
   elseif patternValue == 8;%RegularA-1(Right)のパターン用
       SliderTouch=[0.9300 0.0200 0.1100 0.1900 0.2800 0.3600 0.9600 0.0500 0.1400 0.2200 0.3100 0.3900];  
   elseif patternValue == 9;%A-1(Right3Left9)のパターン用
       SliderTouch=[0.9300 0.0200 0.1100 0.1900 0.2800 0.3600 0.9600 0.0500 0.1400 0.2200 0.3100 0.3900];  
   elseif patternValue == 10;% ABパターン(9peg)用
       SliderTouch=[0.000 0.1200 0.2200 0.3200 0.4200 0.5500 0.0100 0.1200 0.2200 0.3200 0.5000 0.6000]; 
   elseif patternValue == 11;% Multiphase
       RefPeriodCell=get(handles.popupmenu_RefPeriod,'String');
       RefPeriod=str2double(RefPeriodCell(get(handles.popupmenu_RefPeriod,'Value')));
       RefPeriodStr=int2str(RefPeriod);
       [PegTouchCell,PegTouchTurn]=PegTouch;
       [RTouchAll,LTouchAll]=TouchExtract(PegTouchCell);
       [LRLphase,RLRphase]=PhaseAnalyzer(LTouchAll,RTouchAll); 
   elseif patternValue == 12;% Stepwise
       SliderTouch=[0.9300 0.0200 0.1100 0.1900 0.2800 0.3600 0.9600 0.0500 0.1400 0.2200 0.3100 0.3900];    
   else SliderTouch=[0.8600 0.9400 0.0200 0.1100 0.1900 0.2800 0.8600 0.9400 0.0200 0.1100 0.1900 0.2800];
end

TouchDividerAnalyzer24ch(R_PegTouchTurn,L_PegTouchTurn,OneTurnTime,SliderTouch);
%CurDir=char('C:\Documents and Settings\永田雅俊\デスクトップ\WR LVdata\DataAnalysed');
%FTselectCell=get(handles.popupmenu_FirstTouch,'String')
FTselect=get(handles.popupmenu_FirstTouch,'Value')
%FTselect=str2double(get(handles.popupmenu_FirstTouch,'Value'))
if FTselect==1;AllorFirst='1st';elseif FTselect==2;AllorFirst='All';end


function pushbutton_DetachAnalysis_Callback(hObject, eventdata, handles)

disp('Detach');
global RefPeriod;
RefPeriodCell=get(handles.popupmenu_RefPeriod,'String');
RefPeriod=str2double(RefPeriodCell(get(handles.popupmenu_RefPeriod,'Value')))
Detach;


function pushbutton_TouchToDetach_Callback(hObject, eventdata, handles)

global PegTouchCell PegDetachCell;
TouchToDetach(PegTouchCell,PegDetachCell,2000,80,50);%TouchToDetach(PegTouchCell,PegDetachCell,duration,columns,yhight)


function popupmenu_TouchOrDetach_Callback(hObject, eventdata, handles)

function popupmenu_TouchOrDetach_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function pushbutton_CrossPegAnalysis_Callback(hObject, eventdata, handles)

global RpegTouchCell LpegTouchCell RLpegTouchCell PegDetachCell CrossVar CrossVarInv RpegTouchCell LpegTouchCell...
    OneTurnTime DrName RpegTouchTurn LpegTouchTurn RpegTouchMatrix LpegTouchMatrix FTselect fig_CrossVarInv_CLmap Num_SmallVar ChunkLength ChunkEnd ShowFig PegTouchCell

ShowFig=get(handles.radiobutton_ShowFigure,'Value');
Graph=get(handles.radiobutton_Graph1,'Value');
%disp(Graph);
TDselectValue=get(handles.popupmenu_TouchOrDetach,'Value');
if TDselectValue==1;TDselect=RLpegTouchCell;disp('Cross analysis R&L PegTouch');
elseif TDselectValue==2;TDselect=RpegTouchCell;disp('Cross analysis R PegTouch');
elseif TDselectValue==3;TDselect=LpegTouchCell;disp('Cross analysis L PegTouch');
elseif TDselectValue==4;TDselect=PegDetachCell;disp('Cross analysis Detach');
end
% [VarMeans,VarSTD,CrossVar,CrossVarInv]=CrossPeg(RpegTouchTurn,LpegTouchTurn,TDselect,Graph,OneTurnTime,20,FTselect);% Num_SmallVar ChunkLength ChunkEnd Sum_SmallVar
[VarMeans,VarSTD,CrossVar,CrossVarInv]=CrossPeg24ch(RpegTouchTurn,LpegTouchTurn,RpegTouchMatrix,LpegTouchMatrix,TDselect,Graph,OneTurnTime,20,FTselect);
%feval('save',DrName);%すべてのデータをmat形式で保存


function popupmenu_VarRedraw_Callback(hObject, eventdata, handles)


function popupmenu_VarRedraw_CreateFcn(hObject, eventdata, handles)

%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function pushbutton_VarRedraw_Callback(hObject, eventdata, handles)

global CrossVarInv;
XYaxis=length(CrossVarInv);
popupmenu_VarRedrawCell=get(handles.popupmenu_VarRedraw,'String');
Zaxis=str2double(popupmenu_VarRedrawCell(get(handles.popupmenu_VarRedraw,'Value')));
CrossVarInvRedraw(CrossVarInv,XYaxis,Zaxis)


function pushbutton_Autocorr_Callback(hObject, eventdata, handles)

global RpegTimeArray LpegTimeArray RLpegTimeArray SpikeArray1 SpikeArray2 SpikeArray3 SpikeArray4 SpikeArray5 RLPegTouchAll RPegTouchAll LPegTouchAll OneTurnTime...
    DrinkOnArray DrinkOffArray FloorDetachArray DrName FigureSave ACselect ACset %RLPegTouchAll RPegTouchAll LPegTouchAllはPegTouchより
AutoCorrValue=get(handles.popupmenu_AutoCorr,'Value');
if ~isempty(ACset)==1
    AutoCorrValue=ACset;
end

if AutoCorrValue==2;ACselect=SpikeArray1';T='Autocorr Spike';disp(T);
elseif (AutoCorrValue==3)ACselect=RpegTimeArray;T='Autocorr Right peg';disp(T);
elseif (AutoCorrValue==4)ACselect=LpegTimeArray;T='Autocorr Left peg';disp(T);
elseif (AutoCorrValue==5)RLpegTimeArray=sort([RpegTimeArray;LpegTimeArray]);ACselect=RLpegTimeArray;T='Autocorr R&L peg';disp(T);
elseif (AutoCorrValue==6)ACselect=RPegTouchAll;T='Autocorr Right touch';disp(T);
elseif (AutoCorrValue==7)ACselect=LPegTouchAll;T='Autocorr Left touch';disp(T);
elseif (AutoCorrValue==8)ACselect=RLPegTouchAll;T='Autocorr R&L touch';disp(T);
elseif (AutoCorrValue==9)ACselect=DrinkOnArray;T='Autocorr DrinkOn';disp(T);
elseif (AutoCorrValue==10)ACselect=DrinkOffArray;T='Autocorr DrinkOff';disp(T);
elseif (AutoCorrValue==11)ACselect=SpikeArray2';T='Autocorr Spike2';
elseif (AutoCorrValue==12)ACselect=SpikeArray3';T='Autocorr Spike3';
elseif (AutoCorrValue==13)ACselect=SpikeArray4';T='Autocorr Spike4';
elseif (AutoCorrValue==14)ACselect=SpikeArray5';T='Autocorr Spike5';
end

%disp(length(SpikeArray));
disp('AutoCorr length=');disp(length(ACselect));
%disp(length(ACselect));
popupmenu_ACduration=get(handles.popupmenu_ACduration,'String');
duration=str2double(popupmenu_ACduration(get(handles.popupmenu_ACduration,'Value')));
Title=char(strcat({T}));disp(Title);

% if duration<=1000;bin=100;else bin=300;end%binはhistグラフの細かさ（分割数）
bin=floor(duration/10);

Direction=get(handles.radiobutton_direction,'Value');%Directionは両方向か片方向か
% if Direction==1;duration=duration/2;end
% duration=duration/2;
% if duration==-1;duration=OneTurnTime;end

% ACselect=instantArray(ACselect,100);

[AutoCo]=AutoCorr(ACselect,duration,Direction);

FigOpen=get(handles.radiobutton_FigureOpen,'Value');
if FigOpen==1;
   figure('Position',[1 1 1400 975]);

   ACresult=hist(AutoCo,bin)/length(ACselect);

   contents_MovWindow = cellstr(get(handles.popupmenu_MovWindow,'String'));
   MovW=str2num(contents_MovWindow{get(handles.popupmenu_MovWindow,'Value')});

   GaussSmooth=get(handles.radiobutton_Gauss,'Value');%Directionは両方向か片方向か

   if MovW~=0;ACresult=MovWindow(ACresult,MovW);%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   elseif GaussSmooth==1;ACresult=instantArray(ACresult,2);
   end


   % if GaussSmooth==1;ACresult=instantArray(ACresult,2);end

   ACFig=plot(linspace(1,duration,bin),ACresult);title(T);
   axis([0 duration 0 (max(ACresult)*1.05)]);

else
%WHeelAnalyzer内に表示させるとき%%%%%%%%%%
   axes(handles.axes1);
   cla;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   ACresult=hist(AutoCo,bin)/length(ACselect);

   contents_MovWindow = cellstr(get(handles.popupmenu_MovWindow,'String'));
   MovW=str2num(contents_MovWindow{get(handles.popupmenu_MovWindow,'Value')});

   GaussSmooth=get(handles.radiobutton_Gauss,'Value');%Directionは両方向か片方向か

   if MovW~=0;ACresult=MovWindow(ACresult,MovW);%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   elseif GaussSmooth==1;ACresult=instantArray(ACresult,2);
   end


   % if GaussSmooth==1;ACresult=instantArray(ACresult,2);end

   ACFig=plot(linspace(1,duration,bin),ACresult);title(T);
   axis([0 duration 0 (max(ACresult)*1.05)]);
end

ShowFig=get(handles.radiobutton_ShowFigure,'Value');
FigureSave=get(handles.radiobutton_SaveFigure,'Value');

FigName=char(strcat({DrName},{' '},{T},{'.bmp'}));
% if FigureSave==1;saveas(ACFig,FigName);end

set(handles.text_point4,'String','0');


function popupmenu_AutoCorr_Callback(hObject, eventdata, handles)


function popupmenu_AutoCorr_CreateFcn(hObject, eventdata, handles)

%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function popupmenu_ACduration_Callback(hObject, eventdata, handles)


function popupmenu_ACduration_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function pushbutton_ClearAll_Callback(hObject, eventdata, handles)

set(handles.text_FileName,'String','');
set(handles.text_UnitName,'String','');
set(handles.text_UnitName2,'String','');
set(handles.text_UnitName3,'String','');
set(handles.text_UnitName4,'String','');
set(handles.text_UnitName5,'String','');
set(handles.listbox_name,'String','');
set(handles.listbox_Start,'String','');
set(handles.listbox_Stop,'String','');
set(handles.text_cscfile,'String','');
set(handles.text_cscref,'String','');
set(handles.text_SpikeStartTime,'String','');
set(handles.text_SpikeStopTime,'String','');
clearvars -except dpath h len n dpath2 dname
% clear all;
disp ('Clear');

function pushbutton_clearall_Callback(hObject, eventdata, handles)
% pushbutton_ClearAll_Callback(hObject, eventdata, handles);
clear all;
disp ('ClearAll');


function pushbutton_FileSelect_Callback(hObject, eventdata, handles)

global fname dpath DrName
[fname,dpath]=FileSelect;
%disp(fname);
%disp(dpath);
set(handles.text_FileName,'String',fname);
%edit_FileName.string=fname;
          
% cd (char('C:\Documents and Settings\永田雅俊\デスクトップ\WR LVdata\DataAnalysed'));
cd (char('C:\Users\B133\Desktop\WR_LVdata\DataAnalysed'));

DrName=[fname(1:length(fname)-4),' '];%char(fname(1:length(fname)-4),{' '})%char(strcat({fname(1:length(fname)-4)},{' '},{RefPeriodStr},{' '},{AllorFirst}));
mkdir(DrName);
% FLName=char(strcat({'C:\Documents and Settings\永田雅俊\デスクトップ\WR LVdata\DataAnalysed'},{'\'},{DrName}))
FLName=char(strcat({'C:\Users\B133\Desktop\WR_LVdata'},{'\'},{DrName}))

cd (char(FLName));

% --- Executes on button press in pushbutton_SelectMat.
function pushbutton_SelectMat_Callback(hObject, eventdata, handles)
global fname dpath DrName StartTime FinishTime
[fnamemat,dpathmat]=FileSelectMat;
% load(fnamemat)
% TurnMarkerTime

set(handles.text_FileName,'String',fnamemat);

% cd (char('C:\Documents and Settings\永田雅俊\デスクトップ\WR LVdata\DataAnalysed'));
% DrName=[fname(1:length(fname)-4),' '];%char(fname(1:length(fname)-4),{' '})%char(strcat({fname(1:length(fname)-4)},{' '},{RefPeriodStr},{' '},{AllorFirst}));
% mkdir(DrName);
% % FLName=char(strcat({'C:\Documents and Settings\永田雅俊\デスクトップ\WR LVdata\DataAnalysed'},{'\'},{DrName}))
% FLName=char(strcat({'C:\Documents and Settings\永田雅俊\デスクトップ\WR LVdata\DataAnalysed'},{'\'},{DrName}))
% 
% cd (char(FLName));



function pushbutton_ANALYSIS_Callback(hObject, eventdata, handles)

global SliderTouch PegTouchCell TurnMarkerTime OneTurnTime RpegTimeArray2D LpegTimeArray2D RpegTouchCell LpegTouchCell RLpegTouchCell...
    RLpegName RLpegMedian RpegTouchTurn LpegTouchTurn FTselect RLPegTouchAll RPegTouchAll LPegTouchAll ShowFig FigureSave modif...
    RmedianPTTM LmedianPTTM patternValue R_PegTouchCell L_PegTouchCell R_PegTouchTurn L_PegTouchTurn RpegTouchMatrix LpegTouchMatrix...
     RtouchHist LtouchHist RLtouchHist
    %RpegTouchTurn LpegTouchTurn RLpegTouchTurn RpegMedian LpegMedian
FTselect=get(handles.popupmenu_FirstTouch,'Value');
if FTselect==1;disp('Analyze 1st Touch');
elseif FTselect==2;disp('Analyze All Touches');
end
%disp(SliderTouch);

ShowFig=get(handles.radiobutton_ShowFigure,'Value');

% [RpegTouchCell,LpegTouchCell,RLpegTouchCell,RLpegName,RLpegMedian,RpegTouchTurn,LpegTouchTurn RpegTouchMatrix LpegTouchMatrix]=...
    PegTouchAnalysis24ch(R_PegTouchCell,L_PegTouchCell,SliderTouch,TurnMarkerTime,OneTurnTime,RpegTimeArray2D,LpegTimeArray2D,FTselect);


function radiobutton_Graph1_Callback(hObject, eventdata, handles)


function pushbutton_SpikeTime_Callback(hObject, eventdata, handles)
global event_name event_ts filename_spike
set(handles.text_UnitName,'String',filename_spike);
set(handles.listbox_name,'String',event_name);
set(handles.listbox_Start,'String',event_ts);
set(handles.listbox_Stop,'String',event_ts);


function listbox_Start_Callback(hObject, eventdata, handles)

global SpikeStartTime
contents=get(hObject,'String');%event_tsの配列を返す
% A=get(hObject,'Value'); %%%数値は個々の数字のテキストの2次元配列としてコードされている!!!
% disp(A);
% disp(contents(A,:));
SpikeStartTime=str2double(contents(get(hObject,'Value'),:))

function listbox_Start_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function listbox_Stop_Callback(hObject, eventdata, handles)
global SpikeStopTime
contents=get(hObject,'String');%event_tsの配列を返す
% A=get(hObject,'Value'); %%%数値は個々の数字の2次元配列としてコードされている!!!
% disp(A);
% disp(contents(A,:));
SpikeStopTime=str2double(contents(get(hObject,'Value'),:))

function listbox_Stop_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_SpikeTime2.
function pushbutton_SpikeTime2_Callback(hObject, eventdata, handles)
global event_name event_ts filename_spike
set(handles.text_UnitName2,'String',filename_spike);
set(handles.listbox_name,'String',event_name);
set(handles.listbox_Start,'String',event_ts);
set(handles.listbox_Stop,'String',event_ts);


% --- Executes on button press in pushbutton_SpikeTime3.
function pushbutton_SpikeTime3_Callback(hObject, eventdata, handles)
global event_name event_ts filename_spike
set(handles.text_UnitName3,'String',filename_spike);
set(handles.listbox_name,'String',event_name);
set(handles.listbox_Start,'String',event_ts);
set(handles.listbox_Stop,'String',event_ts);


% --- Executes on button press in pushbutton_SpikeTime4.
function pushbutton_SpikeTime4_Callback(hObject, eventdata, handles)
global event_name event_ts filename_spike
set(handles.text_UnitName4,'String',filename_spike);
set(handles.listbox_name,'String',event_name);
set(handles.listbox_Start,'String',event_ts);
set(handles.listbox_Stop,'String',event_ts);


% --- Executes on button press in pushbutton_SpikeTime5.
function pushbutton_SpikeTime5_Callback(hObject, eventdata, handles)
global event_name event_ts filename_spike
set(handles.text_UnitName5,'String',filename_spike);
set(handles.listbox_name,'String',event_name);
set(handles.listbox_Start,'String',event_ts);
set(handles.listbox_Stop,'String',event_ts);

function pushbutton_SpikeAnalysis_Callback(hObject, eventdata, handles)

global SpikeArrayCell StartTime FinishTime SpikeStartTime SpikeStopTime ts_spike SpikeArray1...
    TurnMarkerTime OneTurnTime WaterOnArray WaterOffArray DrName filename_spike SpikeNum Spike OneTurnTime
%SpikeNumはDataLoadでSpikeNum=1と設定され、あとはSpikeAnalysis内で実行のたびに１ずつ増加する。
SpikeArray1=SpikeAnalysis(StartTime,FinishTime,SpikeStartTime,SpikeStopTime,ts_spike);

% --- Executes on button press in pushbutton_SpikeAnalysis2.
function pushbutton_SpikeAnalysis2_Callback(hObject, eventdata, handles)
global SpikeArrayCell StartTime FinishTime SpikeStartTime SpikeStopTime ts_spike SpikeArray2...
    TurnMarkerTime OneTurnTime WaterOnArray WaterOffArray  filename_spike SpikeNum Spike OneTurnTime
%SpikeNumはDataLoadでSpikeNum=1と設定され、あとはSpikeAnalysis内で実行のたびに１ずつ増加する。
SpikeArray2=SpikeAnalysis(StartTime,FinishTime,SpikeStartTime,SpikeStopTime,ts_spike);


% --- Executes on button press in pushbutton_SpikeAnalysis3.
function pushbutton_SpikeAnalysis3_Callback(hObject, eventdata, handles)
global SpikeArrayCell StartTime FinishTime SpikeStartTime SpikeStopTime ts_spike SpikeArray3...
    TurnMarkerTime OneTurnTime WaterOnArray WaterOffArray DrName filename_spike SpikeNum Spike OneTurnTime
%SpikeNumはDataLoadでSpikeNum=1と設定され、あとはSpikeAnalysis内で実行のたびに１ずつ増加する。
SpikeArray3=SpikeAnalysis(StartTime,FinishTime,SpikeStartTime,SpikeStopTime,ts_spike);


% --- Executes on button press in pushbutton_SpikeAnalysis4.
function pushbutton_SpikeAnalysis4_Callback(hObject, eventdata, handles)
global SpikeArrayCell StartTime FinishTime SpikeStartTime SpikeStopTime ts_spike SpikeArray4...
    TurnMarkerTime OneTurnTime WaterOnArray WaterOffArray DrName filename_spike SpikeNum Spike OneTurnTime
%SpikeNumはDataLoadでSpikeNum=1と設定され、あとはSpikeAnalysis内で実行のたびに１ずつ増加する。
SpikeArray4=SpikeAnalysis(StartTime,FinishTime,SpikeStartTime,SpikeStopTime,ts_spike);


% --- Executes on button press in pushbutton_SpikeAnalysis5.
function pushbutton_SpikeAnalysis5_Callback(hObject, eventdata, handles)
global SpikeArrayCell StartTime FinishTime SpikeStartTime SpikeStopTime ts_spike SpikeArray5...
    TurnMarkerTime OneTurnTime WaterOnArray WaterOffArray DrName  SpikeNum Spike OneTurnTime
%SpikeNumはDataLoadでSpikeNum=1と設定され、あとはSpikeAnalysis内で実行のたびに１ずつ増加する。
SpikeArray5=SpikeAnalysis(StartTime,FinishTime,SpikeStartTime,SpikeStopTime,ts_spike);


function pushbutton_CrossCorr_Callback(hObject, eventdata, handles)

global RpegTimeArray LpegTimeArray RLpegTimeArray SpikeArray1 SpikeArray2 SpikeArray3 SpikeArray4 SpikeArray5 RLPegTouchAll RPegTouchAll LPegTouchAll...
    WaterOnArrayOriginal WaterOffArrayOriginal TurnMarkerTime OneTurnTime DrName ACselect CCselect CCselect2 CCselect3...
    T DrinkOnArray DrinkOffArray FloorTouchArray FloorDetachArray MedPegTimeR MedPegTimeL AutoCorrValue CCresult LFPsamples...
    RpegTouchBypegCell  LpegTouchBypegCell ACset CCset CCset2 CCset3 RmedianPTTM LmedianPTTM Alt Maxhold%RLPegTouchAll RPegTouchAll LPegTouchAllはPegTouchより
%Array2のタイミングでアライン

TurnMarkerTime

AutoCorrValue=get(handles.popupmenu_AutoCorr,'Value');
if ~isempty(ACset)==1
    AutoCorrValue=ACset;
end
if AutoCorrValue==1;ACselect=[];T=' ';
elseif AutoCorrValue==2;ACselect=SpikeArray1';T='Crosscorr Spike1';
elseif (AutoCorrValue==3)ACselect=RpegTimeArray;T='Crosscorr Right peg';
elseif (AutoCorrValue==4)ACselect=LpegTimeArray;T='Crosscorr Left peg';
elseif (AutoCorrValue==5)RLpegTimeArray=sort([RpegTimeArray;LpegTimeArray]);ACselect=RLpegTimeArray;T='Crosscorr R&L peg';
elseif (AutoCorrValue==6)ACselect=RPegTouchAll;T='Crosscorr Right touch';
elseif (AutoCorrValue==7)ACselect=LPegTouchAll;T='Crosscorr Left touch';
elseif (AutoCorrValue==8)ACselect=RLPegTouchAll;T='Crosscorr R&L touch';
elseif (AutoCorrValue==9)ACselect=DrinkOnArray;T='Crosscorr DrinkOn';
elseif (AutoCorrValue==10)ACselect=DrinkOffArray;T='Crosscorr DrinkOff';
elseif (AutoCorrValue==11)ACselect=SpikeArray2';T='Crosscorr Spike2';
elseif (AutoCorrValue==12)ACselect=SpikeArray3';T='Crosscorr Spike3';
elseif (AutoCorrValue==13)ACselect=SpikeArray4';T='Crosscorr Spike4';
elseif (AutoCorrValue==14)ACselect=SpikeArray5';T='Crosscorr Spike5';
elseif (AutoCorrValue==15)ACselect=LFPsamples';T='Crosscorr LFP';
end

CrossCorrValue=get(handles.popupmenu_CrossCorr,'Value');
if ~isempty(CCset)==1
    CrossCorrValue=CCset;
end
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

CrossCorrValue2=get(handles.popupmenu_CrossCorr2,'Value');
if ~isempty(CCset2)==1
    CrossCorrValue2=CCset2;
end
if CrossCorrValue2==1;CCselect2=[];R=' ';%CCselect=TurnMarkerTime';S='aligned by TurnMarker';
elseif CrossCorrValue2==2;CCselect2=WaterOnArrayOriginal';R=', WaterOn';    
elseif CrossCorrValue2==3;CCselect2=WaterOffArrayOriginal';R=', WaterOff';    
elseif CrossCorrValue2==4;CCselect2=SpikeArray1';R=', Spike';
elseif (CrossCorrValue2==5) CCselect2=RpegTimeArray;R=', Right peg';
elseif (CrossCorrValue2==6) CCselect2=LpegTimeArray;R=', Left peg';
elseif (CrossCorrValue2==7) RLpegTimeArray=sort([RpegTimeArray;LpegTimeArray]);CCselect2=RLpegTimeArray;R='aligned by R&L peg';
elseif (CrossCorrValue2==8) CCselect2=RPegTouchAll;R=', Right touch';
elseif (CrossCorrValue2==9) CCselect2=LPegTouchAll;R=', Left touch';
elseif (CrossCorrValue2==10) CCselect2=RLPegTouchAll;R=', R&L touch';
elseif (CrossCorrValue2==11) CCselect2=FloorTouchArray;R=', FloorTouch';
elseif (CrossCorrValue2==12) CCselect2=FloorDetachArray;R=', FloorDetach';
elseif (CrossCorrValue2==13) CCselect2=DrinkOnArray;R=', DrinkOn';
elseif (CrossCorrValue2==14) CCselect2=DrinkOffArray;R=', DrinkOff';
elseif (CrossCorrValue2==15)CCselect2=SpikeArray2';R=', Spike2';
elseif (CrossCorrValue2==16)CCselect2=SpikeArray3';R=', Spike3';
elseif (CrossCorrValue2==17)CCselect2=SpikeArray4';R=', Spike4';
elseif (CrossCorrValue2==18)CCselect2=SpikeArray5';R=', Spike5';
end

CrossCorrValue3=get(handles.popupmenu_CrossCorr3,'Value');
if ~isempty(CCset3)==1
    CrossCorrValue3=CCset3;
end
if CrossCorrValue3==1;CCselect3=[];P=' ';%CCselect=TurnMarkerTime';S='aligned by TurnMarker';
elseif CrossCorrValue3==2;CCselect3=WaterOnArrayOriginal';P=', WaterOn';    
elseif CrossCorrValue3==3;CCselect3=WaterOffArrayOriginal';P=', WaterOff';    
elseif CrossCorrValue3==4;CCselect3=SpikeArray1';P=', Spike';
elseif (CrossCorrValue3==5) CCselect3=RpegTimeArray;P=', Right peg';
elseif (CrossCorrValue3==6) CCselect3=LpegTimeArray;P=', Left peg';
elseif (CrossCorrValue3==7) RLpegTimeArray=sort([RpegTimeArray;LpegTimeArray]);CCselect3=RLpegTimeArray;P='aligned by R&L peg';
elseif (CrossCorrValue3==8) CCselect3=RPegTouchAll;P=', Right touch';
elseif (CrossCorrValue3==9) CCselect3=LPegTouchAll;P=', Left touch';
elseif (CrossCorrValue3==10) CCselect3=RLPegTouchAll;P=', R&L touch';
elseif (CrossCorrValue3==11) CCselect3=FloorTouchArray;P=', FloorTouch';
elseif (CrossCorrValue3==12) CCselect3=FloorDetachArray;P=', FloorDetach';
elseif (CrossCorrValue3==13) CCselect3=DrinkOnArray;P=', DrinkOn';
elseif (CrossCorrValue3==14) CCselect3=DrinkOffArray;P=', DrinkOff';
elseif (CrossCorrValue3==15)CCselect3=SpikeArray2';P=', Spike2';
elseif (CrossCorrValue3==16)CCselect3=SpikeArray3';P=', Spike3';
elseif (CrossCorrValue3==17)CCselect3=SpikeArray4';P=', Spike4';
elseif (CrossCorrValue3==18)CCselect3=SpikeArray5';P=', Spike5';
end

Title=char(strcat({T},{R},{P},{' '},{S}));disp(Title);
disp('CrossCorr length=');disp(length(ACselect));
disp('Alignment length=');disp(length(CCselect));
popupmenu_ACduration=get(handles.popupmenu_ACduration,'String');
duration=str2double(popupmenu_ACduration(get(handles.popupmenu_ACduration,'Value')));
Direction=get(handles.radiobutton_direction,'Value');%Directionは両方向か片方向か
% if Direction==1;duration=duration/2;end

%TurnMarkerTimeでアラインするときの処理
if duration==-1 || CrossCorrValue==1;duration=OneTurnTime;Direction=1;end 

% if duration<=1000;bin=100;else bin=300;end%binはhistグラフの細かさ（分割数）

bin=floor(duration/10);

contents_MovWindow = cellstr(get(handles.popupmenu_MovWindow,'String'));
MovW=str2num(contents_MovWindow{get(handles.popupmenu_MovWindow,'Value')});

GaussSmooth=get(handles.radiobutton_Gauss,'Value');

ttestValue=get(handles.radiobutton_ttest,'Value');
% if CrossCorrValue3~=1 | CrossCorrValue2~=1;ttestValue=0;end %CrossCorr2,3の線も入れる場合にttestの点を入れたくない場合。

if ttestValue==1; %t-testを行う
    [ShiftedArray]=ShiftArray(ACselect,TurnMarkerTime);

    HistoMatrix=[];HistoMatrixShifted=[];
    for n=1:length(TurnMarkerTime)-4
    
        tempArrayOriginal=ACselect(ACselect>TurnMarkerTime(n)&ACselect<TurnMarkerTime(n+4));
        tempArrayShifted=ShiftedArray(ShiftedArray>TurnMarkerTime(n)&ShiftedArray<TurnMarkerTime(n+4));

        [CrossCoOriginal]=CrossCorr(tempArrayOriginal,CCselect,floor(duration),Direction,TurnMarkerTime);
        [CrossCoShifted]=CrossCorr(tempArrayShifted,CCselect,floor(duration),Direction,TurnMarkerTime);%(CCselect>=TurnMarkerTime(n+1)&CCselect<TurnMarkerTime(n+2))
        
        HistoOriginal=hist(CrossCoOriginal,bin);
        HistoShifted=hist(CrossCoShifted,bin);
        
        if MovW==0
            HistoOriginal=HistoOriginal';
            HistoShifted=HistoShifted';
            
        elseif MovW~=0
            HistoOriginal=MovWindow(HistoOriginal,MovW);
            HistoShifted=MovWindow(HistoShifted,MovW);
            HistoOriginal=HistoOriginal';
            HistoShifted=HistoShifted';        
        end

        if GaussSmooth==1 && MovW==0
            HistoOriginal=instantArray(HistoOriginal,2);
            HistoShifted=instantArray(HistoShifted,2);
        end
            
        HistoMatrix=[HistoMatrix; HistoOriginal'];
        HistoMatrixShifted=[HistoMatrixShifted; HistoShifted'];
    end
    size(HistoMatrix)
    size(HistoMatrixShifted)
    

    [Xnull,Pvalue]=ttest(HistoMatrix,HistoMatrixShifted,0.001,'both');%ttest----------------
%     piyo=[Xnull',Pvalue']
    Xnull(isnan(Xnull))=0;%要注意％％％％％％％％％％％％％％％
    Xnull_x=1:bin;Xnull_x=floor(Xnull_x*duration/bin);Xnull_x(Xnull==0)=[];
    Xnull(Xnull==0)=[];
    
% HistoMatrix
% HistoMatrixShifted
    
    CCresultOriginal=sum(HistoMatrix)/length(CCselect)*0.25;
    CCresultShifted=sum(HistoMatrixShifted)/length(CCselect)*0.25;
    
%     length(CCresultOriginal);
    
end

% GaussSmooth=get(handles.radiobutton_Gauss,'Value');

[CrossCo]=CrossCorr(ACselect,CCselect,floor(duration),Direction,TurnMarkerTime);
CCresult=hist(CrossCo,bin)/length(CCselect);
% if GaussSmooth==1;CCresult=instantArray(CCresult,2);end
if MovW~=0;CCresult=MovWindow(CCresult,MovW);%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
elseif GaussSmooth==1;CCresult=instantArray(CCresult,2);
end
    
if ~isempty(CCselect2)
    [CrossCo2]=CrossCorr(CCselect2,CCselect,floor(duration),Direction,TurnMarkerTime);
    CCresult2=hist(CrossCo2,bin)/length(CCselect);
%     if GaussSmooth==1;CCresult2=instantArray(CCresult2,2);end
    if MovW~=0;CCresult2=MovWindow(CCresult2,MovW);%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    elseif GaussSmooth==1;CCresult2=instantArray(CCresult2,2);
    end
end
if ~isempty(CCselect3)
    [CrossCo3]=CrossCorr(CCselect3,CCselect,floor(duration),Direction,TurnMarkerTime);
    CCresult3=hist(CrossCo3,bin)/length(CCselect);
    if MovW~=0;CCresult3=MovWindow(CCresult3,MovW);%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    elseif GaussSmooth==1;CCresult3=instantArray(CCresult3,2);
    end
end

FigOpen=get(handles.radiobutton_FigureOpen,'Value');
if FigOpen==1;
    CCFig=figure('Position',[1 1 1400 975]); hold on
%     plot(linspace(1,duration,bin),CCresult);title(Title);
%     axis([0 duration 0 (max(CCresult)*1.05)]);%hold off


% CCFig=figure('Position',[1 1 1400 975]);
% CCFig=handles.axes1;

   plot(linspace(1,duration,bin),CCresult,'color','b');
   if ~isempty(CCselect2);plot(linspace(1,duration,bin),CCresult2,'color','g');else CCresult2=0;end
   if ~isempty(CCselect3);plot(linspace(1,duration,bin),CCresult3,'color','r');else CCresult3=0;end

   Max=max([max(CCresult),max(CCresult2),max(CCresult3)]);
  if CrossCorrValue==1;%TurnMarkerでアラインする場合にはペグパターンを書き込む
       XR=floor(duration*MedPegTimeR(1:end)/OneTurnTime);
       YR=ones(1,length(MedPegTimeR))'*Max*0.85;
       XL=floor(duration*MedPegTimeL(1:end)/OneTurnTime);
       YL=ones(1,length(MedPegTimeL))'*Max*0.95;

       text(XR,YR,'l','FontSize',18,'color',[0 1 0]);
       text(XL,YL,'l','FontSize',18,'color',[1 0 0]);
    
    for n=1:length(MedPegTimeR)
        text(XR(n),YR(n)*1.06,int2str(n),'FontSize',12,'color',[0 1 0]);
    end
    for n=1:length(MedPegTimeL)
        text(XL(n),YL(n)*1.06,int2str(n),'FontSize',12,'color',[1 0 0]);
    end
    
    if ~isempty(RpegTouchBypegCell)==1
    for  n=1:12
        if length(RpegTouchBypegCell{n})>5
            RfromPeg(n)=mean(RpegTouchBypegCell{n});
        else
            RfromPeg(n)=NaN;
        end
        if length(LpegTouchBypegCell{n})>5
            LfromPeg(n)=mean(LpegTouchBypegCell{n});
        else
            LfromPeg(n)=NaN;
        end
    end
    RtouchPlace=MedPegTimeR(1:end)+RfromPeg;
    LtouchPlace=MedPegTimeL(1:end)+LfromPeg;
    RtouchPlace(RtouchPlace<0)=RtouchPlace(RtouchPlace<0)+OneTurnTime;RtouchPlace(RtouchPlace>OneTurnTime)=RtouchPlace(RtouchPlace>OneTurnTime)-OneTurnTime;
    LtouchPlace(LtouchPlace<0)=LtouchPlace(LtouchPlace<0)+OneTurnTime;LtouchPlace(LtouchPlace>OneTurnTime)=LtouchPlace(LtouchPlace>OneTurnTime)-OneTurnTime;
    
    XRplace=floor(duration*RtouchPlace(1:12)/OneTurnTime);
    XLplace=floor(duration*LtouchPlace(1:12)/OneTurnTime);
    
    YRplace=ones(1,12)'*Max*0.6;
    YLplace=ones(1,12)'*Max*0.7;
%     RmedianPTTM LmedianPTTM
    text(RmedianPTTM*10,YRplace,'l','FontSize',18,'color',[0 1 1]);
    text(LmedianPTTM*10,YLplace,'l','FontSize',18,'color',[1 0 1]);
    for n=1:12
        text(XRplace(n),YRplace(n)*1.08,int2str(n),'FontSize',12,'color',[0 1 1]);
        text(XLplace(n),YLplace(n)*1.08,int2str(n),'FontSize',12,'color',[1 0 1]);
    end
    end
    
   end
    if Alt==1;Maxhold=Max;end
    if Alt==2;axis([0 duration 0 Maxhold*1.2]);title(Title,'FontSize',18);
    else
        axis([0 duration 0 Max*1.2]);title(Title,'FontSize',18);
    end
    
   if ttestValue==1
%         plot(linspace(1,duration,bin),CCresultShifted,'color','r');
       text(Xnull_x,Xnull*max(CCresult)*1.05,'*');
   end

else
    axes(handles.axes1);
    cla;
    plot(linspace(1,duration,bin),CCresult,'color','b');hold on
   if ~isempty(CCselect2);plot(linspace(1,duration,bin),CCresult2,'color','g');else CCresult2=0;end
   if ~isempty(CCselect3);plot(linspace(1,duration,bin),CCresult3,'color','r');else CCresult3=0;end

   Max=max([max(CCresult),max(CCresult2),max(CCresult3)]);
  if CrossCorrValue==1;%TurnMarkerでアラインする場合にはペグパターンを書き込む
       XR=floor(duration*MedPegTimeR(1:end)/OneTurnTime);
       YR=ones(1,length(MedPegTimeR))'*Max*0.85;
       XL=floor(duration*MedPegTimeL(1:end)/OneTurnTime);
       YL=ones(1,length(MedPegTimeL))'*Max*0.95;

       text(XR,YR,'l','FontSize',18,'color',[0 1 0]);
       text(XL,YL,'l','FontSize',18,'color',[1 0 0]);
    
    for n=1:length(MedPegTimeR)
        text(XR(n),YR(n)*1.06,int2str(n),'FontSize',12,'color',[0 1 0]);
    end
    for n=1:length(MedPegTimeL)
        text(XL(n),YL(n)*1.06,int2str(n),'FontSize',12,'color',[1 0 0]);
    end
    
    if ~isempty(RpegTouchBypegCell)==1
    for  n=1:12
        if length(RpegTouchBypegCell{n})>5
            RfromPeg(n)=mean(RpegTouchBypegCell{n});
        else
            RfromPeg(n)=NaN;
        end
        if length(LpegTouchBypegCell{n})>5
            LfromPeg(n)=mean(LpegTouchBypegCell{n});
        else
            LfromPeg(n)=NaN;
        end
    end
    RtouchPlace=MedPegTimeR(1:end)+RfromPeg;
    LtouchPlace=MedPegTimeL(1:end)+LfromPeg;
    RtouchPlace(RtouchPlace<0)=RtouchPlace(RtouchPlace<0)+OneTurnTime;RtouchPlace(RtouchPlace>OneTurnTime)=RtouchPlace(RtouchPlace>OneTurnTime)-OneTurnTime;
    LtouchPlace(LtouchPlace<0)=LtouchPlace(LtouchPlace<0)+OneTurnTime;LtouchPlace(LtouchPlace>OneTurnTime)=LtouchPlace(LtouchPlace>OneTurnTime)-OneTurnTime;
    
    XRplace=floor(duration*RtouchPlace(1:12)/OneTurnTime);
    XLplace=floor(duration*LtouchPlace(1:12)/OneTurnTime);
    
    YRplace=ones(1,12)'*Max*0.6;
    YLplace=ones(1,12)'*Max*0.7;
%     RmedianPTTM LmedianPTTM
    text(RmedianPTTM*10,YRplace,'l','FontSize',18,'color',[0 1 1]);
    text(LmedianPTTM*10,YLplace,'l','FontSize',18,'color',[1 0 1]);
    for n=1:12
        text(XRplace(n),YRplace(n)*1.08,int2str(n),'FontSize',12,'color',[0 1 1]);
        text(XLplace(n),YLplace(n)*1.08,int2str(n),'FontSize',12,'color',[1 0 1]);
    end
    end
    
   end
    
   if Alt==1;Maxhold=Max;end
    if Alt==2;axis([0 duration 0 Maxhold*1.2]);title(Title,'FontSize',18);
    else
        axis([0 duration 0 Max*1.2]);title(Title,'FontSize',18);
    end

   if ttestValue==1
%            plot(linspace(1,duration,bin),CCresultShifted,'color','r');
       text(Xnull_x,Xnull*max(CCresult)*1.05,'*');
   end
    
end

ShowFig=get(handles.radiobutton_ShowFigure,'Value');

FigureSave=get(handles.radiobutton_SaveFigure,'Value');
FigName=char(strcat({DrName},{' '},{T},{R},{P},{' '},{S},{'.bmp'}));
% if FigureSave==1;saveas(CCFig,FigName);end

set(handles.text_point4,'String','0');


%CCselectがCrossCorrの中でArray2になり、このタイミングでアラインされる
%1:Spike,2:Right Peg,3:Left Peg,4:R&L peg,5:Right Touch,6:Left Touch,7:R&LTouch


function popupmenu_CrossCorr_Callback(hObject, eventdata, handles)


function popupmenu_CrossCorr_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function pushbutton_CovAnalysis_Callback(hObject, eventdata, handles)

global TurnMarkerTime OneTurnTime RpegTouchCell LpegTouchCell RLpegTouchCell RpegMedian LpegMedian RLpegName RLpegMedian%RpegTouchTurn LpegTouchTurn RLpegTouchTurn
%disp(SliderTouch);
%pegTouchCell=RLpegTouchCell;
Cov_analysis(RLpegTouchCell,RpegMedian,LpegMedian,TurnMarkerTime,RLpegName,RLpegMedian);



function popupmenu_FirstTouch_Callback(hObject, eventdata, handles)


function popupmenu_FirstTouch_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function listbox_name_Callback(hObject, eventdata, handles)


function listbox_name_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function radiobutton_direction_Callback(hObject, eventdata, handles)


function pushbutton_save_Callback(hObject, eventdata, handles)

global data PegOffset dpath fname PegTouchTurn SliderTouch PegTouchCell...
    RpegTouchCell LpegTouchCell RLpegTouchCell CrossVar CrossVarInv OneTurnTime DrName RpegTouchTurn LpegTouchTurn  RPegTouchAll LPegTouchAll RLPegTouchAll FTselect RefPeriod ... %FTselect=first touch or All touches
    TurnMarkerTime RpegTimeArray LpegTimeArray PtouchHistoCell_R PtouchHistoCell_L CrossVarInv_2 CrossVarInv_3 CrossVarInv_4 WaterOnArray WaterOffArray WaterOnArrayOriginal WaterOffArrayOriginal...
    RpegTimeArray2D LpegTimeArray2D RpegTimeArray2D_turn LpegTimeArray2D_turn RLpegName RLpegMedian RpegMedian LpegMedian MedPegTimeR MedPegTimeL StartTime FinishTime ...
    CovInterval_3 CoefInterval_3 SpikeArrayCell CovInterval_5 CoefInterval_5 VarMeans VarSTD Spike ...
    Prod_Int_dev_abs_Mean_3 Prod_Int_dev_abs_Var_3 Prod_Int_dev_abs_Mean_5 Prod_Int_dev_abs_Var_5 PegVar VarNextPeg...
    WaterOn_percent DrinkOnArray DrinkOffArray FloorTouchArray FloorDetachArray DrinkOn_percent FloorTouch_percent Num_SmallVar ChunkLength ChunkEnd...
    SpikeArray1 SpikeArray2 SpikeArray3 SpikeArray4 SpikeArray5 SE lengthEvent Repeat RLRphase LRLphase RLRbefore LRLbefore IntervalR IntervalL...
    RatioAlikeLRL RatioAlikeRLR RatioBlikeLRL RatioBlikeRLR StdLRLphase StdRLRphase StdLRLdiff StdRLRdiff StdIntervalRL StdRLTouchInterval WaterN MeanWaterTime...
    RpegTouchBypegCell LpegTouchBypegCell RmedianPTTM LmedianPTTM LTouchAll RTouchAll LRLpegphase RLRpegphase LRLpegTimeArray RLRpegTimeArray ...
    TurnMarkerTime_L TurnMarkerTime_R MedPegTimeL_L MedPegTimeL_R MedPegTimeR_L MedPegTimeR_R TurnMarkerTimeB TurnMarkerTimeA patternValue ...
    LTouchfromPeg StdLTouchTiming RTouchfromPeg StdRTouchTiming MeanStdTouch VarianceList...
    NumDrinkTurn NumDrinkTurnCum OnWaterLen OnWaterLenCum NumFloorTouchTurn NumFloorTouchTurnCum fig_TouchR fig_TouchL RtouchHist LtouchHist RLtouchHist
%RpegMedian,LpegMedianはTouch時間のMedian
%MedPegTimeR MedPegTimeLはPeg到達時間のMedian

Sname=[DrName '.mat']
feval('save',Sname);%すべてのデータをmat形式で保存
% close all;
disp('saved');


function pushbutton_Auto_Callback(hObject, eventdata, handles)

global RefPeriod OneTurnTime PegTouchCell fname DrName FTselect PegTouchTurn SliderTouch...
    fig_WaterMark fig_DrinkMark fig_FloorMark fig_WaterOn fig_DrinkOn fig_Floor ...
    fig_touchR fig_touchL fig_touchR_TM fig_touchL_TM fig_TMpegs...
    fig_VM fig_VarInvRe_CLmap48 ...
    Cov3scatter Cov5scatter fig_CovInt3 fig_CovInt5 fig_CovInt3_ConstAx fig_CovInt5_ConstAx FigureSave...
    fig_CrossVarInv_CLmap fig_OnWater ...
    fig_NumDrink fig_NumFloorTouch fig_CrossVarRL fig_TouchR fig_TouchL fig_TouchRL fig_VM2...
    fig_CrossVar_CLmap2 fig_WaterOnLen fig_DrinkOnCount fig_FloorTouchCount fig_TouchR fig_TouchL fig_CrossVar_CLmap fig_CrossVar

ShowFig=get(handles.radiobutton_ShowFigure,'Value');
FigureSave=get(handles.radiobutton_SaveFigure,'Value');

pushbutton_FileSelect_Callback(hObject, eventdata, handles);

Dataload_pushbutton_Callback(hObject, eventdata, handles);

%Peg－patternの選択
% patternValue=get(handles.popupmenu_pattern,'Value');
% if patternValue == 1;% 一般的なパターン用
%     SliderTouch=[0.8600 0.9400 0.0200 0.1100 0.1900 0.2800 0.8600 0.9400 0.0200 0.1100 0.1900 0.2800];
% elseif patternValue == 2;%20090312のパターン用
%     SliderTouch=[0.6400 0.8500 0.9500 0.9800 0 0.1000 0.8500 0.8700 0.9300 0.9800 0 0.0500];
% else SliderTouch=[0.8600 0.9400 0.0200 0.1100 0.1900 0.2800 0.8600 0.9400 0.0200 0.1100 0.1900 0.2800];
% end


pushbutton_TouchAnalysis_Callback(hObject, eventdata, handles);

% SliderTouch=[0.8600 0.9400 0.0200 0.1100 0.1900 0.2800 0.8600 0.9400 0.0200 0.1100 0.1900 0.2800];%[0.0300 0.1100 0.1900 0.2700 0.3500 0.4300 0.0300 0.1100 0.1900 0.2700 0.3500 0.4300];
% % [OBJECT,FIGURE] = gcbo;
% % pushbutton_Divide_Callback(OBJECT, eventdata, handles)

pushbutton_ANALYSIS_Callback(hObject, eventdata, handles);

pushbutton_CrossPegAnalysis_Callback(hObject, eventdata, handles);
% pushbutton_CovAnalysis_Callback(hObject, eventdata, handles);

pushbutton_save_Callback(hObject, eventdata, handles);
% close(fig_WaterMark,fig_DrinkMark,fig_FloorMark,fig_WaterOn,fig_DrinkOn,fig_Floor,...
%     fig_touchR,fig_touchL,fig_touchR_TM,fig_touchL_TM,fig_TMpegs,...
%     fig_VM,fig_CrossVarInv_CLmap,fig_VarInvRe_CLmap48,...
%     Cov3scatter,Cov5scatter,fig_CovInt3,fig_CovInt5,fig_CovInt3_ConstAx,fig_CovInt5_ConstAx);
close(fig_WaterMark,fig_DrinkMark,fig_FloorMark,fig_WaterOn,fig_DrinkOn,fig_Floor,...
                    fig_touchR,fig_touchL,fig_touchR_TM,fig_touchL_TM,fig_TMpegs,...
                    fig_VM,fig_CrossVarInv_CLmap,fig_VarInvRe_CLmap48,fig_OnWater,fig_DrinkMark,...
                    fig_NumDrink,fig_FloorMark,fig_NumFloorTouch,fig_CrossVarRL,fig_TouchR,fig_TouchL,fig_TouchRL,fig_VM2,...
                    fig_CrossVar_CLmap2,fig_WaterOnLen,fig_DrinkOnCount,fig_FloorTouchCount,fig_CrossVar_CLmap,fig_CrossVar);%,...

% close all;
% pushbutton_ClearAll_Callback(hObject, eventdata, handles);
WheelAnalyzer24ch;


function pushbutton_AutoALL_Callback(hObject, eventdata, handles)

global dpath dpath2 fname RefPeriod OneTurnTime PegTouchCell fname DrName FTselect PegTouchTurn SliderTouch...
    fig_WaterMark fig_DrinkMark fig_FloorMark fig_WaterOn fig_DrinkOn fig_Floor ...
    fig_touchR fig_touchL fig_touchR_TM fig_touchL_TM fig_TMpegs...
    fig_VM fig_CrossVarInv_CLmap fig_VarInvRe_CLmap48 fig_CrossVar_CLmap ...
    Cov3scatter Cov5scatter fig_CovInt3 fig_CovInt5 fig_CovInt3_ConstAx fig_CovInt5_ConstAx FigureSave...
    fig_LRLphase fig_RLRphase fig_Phasehist fig_IntervalRL fig_Interval2 fig_interval patternValue ...
    fig_LRLphaseMP fig_RLRphaseMP RTouchAll LTouchAll fig_RLRpegphaseMP fig_LRLpegphaseMP...
    fig_CrossVarInv_CLmap fig_OnWater ...
    fig_NumDrink fig_NumFloorTouch fig_CrossVarRL fig_TouchR fig_TouchL fig_TouchRL fig_VM2...
    fig_CrossVar_CLmap2 fig_WaterOnLen fig_DrinkOnCount fig_FloorTouchCount fig_CrossVar...
    fig_OnWater fig_DrinkMark fig_NumDrink fig_FloorMark fig_NumFloorTouch fig_CrossVarRL fig_VM2 fig_CrossVar_CLmap

ShowFig=get(handles.radiobutton_ShowFigure,'Value');
FigureSave=get(handles.radiobutton_SaveFigure,'Value');

% dpath=uigetdir('C:\Documents and Settings\永田雅俊\デスクトップ\WR LVdata\08 1202-')
% dpath=uigetdir('C:\Users\kit\Desktop\WR LVdata')
dpath=uigetdir('C:\Users\B133\Desktop\WR LVdata')

% cd (char('C:\Documents and Settings\永田雅俊\デスクトップ\WR LVdata\DataAnalysed'));
% dname=dpath(length(dpath)-5:length(dpath));
% mkdir(dname);
% dpath2=char(strcat({'C:\Documents and Settings\永田雅俊\デスクトップ\WR LVdata\DataAnalysed\'},{dname}));

% cd (char('C:\Documents and Settings\永田雅俊\デスクトップ\WR LVdata\DataAnalysed'));
% cd (char('C:\Users\kit\Desktop\WR LVdata\DataAnalysed'));
cd (char('C:\Users\B133\Desktop\WR_LVdata\DataAnalysed'));
dname=dpath(length(dpath)-5:length(dpath));

if ~isdir(dname)
    mkdir(dname);
end
% dpath2=char(strcat({'C:\Users\kit\Desktop\WR LVdata\DataAnalysed\'},{dname}));
dpath2=char(strcat({'\Users\kit\Desktop\WR LVdata\DataAnalysed\'},{dname}));


cd(dpath);
h=ls;
% disp(h);

patternValue=get(handles.popupmenu_pattern,'Value');
if patternValue==2
    input('If PegPattern=2 & data is recorded with old wheel, confirm the LpegTimeArray2D is modified at PegTouchAnalysis.m around 222!');
end

for n=1:length(h(:,1))
%     disp(h(n,:));
%     len=length(h(n,:));
    
%     fname=h(n,:);
    fname=strtrim(h(n,:));
    len=length(fname);
    if len>3
%      if strcmp(fname(len-3:len),'.xls') | strcmp(fname(len-3:len),'xls ') | strcmp(fname(len-3:len),'ls  ')
%     if fname(len-3:len)=='.xls' | fname(len-3:len)=='xls ' | fname(len-3:len)=='ls'%h(n,end)=='s' | h(n,end)==' '%~=WDir(1,:) & h(n,:)~='C:\Documents and Settings\永田雅俊\デスクトップ\WR LVdata'
        dpath=cd;dpath=[dpath '\'];disp(dpath);
        disp(fname);
%         cd(char(dpath2));(char('C:\Users\kit\Desktop\WR LVdata\DataAnalysed'));
        cd(char(dpath2));(char('C:\Users\B133\Desktop\WR_LVdata\DataAnalysed'));
        DrName=[fname(1:length(fname)-4)];%char(fname(1:length(fname)-4),{' '})%char(strcat({fname(1:length(fname)-4)},{' '},{RefPeriodStr},{' '},{AllorFirst}));
        mkdir(DrName);
        
%         FLName=char(strcat({'C:\Users\kit\Desktop\WR LVdata\DataAnalysed'},{'\'},{dname},{'\'},{DrName}))
        FLName=char(strcat({'C:\Users\B133\Desktop\WR_LVdata\DataAnalysed'},{'\'},{dname},{'\'},{DrName}))
        
        cd (char(FLName));
        
%         pushbutton_Auto_Callback(hObject, eventdata, handles)
        

%                 ShowFig=get(handles.radiobutton_ShowFigure,'Value');
%                 FigureSave=get(handles.radiobutton_SaveFigure,'Value');

%                 pushbutton_FileSelect_Callback(hObject, eventdata, handles);

                Dataload_pushbutton_Callback(hObject, eventdata, handles);

                %Peg－patternの選択
                % patternValue=get(handles.popupmenu_pattern,'Value');
                % if patternValue == 1;% 一般的なパターン用
                %     SliderTouch=[0.8600 0.9400 0.0200 0.1100 0.1900 0.2800 0.8600 0.9400 0.0200 0.1100 0.1900 0.2800];
                % elseif patternValue == 2;%20090312のパターン用
                %     SliderTouch=[0.6400 0.8500 0.9500 0.9800 0 0.1000 0.8500 0.8700 0.9300 0.9800 0 0.0500];
                % else SliderTouch=[0.8600 0.9400 0.0200 0.1100 0.1900 0.2800 0.8600 0.9400 0.0200 0.1100 0.1900 0.2800];
                % end

% SliderTouch=[0.8300 0.9200 0.0100 0.0900 0.1800 0.2600 0.3400 0.4200 0.5100 0.5900 0.6800 0.7600 0.83 0.92 0.01 0.09 0.18 0.26 0.34 0.42 0.51 0.59 0.67 0.76];%[0.0300 0.1100 0.1900 0.2700 0.3500 0.4300 0.0300 0.1100 0.1900 0.2700 0.3500 0.4300];
SliderTouch=[0.9300 0.0200 0.1100 0.1900 0.2800 0.3600 0.44500 0.5200 0.6100 0.6900 0.77500 0.8600...
        0.9300 0.0200 0.1100 0.1900 0.2800 0.3600 0.44500 0.5200 0.6100 0.6900 0.77500 0.8600];    

                pushbutton_TouchAnalysis_Callback(hObject, eventdata, handles);
                

                % SliderTouch=[0.8600 0.9400 0.0200 0.1100 0.1900 0.2800 0.8600 0.9400 0.0200 0.1100 0.1900 0.2800];%[0.0300 0.1100 0.1900 0.2700 0.3500 0.4300 0.0300 0.1100 0.1900 0.2700 0.3500 0.4300];
                % % [OBJECT,FIGURE] = gcbo;
                % % pushbutton_Divide_Callback(OBJECT, eventdata, handles)

                pushbutton_ANALYSIS_Callback(hObject, eventdata, handles);

                pushbutton_CrossPegAnalysis_Callback(hObject, eventdata, handles);
                % pushbutton_CovAnalysis_Callback(hObject, eventdata, handles);

                pushbutton_save_Callback(hObject, eventdata, handles);
                
                close(fig_WaterMark,fig_DrinkMark,fig_FloorMark,fig_WaterOn,fig_DrinkOn,fig_Floor,...
                    fig_touchR,fig_touchL,fig_touchR_TM,fig_touchL_TM,fig_TMpegs,...
                    fig_VM,fig_CrossVarInv_CLmap,fig_VarInvRe_CLmap48,fig_OnWater,fig_DrinkMark,...
                    fig_NumDrink,fig_FloorMark,fig_NumFloorTouch,fig_CrossVarRL,fig_TouchR,fig_TouchL,fig_TouchRL,fig_VM2,...
                    fig_CrossVar_CLmap2,fig_WaterOnLen,fig_DrinkOnCount,fig_FloorTouchCount,fig_CrossVar_CLmap,fig_CrossVar);%,...
                
%                 close(fig_WaterMark,fig_DrinkMark,fig_FloorMark,fig_WaterOn,fig_DrinkOn,fig_Floor,...
%                     fig_touchR,fig_touchL,fig_touchR_TM,fig_touchL_TM,fig_TMpegs,...
%                     fig_VM,fig_CrossVarInv_CLmap,fig_VarInvRe_CLmap48,fig_OnWater,fig_DrinkMark,...
%                     fig_NumDrink,fig_FloorMark,fig_NumFloorTouch,fig_CrossVarRL,fig_TouchRL,fig_VM2,...
%                     fig_CrossVar_CLmap2);%,...
                %     Cov3scatter,Cov5scatter,fig_CovInt3,fig_CovInt5,fig_CovInt3_ConstAx,fig_CovInt5_ConstAx);

%                 close all;
                % pushbutton_ClearAll_Callback(hObject, eventdata, handles);
%                 WheelAnalyzer24ch;

        
%         patternValue=get(handles.popupmenu_pattern,'Value');
%         Dataload_pushbutton_Callback(hObject, eventdata, handles);
        
        %Peg－patternの選択
        % patternValueの8,9,10の値はDataLoad,PegTouchAnalysisに渡しているので注意
        % Multiphase,StepwiseではTouchの解析法が異なるので注意（RTouchAll,LTouchAllを使用)
        % 
%    if patternValue == 1;% 一般的なパターン用(新ホイール)
%        SliderTouch=[0.9300 0.0200 0.1100 0.1900 0.2800 0.3600 0.9600 0.0500 0.1400 0.2200 0.3100 0.3900];
%    elseif patternValue == 2;% 一般的なパターン用(旧ホイール)
%        SliderTouch=[0.8900 0.9600 0.0400 0.1300 0.1900 0.2800 0.8600 0.9600 0.0500 0.120 0.2100 0.2800];
% %    elseif patternValue == 2;%20090312のパターン用
% %        SliderTouch=[0.8400 0.8900 0.9500 0.0800 0.1100 0.1700 0.7700 0.8000 0.9300 0.9700 0.09100 0.1100];
%    elseif patternValue == 3;%20090220のパターン用 (pattern4,new wheel)
%        SliderTouch=[0.9600 0.0300 0.1150 0.1650 0.2500 0.3600 0.9000 0.9800 0.0800 0.1900 0.2800 0.3300];
%    elseif patternValue == 4;%20090220のパターン用 (pattern4,old wheel)
%        SliderTouch=[0.8600 0.9400 0.0200 0.06500 0.1500 0.2800 0.9300 0.0000 0.0000 0.1100 0.1900 0.2500];        
% %    elseif patternValue == 4;%20090414のパターン用 (pattern6)
% %        SliderTouch=[0.8600 0.9400 0.0200 0.1100 0.1700 0.2800 0.8600 0.9400 0.0000 0.1100 0.1900 0.2300];
%    elseif patternValue == 5;%20090710-Bのパターン用
%        SliderTouch=[0.8000 0.7600 0.96 0.0600 0.15 0.225 0.8200 0.9400 0.00 0.1200 0.1700 0.2400];
%    elseif patternValue == 6;%20090710-Aのパターン用
%        SliderTouch=[0.000 0.0700 0.1400 0.1900 0.2800 0.3600 0.9600 0.0500 0.1400 0.2200 0.3100 0.3900];   
% %    elseif patternValue == 7;%20090904のパターン用
% %        SliderTouch=[0.9100 0.9800 0.0200 0.1400 0.2300 0.2800 0.8100 0.8200 0.8830 0.990 0.0800 0.1900];
%    elseif patternValue == 7;%5秒/turnの一般的なパターン用
%        SliderTouch=[0.8500 0.9300 0.0160 0.0880 0.1520 0.2300 0.8400 0.9000 0.0160 0.0820 0.1520 0.2600];  
%    elseif patternValue == 8;%RegularA-1(Right)のパターン用
%        SliderTouch=[0.9300 0.0200 0.1100 0.1900 0.2800 0.3600 0.9600 0.0500 0.1400 0.2200 0.3100 0.3900];  
%    elseif patternValue == 9;%AA-1(Right6Left6)のパターン用
%        SliderTouch=[0.9300 0.0200 0.1100 0.1900 0.2800 0.3600 0.9600 0.0500 0.1400 0.2200 0.3100 0.3900];  
% %    elseif patternValue == 10;% ABパターン(9peg)用
% %        SliderTouch=[0.000 0.1200 0.2200 0.3200 0.4200 0.5500 0.0100 0.1200 0.2200 0.3200 0.5000 0.6000]; 
%        
%        
%        
%    elseif patternValue == 10 || patternValue == 11 || patternValue == 12;% AB Multiphase, Stepwise
%        RefPeriodCell=get(handles.popupmenu_RefPeriod,'String');
%        RefPeriod=str2double(RefPeriodCell(get(handles.popupmenu_RefPeriod,'Value')));
%        RefPeriodStr=int2str(RefPeriod);
%        [PegTouchCell,PegTouchTurn]=PegTouch;
%        [RTouchAll,LTouchAll]=TouchExtract(PegTouchCell);
%        [LRLphase,RLRphase]=PhaseAnalyzer(LTouchAll,RTouchAll);
% %        pushbutton_save_Callback(hObject, eventdata, handles);
% %        close(fig_WaterMark,fig_DrinkMark,fig_FloorMark,fig_WaterOn,fig_DrinkOn,fig_Floor,fig_LRLphaseMP,fig_RLRphaseMP,fig_Phasehist,...
% %            fig_RLRpegphaseMP,fig_LRLpegphaseMP);
% %        cd(dpath);
% %        pushbutton_ClearAll_Callback(hObject, eventdata, handles); 
% %        break
% %    elseif patternValue == 12;% Stepwise
% %        SliderTouch=[0.9300 0.0200 0.1100 0.1900 0.2800 0.3600 0.9600 0.0500 0.1400 0.2200 0.3100 0.3900]; 
% %        pushbutton_TouchAnalysis_Callback(hObject, eventdata, handles);   
% %        pushbutton_ANALYSIS_Callback(hObject, eventdata, handles);
% %        break
%    else SliderTouch=[0.8600 0.9400 0.0200 0.1100 0.1900 0.2800 0.8600 0.9400 0.0200 0.1100 0.1900 0.2800];
%    end
%     
%    if patternValue< 10
%        CrossPegCov=get(handles.radiobutton_CrossPegCov,'Value');
%         pushbutton_TouchAnalysis_Callback(hObject, eventdata, handles);   
%         pushbutton_ANALYSIS_Callback(hObject, eventdata, handles);
%         pushbutton_TouchVariance_Callback(hObject, eventdata, handles);
%         if CrossPegCov==1
%         pushbutton_CrossPegAnalysis_Callback(hObject, eventdata, handles);
% %         pushbutton_CovAnalysis_Callback(hObject, eventdata, handles);
%         end
% %         pushbutton_PhaseRaster_Callback(hObject, eventdata, handles);
% %         pushbutton_IntervalHist_Callback(hObject, eventdata, handles);
%    end
%         pushbutton_save_Callback(hObject, eventdata, handles);
%         close(fig_WaterMark,fig_DrinkMark,fig_FloorMark,fig_WaterOn,fig_DrinkOn,fig_Floor,...
%             fig_touchR,fig_touchL,fig_touchR_TM,fig_touchL_TM,fig_TMpegs,fig_VM);
% %             close(fig_CrossVar_CLmap,fig_CrossVarInv_CLmap,fig_VarInvRe_CLmap48,...
% %             Cov3scatter,Cov5scatter,fig_CovInt3,fig_CovInt5,fig_CovInt3_ConstAx,fig_CovInt5_ConstAx,...
% %             fig_LRLphase,fig_RLRphase,fig_Phasehist,fig_IntervalRL,fig_Interval2,fig_interval,...
% %             fig_RLRpegphaseMP,fig_LRLpegphaseMP,fig_LRLphaseMP,fig_RLRphaseMP);
%         
        cd(dpath);
        
        %clearvars -except dpath h len n hObject
%         pushbutton_ClearAll_Callback(hObject, eventdata, handles); 
        
    end
    
%     end
end

% cd (char(dpath2));
% % clear all;
% dpath2=cd;
% 
% [Result Result_name Return_Array Return_Array2_varM Return_Array2_PegVar Return_Array2_prod Return_Name]=dir_search(dpath2);
% 
% % Return_Array
% dname=dpath2(length(dpath2)-5:length(dpath2));
% Fname=[dname '.mat']
% feval('save',Fname);%クロスファイルデータをmat形式で保存


function radiobutton_Gauss_Callback(hObject, eventdata, handles)


function popupmenu_raster1_Callback(hObject, eventdata, handles)
function popupmenu_raster1_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function popupmenu_raster2_Callback(hObject, eventdata, handles)
function popupmenu_raster2_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function popupmenu_raster3_Callback(hObject, eventdata, handles)
function popupmenu_raster3_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function popupmenu_raster4_Callback(hObject, eventdata, handles)
function popupmenu_raster4_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function popupmenu_raster5_Callback(hObject, eventdata, handles)
function popupmenu_raster5_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function popupmenu_raster6_Callback(hObject, eventdata, handles)
function popupmenu_raster6_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function pushbutton_raster_Callback(hObject, eventdata, handles)

global TurnMarkerTime RpegTimeArray LpegTimeArray WaterOnArrayOriginal WaterOffArrayOriginal...
    SpikeArray1 SpikeArray2 SpikeArray3 SpikeArray4 SpikeArray5...
    RPegTouchAll LPegTouchAll FloorTouchArray FloorDetachArray DrinkOnArray DrinkOffArray OneTurnTime...
    rasterset1 rasterset2 rasterset3 rasterset4 rasterset10 TurnMarkerTime_R TurnMarkerTime_L

% RPegTouchAll=RPegTouchAll';LPegTouchAll=LPegTouchAll';

raster1Value=get(handles.popupmenu_raster1,'Value');
if ~isempty(rasterset1)==1
    raster1Value=rasterset1;
end
if raster1Value==1;R1select=RpegTimeArray;S1='Right peg';
elseif raster1Value==2;R1select=0;S1=' ';  
elseif raster1Value==3;R1select=WaterOnArrayOriginal;S1='WaterOn';    
elseif raster1Value==4;R1select=WaterOffArrayOriginal;S1='WaterOff';    
elseif raster1Value==5;R1select=SpikeArray1';S1='Spike';
elseif (raster1Value==6) R1select=RpegTimeArray;S1='Right peg';
elseif (raster1Value==7) R1select=LpegTimeArray;S1='Left peg';
elseif (raster1Value==8) R1select=RPegTouchAll;S1='Right touch';
elseif (raster1Value==9) R1select=LPegTouchAll;S1='Left touch';
elseif (raster1Value==10) R1select=FloorTouchArray;S1='FloorTouch';
elseif (raster1Value==11) R1select=FloorDetachArray;S1='FloorDetach';
elseif (raster1Value==12) R1select=DrinkOnArray;S1='DrinkOn';
elseif (raster1Value==13) R1select=DrinkOffArray;S1='DrinkOff';
end

% disp('RpegTimeArray');disp(RpegTimeArray);

raster2Value=get(handles.popupmenu_raster2,'Value');
if ~isempty(rasterset2)==1
    raster2Value=rasterset2;
end
if raster2Value==1;R2select=LpegTimeArray;S2='Left peg';
elseif raster2Value==2;R2select=0;S2=' ';  
elseif raster2Value==3;R2select=WaterOnArrayOriginal;S2='WaterOn';    
elseif raster2Value==4;R2select=WaterOffArrayOriginal;S2='WaterOff';    
elseif raster2Value==5;R2select=SpikeArray1';S2='Spike';
elseif (raster2Value==6) R2select=RpegTimeArray;S2='Right peg';
elseif (raster2Value==7) R2select=LpegTimeArray;S2='Left peg';
elseif (raster2Value==8) R2select=RPegTouchAll;S2='Right touch';
elseif (raster2Value==9) R2select=LPegTouchAll;S2='Left touch';
elseif (raster2Value==10) R2select=FloorTouchArray;S2='FloorTouch';
elseif (raster2Value==11) R2select=FloorDetachArray;S2='FloorDetach';
elseif (raster2Value==12) R2select=DrinkOnArray;S2='DrinkOn';
elseif (raster2Value==13) R2select=DrinkOffArray;S2='DrinkOff';
end

raster3Value=get(handles.popupmenu_raster3,'Value');
if ~isempty(rasterset3)==1
    raster3Value=rasterset3;
end
if raster3Value==1;R3select=RPegTouchAll;S3='Right touch';
elseif raster3Value==2;R3select=0;S3=' ';  
elseif raster3Value==3;R3select=WaterOnArrayOriginal;S3='WaterOn';    
elseif raster3Value==4;R3select=WaterOffArrayOriginal;S3='WaterOff';    
elseif raster3Value==5;R3select=SpikeArray1';S3='Spike';
elseif (raster3Value==6) R3select=RpegTimeArray;S3='Right peg';
elseif (raster3Value==7) R3select=LpegTimeArray;S3='Left peg';
elseif (raster3Value==8) R3select=RPegTouchAll;S3='Right touch';
elseif (raster3Value==9) R3select=LPegTouchAll;S3='Left touch';
elseif (raster3Value==10) R3select=FloorTouchArray;S3='FloorTouch';
elseif (raster3Value==11) R3select=FloorDetachArray;S3='FloorDetach';
elseif (raster3Value==12) R3select=DrinkOnArray;S3='DrinkOn';
elseif (raster3Value==13) R3select=DrinkOffArray;S3='DrinkOff';
end
% disp('RPegTouchAll');disp(RPegTouchAll);


raster4Value=get(handles.popupmenu_raster4,'Value');
if ~isempty(rasterset4)==1
    raster4Value=rasterset4;
end
if raster4Value==1;R4select=LPegTouchAll;S4='Left touch';
elseif raster4Value==2;R4select=0;S4=' ';  
elseif raster4Value==3;R4select=WaterOnArrayOriginal;S4='WaterOn';    
elseif raster4Value==4;R4select=WaterOffArrayOriginal;S4='WaterOff';    
elseif raster4Value==5;R4select=SpikeArray1';S4='Spike';
elseif (raster4Value==6) R4select=RpegTimeArray;S4='Right peg';
elseif (raster4Value==7) R4select=LpegTimeArray;S4='Left peg';
elseif (raster4Value==8) R4select=RPegTouchAll;S4='Right touch';
elseif (raster4Value==9) R4select=LPegTouchAll;S4='Left touch';
elseif (raster4Value==10) R4select=FloorTouchArray;S4='FloorTouch';
elseif (raster4Value==11) R4select=FloorDetachArray;S4='FloorDetach';
elseif (raster4Value==12) R4select=DrinkOnArray;S4='DrinkOn';
elseif (raster4Value==13) R4select=DrinkOffArray;S4='DrinkOff';
end

raster5Value=get(handles.popupmenu_raster5,'Value');
if raster5Value==1;R5select=0;S5=' '; 
elseif raster5Value==2; R5select=DrinkOnArray;S5='DrinkOn';
elseif raster5Value==3;R5select=WaterOnArrayOriginal;S5='WaterOn';    
elseif raster5Value==4;R5select=WaterOffArrayOriginal;S5='WaterOff';    
elseif raster5Value==5;R5select=SpikeArray1';S5='Spike';
elseif (raster5Value==6) R5select=RpegTimeArray;S5='Right peg';
elseif (raster5Value==7) R5select=LpegTimeArray;S5='Left peg';
elseif (raster5Value==8) R5select=RPegTouchAll;S5='Right touch';
elseif (raster5Value==9) R5select=LPegTouchAll;S5='Left touch';
elseif (raster5Value==10) R5select=FloorTouchArray;S5='FloorTouch';
elseif (raster5Value==11) R5select=FloorDetachArray;S5='FloorDetach';
elseif (raster5Value==12) R5select=DrinkOnArray;S5='DrinkOn';
elseif (raster5Value==13) R5select=DrinkOffArray;S5='DrinkOff';
end

raster6Value=get(handles.popupmenu_raster6,'Value');
if raster6Value==1;R6select=0;S6=' ';
elseif raster6Value==2;R6select=SpikeArray1';S6='Spike1';
elseif raster6Value==3;R6select=SpikeArray2';S6='Spike2';
elseif raster6Value==4;R6select=SpikeArray3';S6='Spike3';
elseif raster6Value==5;R6select=SpikeArray4';S6='Spike4'; 
elseif raster6Value==6;R6select=SpikeArray5';S6='Spike5';
elseif raster6Value==7;R6select=WaterOnArrayOriginal;S6='WaterOn';    
elseif raster6Value==8;R6select=WaterOffArrayOriginal;S6='WaterOff';    
elseif (raster6Value==9) R6select=FloorTouchArray;S6='FloorTouch';
elseif (raster6Value==10) R6select=FloorDetachArray;S6='FloorDetach';
elseif (raster6Value==11) R6select=DrinkOnArray;S6='DrinkOn';
elseif (raster6Value==12) R6select=DrinkOffArray;S6='DrinkOff';
end

raster7Value=get(handles.popupmenu_raster7,'Value');
if raster7Value==1;R7select=0;S7=' ';
elseif raster7Value==2;R7select=SpikeArray1';S7='Spike1';
elseif raster7Value==3;R7select=SpikeArray2';S7='Spike2';
elseif raster7Value==4;R7select=SpikeArray3';S7='Spike3';
elseif raster7Value==5;R7select=SpikeArray4';S7='Spike4'; 
elseif raster7Value==6;R7select=SpikeArray5';S7='Spike5';
elseif raster7Value==7;R7select=WaterOnArrayOriginal;S7='WaterOn';    
elseif raster7Value==8;R7select=WaterOffArrayOriginal;S7='WaterOff';    
elseif (raster7Value==9) R7select=FloorTouchArray;S7='FloorTouch';
elseif (raster7Value==10) R7select=FloorDetachArray;S7='FloorDetach';
elseif (raster7Value==11) R7select=DrinkOnArray;S7='DrinkOn';
elseif (raster7Value==12) R7select=DrinkOffArray;S7='DrinkOff';
end

raster8Value=get(handles.popupmenu_raster8,'Value');
if raster8Value==1;R8select=0;S8=' ';
elseif raster8Value==2;R8select=SpikeArray1';S8='Spike1';
elseif raster8Value==3;R8select=SpikeArray2';S8='Spike2';
elseif raster8Value==4;R8select=SpikeArray3';S8='Spike3';
elseif raster8Value==5;R8select=SpikeArray4';S8='Spike4'; 
elseif raster8Value==6;R8select=SpikeArray5';S8='Spike5';
elseif raster8Value==7;R8select=WaterOnArrayOriginal;S8='WaterOn';    
elseif raster8Value==8;R8select=WaterOffArrayOriginal;S8='WaterOff';    
elseif (raster8Value==9) R8select=FloorTouchArray;S8='FloorTouch';
elseif (raster8Value==10) R8select=FloorDetachArray;S8='FloorDetach';
elseif (raster8Value==11) R8select=DrinkOnArray;S8='DrinkOn';
elseif (raster8Value==12) R8select=DrinkOffArray;S8='DrinkOff';
end

raster9Value=get(handles.popupmenu_raster9,'Value');
if raster9Value==1;R9select=0;S9=' ';
elseif raster9Value==2;R9select=SpikeArray1';S9='Spike1';
elseif raster9Value==3;R9select=SpikeArray2';S9='Spike2';
elseif raster9Value==4;R9select=SpikeArray3';S9='Spike3';
elseif raster9Value==5;R9select=SpikeArray4';S9='Spike4'; 
elseif raster9Value==6;R9select=SpikeArray5';S9='Spike5';
elseif raster9Value==7;R9select=WaterOnArrayOriginal;S9='WaterOn';    
elseif raster9Value==8;R9select=WaterOffArrayOriginal;S9='WaterOff';    
elseif (raster9Value==9) R9select=FloorTouchArray;S9='FloorTouch';
elseif (raster9Value==10) R9select=FloorDetachArray;S9='FloorDetach';
elseif (raster9Value==11) R9select=DrinkOnArray;S9='DrinkOn';
elseif (raster9Value==12) R9select=DrinkOffArray;S9='DrinkOff';
end

raster10Value=get(handles.popupmenu_raster10,'Value');
if ~isempty(rasterset10)==1
    raster10Value=rasterset10;
end
if raster10Value==1;R10select=0;S10=' ';
elseif raster10Value==2;R10select=SpikeArray1';S10='Spike1';
elseif raster10Value==3;R10select=SpikeArray2';S10='Spike2';
elseif raster10Value==4;R10select=SpikeArray3';S10='Spike3';
elseif raster10Value==5;R10select=SpikeArray4';S10='Spike4'; 
elseif raster10Value==6;R10select=SpikeArray5';S10='Spike5';
elseif raster10Value==7;R10select=WaterOnArrayOriginal;S10='WaterOn';    
elseif raster10Value==8;R10select=WaterOffArrayOriginal;S10='WaterOff';    
elseif (raster10Value==9) R10select=FloorTouchArray;S10='FloorTouch';
elseif (raster10Value==10) R10select=FloorDetachArray;S10='FloorDetach';
elseif (raster10Value==11) R10select=DrinkOnArray;S10='DrinkOn';
elseif (raster10Value==12) R10select=DrinkOffArray;S10='DrinkOff';
end

Alt=get(handles.radiobutton_Alt,'Value');
if Alt==1
    dTM=diff(TurnMarkerTime);
    TMdiff=abs(diff(diff(TurnMarkerTime)));
    TMdiff(TMdiff>500)=0;
    TMax=find(TMdiff==max(TMdiff),1,'first');
    XMax=dTM(TMax)+100;
    TurnMarkerTime_org=TurnMarkerTime;
    TurnMarkerTime=TurnMarkerTime_R;
    
fig_Raster=figure('Position',[1 400 1400 575]);hold on;zoom xon
if ~isempty(R1select);Raster1=raster(R1select,TurnMarkerTime);if length(Raster1)>1;text(Raster1(:,1),Raster1(:,2),'l','FontSize',14,'color',[0 1 0]);end;end
if ~isempty(R2select);Raster2=raster(R2select,TurnMarkerTime);if length(Raster2)>1;text(Raster2(:,1),Raster2(:,2),'l','FontSize',14,'color',[1 0 1]);end;end
if ~isempty(R3select);Raster3=raster(R3select,TurnMarkerTime);if length(Raster3)>1;text(Raster3(:,1),Raster3(:,2),'>','FontSize',12,'color',[0 0 1]);end;end
if ~isempty(R4select);Raster4=raster(R4select,TurnMarkerTime);if length(Raster4)>1;text(Raster4(:,1),Raster4(:,2),'>','FontSize',12,'color',[1 0 0]);end;end
if ~isempty(R5select);Raster5=raster(R5select,TurnMarkerTime);if length(Raster5)>1;text(Raster5(:,1),Raster5(:,2),'o','FontSize',10,'color',[0 1 1]);end;end

if ~isempty(R6select);Raster6=raster(R6select,TurnMarkerTime);if length(Raster6)>1;text(Raster6(:,1),Raster6(:,2),'l','FontSize',10,'color',[0 0 1]);end;end
if ~isempty(R7select);Raster7=raster(R7select,TurnMarkerTime);if length(Raster7)>1;text(Raster7(:,1),Raster7(:,2),'l','FontSize',10,'color',[1 0 0]);end;end
if ~isempty(R8select);Raster8=raster(R8select,TurnMarkerTime);if length(Raster8)>1;text(Raster8(:,1),Raster8(:,2),'l','FontSize',10,'color',[0 1 0]);end;end
if ~isempty(R9select);Raster9=raster(R9select,TurnMarkerTime);if length(Raster9)>1;text(Raster9(:,1),Raster9(:,2),'l','FontSize',10,'color',[1 0 1]);end;end
if ~isempty(R10select);Raster10=raster(R10select,TurnMarkerTime);if length(Raster10)>1;text(Raster10(:,1),Raster10(:,2),'l','FontSize',10,'color',[0 0 0]);end;end
set(gca,'Xlim',[0 XMax*2],'Ylim',[0 length(TurnMarkerTime)]); % x y 軸の範囲を適宜設定

hold off;
TurnMarkerTime=TurnMarkerTime_org;

else
fig_Raster=figure('Position',[1 1 1400 975]);hold on;zoom xon
if ~isempty(R1select);Raster1=raster(R1select,TurnMarkerTime);if length(Raster1)>1;text(Raster1(:,1),Raster1(:,2),'l','FontSize',14,'color',[0 1 0]);end;end
if ~isempty(R2select);Raster2=raster(R2select,TurnMarkerTime);if length(Raster2)>1;text(Raster2(:,1),Raster2(:,2),'l','FontSize',14,'color',[1 0 1]);end;end
if ~isempty(R3select);Raster3=raster(R3select,TurnMarkerTime);if length(Raster3)>1;text(Raster3(:,1),Raster3(:,2),'>','FontSize',12,'color',[0 0 1]);end;end
if ~isempty(R4select);Raster4=raster(R4select,TurnMarkerTime);if length(Raster4)>1;text(Raster4(:,1),Raster4(:,2),'>','FontSize',12,'color',[1 0 0]);end;end
if ~isempty(R5select);Raster5=raster(R5select,TurnMarkerTime);if length(Raster5)>1;text(Raster5(:,1),Raster5(:,2),'o','FontSize',10,'color',[0 1 1]);end;end

if ~isempty(R6select);Raster6=raster(R6select,TurnMarkerTime);if length(Raster6)>1;text(Raster6(:,1),Raster6(:,2),'l','FontSize',10,'color',[0 0 1]);end;end
if ~isempty(R7select);Raster7=raster(R7select,TurnMarkerTime);if length(Raster7)>1;text(Raster7(:,1),Raster7(:,2),'l','FontSize',10,'color',[1 0 0]);end;end
if ~isempty(R8select);Raster8=raster(R8select,TurnMarkerTime);if length(Raster8)>1;text(Raster8(:,1),Raster8(:,2),'l','FontSize',10,'color',[0 1 0]);end;end
if ~isempty(R9select);Raster9=raster(R9select,TurnMarkerTime);if length(Raster9)>1;text(Raster9(:,1),Raster9(:,2),'l','FontSize',10,'color',[1 0 1]);end;end
if ~isempty(R10select);Raster10=raster(R10select,TurnMarkerTime);if length(Raster10)>1;text(Raster10(:,1),Raster10(:,2),'l','FontSize',10,'color',[0 0 0]);end;end

dTM=diff(TurnMarkerTime);
TMdiff=abs(diff(diff(TurnMarkerTime)));
TMdiff(TMdiff>500)=0;
TMax=find(TMdiff==max(TMdiff),1,'first');
XMax=dTM(TMax)+100;

set(gca,'Xlim',[0 XMax],'Ylim',[0 length(TurnMarkerTime)]); % x y 軸の範囲を適宜設定

% if R1select~=0;Raster1=raster(R1select,TurnMarkerTime);if length(Raster1)>1;plot(Raster1(:,1),Raster1(:,2),'k>');end;end
% if R2select~=0;Raster2=raster(R2select,TurnMarkerTime);if length(Raster2)>1;plot(Raster2(:,1),Raster2(:,2),'k<');end;end
% if R3select~=0;Raster3=raster(R3select,TurnMarkerTime);if length(Raster3)>1;plot(Raster3(:,1),Raster3(:,2),'b^');end;end
% if R4select~=0;Raster4=raster(R4select,TurnMarkerTime);if length(Raster4)>1;plot(Raster4(:,1),Raster4(:,2),'bv');end;end
% if R5select~=0;Raster5=raster(R5select,TurnMarkerTime);if length(Raster5)>1;plot(Raster5(:,1),Raster5(:,2),'go');end;end
% if R6select~=0;Raster6=raster(R6select,TurnMarkerTime);if length(Raster6)>1;plot(Raster6(:,1),Raster6(:,2),'rx');end;end


% RPegTouchAll=RPegTouchAll';LPegTouchAll=LPegTouchAll';
end
Title=char(strcat({S1},{' '},{S2},{' '},{S3},{' '},{S4},{' '},{S5},{' '},{S6},{' '},{S7},{' '},{S8},{' '},{S9},{' '},{S10}));disp(Title);
title(Title);hold off;

ShowFig=get(handles.radiobutton_ShowFigure,'Value');

FigureSave=get(handles.radiobutton_SaveFigure,'Value');
FigName=char(strcat({S1},{' '},{S2},{' '},{S3},{' '},{S4},{' '},{S5},{' '},{S6},{S7},{' '},{S8},{' '},{S9},{' '},{S10},{'.bmp'}));
if FigureSave==1;saveas(fig_Raster,FigName);end


% disp('CrossCorr length=');disp(length(ACselect));
% disp('Alignment length=');disp(length(CCselect));


function radiobutton_ttest_Callback(hObject, eventdata, handles)


% --- Executes on button press in radiobutton_SaveFigure.
function radiobutton_SaveFigure_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton_SaveFigure (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton_SaveFigure


% --- Executes on selection change in popupmenu_pattern.
function popupmenu_pattern_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu_pattern (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns popupmenu_pattern contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu_pattern


% --- Executes during object creation, after setting all properties.
function popupmenu_pattern_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu_pattern (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_SpikeAlignBy12peg.
function pushbutton_SpikeAlignBy12peg_Callback(hObject, eventdata, handles)

global RpegTimeArray2D LpegTimeArray2D RpegTouchCell LpegTouchCell SpikeArray1 DrName ShowFig FigureSave

yhight=1;
%if RefPeriod<=100;yhight=50;else yhight=20;end
[fig_SpikebyR12Peg SpikeHistoCell_Rpeg]=SpikeAlignByPegOrTouch(SpikeArray1,RpegTimeArray2D,yhight);
% FigName=char(strcat({S1},{' '},{S2},{' '},{S3},{' '},{S4},{' '},{S5},{' '},{S6},{'.bmp'}));
if FigureSave==1;saveas(fig_SpikebyR12Peg,[DrName,' ','fig_SpikebyR12Peg.bmp']);end
[fig_SpikebyL12Peg SpikeHistoCell_Lpeg]=SpikeAlignByPegOrTouch(SpikeArray1,LpegTimeArray2D,yhight);
if FigureSave==1;saveas(fig_SpikebyL12Peg,[DrName,' ','fig_SpikebyL12Peg.bmp']);end

[fig_SpikebyR12Touch SpikeHistoCell_Rtouch]=SpikeAlignByPegOrTouch(SpikeArray1,RpegTouchCell,yhight);
if FigureSave==1;saveas(fig_SpikebyR12Peg,[DrName,' ','fig_SpikebyR12Touch.bmp']);end
[fig_SpikebyL12Touch SpikeHistoCell_Ltouch]=SpikeAlignByPegOrTouch(SpikeArray1,LpegTouchCell,yhight);
if FigureSave==1;saveas(fig_SpikebyL12Peg,[DrName,' ','fig_SpikebyL12Touch.bmp']);end


% --- Executes on button press in radiobutton_ShowFigure.
function radiobutton_ShowFigure_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton_ShowFigure (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton_ShowFigure


% --- Executes on selection change in popupmenu_CrossCorr2.
function popupmenu_CrossCorr2_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu_CrossCorr2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns popupmenu_CrossCorr2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu_CrossCorr2


% --- Executes during object creation, after setting all properties.
function popupmenu_CrossCorr2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu_CrossCorr2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu_CrossCorr3.
function popupmenu_CrossCorr3_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu_CrossCorr3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns popupmenu_CrossCorr3 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu_CrossCorr3


% --- Executes during object creation, after setting all properties.
function popupmenu_CrossCorr3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu_CrossCorr3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu_raster7.
function popupmenu_raster7_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu_raster7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns popupmenu_raster7 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu_raster7


% --- Executes during object creation, after setting all properties.
function popupmenu_raster7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu_raster7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu_raster8.
function popupmenu_raster8_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu_raster8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns popupmenu_raster8 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu_raster8


% --- Executes during object creation, after setting all properties.
function popupmenu_raster8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu_raster8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu_raster9.
function popupmenu_raster9_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu_raster9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns popupmenu_raster9 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu_raster9


% --- Executes during object creation, after setting all properties.
function popupmenu_raster9_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu_raster9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu_raster10.
function popupmenu_raster10_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu_raster10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns popupmenu_raster10 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu_raster10


% --- Executes during object creation, after setting all properties.
function popupmenu_raster10_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu_raster10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in pushbutton_point1.
function pushbutton_point1_Callback(hObject, eventdata, handles)
global p1valueX p1valueY
[point] = get(handles.axes1, 'CurrentPoint');
p1valueX=point(1,1);
p1valueY=point(1,2);
set(handles.text_point1,'String',num2str(p1valueX));


% --- Executes on button press in pushbutton_point2.
function pushbutton_point2_Callback(hObject, eventdata, handles)
global p2valueX p2valueY
[point] = get(handles.axes1, 'CurrentPoint');
p2valueX=point(1,1);
p2valueY=point(1,2);
set(handles.text_point2,'String',num2str(p2valueX));


% --- Executes on button press in pushbutton_point3.
function pushbutton_point3_Callback(hObject, eventdata, handles)
global p3valueX p3valueY
[point] = get(handles.axes1, 'CurrentPoint');
p3valueX=point(1,1);
p3valueY=point(1,2);
set(handles.text_point3,'String',num2str(p3valueX));


% --- Executes on button press in pushbutton_point4.
function pushbutton_point4_Callback(hObject, eventdata, handles)
global p4valueX p4valueY
[point] = get(handles.axes1, 'CurrentPoint');
p4valueX=point(1,1);
p4valueY=point(1,2);
set(handles.text_point4,'String',num2str(p4valueX));


% --- Executes on button press in pushbutton_MainPoint.
function pushbutton_MainPoint_Callback(hObject, eventdata, handles)
global MainPointX MainPointY
[point] = get(handles.axes1, 'CurrentPoint');
MainPointX=point(1,1);
MainPointY=point(1,2);
set(handles.text_MainPoint,'String',num2str(MainPointX));

% --- Executes on button press in pushbutton_pitch.
function pushbutton_pitch_Callback(hObject, eventdata, handles)

global Pitch 

str1=get(handles.text_point1,'String');p1=str2num(str1);
str2=get(handles.text_point2,'String');p2=str2num(str2);
str3=get(handles.text_point3,'String');p3=str2num(str3);
str4=get(handles.text_point4,'String');p4=str2num(str4);
Points=[p1 p2 p3 p4];

int1=p2-p1;
int2=p3-p2;
if p4~=0
    int3=p4-p3;
    Pitch=mean([int1 int2 int3]);
else
    Pitch=mean([int1 int2]);
end
set(handles.text_ShowPitch,'String',num2str(Pitch));

% --- Executes on button press in pushbutton_RepeatHist.
function pushbutton_RepeatHist_Callback(hObject, eventdata, handles)

global ACselect

DifACselect=diff(ACselect);
Repeated=[];
for n=1:length(DifACselect)-5
    if DifACselect(n)>DifACselect(n+1)*0.85 & DifACselect(n)<DifACselect(n+1)*1.15
        if DifACselect(n)>DifACselect(n+2)*0.85 & DifACselect(n)<DifACselect(n+2)*1.15
            Repeated=[Repeated DifACselect(n)];
        end
    end
end
if isempty(Repeated);disp('Empty Repeated value');end
% Repeated

% mean(Repeated)
% median(Repeated)
% mode(Repeated)

num=hist(Repeated,15);
hist(Repeated,15);
axis([0 max(Repeated) 0 max(num)+1]);


% --- Executes on button press in pushbutton_HistToPitch.
function pushbutton_HistToPitch_Callback(hObject, eventdata, handles)
global Pitch
[point] = get(handles.axes1, 'CurrentPoint');
Pitch=point(1,1);
set(handles.text_ShowPitch,'String',num2str(Pitch));


% --- Executes on button press in pushbutton_WindowSetA.
function pushbutton_WindowSetA_Callback(hObject, eventdata, handles)
global p1valueX p1valueY p2valueX p2valueY p3valueX  p4valueX p4valueY...
    AutoCal autoy Astart Aend Pitch MainPointX MainPointY 

% MainPoint=str2num(get(handles.text_MainPoint,'String'));
p1=MainPointX-2*Pitch;
p2=MainPointX-Pitch;
p3=MainPointX;
p4=MainPointX+Pitch;
p5=MainPointX+2*Pitch;
Points=[p1 p2 p3 p4 p5];

contents = cellstr(get(handles.popupmenu_lengthA,'String')); 
lengthA=contents{get(handles.popupmenu_lengthA,'Value')};%Pitchの長さの0.25倍など
LenA=str2num(lengthA);%Windowの長さ　範囲

% %     Windowのサイズを一定にする場合。
FixW=get(handles.radiobutton_FixWindowWidth,'Value');

contents2=cellstr(get(handles.popupmenu_FixWindowWidth,'String'));
FixWindow=str2double(contents2{get(handles.popupmenu_FixWindowWidth,'Value')});%100;
% Astart=zeros(1,5);Aend=zeros(1,5);
for n=1:5
    if FixW==0
    % WindowのサイズをPitchサイズにより可変にする場合。%%%%%%%%
        Astart(n)=Points(n)-0.5*LenA*Pitch;
        Aend(n)=Points(n)+0.5*LenA*Pitch;
    else
    % % Windowのサイズを一定にする場合。%%%%%%%%%%%%%%    
        Astart(n)=Points(n)-0.5*FixWindow;
        Aend(n)=Points(n)+0.5*FixWindow;
    end
    
%%%%%%%%%%%%%%%%%  %赤線をプロットする場合にON
%         x = Astart(n):1:Aend(n);%%赤線をプロットする場合に使用
%     if AutoCal==1
%         y=autoy;
%     else 
%         y = MainPointY*ones(length(x),100);
%     end

%     plot(x,y,'r');%赤線をプロットする場合にON
%%%%%%%% axes(handles.axes1);%赤線をプロットする場合にON 
end
popupmenu_ACduration=get(handles.popupmenu_ACduration,'String');
duration=str2double(popupmenu_ACduration(get(handles.popupmenu_ACduration,'Value')));
Astart=Astart-0.5*duration;%真ん中(2500ms)がスパイクのタイミング、これに相対させる
Aend=Aend-0.5*duration;
%Astart、Aendは５つのwindowの左端、右端を決めている。５個の数


% function radiobutton_Equalize_Callback(hObject, eventdata, handles)

function popupmenu_lengthA_Callback(hObject, eventdata, handles)

function popupmenu_lengthA_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function pushbutton_Calc_Callback(hObject, eventdata, handles)

global Astart Aend ACselect CCselect CCselect2 CCselect3 SE lengthEvent...
    SpikeCount EventCount1 EventCount2 EventCount3 EventCount4 EventCount5 ControlSp...
    Ratio111 Ratio110 Ratio101 Ratio100 Ratio011 Ratio010 Ratio001 Ratio000...
    ERatio111 ERatio110 ERatio101 ERatio100 ERatio011 ERatio010 ERatio001 ERatio000
%ACselectがRPegtouchALLあるいはRpegTimeArray,CCselect3がSpikeArray1などになるはず

contents=cellstr(get(handles.popupmenu_SpikeBin,'String'));
SpikeBinWidth=str2double(contents{get(handles.popupmenu_SpikeBin,'Value')});%50;

SpikeWindow=ACselect(1)+Astart(1):10:ACselect(end)-Aend(5);
SpikeWindowsize=size(SpikeWindow)
SpikeWindow(1:20)
A1start=Astart(1)
A1end=Aend(1)
A3start=Astart(3)
A3end=Aend(3)
A5start=Astart(5)
A5end=Aend(5)

SpikeCount=zeros(1,length(SpikeWindow));EventCount1=zeros(1,length(SpikeWindow));EventCount2=zeros(1,length(SpikeWindow));EventCount3=zeros(1,length(SpikeWindow));EventCount4=zeros(1,length(SpikeWindow));EventCount5=zeros(1,length(SpikeWindow));
for n=1:length(SpikeWindow)
    SpikeCount(n)=length(CCselect(CCselect>=SpikeWindow(n)-SpikeBinWidth/2 & CCselect<SpikeWindow(n)+SpikeBinWidth/2));
    EventCount1(n)=length(ACselect(ACselect>=SpikeWindow(n)+Astart(1) & ACselect<SpikeWindow(n)+Aend(1)+10));
    EventCount2(n)=length(ACselect(ACselect>=SpikeWindow(n)+Astart(2) & ACselect<SpikeWindow(n)+Aend(2)+10));
    EventCount3(n)=length(ACselect(ACselect>=SpikeWindow(n)+Astart(3) & ACselect<SpikeWindow(n)+Aend(3)+10));
    EventCount4(n)=length(ACselect(ACselect>=SpikeWindow(n)+Astart(4) & ACselect<SpikeWindow(n)+Aend(4)+10));
    EventCount5(n)=length(ACselect(ACselect>=SpikeWindow(n)+Astart(5) & ACselect<SpikeWindow(n)+Aend(5)+10));
end

if ControlSp==1%SpikeCountの順番をランダムにふり、ControlのSpikeCountを作成
%     thd=sum(SpikeCount)/length(SpikeCount);
    [rnd,index]=sort(rand(1,length(SpikeCount)),'descend');
    SpikeCount=SpikeCount(index);
end

SpikeCount=int8(SpikeCount);
EventCount1=int8(EventCount1);EventCount2=int8(EventCount2);EventCount3=int8(EventCount3);EventCount4=int8(EventCount4);EventCount5=int8(EventCount5);

% SpikeCount(SpikeCount>1)=1;%ひとつのbinに2つ以上のスパイクが入ってもカウントは１とする。
EventCount1(EventCount1>1)=1;EventCount2(EventCount2>1)=1;EventCount3(EventCount3>1)=1;EventCount4(EventCount4>1)=1;EventCount5(EventCount5>1)=1;

Present=get(handles.radiobutton_present_absent,'Value');%Eventがあるときをカウントするか、ないときをカウントするか

if Present~=1%そこにイベントがないとき
    EventCount1(EventCount1>=1)=-1;EventCount1(EventCount1==0)=1;EventCount1(EventCount1==-1)=0;
    EventCount2(EventCount2>=1)=-1;EventCount2(EventCount2==0)=1;EventCount2(EventCount2==-1)=0;
    EventCount3(EventCount3>=1)=-1;EventCount3(EventCount3==0)=1;EventCount3(EventCount3==-1)=0;
    EventCount4(EventCount4>=1)=-1;EventCount4(EventCount4==0)=1;EventCount4(EventCount4==-1)=0;
    EventCount5(EventCount5>=1)=-1;EventCount5(EventCount5==0)=1;EventCount5(EventCount5==-1)=0;
end

SE1=SpikeCount.*EventCount1;SE1sum=sum(SE1)/length(EventCount1(EventCount1==1));
SE2=SpikeCount.*EventCount2;SE2sum=sum(SE2)/length(EventCount2(EventCount2==1));
SE3=SpikeCount.*EventCount3;SE3sum=sum(SE3)/length(EventCount3(EventCount3==1));
SE4=SpikeCount.*EventCount4;SE4sum=sum(SE4)/length(EventCount4(EventCount4==1));
SE5=SpikeCount.*EventCount5;SE5sum=sum(SE5)/length(EventCount5(EventCount5==1));

E12=EventCount1.*EventCount2;disp('SE12');
SE12=SpikeCount.*E12;SE12sum=sum(SE12)/length(E12(E12==1));
E23=EventCount2.*EventCount3;disp('SE23');
SE23=SpikeCount.*E23;SE23sum=sum(SE23)/length(E23(E23==1));
E34=EventCount3.*EventCount4;disp('SE34');
SE34=SpikeCount.*E34;SE34sum=sum(SE34)/length(E34(E34==1));
E45=EventCount4.*EventCount5;disp('SE45');
SE45=SpikeCount.*E45;SE45sum=sum(SE45)/length(E45(E45==1));

E123=EventCount1.*E23;disp('SE123');
SE123=SpikeCount.*E123;SE123sum=sum(SE123)/length(E123(E123==1));
E234=EventCount2.*E34;disp('SE234');
SE234=SpikeCount.*E234;SE234sum=sum(SE234)/length(E234(E234==1));
E345=EventCount3.*E45;disp('SE345');
SE345=SpikeCount.*E345;SE345sum=sum(SE345)/length(E345(E345==1));

E12345=E23.*E345;disp('SE12345');
SE12345=SpikeCount.*E12345;SE12345sum=sum(SE12345)/length(E12345(E12345==1));

% assignin('base','EventCount1',EventCount1);
% assignin('base','E12',E12);
% assignin('base','E123',E123);
% assignin('base','EventCount5',EventCount5);
% assignin('base','E45',E45);
% assignin('base','E345',E345);
% assignin('base','E12345',E12345);
% assignin('base','SE12345',SE12345);
% length(E12345(E12345==1))

Inv3=EventCount3+1;Inv3(Inv3>=2)=0;
E2Inv3=EventCount2.*Inv3;%disp('SE2inv3');
% SE2Inv3=SpikeCount.*E2Inv3;SE2Inv3sum=sum(SE2Inv3)/length(E2Inv3(E2Inv3==1));

E24Inv3=E2Inv3.*EventCount4;disp('SE24inv3');
SE24Inv3=SpikeCount.*E24Inv3;SE24Inv3sum=sum(SE24Inv3)/length(E24Inv3(E24Inv3==1));

E1245=E12.*E45;
E1245Inv3=E1245.*Inv3;disp('SE1245inv3');%1,2,4,5はあてはまっているが、このうち3はないもの。
SE1245Inv3=SpikeCount.*E1245Inv3;SE1245Inv3sum=sum(SE1245Inv3)/length(E1245Inv3(E1245Inv3==1));

% InvE234=E234+1;InvE234(InvE234>=2)=0;
% InvE12345=E12345+1;InvE12345(InvE12345>=2)=0;
% A=EventCount3.*InvE234;
E3Inv234=EventCount3-E234;  %3はあるが、234となっていないもの。上記3行も同じことを行う。
sum(EventCount3)
sum(E234)
SE3Inv234=SpikeCount.*E3Inv234;SE3Inv234sum=sum(SE3Inv234)/length(E3Inv234(E3Inv234==1));
E3Inv12345=EventCount3-E12345;  %3はあるが、234となっていないもの。
SE3Inv12345=SpikeCount.*E3Inv12345;SE3Inv12345sum=sum(SE3Inv12345)/length(E3Inv12345(E3Inv12345==1));

% disp('SE1 SE2 SE3 SE4 SE5 SE12 SE23 SE34 SE45 SE123 SE234 SE345 SE12345 SE24Inv3 SE1245Inv3');
SE=[SE1sum SE2sum SE3sum SE4sum SE5sum SE12sum SE23sum SE34sum SE45sum SE123sum SE234sum SE345sum SE12345sum SE24Inv3sum SE1245Inv3sum SE3Inv234sum SE3Inv12345sum]

% assignin('base','SE',SE);

lengthEvent=[length(EventCount1(EventCount1==1)) length(EventCount2(EventCount2==1)) length(EventCount3(EventCount3==1))...
    length(EventCount4(EventCount4==1)) length(EventCount5(EventCount5==1)) length(E12(E12==1)) length(E23(E23==1)) length(E34(E34==1)) length(E45(E45==1))...
    length(E123(E123==1)) length(E234(E234==1)) length(E345(E345==1)) length(E12345(E12345==1)) length(E24Inv3(E24Inv3==1)) length(E1245Inv3(E1245Inv3==1))...
    length(E3Inv234(E3Inv234==1)) length(E3Inv12345(E3Inv12345==1))]

if Present==1%そこにイベントがないとき
    NotE2=EventCount2;NotE3=EventCount3;NotE4=EventCount4;
%     NotE1(NotE1>=1)=-1;NotE1(NotE1==0)=1;NotE1(NotE1==-1)=0;
    NotE2(NotE2>=1)=-1;NotE2(NotE2==0)=1;NotE2(NotE2==-1)=0;
    NotE3(NotE3>=1)=-1;NotE3(NotE3==0)=1;NotE3(NotE3==-1)=0;
    NotE4(NotE4>=1)=-1;NotE4(NotE4==0)=1;NotE4(NotE4==-1)=0;
%     NotE5(NotE5>=1)=-1;NotE5(NotE5==0)=1;NotE5(NotE5==-1)=0;

%SpikeCountの2以上の部分を１にして、SpikeCount_1という名前にする。
SpikeCount_1=SpikeCount;
SpikeCount_1(SpikeCount_1>1)=1;
%Event 234を8通りに分ける。
E111=EventCount2.*EventCount3;E111=E111.*EventCount4;SE111=SpikeCount.*E111;
E110=EventCount2.*EventCount3;E110=E110.*NotE4;SE110=SpikeCount.*E110;
E101=EventCount2.*NotE3;E101=E101.*EventCount4;SE101=SpikeCount.*E101;
E100=EventCount2.*NotE3;E100=E100.*NotE4;SE100=SpikeCount.*E100;
E011=NotE2.*EventCount3;E011=E011.*EventCount4;SE011=SpikeCount.*E011;
E010=NotE2.*EventCount3;E010=E010.*NotE4;SE010=SpikeCount.*E010;
E001=NotE2.*NotE3;E001=E001.*EventCount4;SE001=SpikeCount.*E001;
E000=NotE2.*NotE3;E000=E000.*NotE4;SE000=SpikeCount.*E000;

Eall=sum(E111)+sum(E110)+sum(E101)+sum(E100)+sum(E011)+sum(E010)+sum(E001)+sum(E000);
PE111=sum(E111)/Eall;
PE110=sum(E110)/Eall;
PE101=sum(E101)/Eall;
PE100=sum(E100)/Eall;
PE011=sum(E011)/Eall;
PE010=sum(E010)/Eall;
PE001=sum(E001)/Eall;
PE000=sum(E000)/Eall;

Px=sum(SpikeCount_1)/length(SpikeCount_1);

%SpikeCount_1が１のときの何％にあたるか
% SE111はEventCount2~4かつSpikeCount
% SE234sum(=3real)、SE234sum=sum(SE234)/length(E234(E234==1));
Ratio111=sum(SE111)/sum(SpikeCount_1)
Ratio110=sum(SE110)/sum(SpikeCount_1)
Ratio101=sum(SE101)/sum(SpikeCount_1)
Ratio100=sum(SE100)/sum(SpikeCount_1)
Ratio011=sum(SE011)/sum(SpikeCount_1)
Ratio010=sum(SE010)/sum(SpikeCount_1)
Ratio001=sum(SE001)/sum(SpikeCount_1)
Ratio000=sum(SE000)/sum(SpikeCount_1)

ERatio111=sum(SE111)/sum(E111)
ERatio110=sum(SE110)/sum(E110)
ERatio101=sum(SE101)/sum(E101)
ERatio100=sum(SE100)/sum(E100)
ERatio011=sum(SE011)/sum(E011)
ERatio010=sum(SE010)/sum(E010)
ERatio001=sum(SE001)/sum(E001)
ERatio000=sum(SE000)/sum(E000)

% Ratio111=sum(SE111)/sum(E111)
% Ratio110=sum(SE110)/sum(E110)
% Ratio101=sum(SE101)/sum(E101)
% Ratio100=sum(SE100)/sum(E100)
% Ratio011=sum(SE011)/sum(E011)
% Ratio010=sum(SE010)/sum(E010)
% Ratio001=sum(SE001)/sum(E001)
% Ratio000=sum(SE000)/sum(E000)

% Ratio111=sum(SE111)/PE111/length(SpikeCount_1)
% Ratio110=sum(SE110)/PE110/length(SpikeCount_1)
% Ratio101=sum(SE101)/PE101/length(SpikeCount_1)
% Ratio100=sum(SE100)/PE100/length(SpikeCount_1)
% Ratio011=sum(SE011)/PE011/length(SpikeCount_1)
% Ratio010=sum(SE010)/PE010/length(SpikeCount_1)
% Ratio001=sum(SE001)/PE001/length(SpikeCount_1)
% Ratio000=sum(SE000)/PE000/length(SpikeCount_1)


% Ratio111=sum(SE111)/PE111/sum(SpikeCount_1)
% Ratio110=sum(SE110)/PE110/sum(SpikeCount_1)
% Ratio101=sum(SE101)/PE101/sum(SpikeCount_1)
% Ratio100=sum(SE100)/PE100/sum(SpikeCount_1)
% Ratio011=sum(SE011)/PE011/sum(SpikeCount_1)
% Ratio010=sum(SE010)/PE010/sum(SpikeCount_1)
% Ratio001=sum(SE001)/PE001/sum(SpikeCount_1)
% Ratio000=sum(SE000)/PE000/sum(SpikeCount_1)

end

clearvars SE12 SE23 SE34 SE45 SE123 SE234 SE345 SE12345 SE24inv3 SE1245inv3...
    E12 E23 E34 E45 E123 E234 E345 E12345 E1245 E1245Inv3 E3Inv234 SE3Inv234 E3Inv12345 SE3Inv12345

% SE1=SpikeCount.*EventCount1;length(SE1(SE1>=1))/length(EventCount1(EventCount1==1))
% SE2=SpikeCount.*EventCount2;length(SE2(SE2>=1))/length(EventCount2(EventCount2==1))
% SE3=SpikeCount.*EventCount3;length(SE3(SE3>=1))/length(EventCount3(EventCount3==1))
% SE4=SpikeCount.*EventCount4;length(SE4(SE4>=1))/length(EventCount4(EventCount4==1))
% 
% E23=EventCount2.*EventCount3;
% SE23=SpikeCount.*E23;length(SE23(SE23>=1))/length(E23(E23==1))
% E123=EventCount1.*E23;
% SE123=SpikeCount.*E123;length(SE123(SE123>=1))/length(E123(E123==1))
% E1234=EventCount4.*E123;
% SE1234=SpikeCount.*E1234;length(SE1234(SE1234>=1))/length(E1234(E1234==1))

% length(EventCount1(EventCount1>=1))
% length(E23(E23>=1))
% length(E123(E123>=1))
% length(E1234(E1234>=1))

% length(SpikeCount(SpikeCount>1))

%スパイク読み込みの際のSpike()がSpikeAnalyzer()になった。


% % --- Executes on button press in pushbutton_WindowSetA.
% function pushbutton_WindowSetA_Callback(hObject, eventdata, handles)
% % hObject    handle to pushbutton_WindowSetA (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in radiobutton_present_absent.
function radiobutton_present_absent_Callback(hObject, eventdata, handles)


% --- Executes on button press in pushbutton_AutoCalc.
function pushbutton_AutoCalc_Callback(hObject, eventdata, handles)
% MainPoint、Pitchともに振る。

global Pitch MainPointX AutoCorrValue SE lengthEvent T autoy CCresult AutoCal Repeat...
    SpikeCount EventCount1 EventCount2 EventCount3 EventCount4 EventCount5 AC ControlSp MainPoint AutoPitch...
    Ratio111 Ratio110 Ratio101 Ratio100 Ratio011 Ratio010 Ratio001 Ratio000...
    ERatio111 ERatio110 ERatio101 ERatio100 ERatio011 ERatio010 ERatio001 ERatio000

ControlSp 

%yはwindowの赤線の高さ,これをAutoCalcでは別に指定する。高さを変えて示すため
AutoCal=1;%%%%%%%赤線を表示する場合に使用
EventCount1=[]; EventCount2=[]; EventCount3=[]; EventCount4=[]; EventCount5=[];
if AutoCorrValue==10%AutoCorrValue==10はDrinkOff
%     MainPointStart=-150;%Drinkの場合、spikeから-150msから15ms刻みで行う。
    MainPoint0=-150:10:150;%[-150,-120,-90,-60,-30,0,30,60,90,120,150];
    MainPoint=MainPoint0+500;%Drinkの場合、全長2000ms、中心1000ms
    AutoPitch=30:10:200;%[60,80,100,120,140,160,180,200,240,260,280];%,250,300,350,400,450,500,550,600,650,700,750,800];
else
%     AutoPitch=[300,350,400,450,500,550,600,650,700,750,800];
%     MainPointStart=-500;%Drink以外の場合、spikeから-500msから50ms刻みで行う。
    MainPoint0=-500:25:500;%[-500,-400,-300,-200,-100,0,100,200,300,400,500];

    MainPoint=MainPoint0+2500;%Drink以外の場合、全長5000ms、中心2500ms
%     AutoPitch=[600,625,650,675,700,725,750,775,800];
    AutoPitch=[200,225,250,275,300,325,350,375,400,425,450,475,500,525,550,575,600,625,650,675,700,725,750,775,800,825,850,875,900,925,950,975,1000];

end

SE3All=zeros(length(MainPoint),length(AutoPitch));
SE5All=zeros(length(MainPoint),length(AutoPitch));
SE3Allnan=zeros(length(MainPoint),length(AutoPitch));
SE5Allnan=zeros(length(MainPoint),length(AutoPitch));
Ratio3Allnan=zeros(length(MainPoint),length(AutoPitch));
Ratio5Allnan=zeros(length(MainPoint),length(AutoPitch));
Ratio3All=zeros(length(MainPoint),length(AutoPitch));
Ratio5All=zeros(length(MainPoint),length(AutoPitch));
Event1=cell(length(MainPoint),length(AutoPitch));Event2=cell(length(MainPoint),length(AutoPitch));Event3=cell(length(MainPoint),length(AutoPitch));Event4=cell(length(MainPoint),length(AutoPitch));Event5=cell(length(MainPoint),length(AutoPitch));
% SE_ADD=zeros(length(AutoPitch),length(SE(1,:)),length(MainPoint));
% Event_ADD=zeros(length(AutoPitch),length(SE(1,:)),length(MainPoint));
SE_ADD=zeros(length(AutoPitch),17,length(MainPoint));
Event_ADD=zeros(length(AutoPitch),17,length(MainPoint));
Ratio111All=zeros(length(MainPoint),length(AutoPitch));
Ratio110All=zeros(length(MainPoint),length(AutoPitch)); 
Ratio101All=zeros(length(MainPoint),length(AutoPitch)); 
Ratio100All=zeros(length(MainPoint),length(AutoPitch)); 
Ratio011All=zeros(length(MainPoint),length(AutoPitch)); 
Ratio010All=zeros(length(MainPoint),length(AutoPitch)); 
Ratio001All=zeros(length(MainPoint),length(AutoPitch)); 
Ratio000All=zeros(length(MainPoint),length(AutoPitch));

ERatio111All=zeros(length(MainPoint),length(AutoPitch));
ERatio110All=zeros(length(MainPoint),length(AutoPitch)); 
ERatio101All=zeros(length(MainPoint),length(AutoPitch)); 
ERatio100All=zeros(length(MainPoint),length(AutoPitch)); 
ERatio011All=zeros(length(MainPoint),length(AutoPitch)); 
ERatio010All=zeros(length(MainPoint),length(AutoPitch)); 
ERatio001All=zeros(length(MainPoint),length(AutoPitch)); 
ERatio000All=zeros(length(MainPoint),length(AutoPitch));

for m=1:length(MainPoint)

%     MainPointX=MainPointStart+(-0.1)*MainPointStart*m;%MainPointStartはマイナスの値
    MainPointX=MainPoint(m);
    
% SE=[SE1sum SE2sum SE3sum SE4sum SE5sum SE12sum SE23sum SE34sum SE45sum SE123sum... 
%      SE234sum SE345sum SE12345sum SE24Inv3sum SE1245Inv3sum SE3Inv234sum SE3Inv12345sum];

%     SEadd=[];lengthEventAdd=[];
    for n=1:length(AutoPitch)
        AC
        MainPointX
        Pitch=AutoPitch(n)
        autoy=max(CCresult)*(1/(length(AutoPitch)*length(MainPoint)))*((m-1)*length(AutoPitch)+n);

        pushbutton_WindowSetA_Callback(hObject, eventdata, handles);
        pushbutton_Calc_Callback(hObject, eventdata, handles);
        
        Ratio111All(m,n)=Ratio111;Ratio110All(m,n)=Ratio110;Ratio101All(m,n)=Ratio101;Ratio100All(m,n)=Ratio100;
        Ratio011All(m,n)=Ratio011;Ratio010All(m,n)=Ratio010;Ratio001All(m,n)=Ratio001;Ratio000All(m,n)=Ratio000;

        ERatio111All(m,n)=ERatio111;ERatio110All(m,n)=ERatio110;ERatio101All(m,n)=ERatio101;ERatio100All(m,n)=ERatio100;
        ERatio011All(m,n)=ERatio011;ERatio010All(m,n)=ERatio010;ERatio001All(m,n)=ERatio001;ERatio000All(m,n)=ERatio000;
        
%         SEadd=[SEadd;SE];
%         lengthEventAdd=[lengthEventAdd;lengthEvent];
        SE_ADD(n,:,m)=SE;
        Event_ADD(n,:,m)=lengthEvent;

        Event1{m,n}=EventCount1;
        Event2{m,n}=EventCount2;
        Event3{m,n}=EventCount3;
        Event4{m,n}=EventCount4;
        Event5{m,n}=EventCount5;
        
        %通常解析用セット%%%%%%%%%%%%
            if SE(16)~=0
                Ratio3All(m,n)=SE(11)/SE(16);
                Ratio5All(m,n)=SE(13)/SE(17);
                
                SE3All(m,n)=SE(11);
                SE5All(m,n)=SE(13);

                if lengthEvent(11)>AutoPitch(n)*0.25
                    Ratio3Allnan(m,n)=SE(11)/SE(16);
                    SE3Allnan(m,n)=SE(11);
                else 
                    Ratio3Allnan(m,n)=NaN;
                    SE3Allnan(m,n)=NaN;
                end
                
                if lengthEvent(13)>AutoPitch(n)*0.25
                    Ratio5Allnan(m,n)=SE(13)/SE(17);
                    SE5Allnan(m,n)=SE(13);
                else 
                    Ratio5Allnan(m,n)=NaN;
                    SE5Allnan(m,n)=NaN;
                end
                
            else                
                Ratio3All(m,n)=NaN;
                Ratio5All(m,n)=NaN;
            end
            %通常解析用セット%%%%%%%%%%%%
            
%             %中抜けのためのセット%%%%%%%%%%%%
%             if SE(3)~=0
%                 Ratio3All(m,n)=SE(14)/SE(11);
%                 Ratio5All(m,n)=SE(15)/SE(13);
%                 
%                 SE3All(m,n)=SE(14);
%                 SE5All(m,n)=SE(15);
% 
%                 if lengthEvent(14)>AutoPitch(n)*0.25
%                     Ratio3Allnan(m,n)=SE(14)/SE(11);
%                     SE3Allnan(m,n)=SE(14);
%                 else 
%                     Ratio3Allnan(m,n)=NaN;
%                     SE3Allnan(m,n)=NaN;
%                 end
%                 
%                 if lengthEvent(15)>AutoPitch(n)*0.25
%                     Ratio5Allnan(m,n)=SE(15)/SE(13);
%                     SE5Allnan(m,n)=SE(15);
%                 else 
%                     Ratio5Allnan(m,n)=NaN;
%                     SE5Allnan(m,n)=NaN;
%                 end
%                 
%             else                
%                 Ratio3All(m,n)=NaN;
%                 Ratio5All(m,n)=NaN;
%             end
%             %中抜けのためのセット%%%%%%%%%%%%

%         end
%         clearvars SE12 SE23 SE34 SE45 SE123 SE234 SE345 SE12345 SE24inv3 SE1245inv3...
%         E12 E23 E34 E45 E123 E234 E345 E12345

    end

end
if ControlSp==0
    nanreal3=figure
    AutoPitch
    MainPoint0
    SE3Allnan
    surf(AutoPitch,MainPoint0,SE3Allnan);
    
    shading interp
    colorbar
    title('3nan real')
    saveas(nanreal3,'3nan real.fig')

    real3=figure
    surf(AutoPitch,MainPoint0,SE3All);
    axis([min(AutoPitch) max(AutoPitch) min(MainPoint0) max(MainPoint0) min(min(SE3Allnan)) max(max(SE3Allnan))]);
    caxis([0 max(max(SE3Allnan))]);
    shading interp
    colorbar
    title('3 real')
    saveas(real3,'3 real.fig')

    nanreal5=figure
    surf(AutoPitch,MainPoint0,SE5Allnan);
    shading interp
    colorbar
    title('5nan real')
    saveas(nanreal5,'5nan real.fig');

    real5=figure
    surf(AutoPitch,MainPoint0,SE5All);
    axis([min(AutoPitch) max(AutoPitch) min(MainPoint0) max(MainPoint0) min(min(SE5Allnan)) max(max(SE5Allnan))]);
    caxis([0 max(max(SE5Allnan))]);
    shading interp
    colorbar
    title('5 real')
    saveas(real5,'5 real.fig');
    
    nan3=figure
    surf(AutoPitch,MainPoint0,Ratio3Allnan);
    shading interp
    colorbar
    title('3nan')
    saveas(nan3,'3nan.fig');

    n3=figure
    surf(AutoPitch,MainPoint0,Ratio3All);
    axis([min(AutoPitch) max(AutoPitch) min(MainPoint0) max(MainPoint0) min(min(Ratio3Allnan)) max(max(Ratio3Allnan))]);
    caxis([0 max(max(Ratio3Allnan))]);
    shading interp
    colorbar
    title('3')
    saveas(n3,'3.fig');

    nan5=figure
    surf(AutoPitch,MainPoint0,Ratio5Allnan);
    shading interp
    colorbar
    title('5nan')
    saveas(nan5,'5nan.fig');

    n5=figure
    surf(AutoPitch,MainPoint0,Ratio5All);
    axis([min(AutoPitch) max(AutoPitch) min(MainPoint0) max(MainPoint0) min(min(Ratio5Allnan)) max(max(Ratio5Allnan))]);
    caxis([0 max(max(Ratio5Allnan))]);
    shading interp
    colorbar
    title('5')
    saveas(n3,'5.fig');
    
    
    ratio111=figure
    surf(AutoPitch,MainPoint0,Ratio111All);
    axis([min(AutoPitch) max(AutoPitch) min(MainPoint0) max(MainPoint0) 0 1]);
    caxis([0 1]);
    shading interp
    colorbar
    title('ratio111')
    saveas(ratio111,'ratio111.fig');
    
    ratio110=figure
    surf(AutoPitch,MainPoint0,Ratio110All);
    axis([min(AutoPitch) max(AutoPitch) min(MainPoint0) max(MainPoint0) 0 1]);
    caxis([0 1]);
    shading interp
    colorbar
    title('ratio110')
    saveas(ratio110,'ratio110.fig');
    
    ratio101=figure
    surf(AutoPitch,MainPoint0,Ratio101All);
    axis([min(AutoPitch) max(AutoPitch) min(MainPoint0) max(MainPoint0) 0 1]);
    caxis([0 1]);
    shading interp
    colorbar
    title('ratio101')
    saveas(ratio101,'ratio101.fig');
    
    ratio100=figure
    surf(AutoPitch,MainPoint0,Ratio100All);
    axis([min(AutoPitch) max(AutoPitch) min(MainPoint0) max(MainPoint0) 0 1]);
    caxis([0 1]);
    shading interp
    colorbar
    title('ratio100')
    saveas(ratio100,'ratio100.fig');
    
    ratio011=figure
    surf(AutoPitch,MainPoint0,Ratio011All);
    axis([min(AutoPitch) max(AutoPitch) min(MainPoint0) max(MainPoint0) 0 1]);
    caxis([0 1]);
    shading interp
    colorbar
    title('ratio011')
    saveas(ratio011,'ratio011.fig');
    
    ratio010=figure
    surf(AutoPitch,MainPoint0,Ratio010All);
    axis([min(AutoPitch) max(AutoPitch) min(MainPoint0) max(MainPoint0) 0 1]);
    caxis([0 1]);
    shading interp
    colorbar
    title('ratio010')
    saveas(ratio010,'ratio010.fig');
    
    ratio001=figure
    surf(AutoPitch,MainPoint0,Ratio001All);
    axis([min(AutoPitch) max(AutoPitch) min(MainPoint0) max(MainPoint0) 0 1]);
    caxis([0 1]);
    shading interp
    colorbar
    title('ratio001')
    saveas(ratio001,'ratio001.fig');
    
    ratio000=figure
    surf(AutoPitch,MainPoint0,Ratio000All);
    axis([min(AutoPitch) max(AutoPitch) min(MainPoint0) max(MainPoint0) 0 1]);
    caxis([0 1]);
    shading interp
    colorbar
    title('ratio000')
    saveas(ratio000,'ratio000.fig');
    
    
    
    
        
    Eratio111=figure
    surf(AutoPitch,MainPoint0,ERatio111All);
    axis([min(AutoPitch) max(AutoPitch) min(MainPoint0) max(MainPoint0) 0 1]);
    caxis([0 1]);
    shading interp
    colorbar
    title('Eratio111')
    saveas(ratio111,'Eratio111.fig');
    
    Eratio110=figure
    surf(AutoPitch,MainPoint0,ERatio110All);
    axis([min(AutoPitch) max(AutoPitch) min(MainPoint0) max(MainPoint0) 0 1]);
    caxis([0 1]);
    shading interp
    colorbar
    title('Eratio110')
    saveas(ratio110,'Eratio110.fig');
    
    Eratio101=figure
    surf(AutoPitch,MainPoint0,ERatio101All);
    axis([min(AutoPitch) max(AutoPitch) min(MainPoint0) max(MainPoint0) 0 1]);
    caxis([0 1]);
    shading interp
    colorbar
    title('Eratio101')
    saveas(ratio101,'Eratio101.fig');
    
    Eratio100=figure
    surf(AutoPitch,MainPoint0,ERatio100All);
    axis([min(AutoPitch) max(AutoPitch) min(MainPoint0) max(MainPoint0) 0 1]);
    caxis([0 1]);
    shading interp
    colorbar
    title('Eratio100')
    saveas(ratio100,'Eratio100.fig');
    
    Eratio011=figure
    surf(AutoPitch,MainPoint0,ERatio011All);
    axis([min(AutoPitch) max(AutoPitch) min(MainPoint0) max(MainPoint0) 0 1]);
    caxis([0 1]);
    shading interp
    colorbar
    title('Eratio011')
    saveas(ratio011,'Eratio011.fig');
    
    Eratio010=figure
    surf(AutoPitch,MainPoint0,ERatio010All);
    axis([min(AutoPitch) max(AutoPitch) min(MainPoint0) max(MainPoint0) 0 1]);
    caxis([0 1]);
    shading interp
    colorbar
    title('Eratio010')
    saveas(ratio010,'Eratio010.fig');
    
    Eratio001=figure
    surf(AutoPitch,MainPoint0,ERatio001All);
    axis([min(AutoPitch) max(AutoPitch) min(MainPoint0) max(MainPoint0) 0 1]);
    caxis([0 1]);
    shading interp
    colorbar
    title('Eratio001')
    saveas(ratio001,'Eratio001.fig');
    
    Eratio000=figure
    surf(AutoPitch,MainPoint0,ERatio000All);
    axis([min(AutoPitch) max(AutoPitch) min(MainPoint0) max(MainPoint0) 0 1]);
    caxis([0 1]);
    shading interp
    colorbar
    title('Eratio000')
    saveas(ratio000,'Eratio000.fig');

end

if isempty(AC)
    AC=1;
end

Repeat(AC).name=T;
Repeat(AC).MainPoint=MainPoint;
Repeat(AC).Pitch=AutoPitch;
Repeat(AC).SE=SE_ADD;
Repeat(AC).EventNum=Event_ADD;
Repeat(AC).Ratio3nan=Ratio3Allnan;
Repeat(AC).Ratio3=Ratio3All;
Repeat(AC).Ratio5nan=Ratio5Allnan;
Repeat(AC).Ratio5=Ratio5All;
Repeat(AC).Ratio111=Ratio111All
Repeat(AC).Ratio110=Ratio110All
Repeat(AC).Ratio101=Ratio101All
Repeat(AC).Ratio100=Ratio100All
Repeat(AC).Ratio011=Ratio011All
Repeat(AC).Ratio010=Ratio010All
Repeat(AC).Ratio001=Ratio001All
Repeat(AC).Ratio000=Ratio000All
% Repeat(AC).spike=SpikeCount;
% Repeat(AC).Event1=Event1;
% Repeat(AC).Event2=Event2;
% Repeat(AC).Event3=Event3;
% Repeat(AC).Event4=Event4;
% Repeat(AC).Event5=Event5;

% assignin('base','Repeat',Repeat);


% --- Executes on button press in pushbutton_MainCenterCalc.
function pushbutton_MainCenterCalc_Callback(hObject, eventdata, handles)
%MainPointだけ手動で決めてPitch（インターバル）を振る。
global Pitch MainPointX AutoCorrValue SE lengthEvent T

if AutoCorrValue==10%AutoCorrValue==10はDrinkOff
    AutoPitch=[60,80,100,120,140,160,180,200,240,260,280];%,250,300,350,400,450,500,550,600,650,700,750,800];
else
%     AutoPitch=[600,625,650,675,700,725,750,775,800];
    AutoPitch=[300,325,350,375,400,425,450,475,500,525,550,575,600,625,650,675,700,725,750,775,800];
end

SEadd=[];lengthEventAdd=[];
for n=1:length(AutoPitch)
    Pitch=AutoPitch(n)

    pushbutton_WindowSetA_Callback(hObject, eventdata, handles);
    pushbutton_Calc_Callback(hObject, eventdata, handles);

    SEadd=[SEadd;SE];
    lengthEventAdd=[lengthEventAdd;lengthEvent];

end
SEadd
Ratio5=[];
for n=1:length(SEadd(:,1))
    if SEadd(n,3)~=0
        Ratio5(n)=SEadd(n,13)/SEadd(n,17);
    else
        Ratio5(n)=0;
    end

end
figure
plot(AutoPitch,Ratio5);


% --- Executes on button press in pushbutton_CalcAll.
function pushbutton_CalcAll_Callback(hObject, eventdata, handles)

global Pitch MainPointX AutoCorrValue SE lengthEvent T autoy CCresult AutoCal Repeat...
    SpikeCount EventCount1 EventCount2 EventCount3 EventCount4 EventCount5 AC...
    filename_spike fname Sname DrName ControlSp MainPoint AutoPitch

% clearvars -except SpikeArray SpikeArray1 SpikeArray2 SpikeArray3 SpikeArray4 SpikeArray5 RpegTimeArray LpegTimeArray RPegTouchAll LPegTouchAll DrinkOffArray...
%     handles hObject fname filename_spike Sname DrName eventdata TurnMarkerTime ControlSp AC Repeat

set(handles.popupmenu_CrossCorr,'Value',4);%BaseをSpikeに設定
pushbutton_CrossCorr_Callback(hObject, eventdata, handles);

ControlSp=get(handles.radiobutton_ControlSpike,'Value');%Spike列のControl（同一発火頻度）を作成して有意検定を行う場合１。

cd('C:\Documents and Settings\永田雅俊\デスクトップ\WR LVdata\MatFig')
dname=filename_spike(length(filename_spike)-10:length(filename_spike)-2);
dpath=char(strcat({DrName},{' '},{dname}));
mkdir(dpath);
cd(dpath);

% % 複数のCCで自動に行う場合。for loopを脱コメントする。
% ACvalue=[3,4,5,6,7,8,10];
% % 3-8はRpeg,Lpeg,RLpeg,Rtouch,Ltouch,RLtouch,10はDrinkOff
% for AC=4%1:7
%     set(handles.popupmenu_AutoCorr,'Value',ACvalue(AC));
% %%%%%%%%%%%%1回コントロールをとるときのセット1---------------
if ControlSp==1    
    for AC=1:1
    pushbutton_AutoCalc_Callback(hObject, eventdata, handles);
    % MainPoint、Pitchともに振る。
    end
    ControlSp=0;
    AC=2;%AC=11;%%%%%%%%%%%%%%%%%
    pushbutton_AutoCalc_Callback(hObject, eventdata, handles);
else
    pushbutton_AutoCalc_Callback(hObject, eventdata, handles);
end
% %%%%%%%%%%%%1回コントロールをとるときのセット1---------------

% % %%%%%%%%%%%%10回コントロールをとるときのセット1---------------
% if ControlSp==1
%     for AC=1:10
%     pushbutton_AutoCalc_Callback(hObject, eventdata, handles);
%     % MainPoint、Pitchともに振る。
%     end
%     ControlSp=0;
%     AC=11;%AC=11;%%%%%%%%%%%%%%%%%
%     pushbutton_AutoCalc_Callback(hObject, eventdata, handles);
% else
%     pushbutton_AutoCalc_Callback(hObject, eventdata, handles);
% end
% % %%%%%%%%%%%%10回コントロールをとるときのセット1---------------

pushbutton_save_Callback(hObject, eventdata, handles);

ControlSp=get(handles.radiobutton_ControlSpike,'Value');%Spike列のControl（同一発火頻度）を作成して有意検定を行う場合１。
if ControlSp==1

% %あとでワークスペースからRepeatを読み込んで処理する場合に必要
% MainPoint=-500:25:500;
% AutoPitch=[300,325,350,375,400,425,450,475,500,525,550,575,600,625,650,675,700,725,750,775,800,825,850,875,900];
% 
% %%%%%%%%%%%%1回コントロールをとるときのセット---------------
% % Repeat=Repeat3_1_Rtouch;
SigniMat=zeros(length(MainPoint),length(AutoPitch));
ContMat=Repeat(1).Ratio3nan;
DataMat=Repeat(2).Ratio3nan;

for m=1:length(AutoPitch)
%     for n=1:length(MainPoint)
%         for l=1:10
            
            A=ContMat(:,m);
%         end
%         ContMean(n,m)=mean(A);
%         ContSD(n,m)=std(A);
% A
% Mean=[Mean mean(A)];
% Std=[Std std(A)];
        for n=1:length(MainPoint)
            if DataMat(n,m)>mean(A)+std(A)*4;SigniMat(n,m)=1;
            elseif DataMat(n,m)<mean(A)-std(A)*4;SigniMat(n,m)=-1;
        end
    end
end
SDx1=figure
surf(AutoPitch,MainPoint,SigniMat);
shading interp
saveas(SDx1,'4SDx1.fig');
%%%%%%%%%%%%1回コントロールをとるときのセット---------------

% %%%%%%%%%%%%10回コントロールをとるときのセット---------------
% SigniMat=zeros(length(MainPoint),length(AutoPitch));
% DataMat=Repeat(11).Ratio3nan;
% for n=1:length(MainPoint)
%     for m=1:length(AutoPitch)
%         for l=1:10
%             ContMat=Repeat(l).Ratio3nan;
%             A(l)=ContMat(n,m);
%         end
%         ContMean(n,m)=mean(A);
%         ContSD(n,m)=std(A);
%         
%         if DataMat(n,m)>mean(A)+std(A)*4;SigniMat(n,m)=1;
%         elseif DataMat(n,m)<mean(A)-std(A)*4;SigniMat(n,m)=-1;
%         end
%     end
% end
% figure
% surf(AutoPitch,MainPoint,SigniMat);
% shading interp
% %%%%%%%%%%%%10回コントロールをとるときのセット---------------
end

cd('C:\Documents and Settings\永田雅俊\デスクトップ\WR LVdata\MatFig')
FLName=char(strcat({filename_spike(end-2)},{' '},{filename_spike(end-8)},{' '},{T},{'.mat'}));
Sname=[T '.mat']
feval('save',FLName);%すべてのデータをmat形式で保存

    clearvars Pitch MainPointX AutoCorrValue SE lengthEvent T autoy CCresult AutoCal...
    SpikeCount EventCount1 EventCount2 EventCount3 EventCount4 EventCount5
%     SE12 SE23 SE34 SE45 SE123 SE234 SE345 SE12345 SE24inv3 SE1245inv3...
%     E12 E23 E34 E45 E123 E234 E345 E12345%-except ACvalue AC Repeat SpikeArray handles.popupmenu_AutoCorr handles.popupmenu_CrossCorr...
        
%     pushbutton_save_Callback(hObject, eventdata, handles);

% end


% --- Executes on button press in radiobutton_ControlSpike.
function radiobutton_ControlSpike_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton_ControlSpike (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton_ControlSpike



% --- Executes on button press in radiobutton_FixWindowWidth.
function radiobutton_FixWindowWidth_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton_FixWindowWidth (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton_FixWindowWidth


% --- Executes on selection change in popupmenu_SpikeBin.
function popupmenu_SpikeBin_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu_SpikeBin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% ヒント: contents = cellstr(get(hObject,'String')) はセル配列として popupmenu_SpikeBin の内容を返します。
%        contents{get(hObject,'Value')} は popupmenu_SpikeBin から選択した項目を返します。


% --- Executes during object creation, after setting all properties.
function popupmenu_SpikeBin_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu_SpikeBin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu_FixWindowWidth.
function popupmenu_FixWindowWidth_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu_FixWindowWidth (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% ヒント: contents = cellstr(get(hObject,'String')) はセル配列として popupmenu_FixWindowWidth の内容を返します。
%        contents{get(hObject,'Value')} は popupmenu_FixWindowWidth から選択した項目を返します。


% --- Executes during object creation, after setting all properties.
function popupmenu_FixWindowWidth_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu_FixWindowWidth (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu_MovWindow.
function popupmenu_MovWindow_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu_MovWindow (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% ヒント: contents = cellstr(get(hObject,'String')) はセル配列として popupmenu_MovWindow の内容を返します。
%        contents{get(hObject,'Value')} は popupmenu_MovWindow から選択した項目を返します。


% --- Executes during object creation, after setting all properties.
function popupmenu_MovWindow_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu_MovWindow (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



% --- Executes on button press in StartStop.
function StartStop_Callback(hObject, eventdata, handles)
global event_name event_ts SpikeStartTime SpikeStopTime ts_spike
% hObject    handle to StartStop (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
format long;
Time1=[];Time2=[];a=1;
for n=1:length(event_name)-1
    if event_name(n)==2&&event_name(n+1)==3
        T1=event_ts(n);T2=event_ts(n+1);
        Time1=[Time1,T1];Time2=[Time2,T2];
        a=a+1;
    end
end
delStartStop=Time2-Time1
Time1=num2str(Time1,9)
Time2=num2str(Time2,9)

SpikeStartTime=input('Enter Time1:')
SpikeStopTime=input('Enter Time2:')
class(SpikeStartTime)
set(handles.text_SpikeStartTime,'String',SpikeStartTime);
set(handles.text_SpikeStopTime,'String',SpikeStopTime);

WheelAnalyzer;


% --- Executes on button press in pushbutton_SelectCSC.
function pushbutton_SelectCSC_Callback(hObject, eventdata, handles)
global fname dpath DrName LFPsamples1 Timestamp fnamemat
cd 'C:\Documents and Settings\永田雅俊\デスクトップ\WR LVdata\CSCmat';
[fnamemat,dpathmat] = uigetfile('*.mat');
cd(dpathmat)
fnamemat
load(fnamemat);
LFPsamples1=Samples;
set(handles.text_cscfile,'String',fnamemat);


% --- Executes on button press in pushbutton_SelectCSCref.
function pushbutton_SelectCSCref_Callback(hObject, eventdata, handles)
global LFPsamples_Ref
[fnamemat,dpathmat] = uigetfile('*.mat');
fnamemat
cd(dpathmat)
load(fnamemat,'Samples')
LFPsamples_Ref=Samples;
set(handles.text_cscref,'String',fnamemat);

% --- Executes on button press in pushbutton_LFPAnalysis.
function pushbutton_LFPAnalysis_Callback(hObject, eventdata, handles)
global fname dpath DrName SpikeStartTime SpikeStopTime StartTime FinishTime...
    TurnMarkerTime OneTurnTime Timestamp TimestampArray ...
    LFPsamples1 LFPsamples_Ref LFPsamples_Run AllTurnLFP ValidTurn LFPRef

AllTimestamp=[];
TimestampArray=[];

for n=1:length(Timestamp)
    m=0:511;
    AllTimestamp=[AllTimestamp,Timestamp(n)+528*m];
end
AllTimestampLength=length(AllTimestamp);

LFPRef=get(handles.text_cscref,'String');
if isnan(LFPRef)==0
    LFPsamples=LFPsamples1-LFPsamples_Ref;
else LFPsamples=LFPsamples1;
end

% SpikeStartTime(LabViewのStartボタンが押された時のNeurarynxの時間）と
% StartTime(LabView開始からStartボタンが押されるまでの時間)をそろえる必要がある。
% なのでTimestampからSpikeStartTimeを引いてStartTimeを加える。
% LFPは528μsecごとに記録されており、時間単位をマイクロ秒に揃えてで計算しないとずれが生じる。

% disp('LFPTimestamp(1:10)=');disp(AllTimestamp(1:10));

T=AllTimestamp-SpikeStartTime*10^6+StartTime*1000;
TimestampArray=T(StartTime*1000<T&T<FinishTime*1000);

BeforeRec=length(AllTimestamp(SpikeStartTime*10^6>=AllTimestamp));
AfterRec=length(AllTimestamp(SpikeStopTime*10^6<=AllTimestamp));
RecLength=length(AllTimestamp(SpikeStartTime*10^6<AllTimestamp&SpikeStopTime*10^6>AllTimestamp));
TimestampArayLength=length(TimestampArray)

LFPsamples_Run=LFPsamples(BeforeRec+1:BeforeRec+RecLength);
LFPsample_length=length(LFPsamples_Run)

format short;
%   StartTimeからFinishTimeまでのLFPとTimestampは
%   LFPsamples_Run、TimestampArray


% --- Executes on selection change in popupmenu_DFTsize.
function popupmenu_DFTsize_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu_DFTsize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% ヒント: contents = cellstr(get(hObject,'String')) はセル配列として popupmenu_DFTsize の内容を返します。
%        contents{get(hObject,'Value')} は popupmenu_DFTsize から選択した項目を返します。


% --- Executes during object creation, after setting all properties.
function popupmenu_DFTsize_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu_DFTsize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_FourierAnalysis.
function pushbutton_FourierAnalysis_Callback(hObject, eventdata, handles)
global fname dpath DrName TurnMarkerTime OneTurnTime TimestampArray...
    LFPsamples_Run AllTurnLFP AllTurnLFPplus fs ValidTurn
%  振幅スペクトルとパワースペクトルの範囲を変更するには、dft_sizeの範囲を変える
%  spectrogramの範囲を変更するには、window_size、shift_sizeの範囲を変える

fs=10^6/528;
contents = cellstr(get(handles.popupmenu_DFTsize,'String')); 
dft_size=str2double(contents{get(handles.popupmenu_DFTsize,'Value')});
contents = cellstr(get(handles.popupmenu_Windowsize,'String')); 
window_size=str2double(contents{get(handles.popupmenu_Windowsize,'Value')});
contents = cellstr(get(handles.popupmenu_Shiftsize,'String')); 
shift_size=str2double(contents{get(handles.popupmenu_Shiftsize,'Value')});

Turnframe=floor(OneTurnTime/(shift_size*0.528))+window_size/shift_size-1;


% 有効なTurnMarkerTimeからOneTurnTimeまでの区間のLFPを抽出
ValidTurn=[];   
AllTurnLFP=[];
AllTurnLFPplus=[];
for n=1:length(TurnMarkerTime)-1
    if TurnMarkerTime(n+1)-TurnMarkerTime(n)<OneTurnTime*1.05
        ValidTurn=[ValidTurn n];
        Index=find(TimestampArray==min(TimestampArray(TimestampArray>TurnMarkerTime(n).*1000)));
        L=LFPsamples_Run(Index:Index+floor(OneTurnTime/0.528)-1);
        LL=LFPsamples_Run(Index:Index+floor(OneTurnTime/0.528)-1+window_size);
        AllTurnLFP(length(ValidTurn),:)=L;   % TurnMarkerTimeからOneTurnTimeまでのLFPsamples
        AllTurnLFPplus(length(ValidTurn),:)=LL;   % TurnMarkerTimeからOneTurnTime+window_sizeまでのLFPsamples
    end
    
end

A=zeros(1,dft_size/2+1);
P=zeros(1,dft_size/2+1);
frequency=zeros(1,dft_size/2+1);

% 走行始め・中盤・終盤3点の振幅スペクトルとパワースペクトルの表示
st=1:length(ValidTurn)/2-1:length(ValidTurn);
st=floor(st);
for n=1:length(st)
    Y=fft(AllTurnLFP((st(n)),:),dft_size);
    k=1:dft_size/2+1;
    A(k)=abs(Y(k));
    P(k)=abs(Y(k)).^2;
    frequency(k)=(k-1)*fs/dft_size;
    figure
    subplot(2,1,1)
    plot(frequency,A)
    axis([0 50 0 max(A)*1.1])
    subplot(2,1,2)
    plot(frequency,P)
    axis([0 50 0 max(P)*1.1])
end

% x=AllTurnLFP(st(1));
% [Pxx,Pxxc,f] = pmtm(x,4,dft_size,fs);
% hpsd = dspdata.psd([Pxx Pxxc],'Fs',fs);
% figure;plot(hpsd)

% 全有効Turnのdft_sizeにおける平均振幅スペクトル、平均パワースペクトル
MeanSpectrum=get(handles.radiobutton_MeanSpectrum,'Value');
if MeanSpectrum==1
    for x=1:length(ValidTurn)
       X=fft(AllTurnLFP(x,:),dft_size);
       k=1:dft_size/2+1;
       A(k)=abs(X(k));
       P(k)=(abs(X(k))).^2;
       An(x,:)=A(k);
       Pn(x,:)=P(k);
       frequency(k)=(k-1)*fs/dft_size;
    end
       
   figure
   subplot(2,1,1)
   plot(frequency,mean(An))
   axis([0 50 0 max(mean(An))*1.1])
   subplot(2,1,2)
   plot(frequency,mean(Pn))
   axis([0 50 0 max(mean(Pn))*1.1])
end



% --- Executes on button press in pushbutton_Spectrogram.
function pushbutton_Spectrogram_Callback(hObject, eventdata, handles)
global fname dpath DrName SpikeStartTime SpikeStopTime StartTime FinishTime...
    TurnMarkerTime OneTurnTime Timestamp Samples RPegTouchAll ts_spike...
    LFPSamples AllTurnLFP AllTurnLFPplus fs ValidTurn event_name event_ts fnamemat

fnamemat
contents = cellstr(get(handles.popupmenu_Windowsize,'String')); 
window_size=str2double(contents{get(handles.popupmenu_Windowsize,'Value')});
contents = cellstr(get(handles.popupmenu_Shiftsize,'String')); 
shift_size=str2double(contents{get(handles.popupmenu_Shiftsize,'Value')});
Turnframe=floor(OneTurnTime/(shift_size*0.528))+window_size/shift_size-1;
WinFunction = get(handles.popupmenu_WindowFunction,'Value'); % 窓関数
if WinFunction==1
    w=HanningWindow_(window_size);
% elseif WinFunction==2
%     w=HammingWindow_(window_size);
% elseif WinFunction==3
%     w=Multitaper;
end
    
% shift_sizeごとにfftを実行。
c=nan(window_size/2+1,floor((length(AllTurnLFPplus)-window_size)/shift_size+1),length(AllTurnLFPplus(:,1)));
for n=1:length(AllTurnLFPplus(:,1))
    s=AllTurnLFPplus(n,:);
    [Ps,time,frequency]=Spectrogram_(s,fs,window_size,shift_size,w);
    c(:,:,n)=Ps;
end
% 走行始め・中盤・終盤3点のspectrogramの表示
st=1:length(ValidTurn)/2-1:length(ValidTurn);
st=floor(st);
for n=1:length(st)
    figure
    imagesc(time,frequency,c(:,:,st(n)));
    axis xy
    ylim([0 10])
    colorbar
end
    
% 平均spectrogram
% 各有効なTurnMarkerTime数分のパワースペクトルを平均する。
MeanSpectrogram=get(handles.radiobutton_MeanSpectrogram,'Value');
if MeanSpectrogram==1
    
   AvePs=mean(c,3);
   figure
% Clim=([0 10^10])
   imagesc(time,frequency,AvePs);
   axis xy
   ylim([0 10])
   colorbar
   cscfile=get(handles.text_cscfile,'String');
   cscref=get(handles.text_cscfile,'String');
   Title=(char(strcat({'Spectrogram'},{' '},{strrep(cscfile,'.mat','')})));
   title(Title);
   saveas(gca,Title,'bmp')
end

% --- Executes on selection change in popupmenu_WindowFunction.
function popupmenu_WindowFunction_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu_WindowFunction (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% ヒント: contents = cellstr(get(hObject,'String')) はセル配列として popupmenu_WindowFunction の内容を返します。
%        contents{get(hObject,'Value')} は popupmenu_WindowFunction から選択した項目を返します。


% --- Executes during object creation, after setting all properties.
function popupmenu_WindowFunction_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu_WindowFunction (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu_Windowsize.
function popupmenu_Windowsize_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu_Windowsize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% ヒント: contents = cellstr(get(hObject,'String')) はセル配列として popupmenu_Windowsize の内容を返します。
%        contents{get(hObject,'Value')} は popupmenu_Windowsize から選択した項目を返します。


% --- Executes during object creation, after setting all properties.
function popupmenu_Windowsize_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu_Windowsize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu_Shiftsize.
function popupmenu_Shiftsize_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu_Shiftsize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% ヒント: contents = cellstr(get(hObject,'String')) はセル配列として popupmenu_Shiftsize の内容を返します。
%        contents{get(hObject,'Value')} は popupmenu_Shiftsize から選択した項目を返します。


% --- Executes during object creation, after setting all properties.
function popupmenu_Shiftsize_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu_Shiftsize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in radiobutton_MeanSpectrum.
function radiobutton_MeanSpectrum_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton_MeanSpectrum (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton_MeanSpectrum


% --- Executes on button press in radiobutton_MeanSpectrogram.
function radiobutton_MeanSpectrogram_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton_MeanSpectrogram (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



% --- Executes on button press in pushbutton_LFPalign.
function pushbutton_LFPalign_Callback(hObject, eventdata, handles)
global fname dpath DrName SpikeStartTime SpikeStopTime StartTime FinishTime TimestampArray...
    TurnMarkerTime OneTurnTime ts_spike LFPsamples_Run AllTurnLFP ValidTurn event_name event_ts fnamemat...
    RpegTimeArray LpegTimeArray RLpegTimeArray SpikeArray1 SpikeArray2 SpikeArray3 SpikeArray4 SpikeArray5...
    RLPegTouchAll RPegTouchAll LPegTouchAll WaterOnArrayOriginal WaterOffArrayOriginal ACselect CCselect CCselect2 CCselect3...
    T DrinkOnArray DrinkOffArray FloorTouchArray FloorDetachArray MedPegTimeR MedPegTimeL AutoCorrValue CCresult LFPRef...

% AutoCorrValue=get(handles.popupmenu_AutoCorr,'Value');
% if AutoCorrValue==1;ACselect=[];T=' ';
% elseif (AutoCorrValue==15)ACselect=LFPsamples_Run';T='Crosscorr LFP';
% end

CrossCorrValue=get(handles.popupmenu_CrossCorr,'Value');
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

Align_Base=CCselect;
% Spike_Array=(ts_spike-SpikeStartTime)*1000+StartTime;
% Spike_Array=Spike_Array(StartTime<Spike_Array&Spike_Array<FinishTime);
% Align_Base=Spike_Array;T='Spike_Array';
% LFP_aligned=zeros(length(Align_Base)-1,ceil((OneTurnTime*1000/2)/528)*2+1);d
AlignmentLength=length(Align_Base)
format short;
ValidIndex=[];
Direction=get(handles.radiobutton_direction,'Value');%Directionは両方向か片方向か
duration=(OneTurnTime*1000)/528;
LFP_aligned=[];
if Direction==1 %片方向
    for n=1:length(Align_Base)
%        A=min(TimestampArray(TimestampArray>Align_Base(n).*1000));
       Index=find(TimestampArray==min(TimestampArray(TimestampArray>Align_Base(n).*1000)));
       if Index>0&&Index+ceil(duration)<length(LFPsamples_Run)
          ValidIndex=[ValidIndex n];
%           x=LFPsamples_Run(Index-ceil((OneTurnTime*1000/2)/528):Index+ceil((OneTurnTime*1000/2)/528));
          LFP_aligned(length(ValidIndex),:)=LFPsamples_Run(Index:Index+ceil(duration));
       end
    end
else
    for n=1:length(Align_Base)
%        A=min(TimestampArray(TimestampArray>Align_Base(n).*1000));
       Index=find(TimestampArray==min(TimestampArray(TimestampArray>Align_Base(n).*1000)));
       if Index-ceil(duration/2)>0&&Index+ceil(duration/2)<length(LFPsamples_Run)
          ValidIndex=[ValidIndex n];
%           x=LFPsamples_Run(Index-ceil((OneTurnTime*1000/2)/528):Index+ceil((OneTurnTime*1000/2)/528));
          LFP_aligned(length(ValidIndex),:)=LFPsamples_Run(Index-ceil(duration/2):Index+ceil(duration/2));
       end
    end
end
LFParray=mean(LFP_aligned,1);

contents_MovWindow = cellstr(get(handles.popupmenu_MovWindow,'String'));
MovW=str2num(contents_MovWindow{get(handles.popupmenu_MovWindow,'Value')});

GaussSmooth=get(handles.radiobutton_Gauss,'Value');

if MovW~=0;LFParray=MovWindow(LFParray,MovW);
elseif GaussSmooth==1;LFParray=instantArray(LFParray,20);
end

if isnan(LFPRef)==0
    Rname=['-',LFPRef(length(LFPRef)-10:length(LFPRef)-4)];
else Rname=nan;
end

figure
plot(LFParray)
axis([0 ceil(duration) min(mean(LFP_aligned)) max(mean(LFP_aligned))])
if Direction==1
    set(gca,'xtick',0:ceil(duration)/8:ceil(duration)+1,'xticklabel',0:round(OneTurnTime*0.1/8)*10:round(OneTurnTime*0.1/8)*80)
else
    set(gca,'xtick',0:ceil(duration)/8:ceil(duration)+1,'xticklabel',-round(OneTurnTime*0.1/8)*40:round(OneTurnTime*0.1/8)*10:round(OneTurnTime*0.1/8)*40)
end
Title=char(strcat({'LFP '},{S},{' '},{strrep(fnamemat,'.mat',' ')},{Rname}));
% disp(Title);
title(Title);
saveas(gca,Title,'bmp')






% --- Executes on mouse press over axes background.
function axes1_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to axes1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)






function pushbutton_PhaseRaster_Callback(hObject, eventdata, handles)
global  RpegTouchCell LpegTouchCell TurnMarkerTime OneTurnTime LRLphase RLRphase LRLbefore RLRbefore IntervalR IntervalL...
        RatioAlikeLRL RatioAlikeRLR RatioBlikeLRL RatioBlikeRLR DrName FigureSave fig_LRLphase fig_RLRphase fig_Phasehist DrName...
        Interval_RL Interval_LR Rafter LTouchAll RTouchAll
DrName
MP=0;
if ~isempty(LTouchAll) && ~isempty(RTouchAll)
    MP=1;
else
RpegTouchArray=[RpegTouchCell{1};RpegTouchCell{2};RpegTouchCell{3};RpegTouchCell{4};RpegTouchCell{5};RpegTouchCell{6};...
    RpegTouchCell{7};RpegTouchCell{8};RpegTouchCell{9};RpegTouchCell{10};RpegTouchCell{11};RpegTouchCell{12}];
RpegTouchArray=sort(RpegTouchArray);


LpegTouchArray=[LpegTouchCell{1};LpegTouchCell{2};LpegTouchCell{3};LpegTouchCell{4};LpegTouchCell{5};LpegTouchCell{6};...
    LpegTouchCell{7};LpegTouchCell{8};LpegTouchCell{9};LpegTouchCell{10};LpegTouchCell{11};LpegTouchCell{12}];
LpegTouchArray=sort(LpegTouchArray);

end

if MP==1
    LpegTouchArray=LTouchAll;
    RpegTouchArray=RTouchAll;
end

RpegTouchArray(RpegTouchArray<TurnMarkerTime(1))=[];
RpegTouchArray(RpegTouchArray>TurnMarkerTime(end))=[];
LpegTouchArray(LpegTouchArray<TurnMarkerTime(1))=[];
LpegTouchArray(LpegTouchArray>TurnMarkerTime(end))=[];
for n=1:length(TurnMarkerTime)-1
    if TurnMarkerTime(n+1)-TurnMarkerTime(n)>OneTurnTime
        RpegTouchArray(RpegTouchArray>TurnMarkerTime(n)+OneTurnTime&RpegTouchArray<TurnMarkerTime(n+1))=[];
        LpegTouchArray(LpegTouchArray>TurnMarkerTime(n)+OneTurnTime&LpegTouchArray<TurnMarkerTime(n+1))=[];
    end
end

LRLphase=[];
LRLTouchArray=[];
RTrialTurn=[];
TurnTime=median(diff(TurnMarkerTime))*1.1;
LRLTurnArray=[];
LRLbefore=[];LRLafter=[];
RLRbefore=[];RLRafter=[];
% LRLphaseの計算
% LRLTouchArrayはLRLphaseのときのRpegTouchのTime
% LRLTurnはLRLTouchに一番近いTurnMarkerTime
for n=1:length(RpegTouchArray)
    Lbefore=max(LpegTouchArray(LpegTouchArray<RpegTouchArray(n) & RpegTouchArray(n)-800<LpegTouchArray));
    Lafter=min(LpegTouchArray(RpegTouchArray(n)<=LpegTouchArray & LpegTouchArray<RpegTouchArray(n)+800));
    
    
    if ~isempty(Lbefore) && ~isempty(Lafter) && Lafter-Lbefore<1000
        
        LRL=(RpegTouchArray(n)-Lbefore)/(Lafter-Lbefore);
        LRLbefore=[LRLbefore Lbefore]; 
        LRLafter=[LRLafter Lafter]; 
        LRLphase=[LRLphase LRL];
        LRLTouchArray=[LRLTouchArray RpegTouchArray(n)];
        LRLTurn=max(TurnMarkerTime(TurnMarkerTime<RpegTouchArray(n)));
        LRLTurnArray=[LRLTurnArray LRLTurn];
        IntervalR=LRLTouchArray-LRLbefore;
        Interval_RL=LRLafter-LRLTouchArray;
    end
    
end


% LRLTurnArrayがTurnMarkerTimeでの何ターン目のトライアルにあたるか
% これをRTrialTurnとして、ラスターの縦軸にする
n=1;
for x=1:length(LRLTurnArray)
    
      if LRLTurnArray(x)==TurnMarkerTime(n)
          RTrialTurn=[RTrialTurn n];
      else n=n+1;
          switch LRLTurnArray(x)
              case TurnMarkerTime(n)
                   RTrialTurn=[RTrialTurn n];
              case TurnMarkerTime(n+1)
                   RTrialTurn=[RTrialTurn n+1];
                   n=n+1;
              case TurnMarkerTime(n+2)
                   RTrialTurn=[RTrialTurn n+2];
                   n=n+2;
              case TurnMarkerTime(n+3)
                   RTrialTurn=[RTrialTurn n+3];
                   n=n+3;
              case TurnMarkerTime(n+4)
                   RTrialTurn=[RTrialTurn n+4];
                   n=n+4;
              case TurnMarkerTime(n+5)
                   RTrialTurn=[RTrialTurn n+5];
                   n=n+5;
              case TurnMarkerTime(n+6)
                   RTrialTurn=[RTrialTurn n+6];
                   n=n+6;
              case TurnMarkerTime(n+7)
                   RTrialTurn=[RTrialTurn n+7];
                   n=n+7;
              case TurnMarkerTime(n+8)
                   RTrialTurn=[RTrialTurn n+8];
                   n=n+8;
          end
      end
end

RPhaseIndex=[];
RPhaseIndex=LRLTouchArray-LRLTurnArray;   % 各TurnMarkerTimeからRTouchまでの時間(横軸での位置)

SizeLRLTouchArray=size(LRLTouchArray)
SizeRTrialTurn=size(RTrialTurn)
SizeLRLphase=size(LRLphase)
SizeRPhaseIndex=size(RPhaseIndex)

if SizeRPhaseIndex==SizeRTrialTurn
bin = 50;
N_Trial = max(RTrialTurn(:));

xaxis = 0: bin: TurnTime;  %軸をつくる
raster = NaN([N_Trial length(xaxis)]); % ラスターの受け皿
X_index = ceil(RPhaseIndex / bin); % 時刻データをrasterの座標に変換
for n = 1:length(LRLphase);
   raster(RTrialTurn(n), X_index(n)) = LRLphase(n);
end

ShowFig=get(handles.radiobutton_ShowFigure,'Value');
if ShowFig==1
    fig_LRLphase=figure;hold on;
    im=imagesc(xaxis,1:N_Trial,raster);colormap(jet);
    axis xy
    set(gca,'Xlim',[-100 OneTurnTime*1.05]);
    colorbar
    caxis(gca,[0 1]);
    title('LRLPhaseRaster')

    del=~isnan(raster); 
    set(im,'alphadata',del) %NaNのところを透明にする。 
    set(gca,'color',[1 1 1]);hold off  %背景色の指定
end
if FigureSave==1;saveas(fig_LRLphase,[DrName,' ','LRLphase.bmp']);end
end
% RLRphaseの計算


RLRphase=[];
RLRdif=[];

RLRTouchArray=[];
LTrialTurn=[];
RLRTurnArray=[];

for n=1:length(LpegTouchArray)
    Rbefore=max(RpegTouchArray(RpegTouchArray<LpegTouchArray(n) & LpegTouchArray(n)-800<RpegTouchArray));
    Rafter=min(RpegTouchArray(LpegTouchArray(n)<=RpegTouchArray & RpegTouchArray<LpegTouchArray(n)+800));
    
    
    if ~isempty(Rbefore) && ~isempty(Rafter) && Rafter-Rbefore<1000
        
        RLR=(LpegTouchArray(n)-Rbefore)/(Rafter-Rbefore);
        RLRbefore=[RLRbefore Rbefore]; 
        RLRafter=[RLRafter Rafter]; 
        RLRphase=[RLRphase RLR];
        RLRTouchArray=[RLRTouchArray LpegTouchArray(n)];
        RLRTurn=max(TurnMarkerTime(TurnMarkerTime<LpegTouchArray(n)));
        RLRTurnArray=[RLRTurnArray RLRTurn];
        IntervalL=RLRTouchArray-RLRbefore;
        Interval_LR=RLRafter-RLRTouchArray;

    end
    
end

n=1;
for x=1:length(RLRTurnArray)
    
      if RLRTurnArray(x)==TurnMarkerTime(n)
          LTrialTurn=[LTrialTurn n];
      else n=n+1;
          switch RLRTurnArray(x)
              case TurnMarkerTime(n)
                   LTrialTurn=[LTrialTurn n];
              case TurnMarkerTime(n+1)
                   LTrialTurn=[LTrialTurn n+1];
                   n=n+1;
              case TurnMarkerTime(n+2)
                   LTrialTurn=[LTrialTurn n+2];
                   n=n+2;
              case TurnMarkerTime(n+3)
                   LTrialTurn=[LTrialTurn n+3];
                   n=n+3;
              case TurnMarkerTime(n+4)
                   LTrialTurn=[LTrialTurn n+4];
                   n=n+4;
              case TurnMarkerTime(n+5)
                   LTrialTurn=[LTrialTurn n+5];
                   n=n+5;
              case TurnMarkerTime(n+6)
                   LTrialTurn=[LTrialTurn n+6];
                   n=n+6;
              case TurnMarkerTime(n+7)
                   LTrialTurn=[LTrialTurn n+7];
                   n=n+7;
              case TurnMarkerTime(n+8)
                   LTrialTurn=[LTrialTurn n+8];
                   n=n+8;
          end
      end
end

LPhaseIndex=[];
LPhaseIndex=RLRTouchArray-RLRTurnArray;

SizeRLRTouchArray=size(RLRTouchArray)
SizeLTrialTurn=size(LTrialTurn)
SizeRLRphase=size(RLRphase)
SizeLPhaseIndex=size(LPhaseIndex)

if SizeLTrialTurn==SizeLPhaseIndex
bin = 50;
L_Trial = max(LTrialTurn(:));

xaxis = 0: bin: TurnTime;  %軸をつくる
raster = NaN([L_Trial length(xaxis)]); % ラスターの受け皿
X_index = ceil(LPhaseIndex / bin); % 時刻データをrasterの座標に変換
for n = 1:length(RLRphase);
   raster(LTrialTurn(n), X_index(n)) = RLRphase(n);
end

ShowFig=get(handles.radiobutton_ShowFigure,'Value');
if ShowFig==1
   fig_RLRphase=figure;hold on;
   im=imagesc(xaxis,1:L_Trial,raster);colormap(jet);
   axis xy
   set(gca,'Xlim',[-100 OneTurnTime*1.05]);
   colorbar
   caxis(gca,[0 1]);
   title('RLRPhaseRaster')

   del=~isnan(raster); 
   set(im,'alphadata',del) %NaNのところを透明にする。 
   set(gca,'color',[1 1 1]);hold off;  %背景色の指定
end
if FigureSave==1;saveas(fig_RLRphase,[DrName,' ','RLRphase.bmp']);end
   
if ShowFig==1
   fig_Phasehist=figure;hold on;
   subplot(2,1,1)
   hist(LRLphase,0:0.05:1)
   set(gca,'Xlim',[-0.05 1.05]);
   title('LRLphase');
   subplot(2,1,2)
   hist(RLRphase,0:0.05:1)
   set(gca,'Xlim',[-0.05 1.05]);
   title('RLRphase');hold off;
end
if FigureSave==1;saveas(fig_Phasehist,[DrName,' ','Phasehist.bmp']);end
end

   

AlikeLRL=length(LRLphase(LRLphase>=0.3&LRLphase<=0.7));
AlikeRLR=length(RLRphase(RLRphase>=0.3&RLRphase<=0.7));
BlikeLRL=length(LRLphase(LRLphase<=0.2|LRLphase>=0.8));
BlikeRLR=length(RLRphase(RLRphase<=0.2|RLRphase>=0.8));
RatioAlikeLRL=AlikeLRL/length(LRLphase)
RatioAlikeRLR=AlikeRLR/length(RLRphase)
RatioBlikeLRL=BlikeLRL/length(LRLphase)
RatioBlikeRLR=BlikeRLR/length(RLRphase)

% --- Executes on button press in pushbutton_IntervalHist.
function pushbutton_IntervalHist_Callback(hObject, eventdata, handles)
global IntervalR IntervalL Interval_RL Interval_LR RLpegTouchCell OneTurnTime LRLphase RLRphase...
     fig_Interval2 fig_interval fig_IntervalRL WaterOnArray WaterOffArray WaterN MeanWaterTime...
     StdLRLphase StdRLRphase StdLRLdiff StdRLRdiff StdIntervalRL StdRLTouchInterval 

ShowFig=get(handles.radiobutton_ShowFigure,'Value');
if ShowFig==1
   fig_interval=figure;
   subplot(2,1,1)
   hist(IntervalR,0:20:600)
   title('Lbefore to Rtouch');
   set(gca,'Xlim',[-20 620]);
   subplot(2,1,2)
   hist(IntervalL,0:20:600)
   title('Rbefore to Ltouch');xlabel('Interval')
   set(gca,'Xlim',[-20 620]);
   
   IntRL=[Interval_RL Interval_LR];
   IntervalRL=sort(IntRL);
   IntervalRL(IntervalRL<50 | IntervalRL>(OneTurnTime*1.6)/24)=[];   
   RLpegTouch=[RLpegTouchCell{:,1};RLpegTouchCell{:,2};RLpegTouchCell{:,3};RLpegTouchCell{:,4};RLpegTouchCell{:,5};RLpegTouchCell{:,6};...
       RLpegTouchCell{:,7}; RLpegTouchCell{:,8}; RLpegTouchCell{:,9}; RLpegTouchCell{:,10}; RLpegTouchCell{:,11}; RLpegTouchCell{:,12};...
       RLpegTouchCell{:,13}; RLpegTouchCell{:,14}; RLpegTouchCell{:,15}; RLpegTouchCell{:,16}; RLpegTouchCell{:,17}; RLpegTouchCell{:,18};...
       RLpegTouchCell{:,19}; RLpegTouchCell{:,20}; RLpegTouchCell{:,21}; RLpegTouchCell{:,22}; RLpegTouchCell{:,23}; RLpegTouchCell{:,24}]; 

   IntervalRLsize=size(IntervalRL)
   RLpegTouchsize=size(RLpegTouch)

   RLTouchArray=diff(sort(RLpegTouch));
   RLTouchArray(RLTouchArray<50 | RLTouchArray>(OneTurnTime*1.6)/24)=[];

   fig_IntervalRL=figure;
   hist(RLTouchArray,0:40:600);
   title('RLTouchInterval');
   set(gca,'Xlim',[-20 620]);


   fig_Interval2=figure;
   subplot(2,1,1)
   hist(Interval_RL,0:20:600)
   title('Rtouch to Lafter');
   set(gca,'Xlim',[-20 620]);
   subplot(2,1,2)
   hist(Interval_LR,0:20:600)
   title('Ltouch to Rafter');xlabel('Interval')
   set(gca,'Xlim',[-20 620]);

   
end
StdLRLphase=std(LRLphase)
StdRLRphase=std(RLRphase)
StdLRLdiff=std(diff(LRLphase))
StdRLRdiff=std(diff(RLRphase))
StdIntervalRL=std(IntervalRL)
StdRLTouchInterval=std(RLTouchArray)

for n=1:min(length(WaterOnArray),length(WaterOffArray))
    if WaterOffArray(n)<=WaterOnArray(n);disp('!!! WaterOffArray(n)<=WaterOnArray(n) !!!');break;end
end
    WaterTime=WaterOffArray-WaterOnArray;
    WaterN=length(WaterOnArray);
    MeanWaterTime=mean(WaterTime)*10^-3;
    
 ShowFig=get(handles.radiobutton_ShowFigure,'Value');
if ShowFig==1
   Raster1=[IntervalR;LRLphase];
   Raster2=[IntervalL;RLRphase];
   fig_phaseinterval=figure;hold on;
   text(Raster2(1,:),Raster2(2,:),'x','color',[1 0 0]);
   text(Raster1(1,:),Raster1(2,:),'x','color',[0 1 0]);
   set(gca,'Xlim',[0 700],'Ylim',[0 1]);hold off % x y 軸の範囲を適宜設定
end   
    
    
% --- Executes on button press in pushbutton_PhaseAnalysis.
function pushbutton_PhaseAnalysis_Callback(hObject, eventdata, handles)
global  RpegTouchCell LpegTouchCell TurnMarkerTime OneTurnTime LRLphase RLRphase LRLbefore RLRbefore IntervalR IntervalL...
        RatioAlikeLRL RatioAlikeRLR RatioBlikeLRL RatioBlikeRLR DrName FigureSave fig_LRLphase fig_RLRphase fig_Phasehist DrName...
        Interval_RL Interval_LR Rafter LTouchAll RTouchAll
% hObject    handle to pushbutton_PhaseAnalysis (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[LRLphase,RLRphase]=PhaseAnalyzer(LTouchAll,RTouchAll);

   


% --- Executes on button press in radiobutton_FigureOpen.
function radiobutton_FigureOpen_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton_FigureOpen (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton_FigureOpen


% --- Executes on button press in radiobutton_spike1.
function radiobutton_spike1_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton_spike1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton_spike1


% --- Executes on button press in radiobutton_spike4.
function radiobutton_spike4_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton_spike4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton_spike4


% --- Executes on button press in radiobutton_spike2.
function radiobutton_spike2_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton_spike2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton_spike2


% --- Executes on button press in radiobutton_spike3.
function radiobutton_spike3_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton_spike3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton_spike3


% --- Executes on button press in radiobutton_spike5.
function radiobutton_spike5_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton_spike5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton_spike5


% --- Executes on selection change in popupmenu_set.
function popupmenu_set_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu_set (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% ヒント: contents = cellstr(get(hObject,'String')) はセル配列として popupmenu_set の内容を返します。
%        contents{get(hObject,'Value')} は popupmenu_set から選択した項目を返します。


% --- Executes during object creation, after setting all properties.
function popupmenu_set_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu_set (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_AutoAnalysis.
function pushbutton_AutoAnalysis_Callback(hObject, eventdata, handles)
global SpikeArray1 SpikeArray2 SpikeArray3 SpikeArray4 SpikeArray5 SpikeOn ACset CCset CCset2 CCset3...
       rasterset1 rasterset2 rasterset3 rasterset4 rasterset10 patternValue

% Spikeでの一連の解析を行う。解析するSpike番号を選択。FigureラジオボタンをONにしておく。
% Aset:AutoCorr(spike),CrossCorr(RTouch,Rpeg,LTouch_aligned by spike),CrossCorr(DrinkOff,RTouch,LTouch_aligned by spike) 
% Bset:Raster(Rpeg,Lpeg,spike),CrossCorr(spike_aligned by TurnMarkerTime),Aset
% Cset:CrossCorr(Rpeg,Lpeg_aligned by spike),Bset
% Dset:Raster(RTouch,LTouch,spike),CrossCorr(spike_aligned by TurnMarkerTime),Aset

Spike1=get(handles.radiobutton_spike1,'Value');
Spike2=get(handles.radiobutton_spike2,'Value');
Spike3=get(handles.radiobutton_spike3,'Value');
Spike4=get(handles.radiobutton_spike4,'Value');
Spike5=get(handles.radiobutton_spike5,'Value');
SetValue=get(handles.popupmenu_set,'Value')
    
SpikeOn=[Spike1 Spike2 Spike3 Spike4 Spike5];

for n=1:5
    if SpikeOn(n)==1
        if SetValue==4 % Cset:CrossCorr(Rpeg,Lpeg_aligned by spike),Bset
            ACset=3; CCset2=1; CCset3=6; CCset=4; if n>=2;CCset=13+n;end
            pushbutton_CrossCorr_Callback(hObject, eventdata, handles)                       
        end
        if SetValue>=2 % Aset
            ACset=10; CCset2=8; CCset3=9; CCset=4; if n>=2;CCset=13+n;end
            pushbutton_CrossCorr_Callback(hObject, eventdata, handles)
            ACset=6; CCset2=5; CCset3=9; CCset=4; if n>=2;CCset=13+n;end
            pushbutton_CrossCorr_Callback(hObject, eventdata, handles)
            ACset=2; if n>=2;ACset=9+n;end
            pushbutton_Autocorr_Callback(hObject, eventdata, handles) 
        end
        if SetValue==3||SetValue==4 % Bset
            if patternValue~=9 % AA-1がAltタイプでは意味をなさない。CrossCorrAltを使用すること。
            ACset=2; CCset2=1; CCset3=1; CCset=1; if n>=2;ACset=9+n;end
            pushbutton_CrossCorr_Callback(hObject, eventdata, handles)
            end
            rasterset1=1; rasterset2=1; rasterset3=2; rasterset4=2; rasterset10=n+1;
            pushbutton_raster_Callback(hObject, eventdata, handles)
        elseif SetValue==5 % Dset
            ACset=2; CCset2=1; CCset3=1; CCset=1; if n>=2;ACset=9+n;end
            pushbutton_CrossCorr_Callback(hObject, eventdata, handles)
            rasterset1=2; rasterset2=2; rasterset3=1; rasterset4=1; rasterset10=n+1;
            pushbutton_raster_Callback(hObject, eventdata, handles)
        end
        
        ACset=[];CCset=[];CCset2=[];CCset3=[];rasterset1=[];rasterset2=[];
        rasterset3=[];rasterset4=[];rasterset10=[];
    end

end

% --- Executes on button press in pushbutton_AutoAnalysis.
function pushbutton_PhaseSpike_Callback(hObject, eventdata, handles)
global SpikeArray1 SpikeArray2 SpikeArray3 SpikeArray4 SpikeArray5 SpikeOn ...
       rasterset1 rasterset2 rasterset3 rasterset4 rasterset10 StartTime FinishTime PhaseTimeS PhaseTimeF...
       RTouchAll LTouchAll TurnMarkerTime rasterset1 rasterset2 rasterset3 rasterset4 rasterset10 patternValue

% Spikeでの一連の解析を行う。解析するSpike番号を選択。FigureラジオボタンをONにしておく。
% Aset:AutoCorr(spike),CrossCorr(RTouch,Rpeg,LTouch_aligned by spike),CrossCorr(DrinkOff,RTouch,LTouch_aligned by spike) 
% Bset:Raster(Rpeg,Lpeg,spike),CrossCorr(spike_aligned by TurnMarkerTime),Aset
% Cset:CrossCorr(Rpeg,Lpeg_aligned by spike),Bset

Spike1=get(handles.radiobutton_spike1,'Value');
Spike2=get(handles.radiobutton_spike2,'Value');
Spike3=get(handles.radiobutton_spike3,'Value');
Spike4=get(handles.radiobutton_spike4,'Value');
Spike5=get(handles.radiobutton_spike5,'Value');
SetValue=get(handles.popupmenu_set,'Value')
    
SpikeOn=[Spike1 Spike2 Spike3 Spike4 Spike5];
SpikeCell={SpikeArray1 SpikeArray2 SpikeArray3 SpikeArray4 SpikeArray5};
SpikeName=char('Spike1','Spike2','Spike3','Spike4','Spike5');
TrialTimeBin=StartTime:2000:FinishTime;

contents_MovWindow = cellstr(get(handles.popupmenu_MovWindow,'String'));
MovW=str2num(contents_MovWindow{get(handles.popupmenu_MovWindow,'Value')});
GaussSmooth=get(handles.radiobutton_Gauss,'Value');

contents = cellstr(get(handles.popupmenu_SpikeWindowMP,'String')); 
Spikewindow=str2double(contents{get(handles.popupmenu_SpikeWindowMP,'Value')});

contents = cellstr(get(handles.popupmenu_SpikeBinMP,'String')); 
SpikeBin=str2double(contents{get(handles.popupmenu_SpikeBinMP,'Value')});

nframe=floor(((FinishTime-StartTime-Spikewindow*2)/SpikeBin)+1)+1;
m=1:nframe;BinTime=StartTime+Spikewindow+SpikeBin*(m-1);
SpikeBincount={[] [] [] [] []};

SpikeArray02=[];RTouchAll02=[];LTouchAll02=[];
SpikeArray04=[];RTouchAll04=[];LTouchAll04=[];
SpikeArray06=[];RTouchAll06=[];LTouchAll06=[];
SpikeArray08=[];RTouchAll08=[];LTouchAll08=[];
SpikeArray10=[];RTouchAll10=[];LTouchAll10=[];
CcMax=[];AcMax=[];
ACresultAll={[] [] [] [] []};CCresultAll={[] [] [] [] []};CCresult2All={[] [] [] [] []};
patternValue=12;
for n=1:5
    if SpikeOn(n)==1
        rasterset1=2; rasterset2=2; rasterset3=1; rasterset4=1; rasterset10=n+1;
        pushbutton_raster_Callback(hObject, eventdata, handles) 
        
        for m=1:nframe,
            SpikeBincount{n}(m)=length(SpikeCell{n}(SpikeCell{n}>=StartTime+SpikeBin*(m-1) & SpikeCell{n}<StartTime+Spikewindow*2+SpikeBin*(m-1)));
        end
        if MovW~=0;SpikeBincount{n}=MovWindow(SpikeBincount{n},MovW);
        elseif GaussSmooth==1;SpikeBincount{n}=instantArray(SpikeBincount{n},5);
        end
        
        fig_Firingrate=figure;
        plot(BinTime*0.001,SpikeBincount{n});

        SpikeName=char('Spike1','Spike2','Spike3','Spike4','Spike5');
        title(strcat({'Firingrate ',SpikeName(n,:)}));
        SpikeArray=SpikeCell{n};
        PhaseSpike(SpikeArray);
        
        for p=1:length(PhaseTimeS{1}) % Phase0-0.2 各TimeSectionをまとめる   
            RTouch02=RTouchAll(RTouchAll>PhaseTimeS{1}(p) & RTouchAll<PhaseTimeF{1}(p));
            RTouchAll02=[RTouchAll02;RTouch02];
            LTouch02=LTouchAll(LTouchAll>PhaseTimeS{1}(p) & LTouchAll<PhaseTimeF{1}(p));
            LTouchAll02=[LTouchAll02;LTouch02];
            Spike02=SpikeCell{n}(SpikeCell{n}>PhaseTimeS{1}(p) & SpikeCell{n}<PhaseTimeF{1}(p));
            SpikeArray02=[SpikeArray02 Spike02];
        end
        for p=1:length(PhaseTimeS{2}) % Phase0.2-0.4 各TimeSectionをまとめる
            RTouch04=RTouchAll(RTouchAll>PhaseTimeS{2}(p) & RTouchAll<PhaseTimeF{2}(p));
            RTouchAll04=[RTouchAll04;RTouch04];
            LTouch04=LTouchAll(LTouchAll>PhaseTimeS{2}(p) & LTouchAll<PhaseTimeF{2}(p));
            LTouchAll04=[LTouchAll04;LTouch04];
            Spike04=SpikeCell{n}(SpikeCell{n}>PhaseTimeS{2}(p) & SpikeCell{n}<PhaseTimeF{2}(p));
            SpikeArray04=[SpikeArray04 Spike04];
        end
        for p=1:length(PhaseTimeS{3}) % Phase0.4-0.6 各TimeSectionをまとめる
            RTouch06=RTouchAll(RTouchAll>PhaseTimeS{3}(p) & RTouchAll<PhaseTimeF{3}(p));
            RTouchAll06=[RTouchAll06;RTouch06];
            LTouch06=LTouchAll(LTouchAll>PhaseTimeS{3}(p) & LTouchAll<PhaseTimeF{3}(p));
            LTouchAll06=[LTouchAll06;LTouch06];
            Spike06=SpikeCell{n}(SpikeCell{n}>PhaseTimeS{3}(p) & SpikeCell{n}<PhaseTimeF{3}(p));
            SpikeArray06=[SpikeArray06 Spike06];
        end
        for p=1:length(PhaseTimeS{4}) % Phase0.6-0.8 各TimeSectionをまとめる
            RTouch08=RTouchAll(RTouchAll>PhaseTimeS{4}(p) & RTouchAll<PhaseTimeF{4}(p));
            RTouchAll08=[RTouchAll08;RTouch08];
            LTouch08=LTouchAll(LTouchAll>PhaseTimeS{4}(p) & LTouchAll<PhaseTimeF{4}(p));
            LTouchAll08=[LTouchAll08;LTouch08];
            Spike08=SpikeCell{n}(SpikeCell{n}>PhaseTimeS{4}(p) & SpikeCell{n}<PhaseTimeF{4}(p));
            SpikeArray08=[SpikeArray08 Spike08];
        end
        for p=1:length(PhaseTimeS{5}) % Phase0.8-1.0 各TimeSectionをまとめる
            RTouch10=RTouchAll(RTouchAll>PhaseTimeS{5}(p) & RTouchAll<PhaseTimeF{5}(p));
            RTouchAll10=[RTouchAll10;RTouch10];
            LTouch10=LTouchAll(LTouchAll>PhaseTimeS{5}(p) & LTouchAll<PhaseTimeF{5}(p));
            LTouchAll10=[LTouchAll10;LTouch10];
            Spike10=SpikeCell{n}(SpikeCell{n}>PhaseTimeS{5}(p) & SpikeCell{n}<PhaseTimeF{5}(p));
            SpikeArray10=[SpikeArray10 Spike10];
        end
            
     ACselect={SpikeArray02' SpikeArray04' SpikeArray06' SpikeArray08' SpikeArray10'};        
     CCselect={RTouchAll02 RTouchAll04 RTouchAll06 RTouchAll08 RTouchAll10};
     CCselect2={LTouchAll02 LTouchAll04 LTouchAll06 LTouchAll08 LTouchAll10};
     duration=4000;Direction=0;bin=floor(duration/10);

     
        for p=1:5
            if ~isempty(ACselect{p})
                [AutoCo]=AutoCorr(ACselect{p},duration,Direction);
                ACresult=hist(AutoCo,bin)/length(ACselect{p});   
                if MovW~=0;ACresult=MovWindow(ACresult,MovW);%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                elseif GaussSmooth==1;ACresult=instantArray(ACresult,2);
                end
                ACresultAll{p}=ACresult;
            end
% if GaussSmooth==1;CCresult=instantArray(CCresult,2);end
            if ~isempty(CCselect{p})
               [CrossCo]=CrossCorr(ACselect{p},CCselect{p},floor(duration),Direction,TurnMarkerTime);
               CCresult=hist(CrossCo,bin)/length(CCselect{p});  
               if MovW~=0;CCresult=MovWindow(CCresult,MovW);%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
               elseif GaussSmooth==1;CCresult=instantArray(CCresult,2);
               end
               CCresultAll{p}=CCresult;
            end
            if ~isempty(CCselect2{p})
               [CrossCo2]=CrossCorr(ACselect{p},CCselect2{p},floor(duration),Direction,TurnMarkerTime);
               CCresult2=hist(CrossCo2,bin)/length(CCselect2{p});
%     if GaussSmooth==1;CCresult2=instantArray(CCresult2,2);end
              if MovW~=0;CCresult2=MovWindow(CCresult2,MovW);%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
              elseif GaussSmooth==1;CCresult2=instantArray(CCresult2,2);
              end
              CCresult2All{p}=CCresult2;
            end
        end   
        Ylabel=char('Phase0-0.2','Phase0.2-0.4','Phase0.4-0.6','Phase0.6-0.8','Phase0.8-1.0');
        C1max=max([max(CCresultAll{1}),max(CCresultAll{2}),max(CCresultAll{3}),max(CCresultAll{4}),max(CCresultAll{5})]);
        C2max=max([max(CCresult2All{1}),max(CCresult2All{2}),max(CCresult2All{3}),max(CCresult2All{4}),max(CCresult2All{5})]);
        CCMax=max(C1max,C2max);
        ACMax=max([max(ACresultAll{1}),max(ACresultAll{2}),max(ACresultAll{3}),max(ACresultAll{4}),max(ACresultAll{5})]);
        
     fig_PhaseSpike=figure('Position',[1 1 1400 975]);hold on
     for p=1:5
        subplot(5,3,3*p-2);
        if ~isempty(CCresultAll{p})
        H1=plot(linspace(1,duration,bin),CCresultAll{p},'color','b');
        ylabel(Ylabel(p,:),'FontSize',14);axis([0 duration 0 CCMax*1.1]);
        if p==1;title(char(strcat({'Crosscorr '},{SpikeName(n,:)},{' aligned by'},{' RTouch'})),'FontSize',18);end
        end
        subplot(5,3,3*p-1);
        if ~isempty(CCresult2All{p})
        H2=plot(linspace(1,duration,bin),CCresult2All{p},'color','r');
        axis([0 duration 0 CCMax*1.1]);
        if p==1;title(char(strcat({'Crosscorr '},{SpikeName(n,:)},{' aligned by'},{' LTouch'})),'FontSize',18);end       
        end
        subplot(5,3,p*3)
        if ~isempty(ACresultAll{p})
        H3=plot(linspace(1,duration,bin),ACresultAll{p},'color','b');
        axis([0 duration 0 ACMax*1.1]);
        if p==1;title(char(strcat({'Autocorr '},{SpikeName(n,:)})),'FontSize',18);end
        end
%         if
%         ~isempty(CCselect2);plot(linspace(1,duration,bin),CCresult2,'color','r');else CCresult2=0;end
     end
        hold off
    end
    SpikeOn(n)=0;
    SpikeArray02=[];RTouchAll02=[];LTouchAll02=[];
    SpikeArray04=[];RTouchAll04=[];LTouchAll04=[];
    SpikeArray06=[];RTouchAll06=[];LTouchAll06=[];
    SpikeArray08=[];RTouchAll08=[];LTouchAll08=[];
    SpikeArray10=[];RTouchAll10=[];LTouchAll10=[];
    ACselectAll={};CCselectAll={};CCselect2All={};
    rasterset1=[];rasterset2=[];
    rasterset3=[];rasterset4=[];rasterset10=[];
end


% --- Executes on button press in pushbutton_AutoAnalysis.
function pushbutton_SpeedSpike_Callback(hObject, eventdata, handles)
global SpikeArray1 SpikeArray2 SpikeArray3 SpikeArray4 SpikeArray5 SpikeOn...
       rasterset1 rasterset2 rasterset3 rasterset4 rasterset10 StartTime FinishTime TurnMarkerTime...
       RTouchAll LTouchAll RPegTouchAll LPegTouchAll rasterset1 rasterset2 rasterset3 rasterset4 rasterset10

% Spikeでの一連の解析を行う。解析するSpike番号を選択。FigureラジオボタンをONにしておく。
% Aset:AutoCorr(spike),CrossCorr(RTouch,Rpeg,LTouch_aligned by spike),CrossCorr(DrinkOff,RTouch,LTouch_aligned by spike) 
% Bset:Raster(Rpeg,Lpeg,spike),CrossCorr(spike_aligned by TurnMarkerTime),Aset
% Cset:CrossCorr(Rpeg,Lpeg_aligned by spike),Bset

Spike1=get(handles.radiobutton_spike1,'Value');
Spike2=get(handles.radiobutton_spike2,'Value');
Spike3=get(handles.radiobutton_spike3,'Value');
Spike4=get(handles.radiobutton_spike4,'Value');
Spike5=get(handles.radiobutton_spike5,'Value');
    
SpikeOn=[Spike1 Spike2 Spike3 Spike4 Spike5];
SpikeCell={SpikeArray1 SpikeArray2 SpikeArray3 SpikeArray4 SpikeArray5};
SpikeName=char('Spike1','Spike2','Spike3','Spike4','Spike5');
TrialTimeBin=StartTime:2000:FinishTime;

contents_MovWindow = cellstr(get(handles.popupmenu_MovWindow,'String'));
MovW=str2num(contents_MovWindow{get(handles.popupmenu_MovWindow,'Value')});
GaussSmooth=get(handles.radiobutton_Gauss,'Value');

contents = cellstr(get(handles.popupmenu_SpikeWindowMP,'String')); 
Spikewindow=str2double(contents{get(handles.popupmenu_SpikeWindowMP,'Value')});

contents = cellstr(get(handles.popupmenu_SpikeBinMP,'String')); 
SpikeBin=str2double(contents{get(handles.popupmenu_SpikeBinMP,'Value')});

RTouchAll45=[];LTouchAll45=[];SpikeArray45=[];
RTouchAll56=[];LTouchAll56=[];SpikeArray56=[];
RTouchAll68=[];LTouchAll68=[];SpikeArray68=[];
ACresultAll={[] [] []};CCresultAll={[] [] []};CCresult2All={[] [] []};

for m=1:5
    
    if SpikeOn(m)==1        
        rasterset1=2; rasterset2=2; rasterset3=1; rasterset4=1; rasterset10=m+1;
        pushbutton_raster_Callback(hObject, eventdata, handles)      
        
        for n=1:length(TurnMarkerTime)-1
            
        if TurnMarkerTime(n+1)-TurnMarkerTime(n)>=4000 && TurnMarkerTime(n+1)-TurnMarkerTime(n)<5000
           RTouch45=RTouchAll(RTouchAll>=TurnMarkerTime(n) & RTouchAll<=TurnMarkerTime(n+1));
           RTouchAll45=[RTouchAll45;RTouch45];
           LTouch45=LTouchAll(LTouchAll>=TurnMarkerTime(n) & LTouchAll<=TurnMarkerTime(n+1));
           LTouchAll45=[LTouchAll45;LTouch45];
           Spike45=SpikeCell{m}(SpikeCell{m}>=TurnMarkerTime(n) & SpikeCell{m}<=TurnMarkerTime(n+1));
           SpikeArray45=[SpikeArray45 Spike45];
        elseif TurnMarkerTime(n+1)-TurnMarkerTime(n)>=5000 && TurnMarkerTime(n+1)-TurnMarkerTime(n)<6000
           RTouch56=RTouchAll(RTouchAll>=TurnMarkerTime(n) & RTouchAll<=TurnMarkerTime(n+1));
           RTouchAll56=[RTouchAll56;RTouch56];
           LTouch56=LTouchAll(LTouchAll>=TurnMarkerTime(n) & LTouchAll<=TurnMarkerTime(n+1));
           LTouchAll56=[LTouchAll56;LTouch56];
          Spike56=SpikeCell{m}(SpikeCell{m}>=TurnMarkerTime(n) & SpikeCell{m}<=TurnMarkerTime(n+1));
          SpikeArray56=[SpikeArray56 Spike56];
        elseif TurnMarkerTime(n+1)-TurnMarkerTime(n)>=6000 && TurnMarkerTime(n+1)-TurnMarkerTime(n)<8000
          RTouch68=RTouchAll(RTouchAll>=TurnMarkerTime(n) & RTouchAll<=TurnMarkerTime(n+1));
          RTouchAll68=[RTouchAll68;RTouch68];
          LTouch68=LTouchAll(LTouchAll>=TurnMarkerTime(n) & LTouchAll<=TurnMarkerTime(n+1));
          LTouchAll68=[LTouchAll68;LTouch68];
          Spike68=SpikeCell{m}(SpikeCell{m}>=TurnMarkerTime(n) & SpikeCell{m}<=TurnMarkerTime(n+1));
          SpikeArray68=[SpikeArray68 Spike68];
        end
        end
            
     ACselect={SpikeArray45' SpikeArray56' SpikeArray68'};        
     CCselect={RTouchAll45 RTouchAll56 RTouchAll68};
     CCselect2={LTouchAll45 LTouchAll56 LTouchAll68};
     duration=2000;Direction=0;bin=floor(duration/10);
     
        for n=1:3
            if ~isempty(ACselect{n})
                [AutoCo]=AutoCorr(ACselect{n},duration,Direction);
                ACresult=hist(AutoCo,bin)/length(ACselect);   
                if MovW~=0;ACresult=MovWindow(ACresult,MovW);%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                elseif GaussSmooth==1;ACresult=instantArray(ACresult,2);
                end
                ACresultAll{n}=ACresult;
            end
% if GaussSmooth==1;CCresult=instantArray(CCresult,2);end
            if ~isempty(CCselect{n})
               [CrossCo]=CrossCorr(ACselect{n},CCselect{n},floor(duration),Direction,TurnMarkerTime);
               CCresult=hist(CrossCo,bin)/length(CCselect{n});  
               if MovW~=0;CCresult=MovWindow(CCresult,MovW);%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
               elseif GaussSmooth==1;CCresult=instantArray(CCresult,2);
               end
               CCresultAll{n}=CCresult;
            end
            if ~isempty(CCselect2{n})
               [CrossCo2]=CrossCorr(ACselect{n},CCselect2{n},floor(duration),Direction,TurnMarkerTime);
               CCresult2=hist(CrossCo2,bin)/length(CCselect2{n});
%     if GaussSmooth==1;CCresult2=instantArray(CCresult2,2);end
              if MovW~=0;CCresult2=MovWindow(CCresult2,MovW);%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
              elseif GaussSmooth==1;CCresult2=instantArray(CCresult2,2);
              end
              CCresult2All{n}=CCresult2;
            end
        end
        
        Ylabel=char('4-5sec','5-6sec','6-8sec');
        C1max=max([max(CCresultAll{1}),max(CCresultAll{2}),max(CCresultAll{3})]);
        C2max=max([max(CCresult2All{1}),max(CCresult2All{2}),max(CCresult2All{3})]);
        CCMax=max(C1max,C2max);
        ACMax=max([max(ACresultAll{1}),max(ACresultAll{2}),max(ACresultAll{3})]);
        
     fig_SpeedSpike=figure('Position',[1 1 1400 975]);hold on   
        for n=1:3
        subplot(3,3,3*n-2);
          if ~isempty(CCresultAll{n})==1
          plot(linspace(1,duration,bin),CCresultAll{n},'color','b');
          ylabel(Ylabel(n,:),'FontSize',15);axis([0 duration 0 CCMax*1.1]);
          if n==1;title(char(strcat({'Crosscorr '},{SpikeName(m,:)},{' aligned by'},{' RTouch'})),'FontSize',18);end
          end
        subplot(3,3,3*n-1);
          if ~isempty(CCresult2All{n})==1
          plot(linspace(1,duration,bin),CCresult2All{n},'color','r');
          axis([0 duration 0 CCMax*1.1]);
          if n==1;title(char(strcat({'Crosscorr '},{SpikeName(m,:)},{' aligned by'},{' LTouch'})),'FontSize',18);end
          end
        subplot(3,3,n*3)
          if ~isempty(ACresultAll{n})==1
          plot(linspace(1,duration,bin),ACresultAll{n},'color','b');
          axis([0 duration 0 ACMax*1.1]);
          if n==1;title(char(strcat({'Autocorr '},{SpikeName(m,:)})),'FontSize',18);end
%          if ~isempty(CCselect2);plot(linspace(1,duration,bin),CCresult2,'color','r');else CCresult2=0;end
          end
        end
        
        hold off
    end
    SpikeOn(m)=0;
    SpikeArray45=[];RTouchAll45=[];LTouchAll45=[];
    SpikeArray56=[];RTouchAll56=[];LTouchAll56=[];
    SpikeArray68=[];RTouchAll68=[];LTouchAll68=[];
    ACselect={};CCselect={};CCselect2={};
    rasterset1=[];rasterset2=[];
    rasterset3=[];rasterset4=[];rasterset10=[];
end



% --- Executes on button press in radiobutton_CrossPegCov.
function radiobutton_CrossPegCov_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton_CrossPegCov (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton_CrossPegCov



% --- Executes on selection change in popupmenu_SpikeBinMP.
function popupmenu_SpikeBinMP_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu_SpikeBinMP (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% ヒント: contents = cellstr(get(hObject,'String')) はセル配列として popupmenu_SpikeBinMP の内容を返します。
%        contents{get(hObject,'Value')} は popupmenu_SpikeBinMP から選択した項目を返します。


% --- Executes during object creation, after setting all properties.
function popupmenu_SpikeBinMP_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu_SpikeBinMP (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu_SpikeWindowMP.
function popupmenu_SpikeWindowMP_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu_SpikeWindowMP (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% ヒント: contents = cellstr(get(hObject,'String')) はセル配列として popupmenu_SpikeWindowMP の内容を返します。
%        contents{get(hObject,'Value')} は popupmenu_SpikeWindowMP から選択した項目を返します。


% --- Executes during object creation, after setting all properties.
function popupmenu_SpikeWindowMP_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu_SpikeWindowMP (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


 


% --- Executes on button press in radiobutton_Alt.
function radiobutton_Alt_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton_Alt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton_Alt


% --- Executes on button press in pushbutton_CrossCorrAlt.
function pushbutton_CrossCorrAlt_Callback(hObject, eventdata, handles)
global RpegTimeArray LpegTimeArray RLpegTimeArray SpikeArray1 SpikeArray2 SpikeArray3 SpikeArray4 SpikeArray5 RLPegTouchAll RPegTouchAll LPegTouchAll...
    WaterOnArrayOriginal WaterOffArrayOriginal TurnMarkerTime OneTurnTime DrName ACselect CCselect CCselect2 CCselect3...
    T DrinkOnArray DrinkOffArray FloorTouchArray FloorDetachArray MedPegTimeR MedPegTimeL AutoCorrValue CCresult LFPsamples...
    RpegTouchBypegCell  LpegTouchBypegCell  RmedianPTTM LmedianPTTM TurnMarkerTime_R TurnMarkerTime_L ...
    MedPegTimeL_L MedPegTimeL_R MedPegTimeR_L MedPegTimeR_R Alt Maxhold
%ホイール1周の中で、２回の各turnで右ペグ、左ペグを一本抜いたときに使用。これを使わないと右ペグ抜きのターンと左ペグ抜きのターンが平均化されてしまう。
%GUI上で表示(FigOpen==0)の場合、右ペグ抜きのグラフ表示後puaseをとるので、どれかのキーをたたくと左ペグ抜きのグラフを表示する。

TurnMarkerTime_org=TurnMarkerTime;
MedR=MedPegTimeR; MedL=MedPegTimeL;
for n=1:2 % AA-1pattern等でAltオンのとき
    if n==1
         TurnMarkerTime=TurnMarkerTime_L; % R抜き
         MedPegTimeR=MedPegTimeR_R;MedPegTimeL=MedPegTimeL_R;
         Alt=1;
    elseif n==2
         TurnMarkerTime=TurnMarkerTime_R;% L抜き
         MedPegTimeR=MedPegTimeR_L;MedPegTimeL=MedPegTimeL_L;
         Alt=2;
    end
    pushbutton_CrossCorr_Callback(hObject, eventdata, handles)
    FigOpen=get(handles.radiobutton_FigureOpen,'Value');
    if FigOpen==0 && n==1
        pause
    end
end
TurnMarkerTime=TurnMarkerTime_org;
MedPegTimeR=MedR; MedPegTimeL=MedL;
Alt=0;

% hObject    handle to pushbutton_CrossCorrAlt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)




% --- Executes on button press in pushbutton_TouchVariance.
function pushbutton_TouchVariance_Callback(hObject, eventdata, handles)
global  RpegTouchCell LpegTouchCell TurnMarkerTime OneTurnTime LRLphase RLRphase LRLbefore RLRbefore IntervalR IntervalL...
        RatioAlikeLRL RatioAlikeRLR RatioBlikeLRL RatioBlikeRLR DrName FigureSave fig_LRLphase fig_RLRphase fig_Phasehist DrName...
        Interval_RL Interval_LR Rafter RLpegTouchCell LTouchAll RTouchAll PTpegHistoCell ShowFig LpegTimeArray2D RpegTimeArray2D ...
        LTouchfromPeg StdLTouchTiming RTouchfromPeg StdRTouchTiming MeanStdTouch MeanTouchfromPeg VarianceList
    % 各ペグにおけるTouchのVariance
    [LTouchfromPeg,StdLTouchTiming,RTouchfromPeg,StdRTouchTiming,MeanStdTouch,StdTouchfromPeg]=KolmogorovTouch2;
    [StdRLRTouch,StdRLRTouchDiff,StdLRLTouch,StdLRLTouchDiff,StdRLTouchInterval,StdLRLphase,StdRLRphase,StdLRLdiff,StdRLRdiff]=TouchVariance;
    
    % MeanStdTouch,TouchInterval左右,diffTouch左右についてまとめる
    VarianceList=([MeanStdTouch,StdTouchfromPeg,StdRLRTouch,StdRLRTouchDiff,StdLRLTouch,StdLRLTouchDiff,StdRLTouchInterval,StdLRLphase,StdRLRphase,StdLRLdiff,StdRLRdiff])';
%     Sname=[DrName '.mat']
%     feval('save',Sname);
    
    
    
function pushbutton_VarianceAuto_Callback(hObject, eventdata, handles)
global dpath dpath2 fname fname DrName FigureSave VarianceList ...

%%%複数のマウスのDataAnalyzedファイルからTouchVarianceを任意の順番でVarianceListを作成する
%%%解析するファイル数nを指定し、ファイルの日付を指定、順番に各個体のDataAnalyzedファイルを選択する
%%%Variancesの1行目はファイル名（個体番号.日付）なので注意

ShowFig=get(handles.radiobutton_ShowFigure,'Value');
FigureSave=get(handles.radiobutton_SaveFigure,'Value');

dpath=uigetdir('C:\Documents and Settings\永田雅俊\デスクトップ\WR LVdata\08 1202-')

% cd (char('C:\Documents and Settings\永田雅俊\デスクトップ\WR LVdata\DataAnalysed'));
% dname=dpath(length(dpath)-5:length(dpath));
% mkdir(dname);
% dpath2=char(strcat({'C:\Documents and Settings\永田雅俊\デスクトップ\WR LVdata\DataAnalysed\'},{dname}));

cd(dpath);
h=ls;
% disp(h);
Variances=[];
contents = cellstr(get(handles.popupmenu_Number,'String')); 
Number=str2double(contents{get(handles.popupmenu_Number,'Value')});

for n=1:Number
%     disp(h(n,:));
    len=length(h(n,:));
    fname=h(n,:);
    [fnamemat,dpathmat] = uigetfile('*.mat');
% [fnamemat,dpathmat] = uiload;
    fnamemat
    cd(dpathmat)
    load(fnamemat)
    pushbutton_TouchVariance_Callback(hObject, eventdata, handles);
    Var=[str2double(DrName(1:3))+str2double(DrName(end-3:end)).*10^-4;VarianceList];
    Variances=[Variances Var];
    cd ..
end
mkdir('Variance');
dpath2=cd;
cd(char(strcat({dpath2},{'\Variance'})));
save Variances
clear all;
    


% --- Executes on selection change in popupmenu_Number.
function popupmenu_Number_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu_Number (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% ヒント: contents = cellstr(get(hObject,'String')) はセル配列として popupmenu_Number の内容を返します。
%        contents{get(hObject,'Value')} は popupmenu_Number から選択した項目を返します。


% --- Executes during object creation, after setting all properties.
function popupmenu_Number_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu_Number (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes when figure1 is resized.
function figure1_ResizeFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_1_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_2_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_3_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
