%% Idea Generating Script

%% Practice System
clear; clc;

% spring-mass damper
s = tf('s');

% proving the coefficients for the discrete system matches spring-mass-damp
Gs = 1/(s^2 + s + 1)
Gz = c2d(Gs, 0.1)

% pretend tf
%num = [0.02 0.04 0.02];
num = [0.02 0.04];
den = [1 -1.5 0.6];
G_actual = tf(num, den)

% simulated data
N = 1000;
u = randn(N,1);
y = filter(num, den, u);
Fs = 1000;

%% Explain the system behavior further

figure(1)
time = 1/Fs * 1:N;
plot(time, y)
xlabel('t')
ylabel('y')


Y = fft(y);
figure(2)
freq = Fs/N*(0:N-1);
plot(freq, abs(Y))
xlabel('f(Hz)')
ylabel('fft(y)')

power = abs(Y).^2/N;
figure(3)
plot(freq, power)
xlabel('f(Hz)')
ylabel('power')

%% LS estimation, L7
% y = PHI*theta + e
% so, theta = PHI \ Y
PHI = [u(3:N) u(2:N-1) u(1:N-2) -y(2:N-1) -y(1:N-2)];
Y = y(3:N);

theta = PHI\Y
%need e to be small white noise

%% ETFE, spectrum, spa

tf_etfe = etfe([y u])
figure(4)
bode(G_actual, 'r', tf_etfe, 'b*')



%% Spectral Analysis

% G_spa = spect_yu / spect_u

% fft, spectrum, etfe, spa

%% Grey-Box Model Estimation
% https://www.mathworks.com/help/ident/grey-box-model-estimation.html



