%先行ペグ（ペグ１－６）の前にスライダを設定する。
function varargout = TouchDivider(varargin)

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
%      stop.  All inputs are passed to TOUCHDIVIDER_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help TouchDivider

% Last Modified by GUIDE v2.5 25-Oct-2010 13:15:07

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @TouchDivider_OpeningFcn, ...
                   'gui_OutputFcn',  @TouchDivider_OutputFcn, ...
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
function TouchDivider_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to TouchDivider (see VARARGIN)

global fname

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
PegTouchTurn13=PegTouchTurn(:,13);PegTouchTurn13(find(PegTouchTurn13==0))=[];
PegTouchTurn14=PegTouchTurn(:,14);PegTouchTurn14(find(PegTouchTurn14==0))=[];
PegTouchTurn15=PegTouchTurn(:,15);PegTouchTurn15(find(PegTouchTurn15==0))=[];
PegTouchTurn16=PegTouchTurn(:,16);PegTouchTurn16(find(PegTouchTurn16==0))=[];
PegTouchTurn17=PegTouchTurn(:,17);PegTouchTurn17(find(PegTouchTurn17==0))=[];
PegTouchTurn18=PegTouchTurn(:,18);PegTouchTurn18(find(PegTouchTurn18==0))=[];
PegTouchTurn19=PegTouchTurn(:,19);PegTouchTurn19(find(PegTouchTurn19==0))=[];
PegTouchTurn20=PegTouchTurn(:,20);PegTouchTurn20(find(PegTouchTurn20==0))=[];
PegTouchTurn21=PegTouchTurn(:,21);PegTouchTurn21(find(PegTouchTurn21==0))=[];
PegTouchTurn22=PegTouchTurn(:,22);PegTouchTurn22(find(PegTouchTurn22==0))=[];
PegTouchTurn23=PegTouchTurn(:,23);PegTouchTurn23(find(PegTouchTurn23==0))=[];
PegTouchTurn24=PegTouchTurn(:,24);PegTouchTurn24(find(PegTouchTurn24==0))=[];

