%% ELEC 4700 Assignment-3 Monte-Carlo/Finite Difference Method
% Assignment 3 - Joanna Abalos 100962263

close all
clear
clc

global G;
global C;
global b;



% In this assignment, circuits are modelled and simulated using MNA and
% circuit simulation.

assignment4_1

% By inspection, this is a low pass filter and amplifier. This is known
% because the signal goes through the inductor and a resistor in resies 
% goes to ground. In DC, the capacitor appears as an open circuit and the 
% inductor appears as a short. Reading the output of the inductor will 
% result in high frequencies being cutoff.

% The frequency response effectively passes low voltage and cuts off high
% frequencies.

assignment4_2

% Increasing the timestep reduces the accuracy of the model.

assignment4_3
% Adding noise the the circuit does not effect the frequency response
% because high frequency noise is filtered out. The noise is seen on the DC
% response but the general output is close to the circuit without noise.

%Varying values of Cn increases the bandwidth of passing frequencies. At
%higher values of Cn, the circuit becomes overdamped as shown by the peak
%when C = 1. At low values of Cn, the circuit is underdamped as shown by
%the lowest C value. The cutoff varies slightly, but mostly the amplitude
%response of the frequeny plot is effected by Cn. This stamp was written
%when I took ELEC4609 last semester.

% If the votlage source was replaces by the transconductance equation, the
% voltage source would need to be converted into the current controlled
% voltage source. The stamp of that is used to implemented is as shown
% below:

%   ni1 -------o+          |----------o nd1
%                          |
%                         /+\
%                      | /   \    Vnd1 - Vnd2 = val*(Vni1 - Vni2)
%                Ivcvs | \   /
%                      V  \-/ 
%                          |
%   ni2 -------o-          |----------o nd2
%
% The nodes across the dependent source are nd1 and nd2 (positive voltage at nd1)
% The independent nodes are ni1 and ni2 (positive voltage at ni1).
%   Vnd1 - Vnd2 = val*(Vni1 - Vni2)
