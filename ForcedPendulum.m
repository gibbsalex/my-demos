%% 
% MAE 281b - Jorge Cortes Notes
% 
% Example 2.1(Forced Pendulum) - Chp: Stabilization by *State Feedback Control*
% 
% *Dynamics:* 
% 
% a = g/l, b = k/m > 0, c = 1/ml^2
% 
% $$\ddot{\theta} = -a\sin(\theta) - b\dot{\theta} + cT$$
% 
% At the desired torque, dynamics look like:
% 
% $$0 = -a\sin(\theta_d) - 0 + cT_d$$
% 
% $$T_d = \frac{a}{c}\sin(\theta_d)$$
% 
% *State Variables:*
% 
% $$x_1 = \theta - \theta_d$$
% 
% $$x_2 = \dot{\theta}$$
% 
% $$u = T - T_d$$
% 
% *Determine State-Space Equation:*
% 
% $$\dot{x_1} = x_2$$
% 
% $$\dot{x_2} = \ddot{\theta} = -a\sin(x_1 + \theta_d) - bx_2 + c(u + T_d)$$
% 
% update further to turn desired torque into state parameters
% 
% $$\dot{x_2} = \ddot{\theta} = -a\sin(x_1 + \theta_d) - bx_2 + cu + a\sin(\theta_d)$$
% 
% *Linearization at the origin:*

syms x1 x2
theta_d = pi/2
g = 9.8
l = 1
a = g/l

k = 2
m = 1
b = k/m

c = 1/(m*l^2)

A = [0 1; -a*cos(theta_d) -b]
B = [0; c]
%%
syms k1 k2
K = [k1 k2]
CL = A - B*K

E = eig(CL)
%% 
% $$T = u + T_d$$
% 
% $$T = \frac{a}{c}\sin(\theta_d) - k_1x_1-k_2x_2$$
% 
% $$\dot{x_2} =  -a\sin(x_1 + \theta_d) - bx_2 + cu + a\sin(\theta_d)$$

tspan = [0 5]
x0 = [0; 0]
K = [5 1] %eigs = -2.6180, -0.3820

[t, x] = ode45(@(t, x)pendulum(x, theta_d, a, b, c, K), tspan, x0);

plot(t, x)
yline(pi/2)
legend('\theta', '\theta_dot')
%plotting theta, and theta_dot
% the actual x1 of the graph is x1 = theta - theta_dot
% this would have convergence to x1 = 0 and x2 = 0
% it would be good to start the x0 away from pi/2
% some of these are
% this plot is just for fun
%%
function dxdt = pendulum(x, theta_d, a, b, c, K)
    theta = x(1);
    theta_dot = x(2);
    k1 = K(1);
    k2 = K(2);
    T = a/c*sin(theta_d) - k1*(theta - theta_d) - k2*theta_dot;
    %T_d = a/c*sin(theta_d);
    %u = T - T_d;
    dxdt = [x(2); -a*sin(theta) - b*theta_dot + c*T];
end