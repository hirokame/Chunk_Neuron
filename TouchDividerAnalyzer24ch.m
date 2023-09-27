function varargout = TouchDividerAnalyzer24ch(varargin)

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

% Last Modified by GUIDE v2.5 16-Mar-2015 15:21:43

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @TouchDividerAnalyzer24ch_OpeningFcn, ...
                   'gui_OutputFcn',  @TouchDividerAnalyzer24ch_OutputFcn, ...
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
function TouchDividerAnalyzer24ch_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to TouchDivider (see VARARGIN)

global fname DrName

%[PegTouchCell]=PegTouch;
R_PegTouchTurn = varargin{1};
L_PegTouchTurn = varargin{2};
OneTurnTime = varargin{3};
SliderTouch = varargin{4};

%チャンネルごとに分ける。Turnごと Right Touches
R_PegTouchTurn1=R_PegTouchTurn(:,1);R_PegTouchTurn1(find(R_PegTouchTurn1==0))=[];
R_PegTouchTurn2=R_PegTouchTurn(:,2);R_PegTouchTurn2(find(R_PegTouchTurn2==0))=[];
R_PegTouchTurn3=R_PegTouchTurn(:,3);R_PegTouchTurn3(find(R_PegTouchTurn3==0))=[];
R_PegTouchTurn4=R_PegTouchTurn(:,4);R_PegTouchTurn4(find(R_PegTouchTurn4==0))=[];
R_PegTouchTurn5=R_PegTouchTurn(:,5);R_PegTouchTurn5(find(R_PegTouchTurn5==0))=[];
R_PegTouchTurn6=R_PegTouchTurn(:,6);R_PegTouchTurn6(find(R_PegTouchTurn6==0))=[];
R_PegTouchTurn7=R_PegTouchTurn(:,7);R_PegTouchTurn7(find(R_PegTouchTurn7==0))=[];
R_PegTouchTurn8=R_PegTouchTurn(:,8);R_PegTouchTurn8(find(R_PegTouchTurn8==0))=[];
R_PegTouchTurn9=R_PegTouchTurn(:,9);R_PegTouchTurn9(find(R_PegTouchTurn9==0))=[];
R_PegTouchTurn10=R_PegTouchTurn(:,10);R_PegTouchTurn10(find(R_PegTouchTurn10==0))=[];
R_PegTouchTurn11=R_PegTouchTurn(:,11);R_PegTouchTurn11(find(R_PegTouchTurn11==0))=[];
R_PegTouchTurn12=R_PegTouchTurn(:,12);R_PegTouchTurn12(find(R_PegTouchTurn12==0))=[];

%Do plot
%figure
axes(handles.axes1);
if R_PegTouchTurn1;plot(R_PegTouchTurn1,1,'k.');axis([0 OneTurnTime+10 0 12.5]);end;hold on
if R_PegTouchTurn2;plot(R_PegTouchTurn2,2,'c.');axis([0 OneTurnTime+10 0 12.5]);end
if R_PegTouchTurn3;plot(R_PegTouchTurn3,3,'m.');axis([0 OneTurnTime+10 0 12.5]);end
if R_PegTouchTurn4;plot(R_PegTouchTurn4,4,'r.');axis([0 OneTurnTime+10 0 12.5]);end
if R_PegTouchTurn5;plot(R_PegTouchTurn5,5,'g.');axis([0 OneTurnTime+10 0 12.5]);end
if R_PegTouchTurn6;plot(R_PegTouchTurn6,6,'b.');axis([0 OneTurnTime+10 0 12.5]);end
if R_PegTouchTurn7;plot(R_PegTouchTurn7,7,'k.');axis([0 OneTurnTime+10 0 12.5]);end
if R_PegTouchTurn8;plot(R_PegTouchTurn8,8,'c.');axis([0 OneTurnTime+10 0 12.5]);end
if R_PegTouchTurn9;plot(R_PegTouchTurn9,9,'m.');axis([0 OneTurnTime+10 0 12.5]);end
if R_PegTouchTurn10;plot(R_PegTouchTurn10,10,'r.');axis([0 OneTurnTime+10 0 12.5]);end
if R_PegTouchTurn11;plot(R_PegTouchTurn11,11,'g.');axis([0 OneTurnTime+10 0 12.5]);end
if R_PegTouchTurn12;plot(R_PegTouchTurn12,12,'b.');axis([0 OneTurnTime+10 0 12.5]);end

