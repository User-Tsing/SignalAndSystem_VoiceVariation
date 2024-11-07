function varargout = Voice_Changer(varargin)
% VOICE_CHANGER MATLAB code for Voice_Changer.fig
%      VOICE_CHANGER, by itself, creates a new VOICE_CHANGER or raises the existing
%      singleton*.
%
%      H = VOICE_CHANGER returns the handle to a new VOICE_CHANGER or the handle to
%      the existing singleton*.
%
%      VOICE_CHANGER('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VOICE_CHANGER.M with the given input arguments.
%
%      VOICE_CHANGER('Property','Value',...) creates a new VOICE_CHANGER or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Voice_Changer_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Voice_Changer_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Voice_Changer

% Last Modified by GUIDE v2.5 05-May-2024 17:38:45

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Voice_Changer_OpeningFcn, ...
                   'gui_OutputFcn',  @Voice_Changer_OutputFcn, ...
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


% --- Executes just before Voice_Changer is made visible.
function Voice_Changer_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Voice_Changer (see VARARGIN)

% Choose default command line output for Voice_Changer
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Voice_Changer wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Voice_Changer_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
R=audiorecorder(44100,16,2);
record(R);
set(handles.pushbutton1,'userdata',R);
set(handles.text2,'string','录音中');


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
R=get(handles.pushbutton1,'userdata');
stop(R);
Myrecording=getaudiodata(R);
audiowrite("GotSound.wav",Myrecording,44100);
[y0,fs]= audioread("GotSound.wav");%采集原始音频文件
N=length(y0);
plot(handles.axes1,y0);
title(handles.axes1,'时域特性');
fy0=abs(fft(y0,N));
plot(handles.axes2,fy0);
title(handles.axes2,'频率特性');
set(handles.text2,'string','');
% [acor,lag]=xcorr(y0);
% [max_peak,max_peak_index]=max(acor);
% fun_freq=fs/abs(lag(max_peak_index));
% set(handles.text2,'string','该波形的基频为%.2f',fun_freq);
% fre=to_calculate(y0,fs);
% disp(fs);



% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[au,fs]=audioread("GotSound.wav");
au=au(:,1);
n=-10;
yau=shiftPitch(au,n);
sound(yau,fs);
N=length(yau);
plot(handles.axes3,yau);
title(handles.axes3,'变声时域特性');
fyau=abs(fft(yau,N));
plot(handles.axes4,fyau);
title(handles.axes4,'变声频率特性');
set(handles.text2,'string','');
set(handles.text2,'string','变男声');
audiowrite("Ch_M_Sound.wav",yau,44100);


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[au,fs]=audioread("GotSound.wav");
au=au(:,1);
n=3;
yau=shiftPitch(au,n);
sound(yau,fs);
N=length(yau);
plot(handles.axes3,yau);
title(handles.axes3,'变声时域特性');
fyau=abs(fft(yau,N));
plot(handles.axes4,fyau);
title(handles.axes4,'变声频率特性');
set(handles.text2,'string','');
set(handles.text2,'string','变女声');
audiowrite("Ch_W_Sound.wav",yau,44100);


% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[au,fs]=audioread("GotSound.wav");
au=au(:,1);
n=10;
yau=shiftPitch(au,n);
sound(yau,fs);
N=length(yau);
plot(handles.axes3,yau);
title(handles.axes3,'变声时域特性');
fyau=abs(fft(yau,N));
plot(handles.axes4,fyau);
title(handles.axes4,'变声频率特性');
set(handles.text2,'string','');
set(handles.text2,'string','变童声');
audiowrite("Ch_C_Sound.wav",yau,44100);


% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[au,fs]=audioread("GotSound.wav");
sound(au,fs);
set(handles.text2,'string','原声');
