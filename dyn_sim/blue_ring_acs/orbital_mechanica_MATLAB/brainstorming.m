%% RPOD Guidance and Control Algorithm Sim
% Simulate a chaser spacecraft performing a rendez-vous with a target in
% LEO using Clohessy-Wilthire equations 
% assumptions: 
%   Target in near circular orbit
%   Relative distance is much closer than orbital radius
%   constant n

% x_ddot = 3n^2 x + 2 n y_dot
% y_ddot = -2n x_dot
% z_ddot = -n^2 z

% Extension
% 1. Better animation to show orbits and tracking

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

u = ones(3, 1);

%% LQR Controller

Qw = [1 1 1 1 1 1] * 10;
Q = diag(Qw); %penalty on state

Rw = [1 1 1];
R = diag(Rw); %penalty on input

[K, S, P] = lqr(A, B, Q, R)

%u = K x

%% Simulation time
% euler integration

x = ones(6, 1)*10; % i.c.

x_d = zeros(6, 1);

t = 1000;
for i = 1:t
    
    curr_x = x(:, i);
    curr_e = x_d - curr_x;

    u = K * curr_e;

    next_x = Ad * curr_x + Bd * u;

    x(:, i+1) = next_x; 

end

%% Data Viz
figure(1)
subplot(3, 1, 1)
plot(x(1, :))
ylabel('x')

subplot(3, 1, 2)
plot(x(2, :))
ylabel('y')

subplot(3, 1, 3)
plot(x(3, :))
ylabel('z')
xlabel('time')

%%

figure(2)
plot3(x(1, 1), x(2,1), x(3,1))
axis equal;
axis([0 10 0 10 0 10])
grid on;
hold on;
xlabel('x')
ylabel('y')
zlabel('z')

satBody = plot3(x(1,1), x(2,1), x(3,1), 'ro', 'MarkerFaceColor','r');

% Animation
for k = 1:t

    set(satBody, 'XData', x(1, k), 'YData', x(2, k), 'Zdata', x(3, k))
    drawnow
end