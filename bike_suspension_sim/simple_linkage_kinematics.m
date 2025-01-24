%% Kinematics 4bar Linkage
clear; clc; 

l1 = 1;
l2 = 2;
l3 = 3;
l4 = 4;

syms theta1(t) theta2(t) theta3(t) t;

pos_x = l1*cos(theta1) + l2*cos(theta2) + l3*cos(theta3) == 0;
pos_y = l1*sin(theta1) + l2*sin(theta2) + l3*sin(theta3) + l4 == 0;

vel_x = diff(pos_x, t) == 0;
vel_y = diff(pos_y, t) == 0;


acc_x = diff(vel_x, t) == 0;
acc_y = diff(vel_y, t) == 0;

eqns = [pos_x, pos_y, vel_x, vel_y, acc_x, acc_y];

time = linspace(1, 100);
theta_u = pi/10*time;

theta1 = theta_u;

vars = [theta2(t), theta3(t)]

Y = solve(eqns, vars)