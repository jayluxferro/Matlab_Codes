function s = openInstek1000Serial(varargin)
%OPENINSTEK1000SERIAL set up serial port for an Instek digital scope
%
% This is a set of commands that should work with an Instek GDS-1062A.
%
% Synopsis:
%    Open a port at the slow hard-coded rate of 9600 baud:
%    s = openInstek1000Serial('/dev/tty.usbmodemEK211491')
%
%    Open a port at a zippier rate:
%    s = openInstek1000Serial('/dev/tty.usbmodemEK211491', 921600)
%
% Recommended baud rates that keep most drivers happy:
%
%    Baud rates tested on mac 10.6, also mentioned in NI-VISA doc.
%    Obviously faster is better - if you get communication errors, you
%    might want to try slower speeds:
%
%    conventional serial port speeds:  9600, 19200, 38400, 57600, 115200
%    faster serial port speeds: 128000, 230400, 256000, 460800, 921600
%
% Windows drivers to assign a USB device to be a COM: port:  
%   1) Go to http://www.gwinstek.com, find your product, click on Download
%   2) download and install an appropriate driver, e.g., 
%      * for Windows XP 32-bit, get dso_cdc_1000a.inf
%      * for Windows 7 64-bit,  get GDS-1000A.win7.x64.driver
%
% MAC drivers:
%   1) look in /dev for tty.<something> files; these are often serial ports
%   2) To get started and you have no serial devices, install Keyspan 
%      driver from TrippLite's product page download section for Keyspan
%      http://www.tripplite.com, 
%   3) go to Products->Keyspan Products->USB adapter
%   4) download and install and install an appropriate driver
%   5) look again in /dev/tty.* to verify there is something new, 
%      maybe like this: /dev/tty.usbmodemEK211491
%   6) use the full path as the name, like this:
%      '/dev/tty.usbmodemEK211491'
%   7) hook up the scope's USB cable to a free USB port, turn on the scope
%   8) if your mac pops up a dialog about a new network connection, cancel
%

% Copyright 2011 MathWorks, Inc.

if nargin >= 1
    s = serial(varargin{1});
else
    s = serial('/dev/tty.usbmodemEK211491');
end


if nargin >= 2
    s.BaudRate = varargin{2};
else
    s.BaudRate = 115200;
end

s.InputBufferSize = 2.1e6; % expect lots of bytes coming in

fopen(s)

end

%[EOF]
