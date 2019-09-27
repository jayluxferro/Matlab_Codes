%SIM_WITH_INPUTDATA convert acquired data into Simulation input
%
% After you run longmemplot.m, this script can take the result and
% feed it into a Simulink simulation.  This technique can be used to
% stimulate models or to perform dynamic signal processing operations
% using Simulink blocks.
%
% This is a basic demo.  Simulink supports multiple inputs with
% differing datatypes and sample times.  The documentation
% shows the many options for configuring input data for simulation.
%

% Copyright 2011 MathWorks, Inc.

%--- Configure and run a shipping demo model from Simulink
mdl = 'sldemo_f14';  % has an input port for data already
open_system(mdl);

%-- turn off signal generator block (Name = 'Pilot')
set_param([mdl,'/Pilot'],'Amplitude','0')
sim(mdl);            % simulate with no input data
pause(4);            % while paused, notice the viewer is all quiet

%-- Convert the acquired data into Simulink's v2 data structure format
vin = 0.500 * v;  % numC and v acquired using longmemplot
tin = 0.005 * (1:numC)'; % create a time column vector for the model

clear uin
uin.signals(1).values = vin; % signals(1) goes to inport #1, etc.
uin.time              = tin;

%-- Configure the model to feed data to its input ports
%
%   See where 'uin' is referenced from above - the model picks up
%   the values automatically during simulation.
set_param(mdl,'LoadExternalInput','on');
set_param(mdl,'ExternalInput','uin');

%-- Run the simulation again, this time using the acquired data
[tout,x,y] = sim(mdl);


%[eof]
