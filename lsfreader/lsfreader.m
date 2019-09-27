function [data, info] = lsfreader(datafile)
% LSFREADER LSF file reader.
% LSF is the internal file format for saving and recalling waveforms fast
% for GWInstek oscilloscope.
%
% SYNTAX
% [data, info] = LSFREADER(datafilename)
%
% OUTPUT PARAMETERS
% data: output floating point number
% info: information of datafile, including all information you want.
%
% Examples:
% description of example for lsfreader
% >> data = lsfreader('d:\waveform.lsf');
%
% >> [data, info] = lsfreader('\root\data\AL0049.LSF');
% >> info.Time
% ans =
% 01-Sep-15 18:58:38
%
% References:
% [1] https://github.com/OpenWave-GW/OpenWave-200/

% Copyright (c) CAS Key Laboratory of Basic Plasma Physics, USTC 1958-2016
% Author: lantao
% Email: lantao@ustc.edu.cn
% All Rights Reserved.
% $Revision: 1.0$ Created on: 20-Nov-2015 09:58:24
% $Revision: 1.1$ fix bugs: 23-Nov-2015
% $Revision: 1.2$ fix the data length: 12-July-2016 04:40:15

% write down your codes from here.

% if nargin < 1
%     display(['>> help ' mfilename])
%     eval(['help ' mfilename]);
%     error('lsfreader','Too less input parameters!');
% end

if nargin < 1
    [filename, pathname ] = uigetfile({'*.lsf','LSF data file'; '*.*', 'All Files (*.*)'}, 'Select LSF data file');
    if isequal(filename,0)
        % user escape
        disp('User selects cancel!')
        return;
    end
    datafile = [pathname filesep filename];
end

fid = fopen(datafile,'r');
if fid < 0
    error('lsfreader','Input file not exist or can''t be opened!');
end

% get information line, ending with '\n'
infostr = fgetl(fid);
info = infoparse(infostr);
if ~strcmpi(info.Format,'0.20') % check format version
    disp('Format version is not 0.20');
    fclose(fid);
    error('lsfreader','Format version is not 0.20!')
end

startsmbol = fread(fid,1,'char=>char');
if ~strcmpi(startsmbol, '#')
    fclose(fid);
%     data = [];
%     info = [];
    error('Format error!');
end

digit = str2num(fread(fid, 1, 'char=>char'));   % digit for number of data
num = str2num(fread(fid, digit, 'char=>char')'); % number of data

% read raw data
data = fread(fid, inf, 'int16');

% check the length of data
if length(data) ~= num
    disp(['Data length should be ' num2str(num) ', which the real length is ' num2str(length(data)) '.']);
end

% close file
fclose(fid);

% convert data
dv1 = info.VerticalScale/25;
vpos = info.VerticalPosition/dv1+128;
data = (data - vpos)*dv1;

% if no output, then plot data

% parse information structure
function info = infoparse(infostr)
a = strsplit(infostr, ';');
for ii = 1:length(a)
    b = a{ii};
    if isempty(b)
        continue;
    end
    temp = strsplit(b, ',');
    if length(temp)<2
        continue;
    end
    temp{1}(isspace(temp{1}))=[];
    info.(temp{1}) = temp{2};
end
info.MemoryLength = str2num(info.MemoryLength);
info.IntpDistance = str2num(info.IntpDistance);
info.TriggerAddress = str2num(info.TriggerAddress);
info.TriggerLevel = str2num(info.TriggerLevel);
info.VerticalUnitsDiv = str2num(info.VerticalUnitsDiv);
info.VerticalUnitsExtendDiv = str2num(info.VerticalUnitsExtendDiv);
info.ProbeRatio = str2num(info.ProbeRatio);
info.VerticalScale = str2num(info.VerticalScale);
info.VerticalPosition = str2num(info.VerticalPosition);
info.HorizontalScale = str2num(info.HorizontalScale);
info.HorizontalPosition = str2num(info.HorizontalPosition);
info.SamplingPeriod = str2num(info.SamplingPeriod);
info.HorizontalOldScale = str2num(info.HorizontalOldScale);
info.HorizontalOldPosition = str2num(info.HorizontalOldPosition);
