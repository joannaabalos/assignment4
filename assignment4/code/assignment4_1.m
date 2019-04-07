close all
clc
clear all

fprintf('\nPart 1.');

%Using stamps from ELEC4609
global G;
global C;
global b;

G = zeros(5,5); 
C = zeros(5,5); 
b = zeros(5,1); 

R1 = 1;
C1 = 0.25;
R2 = 2;
L = 0.2;
R3 = 10;
a = 100;
R4 = 0.1;
R5 = 1000;

vol(1,0,1);
res(1,2,R1);
cap(1,2,C1);
res(2,0,R2);
ind(2,3,L);
vcvs(4,0,3,0,(a/R3));
res(3,0,R3);
res(4,5,R4);
res(5,0,R5);


C
G

%% Part 1bi - DC Sweep

Vin = linspace(-10,10,10);  

for v=1:10
    %DC sweep from -10 to 10
    b(6) = Vin(v);
    X = G\b; 
    Vout(v) = X(5);
    V3(v) = X(3);
    Gain(v) = Vout(v)/Vin(v);
end

figure
plot(Vin,V3,Vin,Vout)
title('DC Sweep - N3(blue) - Vout(red)')
ylabel('Node Voltage (V)')
xlabel('Sweep Voltage (V)')

%% Part 1bii - AC Gain

F = logspace(0,10,1000);

for f=1:1000
    %AC sweep from 1 to 1MHz
    w = 2*pi*F(f);
    X = (G + 1i*F(f)*C)\b;
    Gain(f) = 20*log(abs(X(5)));
end

figure(2)
semilogx(F,Gain);
title('AC Sweep with Respect to w')
ylabel('Gain at Output (dB)')
xlabel('Frequency (Hz)')

             

std = 0.05;
w = pi;
Crand = normrnd(L,std,1,1000);

for c = 1:1000
    %applying random C values to C matrix
    C(1,1) = Crand(c);
    C(1,2) = -1*Crand(c);
    C(2,1) = -1*Crand(c);
    C(2,2) = Crand(c);
    X = (G + 1i*w*C)\b;
    Gain(c) = 20*log10(abs(X(5)));
end

figure(3)
histogram(Gain)
title('Histogram of Gain with Random Perturbations on C')
xlabel('Gain (dB)')

fprintf('\nC after applying random values.');
C

    