%チャンネルごとに分ける。Turnごと Left Touches
L_PegTouchTurn1=L_PegTouchTurn(:,1);L_PegTouchTurn1(find(L_PegTouchTurn1==0))=[];
L_PegTouchTurn2=L_PegTouchTurn(:,2);L_PegTouchTurn2(find(L_PegTouchTurn2==0))=[];
L_PegTouchTurn3=L_PegTouchTurn(:,3);L_PegTouchTurn3(find(L_PegTouchTurn3==0))=[];
L_PegTouchTurn4=L_PegTouchTurn(:,4);L_PegTouchTurn4(find(L_PegTouchTurn4==0))=[];
L_PegTouchTurn5=L_PegTouchTurn(:,5);L_PegTouchTurn5(find(L_PegTouchTurn5==0))=[];
L_PegTouchTurn6=L_PegTouchTurn(:,6);L_PegTouchTurn6(find(L_PegTouchTurn6==0))=[];
L_PegTouchTurn7=L_PegTouchTurn(:,7);L_PegTouchTurn7(find(L_PegTouchTurn7==0))=[];
L_PegTouchTurn8=L_PegTouchTurn(:,8);L_PegTouchTurn8(find(L_PegTouchTurn8==0))=[];
L_PegTouchTurn9=L_PegTouchTurn(:,9);L_PegTouchTurn9(find(L_PegTouchTurn9==0))=[];
L_PegTouchTurn10=L_PegTouchTurn(:,10);L_PegTouchTurn10(find(L_PegTouchTurn10==0))=[];
L_PegTouchTurn11=L_PegTouchTurn(:,11);L_PegTouchTurn11(find(L_PegTouchTurn11==0))=[];
L_PegTouchTurn12=L_PegTouchTurn(:,12);L_PegTouchTurn12(find(L_PegTouchTurn12==0))=[];

%Do plot
%figure
axes(handles.axes2);
if L_PegTouchTurn1;plot(L_PegTouchTurn1,1,'k.');axis([0 OneTurnTime+10 0 12.5]);end;hold on
if L_PegTouchTurn2;plot(L_PegTouchTurn2,2,'c.');axis([0 OneTurnTime+10 0 12.5]);end
if L_PegTouchTurn3;plot(L_PegTouchTurn3,3,'m.');axis([0 OneTurnTime+10 0 12.5]);end
if L_PegTouchTurn4;plot(L_PegTouchTurn4,4,'r.');axis([0 OneTurnTime+10 0 12.5]);end
if L_PegTouchTurn5;plot(L_PegTouchTurn5,5,'g.');axis([0 OneTurnTime+10 0 12.5]);end
if L_PegTouchTurn6;plot(L_PegTouchTurn6,6,'b.');axis([0 OneTurnTime+10 0 12.5]);end
if L_PegTouchTurn7;plot(L_PegTouchTurn7,7,'k.');axis([0 OneTurnTime+10 0 12.5]);end
if L_PegTouchTurn8;plot(L_PegTouchTurn8,8,'c.');axis([0 OneTurnTime+10 0 12.5]);end
if L_PegTouchTurn9;plot(L_PegTouchTurn9,9,'m.');axis([0 OneTurnTime+10 0 12.5]);end
if L_PegTouchTurn10;plot(L_PegTouchTurn10,10,'r.');axis([0 OneTurnTime+10 0 12.5]);end
if L_PegTouchTurn11;plot(L_PegTouchTurn11,11,'g.');axis([0 OneTurnTime+10 0 12.5]);end
if L_PegTouchTurn12;plot(L_PegTouchTurn12,12,'b.');axis([0 OneTurnTime+10 0 12.5]);end

