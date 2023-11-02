%% Exploring the inverted pendulum
% Frequency separation turns SISO to SIMO
clear;clc; close all

mc = 2; %kg
mp = 1; %kg
l = 1;%m distance from cart to center of mass of Pend
Ip = mp*l^2/3; % moment of inertia of the pend about CoM
g = 9.8;%m/s^2
c1 = 0.01;
c2 = 0.05; %friction coeff

a0 = mp*g*l*c2;
a1 = (mc + mp)*mp*g*l +c1*c2;
a2 = (mc + mp) * c1 + (Ip + mp*l^2) *c2;
a3 = (mc + mp)*Ip + mc*mp*l^2;

b = mp*l;
b2_bar = (Ip + mp*l^2)/(mp*l);
b1_bar = c1/(mp*l);
b0_bar = g;

G1 = tf( b, [a3 a2 -a1 -a0])
G2 = tf([b2_bar b1_bar -b0_bar], [1 0 0])

%Inner Loop
K = 5;
D1 = tf(K, 1)
L = D1*G1
rlocus(L)

%Outer Loop
P = 1/1.4
T1 = (P * G1 * D1)/(1 + G1 * D1)

figure;
bode(T1)
figure;
step(T1)
figure;
rlocus(T1)