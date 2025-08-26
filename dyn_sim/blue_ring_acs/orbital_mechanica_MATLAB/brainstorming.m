%% RPOD Guidance and Control Algorithm Sim
% Simulate a chaser spacecraft performing a rendez-vous with a target in
% LEO using Clohessy-Wilthire equations 

% x_ddot = 3n^2 x + 2 n y_dot
% y_ddot = -2n x_dot
% z_ddot = -n^2 z
clear; clc;
% Parameters
mu = 3.986E14; % std. grav. param. m^3/s^2
a = 6793137; % m radius of target body's circular orbit, LEO
n = sqrt(mu/(a^3)); % orbital rate of target body

% Dynamics:
A = [0 0 0 1 0 0;
     0 0 0 0 1 0;
     0 0 0 0 0 1;
     3*n^2 0 0 0 2*n 0;
     0 0 0 -2*n 0 0;
     0 0 -n^2 0 0 0];

% cntrl u = F/m
B = [0 0 0;
     0 0 0;
     0 0 0;
     1 0 0;
     0 1 0;
     0 0 1]; % applied force per unit mass

sys = ss(A, B, [], []);

% Convert to integrate forward
dt = 0.01;
sysd = c2d(sys, dt, 'zoh');
Ad = sysd.A;
Bd = sysd.B;

%% Controllable 
Co = ctrb(A, B);
rank(Co);
% rank(Co) equals number of states, thus the system is controllable.

%% null Controller

u = zeros(3, 1);

%% LQR Controller

%% Simulation time
% euler integration

x = zeros(6, 1);

for i = 1:10
    
    curr_x = x(:, i);

    next_x = Ad * curr_x + Bd * u;

    x(:, i+1) = next_x;

end