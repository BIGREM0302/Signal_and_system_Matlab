clear all; clc;

%%
Ts=0.002;
f1=100;
M=1000;
n=(1:M);

x=cos(2*pi*(n-1)*Ts)+2*cos(2*pi*f1*(n-1)*Ts);
figure;
subplot(3,1,1);
plot(n,x);
xlabel('n');
ylabel('x[n]');
title('x[n] vs n');

%%
L=16;
fc1=2*pi*Ts*f1/pi/2;
[b1,a1]=butter(L,fc1,'low');
[H1,w1]=freqz(b1,a1,M);

y1=filter(b1,a1,x);
subplot(3,1,2);
plot(n,y1);
xlabel('n');
ylabel('y[n]');
title('y[n] vs n');

%%
fc2 = [ 150 , 250 ]*Ts;
[b2,a2]=butter(16,fc2,'bandpass');
[H2,w2]=freqz(b2,a2,M);

subplot(3,1,3);
plot(n,filter(b2,a2,x));
xlabel('n');
ylabel('y[n]');
title('y[n] vs n');