%Do plot
%figure
if PegTouchTurn1;subplot(1,2,1);plot(PegTouchTurn1,12,'k.');axis([0 OneTurnTime+10 0 12.5]);end;hold on
if PegTouchTurn2;subplot(1,2,1);plot(PegTouchTurn2,11,'c.');axis([0 OneTurnTime+10 0 12.5]);end
if PegTouchTurn3;subplot(1,2,1);plot(PegTouchTurn3,10,'m.');axis([0 OneTurnTime+10 0 12.5]);end
if PegTouchTurn4;subplot(1,2,1);plot(PegTouchTurn4,9,'r.');axis([0 OneTurnTime+10 0 12.5]);end
if PegTouchTurn5;subplot(1,2,1);plot(PegTouchTurn5,8,'g.');axis([0 OneTurnTime+10 0 12.5]);end
if PegTouchTurn6;subplot(1,2,1);plot(PegTouchTurn6,7,'b.');axis([0 OneTurnTime+10 0 12.5]);end
if PegTouchTurn7;subplot(1,2,1);plot(PegTouchTurn7,6,'k.');axis([0 OneTurnTime+10 0 12.5]);end
if PegTouchTurn8;subplot(1,2,1);plot(PegTouchTurn8,5,'c.');axis([0 OneTurnTime+10 0 12.5]);end
if PegTouchTurn9;subplot(1,2,1);plot(PegTouchTurn9,4,'m.');axis([0 OneTurnTime+10 0 12.5]);end
if PegTouchTurn10;subplot(1,2,1);plot(PegTouchTurn10,3,'r.');axis([0 OneTurnTime+10 0 12.5]);end
if PegTouchTurn11;subplot(1,2,1);plot(PegTouchTurn11,2,'g.');axis([0 OneTurnTime+10 0 12.5]);end
if PegTouchTurn12;subplot(1,2,1);plot(PegTouchTurn12,1,'b.');axis([0 OneTurnTime+10 0 12.5]);end
if PegTouchTurn13;subplot(1,2,2);plot(PegTouchTurn13,12,'k.');axis([0 OneTurnTime+10 0 12.5]);end;hold on
if PegTouchTurn14;subplot(1,2,2);plot(PegTouchTurn14,11,'c.');axis([0 OneTurnTime+10 0 12.5]);end
if PegTouchTurn15;subplot(1,2,2);plot(PegTouchTurn15,10,'m.');axis([0 OneTurnTime+10 0 12.5]);end
if PegTouchTurn16;subplot(1,2,2);plot(PegTouchTurn16,9,'r.');axis([0 OneTurnTime+10 0 12.5]);end
if PegTouchTurn17;subplot(1,2,2);plot(PegTouchTurn17,8,'g.');axis([0 OneTurnTime+10 0 12.5]);end
if PegTouchTurn18;subplot(1,2,2);plot(PegTouchTurn18,7,'b.');axis([0 OneTurnTime+10 0 12.5]);end
if PegTouchTurn19;subplot(1,2,2);plot(PegTouchTurn19,6,'k.');axis([0 OneTurnTime+10 0 12.5]);end
if PegTouchTurn20;subplot(1,2,2);plot(PegTouchTurn20,5,'c.');axis([0 OneTurnTime+10 0 12.5]);end
if PegTouchTurn21;subplot(1,2,2);plot(PegTouchTurn21,4,'m.');axis([0 OneTurnTime+10 0 12.5]);end
if PegTouchTurn22;subplot(1,2,2);plot(PegTouchTurn22,3,'r.');axis([0 OneTurnTime+10 0 12.5]);end
if PegTouchTurn23;subplot(1,2,2);plot(PegTouchTurn23,2,'g.');axis([0 OneTurnTime+10 0 12.5]);end
if PegTouchTurn24;subplot(1,2,2);plot(PegTouchTurn24,1,'b.');axis([0 OneTurnTime+10 0 12.5]);end

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
set(handles.slider_touch13,'Value',SliderTouch(13));set(handles.slider_touch14,'Value',SliderTouch(14));
set(handles.slider_touch15,'Value',SliderTouch(15));set(handles.slider_touch16,'Value',SliderTouch(16));
set(handles.slider_touch17,'Value',SliderTouch(17));set(handles.slider_touch18,'Value',SliderTouch(18));
set(handles.slider_touch19,'Value',SliderTouch(19));set(handles.slider_touch20,'Value',SliderTouch(20));
set(handles.slider_touch21,'Value',SliderTouch(21));set(handles.slider_touch22,'Value',SliderTouch(22));
set(handles.slider_touch23,'Value',SliderTouch(23));set(handles.slider_touch24,'Value',SliderTouch(24));

% Choose default command line output for TouchDivider
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);



% UIWAIT makes TouchDivider wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = TouchDivider_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

%%% Slider----------------------------------------------begin
function slider_touch12_Callback(hObject, eventdata, handles)
function slider_touch12_CreateFcn(hObject, eventdata, handles)
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

function slider_touch11_Callback(hObject, eventdata, handles)
function slider_touch11_CreateFcn(hObject, eventdata, handles)
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

function slider_touch10_Callback(hObject, eventdata, handles)
function slider_touch10_CreateFcn(hObject, eventdata, handles)
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

function slider_touch9_Callback(hObject, eventdata, handles)
function slider_touch9_CreateFcn(hObject, eventdata, handles)
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

function slider_touch8_Callback(hObject, eventdata, handles)
function slider_touch8_CreateFcn(hObject, eventdata, handles)
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

function slider_touch7_Callback(hObject, eventdata, handles)
function slider_touch7_CreateFcn(hObject, eventdata, handles)
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

function slider_touch6_Callback(hObject, eventdata, handles)
function slider_touch6_CreateFcn(hObject, eventdata, handles)
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

function slider_touch5_Callback(hObject, eventdata, handles)
function slider_touch5_CreateFcn(hObject, eventdata, handles)
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

function slider_touch4_Callback(hObject, eventdata, handles)
function slider_touch4_CreateFcn(hObject, eventdata, handles)
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

function slider_touch3_Callback(hObject, eventdata, handles)
function slider_touch3_CreateFcn(hObject, eventdata, handles)
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

