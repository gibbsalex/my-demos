%% Bicycle Model and Control! in Vehicle Dynamics
% https://dingyan89.medium.com/simple-understanding-of-kinematic-bicycle-model-81cac6420357
% Lets get it

%% Example from article with refrence frame at the rear axle
clear; clc; close all;

v = 11; %m/s or 25 mph
phi = 0;  %rate of change of steering wheel (phi interprets the driver continues to steer between steps)
delta = [deg2rad(0)]; %steering angle
theta = [deg2rad(0)]; %deg rotation position
L = 2.928; %wheel base of Mazda CX-9
dt = 0.1; %steps
x = [0];
y = [0];

%state = [x, y, theta, delta];
%R = L/tan(delta);
%omega = v/R;
% statedot = [xdot, ydot, thetadot, deltadot];
%A = [ v*cos(theta); v*sin(theta); omega; phi];
x_track = linspace(0, 10, 11);
y_track = 5*x_track;
theta_track = atan(y_track./x_track);
delta_track = theta_track;

Kp = 0.5;% Get this into a PID

%bikeRear(L, v, phi, x, y, delta, theta, dt)
for step = [1: 10]
    %[new_x, new_y, new_theta, new_delta] = bikeRear(L, v, phi, x(step), y(step), delta(step), theta(step), dt);
    x_dot(step) = v*cos(theta(step));
    y_dot(step) = v*sin(theta(step));
    theta_dot(step) = v / (L/tan(delta(step)));
    delta_dot(step) = phi*dt;
    

    x_guess = x(step) + x_dot(step) * dt;
    y_guess = y(step) + y_dot(step) * dt;
    theta_guess = theta(step) + theta_dot(step)*dt;
    delta_guess = delta(step) + delta_dot(step)*dt;

    

    error_y = y_track(step) - y_guess;
    error_x = x_track(step) - x_guess;
    error_theta = theta_track(step) - theta_guess;
    error_delta = delta_track - delta_guess;

    pcon_y = Kp*error_y;
    pcon_x = Kp*error_x;
    pcon_theta = Kp*error_theta;
    pcon_delta = Kp*error_delta;


    x = [x pcon_x];
    y = [y pcon_y];
    theta = [theta pcon_theta];
    delta = [delta pcon_delta];

%    R = L/tan(delta);

end

plot(y_track)
hold on;
plot(y)


%[x_f, y_f, x_r, y_r] = plotBike(x, y, L, theta)

%s = linspace(0, 10, 11);
%y_track = sqrt(10 - s.^2);
%y_track = 5*s
%plot(y_track, s)

%error_y = y_track - y
%error_x = s - x

%hold on 
%[x_f, y_f, x_r, y_r] = plotBike(x, y, L, theta)

%Kp = 0.5;% Get this into a PID
%pcon_y = Kp*error_y
%pcon_x = Kp*error_x


%bikeRear(pcon_y)
%[x_fp, y_fp, x_rp, y_rp] = plotBike(pcon_x, pcon_y, L, theta);