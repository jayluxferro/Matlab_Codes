function varargout = imageProcessing(varargin)
% IMAGEPROCESSING MATLAB code for imageProcessing.fig
%      IMAGEPROCESSING, by itself, creates a new IMAGEPROCESSING or raises the existing
%      singleton*.
%
%      H = IMAGEPROCESSING returns the handle to a new IMAGEPROCESSING or the handle to
%      the existing singleton*.
%
%      IMAGEPROCESSING('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in IMAGEPROCESSING.M with the given input arguments.
%
%      IMAGEPROCESSING('Property','Value',...) creates a new IMAGEPROCESSING or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before imageProcessing_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to imageProcessing_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help imageProcessing

% Last Modified by GUIDE v2.5 08-Jun-2017 13:00:55

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @imageProcessing_OpeningFcn, ...
                   'gui_OutputFcn',  @imageProcessing_OutputFcn, ...
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


% --- Executes just before imageProcessing is made visible.
function imageProcessing_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to imageProcessing (see VARARGIN)

%clearing command windows and all data in the workspace

clc;

%disabling all other button except load
set(handles.resetImage,'Enable','Off');
set(handles.blackWhite,'Enable','Off');
set(handles.grayScale,'Enable','Off');
set(handles.slider1,'Enable','Off');

% Choose default command line output for imageProcessing
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes imageProcessing wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = imageProcessing_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in loadImage.
function loadImage_Callback(hObject, eventdata, handles)
% hObject    handle to loadImage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global im im2
[imgPath,userCancel] = imgetfile();
if userCancel
   %msgbox('No Image Selected','Image Processing','error');
   return;
end
im = imread(imgPath);
im =im2double(im); % converts to double
im2 = im; % backup
axes(handles.axes1);
imshow(im);
set(handles.resetImage,'Enable','On');
set(handles.blackWhite,'Enable','On');
set(handles.grayScale,'Enable','On');
set(handles.slider1,'Enable','On');



% --- Executes on button press in resetImage.
function resetImage_Callback(hObject, eventdata, handles)
% hObject    handle to resetImage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global im2
axes(handles.axes1);
imshow(im2);


% --- Executes on button press in blackWhite.
function blackWhite_Callback(hObject, eventdata, handles)
% hObject    handle to blackWhite (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global im
blackWhite = 1-im;
axes(handles.axes1);
imshow(blackWhite);


% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global im
brightness = 0.5*get(hObject,'Value')-0.5;
axes(handles.axes1);
imshow(im+brightness);


% --- Executes during object creation, after setting all properties.
function slider1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in grayScale.
function grayScale_Callback(hObject, eventdata, handles)
% hObject    handle to grayScale (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global im
grayScale = (im(:,:,1)+im(:,:,2)+im(:,:,2))/3;
axes(handles.axes1);
imshow(grayScale);
