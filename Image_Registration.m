function varargout = Image_Registration(varargin)
% IMAGE_REGISTRATION MATLAB code for Image_Registration.fig
%      IMAGE_REGISTRATION, by itself, creates a new IMAGE_REGISTRATION or raises the existing
%      singleton*.
%
%      H = IMAGE_REGISTRATION returns the handle to a new IMAGE_REGISTRATION or the handle to
%      the existing singleton*.
%
%      IMAGE_REGISTRATION('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in IMAGE_REGISTRATION.M with the given input arguments.
%
%      IMAGE_REGISTRATION('Property','Value',...) creates a new IMAGE_REGISTRATION or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Image_Registration_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Image_Registration_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Image_Registration

% Last Modified by GUIDE v2.5 06-Apr-2019 22:15:22

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Image_Registration_OpeningFcn, ...
                   'gui_OutputFcn',  @Image_Registration_OutputFcn, ...
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


% --- Executes just before Image_Registration is made visible.
function Image_Registration_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Image_Registration (see VARARGIN)

% Choose default command line output for Image_Registration
handles.output = hObject;
axes(handles.axes1);
matlabImage = imread('LOGO.jpg');
image(matlabImage)
axis off
axis image

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Image_Registration wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Image_Registration_OutputFcn(hObject, eventdata, handles) 
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
[file,path] = uigetfile('*.tif');
addpath(path);
image=imread(file);
set(handles.figure1, 'pointer', 'watch')
drawnow;
setappdata(0,'image',image);
setappdata(0,'file',file);
setappdata(0,'path',path)
set(handles.figure1, 'pointer', 'arrow')

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.figure1, 'pointer', 'watch')
drawnow;
[file2,path2] = uigetfile('*.tif');
addpath(path2);
b1=imread(file2);
c=rgb2gray(b1);
c=im2double(c);
a2=c;
a2=1-a2;
figure(1);
subplot(1,2,1); imshow(c); title('1. Gray scale reference image')
subplot(1,2,2); imshow(a2);title('2. Negative gray scale reference image')
prompt='Input 1 if the test image looks like the gray scale reference or 2 if it looks like the negative reference';
x = inputdlg(prompt);
x=str2num(x{1});
close(figure(1))
if x == 1
    ref=c;
else
    ref=a2;
end
setappdata(0,'ref',ref);
set(handles.figure1, 'pointer', 'arrow')


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.figure1, 'pointer', 'watch')
drawnow;
image=getappdata(0,'image');
path=getappdata(0,'path');
file=getappdata(0,'file');
ref=getappdata(0,'ref');
Function1;
outputf=output;
datafile = [path 'registered' file];
imwrite(outputf,datafile);
f = msgbox('Operation Completed');set(f, 'position', [300 220 310 70]); %makes box bigger
ah = get( f, 'CurrentAxes' );
ch = get( ah, 'Children' );
set( ch, 'FontSize', 30 ); %makes text bigger
set(handles.figure1, 'pointer', 'arrow')
