%SIMPLE_IDN_PC open serial connection to Instek GDS-1062A, get ID
%
% If the serial device is already open, this script will error.
%
% Recover by finding the serial object and running fclose on it first.
% 

% Copyright 2011 MathWorks, Inc.


%--- NOTE 1: you will need to edit this for the correct device name
%    NOTE 2: set baud rate to 921,200 bits/sec for fast communication.
s = serial('COM4','BaudRate',921600)

%-- Open the serial device
fopen(s)

%-- Send the ID request command per p.14 of Instek Programming Manual
%   ref: this is a standard SCPI command for instruments
fprintf(s, '*IDN?');

%-- Receive the response
pause(0.2); % in case it is sluggish the first time...
b   = s.BytesAvailable;
idn = char(fread(s,b,'char'))'

%-- Close the serial device
fclose(s)

%[eof]
