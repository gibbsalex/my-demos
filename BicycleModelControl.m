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

% xdot = Ax + Bu
% x = x, y, theta
% A = [v*cos(theta), v*sin(theta), v / (L/tan(delta))]
% u = delta
% control on delta
% if state is off of line, update next turn with delta

[new_x, new_y, new_theta] = bikeRear(L, v, x, y, delta(1), theta(1), dt)

error_x = new_x - x(1)
error_y = new_y - y(1)
error_theta = new_theta - theta(1)

new_delta = tan(error_y/error_x) 

x(2) = new_x 
y(2) = new_y
theta(2) = new_theta

[new_x, new_y, new_theta] = bikeRear(L, v, x(2), y(2), new_delta, theta(2), dt)

error_x(2) = new_x - x(2)
error_y(2) = new_y - y(2)
error_theta(2) = new_theta - theta(2)

for step = [1: 10]
    [new_x, new_y, new_theta] = bikeRear(L, v, x(step), y(step), delta(step), theta(step), dt);

    error_x(step) = new_x - x_track(step);
    error_y(step) = new_y - y_track(step);
    error_theta(step) = new_theta - tan(y_track(step)/x_track(step));
    
    x(step+1) = new_x;
    y(step+1) = new_y;
    delta(step+1) = error_theta(step)%tan(error_y(step)/error_x(step)) ; %maybe this should be the error in turning
    theta(step+1) = new_theta;
end

plot(x_track, y_track, "LineWidth", 5)
hold on;
%plot(y)


[x_f, y_f, x_r, y_r] = plotBike(x, y, L, theta)
%% Old Appendix - Old code with 4 states
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