set(handles.text_fname,'String',fname);

%Slider for right touches
set(handles.slider_touch1,'Value',SliderTouch(1));set(handles.slider_touch2,'Value',SliderTouch(2));
set(handles.slider_touch3,'Value',SliderTouch(3));set(handles.slider_touch4,'Value',SliderTouch(4));
set(handles.slider_touch5,'Value',SliderTouch(5));set(handles.slider_touch6,'Value',SliderTouch(6));
set(handles.slider_touch7,'Value',SliderTouch(7));set(handles.slider_touch8,'Value',SliderTouch(8));
set(handles.slider_touch9,'Value',SliderTouch(9));set(handles.slider_touch10,'Value',SliderTouch(10));
set(handles.slider_touch11,'Value',SliderTouch(11));set(handles.slider_touch12,'Value',SliderTouch(12));
%Slider for left touches
set(handles.slider14,'Value',SliderTouch(13));set(handles.slider15,'Value',SliderTouch(14));
set(handles.slider16,'Value',SliderTouch(15));set(handles.slider17,'Value',SliderTouch(16));
set(handles.slider18,'Value',SliderTouch(17));set(handles.slider19,'Value',SliderTouch(18));
set(handles.slider20,'Value',SliderTouch(19));set(handles.slider21,'Value',SliderTouch(20));
set(handles.slider22,'Value',SliderTouch(21));set(handles.slider23,'Value',SliderTouch(22));
set(handles.slider24,'Value',SliderTouch(23));set(handles.slider25,'Value',SliderTouch(24));


% Choose default command line output for TouchDivider
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);


% UIWAIT makes TouchDivider wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = TouchDividerAnalyzer24ch_OutputFcn(hObject, eventdata, handles) 
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

SliderTouch(13)=get(handles.slider14,'Value');SliderTouch(14)=get(handles.slider15,'Value');SliderTouch(15)=get(handles.slider16,'Value');
SliderTouch(16)=get(handles.slider17,'Value');SliderTouch(17)=get(handles.slider18,'Value');SliderTouch(18)=get(handles.slider19,'Value');
SliderTouch(19)=get(handles.slider20,'Value');SliderTouch(20)=get(handles.slider21,'Value');SliderTouch(21)=get(handles.slider22,'Value');
SliderTouch(22)=get(handles.slider23,'Value');SliderTouch(23)=get(handles.slider24,'Value');SliderTouch(24)=get(handles.slider25,'Value');

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


% --- Executes on slider movement.
function slider14_Callback(hObject, eventdata, handles)
% hObject    handle to slider14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider14_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider15_Callback(hObject, eventdata, handles)
% hObject    handle to slider15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider15_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider16_Callback(hObject, eventdata, handles)
% hObject    handle to slider16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider16_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider17_Callback(hObject, eventdata, handles)
% hObject    handle to slider17 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider17_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider17 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider18_Callback(hObject, eventdata, handles)
% hObject    handle to slider18 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider18_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider18 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider19_Callback(hObject, eventdata, handles)
% hObject    handle to slider19 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider19_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider19 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider20_Callback(hObject, eventdata, handles)
% hObject    handle to slider20 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider20_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider20 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider21_Callback(hObject, eventdata, handles)
% hObject    handle to slider21 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider21_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider21 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider22_Callback(hObject, eventdata, handles)
% hObject    handle to slider22 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider22_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider22 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider23_Callback(hObject, eventdata, handles)
% hObject    handle to slider23 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider23_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider23 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider24_Callback(hObject, eventdata, handles)
% hObject    handle to slider24 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider24_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider24 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider25_Callback(hObject, eventdata, handles)
% hObject    handle to slider25 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider25_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider25 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
