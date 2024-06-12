clear all; clc;

%%

T=0.2;
Fs=5;
L=1001;
t=(-500:500)*T;
x=(sin(2*pi*(t+eps)))./(2*pi*(t+eps));
figure;
plot((-500:500),x);

%%

x_=fft(x);
x_=fftshift(x_);

figure;
plot((-500:500)*(pi/500),abs(x_));

%%

X=zeros(1,1001);

for k = 1:501
    for n = 1:1001
        X(1,k+500) = X(1,k+500)+x(1,n)*exp(-2*1i*pi*(k-1)*(n-1)/1001);
    end
end

for k = 502:1001
    for n = 1:1001
        X(1,k-501) = X(1,k-501)+x(1,n)*exp(-2*1i*pi*(k-1)*(n-1)/1001);
    end
end

figure;
plot((-500:500)*(pi/500),abs(X));

%{
figure
plot(abs(X-x_))
%}

correct = true;
i = 1;
for err = abs(X-x_)
    if err > 10^-11
        disp('there is difference');
        correct = false;
        i = i + 1;
        disp(i);
        disp(err);
    end
end

if correct
    disp('answer in c is the same as answer in b')
end

%˙%
w=zeros(1,1001);

for k = 1:1001
    if abs(t(1,k)) > 25
        w(1,k)=0;
    else
        w(1,k)=0.5*(1+cos(2*pi*abs(t(1,k))/50));
    end
end

figure;
plot((-500:500),w);

%%

y=x.*w;
figure;
plot((-500:500),y);

%%

Y=fft(y);
Y=fftshift(Y);
figure;
plot((-500:500)*(pi/500),abs(Y));
