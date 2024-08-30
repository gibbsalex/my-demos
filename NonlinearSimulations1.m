

%% Simulate nonlinear dynamics - MATLAB

tspan = [0 5];
y0 = 0;

[t, y] = ode45(@(t, y) 2*t, tspan, y0);

plot(t, y)

%% Van der Pol equation - MATLAB

% y1' = y2
% y2' = mu(1 - y1^2)*y2 - y1

[t, y] = ode45(@vdp, [0 20], [2; 0])

plot(t, y)

%% Jorge Cortez - Lecture 1 - MAE 281b
%ex: 1.1
% x' = x^2 + u
clear; clc;

%[t, x] = ode45(@ex1, [0 5], [2]);
%plot(t, x)

% Process of linearization
% x'(t) = f(x(t), u(t), t)
% y(t) = g(x(t), u(t), t)

% ex: x'(t) = x^2 + u

% Linearization is valid around an operating point
% deltaX = x(t) - x0
% deltaU = u(t) - u0
% deltaY = y(t) - y0
syms xsym usym
x0 = 0 %origin
u0 = 0
t = linspace(1,5)
A = subs(jacobian(ex1(t, xsym, usym), xsym), xsym, x0)
B = subs(jacobian(ex1(t, xsym, usym), usym), usym, u0)

x_bar_dot = A*xsym + B*usym
% local stabilization with u = - K*x

%%
function dydt = vdp(t, y)
    mu = 1
    dydt = [y(2); (mu - y(1)^2)*y(2)-y(1)]

end


function dxdt = ex1(t, x, u)
    dxdt = x^2 + u
end