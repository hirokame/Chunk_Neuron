%先行ペグ（ペグ１－６）の前にスライダを設定する。
function varargout = TouchDividerAnalyzer(varargin)

% TOUCHDIVIDER M-file for TouchDivider.fig
%      TOUCHDIVIDER, by itself, creates a new TOUCHDIVIDER or raises the existing
%      singleton*.
%
%      H = TOUCHDIVIDER returns the handle to a new TOUCHDIVIDER or the handle to
%      the existing singleton*.
%
%      TOUCHDIVIDER('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TOUCHDIVIDER.M with the given input arguments.
%
%      TOUCHDIVIDER('Property','Value',...) creates a new TOUCHDIVIDER or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before TouchDivider_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to TouchDivider_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help TouchDivider

% Last Modified by GUIDE v2.5 02-Oct-2008 11:19:24

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @TouchDividerAnalyzer_OpeningFcn, ...
                   'gui_OutputFcn',  @TouchDividerAnalyzer_OutputFcn, ...
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


% --- Executes just before TouchDivider is made visible.
function TouchDividerAnalyzer_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to TouchDivider (see VARARGIN)

global fname DrName

%[PegTouchCell]=PegTouch;
PegTouchTurn = varargin{1};
OneTurnTime = varargin{2};
SliderTouch = varargin{3};
%チャンネルごとに分ける。Turnごと
PegTouchTurn1=PegTouchTurn(:,1);PegTouchTurn1(find(PegTouchTurn1==0))=[];
PegTouchTurn2=PegTouchTurn(:,2);PegTouchTurn2(find(PegTouchTurn2==0))=[];
PegTouchTurn3=PegTouchTurn(:,3);PegTouchTurn3(find(PegTouchTurn3==0))=[];
PegTouchTurn4=PegTouchTurn(:,4);PegTouchTurn4(find(PegTouchTurn4==0))=[];
PegTouchTurn5=PegTouchTurn(:,5);PegTouchTurn5(find(PegTouchTurn5==0))=[];
PegTouchTurn6=PegTouchTurn(:,6);PegTouchTurn6(find(PegTouchTurn6==0))=[];
PegTouchTurn7=PegTouchTurn(:,7);PegTouchTurn7(find(PegTouchTurn7==0))=[];
PegTouchTurn8=PegTouchTurn(:,8);PegTouchTurn8(find(PegTouchTurn8==0))=[];
PegTouchTurn9=PegTouchTurn(:,9);PegTouchTurn9(find(PegTouchTurn9==0))=[];
PegTouchTurn10=PegTouchTurn(:,10);PegTouchTurn10(find(PegTouchTurn10==0))=[];
PegTouchTurn11=PegTouchTurn(:,11);PegTouchTurn11(find(PegTouchTurn11==0))=[];
PegTouchTurn12=PegTouchTurn(:,12);PegTouchTurn12(find(PegTouchTurn12==0))=[];

%Do plot
%figure
if PegTouchTurn1;plot(PegTouchTurn1,1,'k.');axis([0 OneTurnTime+10 0 12.5]);end;hold on
if PegTouchTurn2;plot(PegTouchTurn2,2,'c.');axis([0 OneTurnTime+10 0 12.5]);end
if PegTouchTurn3;plot(PegTouchTurn3,3,'m.');axis([0 OneTurnTime+10 0 12.5]);end
if PegTouchTurn4;plot(PegTouchTurn4,4,'r.');axis([0 OneTurnTime+10 0 12.5]);end
if PegTouchTurn5;plot(PegTouchTurn5,5,'g.');axis([0 OneTurnTime+10 0 12.5]);end
if PegTouchTurn6;plot(PegTouchTurn6,6,'b.');axis([0 OneTurnTime+10 0 12.5]);end
if PegTouchTurn7;plot(PegTouchTurn7,7,'k.');axis([0 OneTurnTime+10 0 12.5]);end
if PegTouchTurn8;plot(PegTouchTurn8,8,'c.');axis([0 OneTurnTime+10 0 12.5]);end
if PegTouchTurn9;plot(PegTouchTurn9,9,'m.');axis([0 OneTurnTime+10 0 12.5]);end
if PegTouchTurn10;plot(PegTouchTurn10,10,'r.');axis([0 OneTurnTime+10 0 12.5]);end
if PegTouchTurn11;plot(PegTouchTurn11,11,'g.');axis([0 OneTurnTime+10 0 12.5]);end
if PegTouchTurn12;plot(PegTouchTurn12,12,'b.');axis([0 OneTurnTime+10 0 12.5]);end

% %disp(MedPegTimeR);
% cl={'k','c','m','r','g','b','k','c','m','r','g','b'};
% y=(0:1250)*0.01;
% for n=1:length(MedPegTimeR);plot(MedPegTimeR(n),y,cl{n});end;hold off

set(handles.text_fname,'String',fname);

set(handles.slider_touch1,'Value',SliderTouch(1));set(handles.slider_touch2,'Value',SliderTouch(2));
set(handles.slider_touch3,'Value',SliderTouch(3));set(handles.slider_touch4,'Value',SliderTouch(4));
set(handles.slider_touch5,'Value',SliderTouch(5));set(handles.slider_touch6,'Value',SliderTouch(6));
set(handles.slider_touch7,'Value',SliderTouch(7));set(handles.slider_touch8,'Value',SliderTouch(8));
set(handles.slider_touch9,'Value',SliderTouch(9));set(handles.slider_touch10,'Value',SliderTouch(10));
set(handles.slider_touch11,'Value',SliderTouch(11));set(handles.slider_touch12,'Value',SliderTouch(12));

% Choose default command line output for TouchDivider
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);


