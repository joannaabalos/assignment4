fprintf('\nPart 3.');

clc
clear all

%Using stamps from ELEC4609
global G;
global C;
global b;

G = zeros(6,6); 
C = zeros(6,6); 
b = zeros(6,1); 

R1 = 1;
C1 = 0.25;
R2 = 2;
L = 0.2;
R3 = 10;
a = 100;
R4 = 0.1;
R5 = 1000;
Cn = 0.00001;
In = 0.001;

vol(1,0,1);
res(1,2,R1);
cap(1,2,C1);
res(2,0,R2);
ind(2,3,L);

ccvs(5,4,3,0,a);
res(3,4,R3);
cap(3,4,Cn);
cur(3,4,In);
res(5,6,R4);
res(6,0,R5);

fprintf('\nUpdated C matrix:');
C
%% Part 3C - Gaussian Excitation with Noise

h = 1/1000;
bn=zeros(length(b));
bn1=zeros(length(b));
xn=zeros(length(b));
time = linspace(0,1,1000);

delay=0.06+(1-0.06)/2;

gdist=makedist('Normal','mu',delay,'sigma',0.03);
gpdf=pdf(gdist,time);
gpulse=gpdf/max(gpdf);

for n=2:numel(time)
    
    %Trapezoidal Rule
    bn1(7) = gpulse(n);
    bn(7) = gpulse(n-1);
    trappy =(2*C/h-G)*xn+bn1+bn;
    xn1=(2*C/h + G)\trappy;
    Vout1(n) = xn(6)*2;
    xn = xn1;
    
    Vin(n-1) = xn(1);
    Vout(n-1) = xn(6);
end

Vin(n) = xn(1);
Vout(n) = xn(6);
% 
% figure(7)
% plot(time,Vin,time,Vout)
% title('Vo Signal with Noise Using the Gaussian Excitation - Vin(blue) Vout(red)')

%% Part 3C - In Gaussian Distribution

genIn = randn(1,1000)*In;
InRand = genIn/max(genIn);

figure(8)
subplot(2,1,1)
hist(InRand,100)
title('randn In Values')
xlabel('In (A)')

h = 1/1000;
bn=zeros(length(b));
bn1=zeros(length(b));
xn=zeros(length(b));
time = linspace(0,1,1000);

delay=0.06+(1-0.06)/2;

gdist=makedist('Normal','mu',delay,'sigma',0.03);
gpdf=pdf(gdist,time);
gpulse=gpdf/max(gpdf);

for n=2:numel(time)
    
    %Trapezoidal Rule
    bn(3) = InRand(n);
    bn(4) = -1*InRand(n);
    bn1(7) = gpulse(n);
    bn(7) = gpulse(n-1);
    trappy =(2*C/h-G)*xn+bn1+bn;
    xn1=(2*C/h + G)\trappy;
    Vout1(n) = xn(6)*2;
    xn = xn1;
    
    Vin(n-1) = xn(1);
    Vout(n-1) = xn(6);
end

Vin(n) = xn(1);
Vout(n) = xn(6);

subplot(2,1,2)
plot(time,Vin,time,Vout)
title('Vo Signal with Noise Using the Gaussian Excitation - Vin(blue) Vout(red)')





%% Part 3 - AC Gain

F = logspace(0,10,1000);

for f=1:1000
    
    %AC sweep 
    w = 2*pi*F(f);
    X = (G + 1i*F(f)*C)\b;
    Gain(f) = 20*log(abs(X(6)));
end

figure(9)
semilogx(F,Gain);
title('AC Sweep with Respect to w with Noise')
ylabel('Gain at Output (dB)')
xlabel('Frequency (Hz)')

%% Part 3 - Varying Capacitance
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
    Gain(c) = 20*log10(abs(X(6)));
end

figure(10)
histogram(Gain)
title('Histogram of Gain with Random Perturbations on C')
xlabel('Gain (dB)')

%% 3 different Cn values

Crand(1) = 1e-12;
Crand(2) = .1;
Crand(3) = 1;
F = logspace(0,10,1000);

    C(1,1) = Crand(1);
    C(1,2) = -1*Crand(1);
    C(2,1) = -1*Crand(1);
    C(2,2) = Crand(1);

for f=1:1000
    %AC sweep from 1 to 1MHz
    w = 2*pi*F(f);
    X = (G + 1i*F(f)*C)\b;
    Gain(f) = 20*log(abs(X(6)));
end

figure(11)
subplot(3,1,1)
semilogx(F,Gain);
title(['AC Sweep with C = ',num2str(Crand(1))])
ylabel('Gain at Output (dB)')
xlabel('Frequency (Hz)')

    C(1,1) = Crand(2);
    C(1,2) = -1*Crand(2);
    C(2,1) = -1*Crand(2);
    C(2,2) = Crand(2);

for f=1:1000
    %AC sweep from 1 to 1MHz
    w = 2*pi*F(f);
    X = (G + 1i*F(f)*C)\b;
    Gain(f) = 20*log(abs(X(6)));
end

subplot(3,1,2)
semilogx(F,Gain);
title(['AC Sweep with C = ',num2str(Crand(2))])
ylabel('Gain at Output (dB)')
xlabel('Frequency (Hz)')

    C(1,1) = Crand(3);
    C(1,2) = -1*Crand(3);
    C(2,1) = -1*Crand(3);
    C(2,2) = Crand(3);

for f=1:1000
    %AC sweep from 1 to 1MHz
    w = 2*pi*F(f);
    X = (G + 1i*F(f)*C)\b;
    Gain(f) = 20*log(abs(X(6)));
end

subplot(3,1,3)
semilogx(F,Gain);
title(['AC Sweep with C = ',num2str(Crand(3))])
ylabel('Gain at Output (dB)')
xlabel('Frequency (Hz)')





    