function slider_touch2_Callback(hObject, eventdata, handles)
function slider_touch2_CreateFcn(hObject, eventdata, handles)
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

function slider_touch1_Callback(hObject, eventdata, handles)
function slider_touch1_CreateFcn(hObject, eventdata, handles)
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


function slider_touch13_Callback(hObject, eventdata, handles)
function slider_touch13_CreateFcn(hObject, eventdata, handles)
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


function slider_touch14_Callback(hObject, eventdata, handles)
function slider_touch14_CreateFcn(hObject, eventdata, handles)
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


function slider_touch15_Callback(hObject, eventdata, handles)
function slider_touch15_CreateFcn(hObject, eventdata, handles)
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


function slider_touch16_Callback(hObject, eventdata, handles)
function slider_touch16_CreateFcn(hObject, eventdata, handles)
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


function slider_touch17_Callback(hObject, eventdata, handles)
function slider_touch17_CreateFcn(hObject, eventdata, handles)
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


function slider_touch18_Callback(hObject, eventdata, handles)
function slider_touch18_CreateFcn(hObject, eventdata, handles)
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


function slider_touch19_Callback(hObject, eventdata, handles)
function slider_touch19_CreateFcn(hObject, eventdata, handles)
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


function slider_touch20_Callback(hObject, eventdata, handles)
function slider_touch20_CreateFcn(hObject, eventdata, handles)
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


function slider_touch21_Callback(hObject, eventdata, handles)
function slider_touch21_CreateFcn(hObject, eventdata, handles)
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


function slider_touch22_Callback(hObject, eventdata, handles)
function slider_touch22_CreateFcn(hObject, eventdata, handles)
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


function slider_touch23_Callback(hObject, eventdata, handles)
function slider_touch23_CreateFcn(hObject, eventdata, handles)
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


function slider_touch24_Callback(hObject, eventdata, handles)
function slider_touch24_CreateFcn(hObject, eventdata, handles)
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

function pushbutton_Divide_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_Divide (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global SliderTouch DrName FigureSave
SliderTouch=zeros(1,24);
SliderTouch(1)=get(handles.slider_touch1,'Value');SliderTouch(2)=get(handles.slider_touch2,'Value');SliderTouch(3)=get(handles.slider_touch3,'Value');
SliderTouch(4)=get(handles.slider_touch4,'Value');SliderTouch(5)=get(handles.slider_touch5,'Value');SliderTouch(6)=get(handles.slider_touch6,'Value');
SliderTouch(7)=get(handles.slider_touch7,'Value');SliderTouch(8)=get(handles.slider_touch8,'Value');SliderTouch(9)=get(handles.slider_touch9,'Value');
SliderTouch(10)=get(handles.slider_touch10,'Value');SliderTouch(11)=get(handles.slider_touch11,'Value');SliderTouch(12)=get(handles.slider_touch12,'Value');
SliderTouch(13)=get(handles.slider_touch13,'Value');SliderTouch(14)=get(handles.slider_touch14,'Value');SliderTouch(15)=get(handles.slider_touch15,'Value');
SliderTouch(16)=get(handles.slider_touch16,'Value');SliderTouch(17)=get(handles.slider_touch17,'Value');SliderTouch(18)=get(handles.slider_touch18,'Value');
SliderTouch(19)=get(handles.slider_touch19,'Value');SliderTouch(20)=get(handles.slider_touch20,'Value');SliderTouch(21)=get(handles.slider_touch21,'Value');
SliderTouch(22)=get(handles.slider_touch22,'Value');SliderTouch(23)=get(handles.slider_touch23,'Value');SliderTouch(24)=get(handles.slider_touch24,'Value');
disp('DividerValues=');
disp(SliderTouch);
%handles.DivideValues=SliderTouch;
%guidata(hObject,handles);
%close('TouchDivider');
if FigureSave==1;saveas(hObject,[DrName(1:9),' ','Divider.bmp']);end
close;
WheelRunner;
%%% Slide------------------------------------------------end


% --- Executes during object creation, after setting all properties.
function axes3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes3


% --- Executes during object creation, after setting all properties.
function axes1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes1