% UIWAIT makes TouchDivider wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = TouchDividerAnalyzer_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

%%% Slider----------------------------------------------begin
function slider_touch1_Callback(hObject, eventdata, handles)
function slider_touch1_CreateFcn(hObject, eventdata, handles)
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

function slider_touch2_Callback(hObject, eventdata, handles)
function slider_touch2_CreateFcn(hObject, eventdata, handles)
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

function slider_touch3_Callback(hObject, eventdata, handles)
function slider_touch3_CreateFcn(hObject, eventdata, handles)
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

function slider_touch4_Callback(hObject, eventdata, handles)
function slider_touch4_CreateFcn(hObject, eventdata, handles)
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

function slider_touch5_Callback(hObject, eventdata, handles)
function slider_touch5_CreateFcn(hObject, eventdata, handles)
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

function slider_touch6_Callback(hObject, eventdata, handles)
function slider_touch6_CreateFcn(hObject, eventdata, handles)
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

function slider_touch7_Callback(hObject, eventdata, handles)
function slider_touch7_CreateFcn(hObject, eventdata, handles)
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

function slider_touch8_Callback(hObject, eventdata, handles)
function slider_touch8_CreateFcn(hObject, eventdata, handles)
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

function slider_touch9_Callback(hObject, eventdata, handles)
function slider_touch9_CreateFcn(hObject, eventdata, handles)
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

function slider_touch10_Callback(hObject, eventdata, handles)
function slider_touch10_CreateFcn(hObject, eventdata, handles)
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

function slider_touch11_Callback(hObject, eventdata, handles)
function slider_touch11_CreateFcn(hObject, eventdata, handles)
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

function slider_touch12_Callback(hObject, eventdata, handles)
function slider_touch12_CreateFcn(hObject, eventdata, handles)
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

function pushbutton_Divide_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_Divide (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global SliderTouch DrName FigureSave
SliderTouch=zeros(1,12);
SliderTouch(1)=get(handles.slider_touch1,'Value');SliderTouch(2)=get(handles.slider_touch2,'Value');SliderTouch(3)=get(handles.slider_touch3,'Value');
SliderTouch(4)=get(handles.slider_touch4,'Value');SliderTouch(5)=get(handles.slider_touch5,'Value');SliderTouch(6)=get(handles.slider_touch6,'Value');
SliderTouch(7)=get(handles.slider_touch7,'Value');SliderTouch(8)=get(handles.slider_touch8,'Value');SliderTouch(9)=get(handles.slider_touch9,'Value');
SliderTouch(10)=get(handles.slider_touch10,'Value');SliderTouch(11)=get(handles.slider_touch11,'Value');SliderTouch(12)=get(handles.slider_touch12,'Value');
disp('DividerValues=');
disp(SliderTouch);
%handles.DivideValues=SliderTouch;
%guidata(hObject,handles);
%close('TouchDivider');
DrName
if FigureSave==1;saveas(hObject,[DrName(1:8),' ','Divider.bmp']);end
close;
% WheelAnalyzer;
%%% Slide------------------------------------------------end
