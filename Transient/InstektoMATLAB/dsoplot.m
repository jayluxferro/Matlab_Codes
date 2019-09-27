%DSOPLOT Collect fast scan waveform data from an Instek GDS-1062A 
%
% To get started, see info in openInstek1000Serial.m
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
b = s.BytesAvailable;
if b > 0
  fread(s,b,'char');
end

% Get count scaling info once (speedier loops this way)
fprintf(s, ':CHAN1:SCAL?'); scale  = fscanf(s,'%f');
fprintf(s, ':CHAN1:OFFS?'); offset = fscanf(s,'%f');


%--- Do 100 collections to see the plot dance around a little

tic
for k=1:100
    
    %--- Send the acquisition command
    fprintf(s, ':ACQ1:MEM?');
    
    %--- Read the header for the acquired data
    
    % read #4 header start
    h  = char(fread(s,1,'char'));
    f  = char(fread(s,1,'char'));

    % number of remaining bytes
    n  = char(fread(s,4,'char'));
    nn = str2num(char(n'));
    
    % todo:  assert that h is #, f is 4, and nn is 8008 for fast scan
    % read the 4-byte IEEE 754 sample time as big endian bytes
    tb = uint8(fread(s,4,'uint8')); % reverse the endianness
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
    c = fread(s, 4000, 'int16')/256; % really 8-bit values on a GDS-1062A

    % Convert ADC counts to display volts
    %   is ADCgain the ADC mapping of 10 volts range onto 256 8-bit values
    %   ... or is it really just a magic constant of 1/25?
    ADCgain = 10.0/250;  %todo: why not 256?  data matches for 1/25
    v = offset + c*scale*ADCgain;

    % todo: plot data format range or 'eps' size for comparison
    % todo: add offset time and time resolution
    % todo: match scope's colors
    plot(t*(1:4000),v); grid
    title(sprintf('Waveform %02d from GDS-1062A, Vpp = %0.3f Volts', ...
        k, (max(v)-min(v))));
    drawnow
    
end
dt = toc

%[EOF]
