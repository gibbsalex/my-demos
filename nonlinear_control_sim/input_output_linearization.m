%% Example 2.7 in Jorge Cortes MAE 281b Nonlinear Control
clear; clc;

%plot simulation
%[t, x] = ode45(@innout, [0 20], [1; 1; 1]);
%plot(t, x(:,3), '-o'); %observer y = x3

% is the zero dyn at minimum phase? is it asymp stable? not able to
% determine
syms n(t)
z2 = 0;

ode = diff(n,t) == -(n + sin(z2))^3 - (cos(z2))^2*cos(n + sin(z2));
ode2 = diff(n, t) == -(n)^3 -cos(n);

nSol(t) = dsolve(ode)
nSol2(t) = dsolve(ode2)

function dxdt = innout(t, x)
    x1 = x(1);
    x2 = x(2);
    x3 = x(3);

    k1 = 1;
    k2 = 1;
    k3 = 10;

    u = -k1*x1 - k2*x2 - k3*x3;

    %dynamics
    x1dot = -x1^3 + cos(x2) * u;
    x2dot = cos(x1)*cos(x2) + u;
    x3dot = x2;

    %change of coords - transformation
    %z1 = x3
    %z2 = x2
    %n = x1 - sin(x2)

    %new system "normal form"
    % z1dot = z2
    % z2dot = cos(n + sin(z2))*cos(z2) + u
    % ndot = -(n + sin(z2))^3 - (cos(z2))^2*cos(n + sin(z2))
    % ^ "internal dynamics" = can't be made linear

    dxdt = [x1dot; x2dot; x3dot];
end