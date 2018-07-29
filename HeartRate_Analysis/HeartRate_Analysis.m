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

% Last Modified by GUIDE v2.5 16-May-2018 07:25:23

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
set(handles.pnn50, 'String', '');
set(handles.heartRate, 'String', '');
set(handles.diagnose, 'String', '..');
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
global z1
global z
axes(handles.axes1);
switch get(handles.popupmenu1, 'Value')
    case 2
        plot(seg4);
        title('ECG Signal');
        xlabel('sample');
        ylabel('amplitude');
    case 3
        plot(z1);
        title('R Peaks');
        xlabel('sample');
        ylabel('amplitude');
    case 4
        cla;
        plot(z);
        title('Threshold Signal');
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
global defdif
global init
global Fs
global Ts
global L
global time
global sig_position_in_time
global position_in_ms
global z1
global count
global HEART_RATE
global stndDev
global sqDev
global mean_sqDev
global standard_dev
global NNN
global p11
global p22
global rmssd
global NNN_positions
global count2
global PNN50
global sampleFreq

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
    Fs = str2num(get(handles.sampleFreq, 'String'));
    Ts = 1/Fs;
    L = length(seg4);
    time = L/Fs;
    sig_positions=[];    % TO CREATE AN ARRAY TO STORE THE RR INTERVALS DETECTED
    sig_position_in_time = [];
    position_in_ms = [];
    count = 0;
    for k=2: length(seg4)-1
        if(seg4(k)> seg4(k-1)& seg4(k)> seg4(k+1)& seg4(k) > 180)
            count = count+1;
            sig_positions=[sig_positions;k];
            sig_position_in_time = sig_positions/Fs;
        end

    end
    
    % LOCATION OF R PEAKS
    z1 = zeros(1,length(seg4));
    for i = 2:length(seg4)-1
        if seg4(i) >= 100
            z1(i) =seg4(i);
        end
    end
    
    % THRESHOLD PROCESS
    z = zeros(1,length(seg4));
    for i = 2:length(seg4)-1
           if seg4(i) >= 100
                z(i) = 10;
           end
    end
    
    HEART_RATE = (count*60)/time;
    
    differences = diff(sig_position_in_time);
    mean_sig = mean(differences);
    %std_dev = std(differences);
    
    stndDev = differences-(mean_sig);
    sqDev = (stndDev).^2;
    mean_sqDev = mean(sqDev);
    standard_dev = sqrt(mean_sqDev);
    
    
    NNN = diff(differences);
    p11 = (NNN).^2;
    p22 = mean(p11);
    rmssd = sqrt(p22);

    NNN_positions = [];
    
    count2 = 0;
    for m=2: length(NNN)-1
        if(NNN(m)> 0.050 || NNN(m)< -0.050) %suppress
            count2 = count2+1;
            NNN_positions =[NNN_positions;m];
        end
    end
    
    PNN50 = ((count2)/count)*100;
    
   
    % displaying data
    set(handles.mean_signal, 'String', num2str(rmssd));
    set(handles.std_signal, 'String', num2str(standard_dev));
    set(handles.heartRate, 'String', num2str(HEART_RATE));
    set(handles.pnn50, 'String', num2str(PNN50));
    
    % DIAGNOSIS

    % FOR NORMAL AUTONOMIC FUNCTION
    if standard_dev > 0.150
        set(handles.diagnose, 'String', 'NORMAL AUTONOMIC FUNCTION');
    end

    % FOR MODERATELY DEPRESSED HRV
    if standard_dev < 0.10O
        set(handles.diagnose, 'String', 'MODERATELY DEPRESSESD HRV');
    end

    % FOR CARDIOVASCULAR DISEASES
    if standard_dev > 0.35
        set(handles.diagnose, 'String', 'POSSIBLE CARDIOVASCULAR DISEASE, VISIT THE NEAREST HOSPITAL IMMEDIATELY');
    end

    % FOR HIGHLY DEPRESSED HRV
    if standard_dev < 0.05
        set(handles.diagnose, 'String', 'HIGHLY DEPRESSED HRV VISIT THE NEAREST HOSPITAL FOR FURTHER TEST');
    end

    % FOR NORMAL HEART RATE
    if HEART_RATE > 60 & HEART_RATE < 90
        set(handles.diagnose, 'String', 'NORMAL HEART RATE');
    end

    % FOR ABNORMAL HEART RATE
    if HEART_RATE < 60 ||HEART_RATE > 90
        set(handles.diagnose, 'String', 'POSSIBLE CARDIOVASCULAR DISEASE PRESENT');
    end
    
    
    % plot ecg signal
    plot(seg4);
    title('ECG Signal');
    xlabel('sample');
    ylabel('amplitude');
    
    % initialize
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



function sampleFreq_Callback(hObject, eventdata, handles)
% hObject    handle to sampleFreq (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of sampleFreq as text
%        str2double(get(hObject,'String')) returns contents of sampleFreq as a double


% --- Executes during object creation, after setting all properties.
function sampleFreq_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sampleFreq (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function heartRate_Callback(hObject, eventdata, handles)
% hObject    handle to heartRate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of heartRate as text
%        str2double(get(hObject,'String')) returns contents of heartRate as a double


% --- Executes during object creation, after setting all properties.
function heartRate_CreateFcn(hObject, eventdata, handles)
% hObject    handle to heartRate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function pnn50_Callback(hObject, eventdata, handles)
% hObject    handle to pnn50 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of pnn50 as text
%        str2double(get(hObject,'String')) returns contents of pnn50 as a double


% --- Executes during object creation, after setting all properties.
function pnn50_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pnn50 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
