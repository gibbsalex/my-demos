clear; clc; close all;
s = tf('s');

G = 100/(s^2);

D = (s + 6)/(s + 10);

T = (G*D)/(1 + G*D);

L = D*G;

figure('Position', [100, 50, 1500, 1000]);
subplot(2, 3, 1)
rlocus(D*G)
legend(AutoUpdate="on")

subplot(2, 3, 2)
rlocus(G)
legend(AutoUpdate="on")

subplot(2, 3, 4)
bode(D*G)
margin(D*G)
legend(AutoUpdate="on")

subplot(2, 3, 5)
bode(G)
legend(AutoUpdate="on")

subplot(2, 3, 3)
step(T)
legend(AutoUpdate="on")
% bode(T) plots the plant but we look for behavior in OL

%%

t = linspace(0,2*pi)

y1 = 1*sin(1*t + 0)
plot(t, y1)
hold on

y2 = 1*sin(1*t + pi) %phase shift 90 deg
plot(t, y2)
