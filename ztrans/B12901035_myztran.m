clear all; clc;

%%
num = [0.09,0, -0.18,0, 0.09]; 
den = [1,-0.8,0.39,-0.062,0.005];
figure;
subplot(2,4,1);
zplane(num, den);

title('Poles and Zeros Plot of the Transfer function');

xlabel('Real');
ylabel('Imaginary');

%%
[r, p, k] = residuez(num, den); 
n = 0:20;


h_n = zeros(size(n));
for i = 1:length(r)
    h_n = h_n + r(i) * p(i).^n;
end
for i = 1:length(k)
    h_n(i) = h_n(i) + k(i);
end
subplot(2,4,2);
stem(n, real(h_n));
title('Impulse Response');
xlabel('n');
ylabel('h[n]');


%%
[~, w] = freqz(num, den); 
mag = abs(freqz(num, den, w));
phase = angle(freqz(num, den, w))*180/pi;

subplot(2, 4, 3);
plot(w, mag); % Plotting magnitude response
title('Magnitude Response');
xlabel('Frequency (rad/sample)');
ylabel('|H(e^j\omega)|');

subplot(2, 4, 4);
plot(w, phase); % Plotting phase response
title('Phase Response');
xlabel('Frequency (rad/sample)');
ylabel('Phase(H(e^j\omega))(degree)');

%%
z=[-1, -1, 1, 1];

p=[0.3+0.4i, 0.3-0.4i,0.1+0.1i,0.1-0.1i];
sos = zp2sos(z, p,0.09); % Second-order sections
disp('Second-Order Sections:');
disp(sos);

%%
b_1=sos(1,[1 2 3]);
a_1=sos(1,[4 5 6]);
b_2=sos(2,[1 2 3]);
a_2=sos(2,[4 5 6]);
disp(b_1);
disp(a_1);
disp(b_2);
disp(a_2);

[~, w_1] = freqz(b_1,a_1); 
mag_1 = abs(freqz(b_1,a_1,w));

subplot(2, 4, 5);
plot(w_1, mag_1); % Plotting magnitude response
title('Magnitude Response');
xlabel('Frequency (rad/sample)');
ylabel('|H1(e^j\omega)|');

[~, w_2] = freqz(b_2,a_2); 
mag_2 = abs(freqz(b_2,a_2,w_2));
subplot(2, 4, 6);
plot(w_2, mag_2); % Plotting magnitude response
title('Magnitude Response');
xlabel('Frequency (rad/sample)');
ylabel('|H2(e^j\omega)|');

mag_ = mag_1.*mag_2;
subplot(2,4,7);
plot(w_1, mag_);
title('Magnitude Response');
xlabel('Frequency (rad/sample)');
ylabel('|H1H2(e^j\omega)|');

correct = true;
i = 1;
for err = abs(mag-mag_)
    if err > 10^-15
        disp('there is difference');
        correct = false;
        i = i + 1;
        disp(i);
        disp(err);
    end
end

if correct
    disp('answer in e is the same as answer in c')
end

%%
x=zeros(size(n));
x(1) = 1;
y=filter(num,den,x);
subplot(2,4,8);
stem(n, real(y));
title('Impulse Response');
xlabel('n');
ylabel('y[n]');

correct_ = true;
i = 1;
for err_ = abs(h_n-y)
    if err_ > 10^-14
        disp('there is difference');
        correct_ = false;
        i = i + 1;
        disp(i);
        disp(err_);
    end
end

if correct_
    disp('answer in f is the same as the theoretical answer in b')
end
