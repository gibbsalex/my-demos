%% Exploring the control chapter in Modern Robotics
% Error Dynamics ----
% theta_e = theta_d - theta
% Error Response ----
% = transient response + steady-state response
% Transient response = overshoot + settling time
% Steady-state response = steady-state error = theta_e(t)/theta_e(0)
clear; clc; clf;

t = linspace(0, 5);
k = 3;
b = 5;
%% First Order Error Dynamics
% dynm : thetadot = k/b*theta = 0
% soln : theta = e^(-t*b/k)*theta(0)

theta_0 = 1;

theta = exp(-t*b/k)*theta_0;
plot(t, theta)
hold on;
%% Second Order Error Dynamics
% dynm: thetaddot + b/m*thetadot + k/m*theta = 0
% soln: 
m = 1;

%   Overdamped: theta = c1*e^(s1*t) + c2*e^(s2*t)
k_o = 3;
b_o = 5;
omg_o = sqrt(k_o/m);
dmp_o = b_o/(2*sqrt(k_o*m));

lap_dyn = [1, 2*dmp_o*omg_o, omg_o^2]; %s^2 + 2*dmp*omg*s + omg^2
s_r = roots(lap_dyn)

s1 = s_r(1);
s2 = s_r(2);
c1 = 0.5 + dmp_o/(2*sqrt(dmp_o^2 - 1)); %Unit error response
c2 = 0.5 - dmp_o/(2*sqrt(dmp_o^2 - 1));
theta_Over = c1*exp(s1*t) + c2*exp(s2*t);
plot(t, theta_Over)

%   Critically: theta = (c1 + c2*t)e^(-omega*t)
k_c = 6;
b_c = 5;
omg_c = sqrt(k_c/m);
dmp_c = b_c/(2*sqrt(k_c*m));

s1_c = -omg_c;
c1_c = 1;
c2_c = omg_c;
theta_crit = (c1_c + c2_c*t).*exp(s1_c*t);
plot(t, theta_crit)

%   Underdmped: theta = (c1*cos(omega*t) + c2*sin(omega*t))e^(-dmp*omega*t)
k_u = 2;
b_u = 1;
omg_u = sqrt(k_u/m);
dmp_u = b_u/(2*sqrt(k_u*m));

c1_u = 1;
c2_u = dmp_u/sqrt(1-dmp_u^2);
omgd = omg_u*sqrt(1-dmp_u^2);
theta_und = (c1_u*cos(omgd*t) + c2_u*sin(omgd*t)).*exp(-dmp_u*omg_u*t);
plot(t, theta_und)
legend('First Order', '2nd - Over', ' 2nd - Crit', '2nd - Under')