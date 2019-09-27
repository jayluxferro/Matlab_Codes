%LONGMEMPLOT Acquire a long memory trace on an Instek GDS-1062A scope
%
% Using the single trigger feature when auto trigger is set to STOP,
% it's possible to acquire up to 2 million bytes of data, which is 1
% million 16-bit data points (the only size available) when 1 channel is
% active.  The value is halved if both channels are active.
%
% tip:  Set scope to STOP, set time/div to 50ms for demo results
%
% Note: the Instek GDS-1062A in firmware revision 11 appears to make 2.1M 
% bytes available, or 1,050,000 data points.
%

% Copyright 2011 MathWorks, Inc.


% Check to see that the serial port object is open and ready
serialOK = false; 
if exist('s','var')
    if isa(s,'serial')
        if strcmp(s.Status,'open') && s.InputBufferSize > 8016
            serialOK = true;
        end
    end
end
if ~serialOK
    error('Serial port is not set up, open, or of sufficient input buffer');
end

% First, empty the serial input buffer so we don't read old stuff
% NOTE: may actually require a full *RST to be reliable
b = s.BytesAvailable;
if b > 0
  fread(s,b,'char');
  disp('Emptying serial buffer first...');
end

% Get count scaling info once (speedier loops this way)
fprintf(s, ':CHAN1:SCAL?'); scale  = fscanf(s,'%f');
fprintf(s, ':CHAN1:OFFS?'); offset = fscanf(s,'%f');
%fprintf(s, ':CHAN2:SCAL?'); scale  = fscanf(s,'%f');
%fprintf(s, ':CHAN2:OFFS?'); offset = fscanf(s,'%f');


tic
%--- Do a collection of long memory

%--- Send the acquisition command to acquire long memory
%TODO: timing is off - can step through this, but cannot run it
fprintf(s, ':STOP');
fprintf(s, ':SINGLE');
pause(16.0); %NOTE: edit this, it is based on timebase
fprintf(s, ':ACQUIRE1:LMEMORY?');
pause(16.0); %NOTE: varies w/timebase time/div setting (implicit)
%fprintf(s, ':ACQUIRE2:LMEMORY?');
%pause(16.0);

%--- Read the header for the acquired data

% read #4 header start: #N where N is number of digits
h  = char(fread(s,1,'char')); % the #
f  = char(fread(s,1,'char')); % the N

% number of remaining bytes (8008, 2000008, or 4000008)
numN = str2num(f);
n    = char(fread(s,numN,'char'));
nn   = str2num(char(n'));
% todo:  could assert that h is #, f is 4 or 7, and nn is 8008 for fast scan


% read the 4-byte IEEE 754 sample time as big endian bytes
tb = uint8(fread(s,4,'uint8')); % reverse the endianness for intel MATLAB
% convert sampling period to host byte order
% todo: check host byte order first...
t = typecast(tb(4:-1:1),'single'); % reverse the byte order

% read the channel byte character
ch = fread(s,1,'char');

% read the 3 reserved bytes just to get them off the buffer
r = fread(s,3,'char');


%--- Finally, read the waveform data

% Raw integer ADC counts:
%   signed 16-bit integer but LSB is always 0!
numCwanted = (nn - 8)/2;
numC       = numCwanted; % for the case where it works OK
oldBytes = 0;
while (s.bytesAvailable < numCwanted*2)
    if s.bytesAvailable ~= oldBytes
        oldBytes = s.bytesAvailable;
    else
        numC = s.bytesAvailable/2;  % when it doesn't work OK
        break;
    end
    pause(0.5);
end    
c = fread(s, numC, 'int16')/256; % really 8-bit values on a GDS-1062A

% Convert ADC counts to display volts
%   is ADCgain the ADC mapping of 10 volts range onto 256 8-bit values
%   ... or is it really just a magic constant of 1/25?
ADCgain = 10.0/250;  %todo: why not 256?  data matches for 1/25
v = offset + c*scale*ADCgain;

% todo: plot data format range or 'eps' size for comparison
% todo: add offset time and time resolution
% todo: match scope's colors
plot(t*(1:numC),v); grid
title(sprintf('Long Waveform from GDS-1062A, Vpp = %0.3f Volts', ...
    (max(v)-min(v))));
drawnow
    
dt = toc

%[EOF]
