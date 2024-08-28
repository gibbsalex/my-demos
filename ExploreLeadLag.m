%% Explore Lead lag
% Uisng RR from Prof. Bewley

%Status: Completed lead lag analysis + overleaf chapter
clear; clc; close all;

%Define
K = 60 * 2000 * 0.95
Dlead = tf([1 -100], [1 -1]) % p > z | p leads the z
Dlag = tf([1 -1], [1 -100]) % p < z  | p lags the z
Dll = K * Dlead * Dlag

%% analyze bode plots
bode(Dlead) % looks like a low pass filter with a pos. phas bump at freq 10
figure()
bode(Dlag) % looks like a high pass filter with a neg. phas dip at freq 10

%% analyze the root locus
figure()
rlocus(Dlead) %zero @ 100, pole @ 1 - straight line between the two
figure()
rlocus(Dlag) %zero @ 1, pole @ 100 - straight line between the two

