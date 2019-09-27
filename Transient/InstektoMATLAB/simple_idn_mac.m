%SIMPLE_IDN_MAC open serial connection to Instek GDS-1062A, get ID
%
% If the serial device is already open, this script will error.
%
% Recover by finding the serial object and running fclose on it first.
% 

% Copyright 2011 MathWorks, Inc.


%--- NOTE 1: you will need to edit this for the correct device name
%    NOTE 2: set baud rate to 921,200 bits/sec for faster comms.
s = serial('/dev/tty.usbmodemEK211491','BaudRate',921600)
s.InputBufferSize = 2.1e6;

%-- open the serial device
fopen(s)

%-- send the ID request command per p.14 of Instek Programming Manual
fprintf(s, '*IDN?');

%-- receive the response
b = s.BytesAvailable;
idn = char(fread(s,b,'char'))'

%-- close the serial device
fclose(s)
%[eof]
