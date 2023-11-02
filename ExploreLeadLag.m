%% Explore Lead lag
% Uisng RR from Prof. Bewley

%Status: Didn't get a chance to compare PID and LeadLag - Incomplete
clear; clc; close all;

%Define
K = 60 * 2000 * 0.95
Dlead = tf([1 100], [1 1]) % p > z | p leads the z
Dlag = tf([1 100], [1 2000]) % p < z  | p lags the z
Dll = K * Dlead * Dlag

%Compare to PID
Ti = 200;
Td = 0.005;
Kp = 12000;

Dpid = Kp*Td* tf([1 1/Td 1/(Td*Ti)], [1 0] )

%Plot Bode
figure;
bode(Dpid)
hold on;
bode(Dll)

figure;
plot([0.1:10^(4)], Dll)

%THis needs a plant G before it can plot step