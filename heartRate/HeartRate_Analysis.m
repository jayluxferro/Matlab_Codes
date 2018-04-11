function varargout = HeartRate_Analysis(varargin)
% HEARTRATE_ANALYSIS MATLAB code for HeartRate_Analysis.fig
%      HEARTRATE_ANALYSIS, by itself, creates a new HEARTRATE_ANALYSIS or raises the existing
%      singleton*.
%
%      H = HEARTRATE_ANALYSIS returns the handle to a new HEARTRATE_ANALYSIS or the handle to
%      the existing singleton*.
%
%      HEARTRATE_ANALYSIS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in HEARTRATE_ANALYSIS.M with the given input arguments.
%
%      HEARTRATE_ANALYSIS('Property','Value',...) creates a new HEARTRATE_ANALYSIS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before HeartRate_Analysis_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to HeartRate_Analysis_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help HeartRate_Analysis

% Last Modified by GUIDE v2.5 11-Apr-2018 14:20:33

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @HeartRate_Analysis_OpeningFcn, ...
                   'gui_OutputFcn',  @HeartRate_Analysis_OutputFcn, ...
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


% --- Executes just before HeartRate_Analysis is made visible.
function HeartRate_Analysis_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to HeartRate_Analysis (see VARARGIN)

% Choose default command line output for HeartRate_Analysis
handles.output = hObject;

% disabling go button
set(handles.go_button, 'Enable', 'off');

% resetting all fields
set(handles.std_signal, 'String', '');
set(handles.mean_signal, 'String', '');
axes(handles.axes1)
cla

global init
init = false;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes HeartRate_Analysis wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = HeartRate_Analysis_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1


% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in go_button.
function go_button_Callback(hObject, eventdata, handles)
% hObject    handle to go_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global seg4
global feltseg4
global difseg4
global defdif
global z
global sig_positions
global differences
global mean_sig
global std_dev
global init
axes(handles.axes1);
switch get(handles.popupmenu1, 'Value')
    case 2
        [b,a]=butter(10,[0.15,0.40]);
        feltseg4=filter(b,a,seg4);
        plot(abs(feltseg4))
        title('Band pass filtered  signal');
        xlabel('sample');
        ylabel('amplitude');
    case 3
        difseg4=abs(diff(feltseg4));
        plot(difseg4)
        title('first  derivative of signal');
        xlabel('sample');
        ylabel('amplitude');
    case 4
        defdif=abs(diff(difseg4));
        plot(defdif)
        title('Second derivative of signal');
        xlabel('sample');
        ylabel('amplitude');
    case 5
        plot(z)
        title('Threshold signal');
        xlabel('sample');
        ylabel('amplitude');
    case 6
        plot(seg4)
        title('Unprocessed signal');
        xlabel('sample');
        ylabel('amplitude');
end

% --- Executes on button press in source_file.
function source_file_Callback(hObject, eventdata, handles)
% hObject    handle to source_file (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global seg4
global sig_positions
global z
global differences
global mean_sig
global std_dev
global defdif
global feltseg4
global difseg4
global init
axes(handles.axes1)

[filename, pathname, filterindex] = uigetfile('*.mat', 'Load Signal .mat file'); 
if isequal(filename,0) || isequal(pathname,0)
    %disp('User pressed cancel');
    % disable go button
    if init == false
        set(handles.go_button, 'Enable', 'off');
    end
else
    cla
    set(handles.popupmenu1, 'Value', 1);
    set(handles.go_button, 'Enable', 'on');
    load(fullfile(pathname, filename));
    seg4 = val;
    sig_positions=[];    % TO CREATE AN ARRAY TO STORE THE RR INTERVALS DETECTED

    count = 0;
    for k=2: length(seg4)-1
        if(seg4(k)> seg4(k-1)& seg4(k)> seg4(k+1)& seg4(k) > 300)
            count = count+1;
            sig_positions=[sig_positions;k];
        end

    end
    
    % THRESHOLD PROCESS
    z = zeros(1,length(defdif));
    for i = 10:length(defdif)-1
           if defdif(i) >= 50
                z(i) = 10;
           end
    end
    
    differences = diff(sig_positions);
    mean_sig = mean(differences);
    std_dev = std(differences);
    
    % displaying data
    set(handles.mean_signal, 'String', num2str(mean_sig));
    set(handles.std_signal, 'String', num2str(std_dev));
    init = true;
end
guidata(hObject, handles);

function mean_signal_Callback(hObject, eventdata, handles)
% hObject    handle to mean_signal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of mean_signal as text
%        str2double(get(hObject,'String')) returns contents of mean_signal as a double


% --- Executes during object creation, after setting all properties.
function mean_signal_CreateFcn(hObject, eventdata, handles)
% hObject    handle to mean_signal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function std_signal_Callback(hObject, eventdata, handles)
% hObject    handle to std_signal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of std_signal as text
%        str2double(get(hObject,'String')) returns contents of std_signal as a double


% --- Executes during object creation, after setting all properties.
function std_signal_CreateFcn(hObject, eventdata, handles)
% hObject    handle to std_signal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
