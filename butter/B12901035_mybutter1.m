clear all; clc;

%%
x=zeros(1,100);
n=(1:100);
N=100;
fs=20;
Ts=1/fs;

x=cos(2*pi*(n-1)*Ts);

figure;
plot(n,x);
xlabel('n');
ylabel('x[n]');
title('x[n] vs n')

%%
L=3;
fc=0.05;
[b,a]=butter(L,fc,'low');
[H,w]=freqz(b,a,N);


figure;
subplot(3,3,1);
plot(w,20*log10(abs(H)));
xlabel('Frequency');
ylabel('Magnitude (dB)');
title('Manitude Response');

subplot(3,3,2);
plot(w,rad2deg(angle(H)));
xlabel('Frequency');
ylabel('Degree');
title('Phase Response');
subplot(3,3,3);
plot(n,filter(b,a,x));
xlabel('n');
ylabel('y[n]');
title('y[n] vs n');
y=filter(b,a,x);

%%
L_=7;
[b1,a1]=butter(L_,fc,'low');
[H1,w1]=freqz(b1,a1,N);

subplot(3,3,4);
plot(w1,20*log10(abs(H1)));
xlabel('Frequency');
ylabel('Magnitude (dB)');
title('Manitude Response');

subplot(3,3,5);
plot(w1,rad2deg(angle(H1)));
xlabel('Frequency');
ylabel('Degree');
title('Phase Response');
subplot(3,3,6);
plot(n,filter(b1,a1,x));
xlabel('n');
ylabel('y[n]');
title('y[n] vs n');
y1=filter(b1,a1,x);

%%
fc_=0.5;
[b2,a2]=butter(L,fc_,'low');
[H2,w2]=freqz(b2,a2,N);

subplot(3,3,7);
plot(w2,20*log10(abs(H2)));
xlabel('Frequency');
ylabel('Magnitude (dB)');
title('Manitude Response');

subplot(3,3,8);
plot(w2,rad2deg(angle(H2)));
xlabel('Frequency');
ylabel('Degree');
title('Phase Response');
subplot(3,3,9);
plot(n,filter(b2,a2,x));
xlabel('n');
ylabel('y[n]');
title('y[n] vs n')
y2=filter(b2,a2,x);
