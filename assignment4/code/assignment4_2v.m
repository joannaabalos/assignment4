%% Part 2c - Numerical Solution in Time Domain - Pulse Input


clc
clear all

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

%Using trapezoidal rule from ELEC 4506
h = 1/100;
bn=zeros(length(b));
bn1=zeros(length(b));
xn=zeros(length(b));
time = linspace(0,1,100);

for n=2:numel(time)
    pulse = inputsigv(1);
    %Trapezoidal Rule
    bn1(6) = pulse(n);
    bn(6) = pulse(n-1);
    trappy =(2*C/h-G)*xn+bn1+bn;
    xn1=(2*C/h + G)\trappy;
    Vout1(n) = xn(5)*2;
    xn = xn1;
    
    Vin(n-1) = xn(1);
    Vout(n-1) = xn(5);
end

Vin(n) = xn(1);
Vout(n) = xn(5);

figure(20)
subplot(3,1,1)
plot(time,Vin,time,Vout)
title('Pulse Input - Vin(blue) Vout(red) WITH INCREASED TIME STEP')

subplot(3,1,2)
plot(abs(fftshift(fft(Vin))))
title('FFT of Vin - Pulse Input')

subplot(3,1,3)
plot(abs(fftshift(fft(Vout))))
title('FFT of Vout - Pulse Input')

%% Part 2c - Numerical Solution in Time Domain - Sine Input

%Using trapezoidal rule from ELEC 4506
h = 1/100;
bn=zeros(length(b));
bn1=zeros(length(b));
xn=zeros(length(b));
time = linspace(0,1,100);

for n=2:numel(time)
    sinIn = inputsigv(2);
    %Trapezoidal Rule
    bn1(6) = sinIn(n);
    bn(6) = sinIn(n-1);
    trappy =(2*C/h-G)*xn+bn1+bn;
    xn1=(2*C/h + G)\trappy;
    Vout1(n) = xn(5)*2;
    xn = xn1;
    
    Vin(n-1) = xn(1);
    Vout(n-1) = xn(5);
end

Vin(n) = xn(1);
Vout(n) = xn(5);

figure(21)
subplot(3,1,1)
plot(time,Vin,time,Vout)
title('Sine Input - Vin(blue) Vout(red) WITH INCREASED TIME STEP')

subplot(3,1,2)
plot(abs(fftshift(fft(Vin))))
title('FFT of Vin - Sine Input')

subplot(3,1,3)
plot(abs(fftshift(fft(Vout))))
title('FFT of Vout - Sine Input')

%% Part 2c - Numerical Solution in Time Domain - Gaussian Pulse Input

%Using trapezoidal rule from ELEC 4506
h = 1/100;
bn=zeros(length(b));
bn1=zeros(length(b));
xn=zeros(length(b));
time = linspace(0,1,100);

gdist=makedist('Normal','mu',0.53,'sigma',0.03);
gpdf=pdf(gdist,time);
gpulse=gpdf/max(gpdf);

for n=2:numel(time)
    
    %Trapezoidal Rule
    bn1(6) = gpulse(n);
    bn(6) = gpulse(n-1);
    trappy =(2*C/h-G)*xn+bn1+bn;
    xn1=(2*C/h + G)\trappy;
    Vout1(n) = xn(5)*2;
    xn = xn1;
    
    Vin(n-1) = xn(1);
    Vout(n-1) = xn(5);
end

Vin(n) = xn(1);
Vout(n) = xn(5);

figure(22)
subplot(3,1,1)
plot(time,Vin,time,Vout)
title('Gaussian Pulse Input - Vin(blue) Vout(red) WITH INCREASED TIME STEP')

subplot(3,1,2)
plot(abs(fftshift(fft(Vin))))
title('FFT of Vin - Gaussian Pulse Input')

subplot(3,1,3)
plot(abs(fftshift(fft(Vout))))
title('FFT of Vout - Gaussian Pulse Input')
