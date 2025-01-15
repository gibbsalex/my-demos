%% Lecture 2 Jorge Cortes 281b notes

% goal: transform a nonlinear control system affine-inputs into a linear
% system

% method: state feedback control + change of coordinates

% Nonlinear control affine system:
% xdot = f(x) + G(x)u
% y = h(x)

% state feedback control law
% u = alpha(x) + beta(x)v

% change of variables (nonlinear -> linear)
% z = T(x) where T must follow diffeomorphism

% nonlinear system must look like
% xdot = Ax + B*gamma(x)*(u-alpha(x))

%Start with
% x1dot = a*sin(x2)
% x2dot = -x1^2 + u

% (x1, x2) -> (x1, a*sin(x2))

[t,y] = ode45(@dyn_z,[0 20],[2; 0]);

plot(t,y(:,1),'-o',t,y(:,2),'-o')
title('Solution of Nonlinear System + local change of coords');
xlabel('Time t');
ylabel('Solution y');
legend('y_1','y_2')

function dzdt = dyn_z(t, z)
    z1 = z(1);
    z2 = z(2);

    a = 1;
    
    k1 = 1;
    k2 = 1;
    v = -k1*z1 -k2*z2;
    u = z1^2 + 1/(a*cos(asin(z2/a)))*v;

    z1_dot = z2; % = z2
    z2_dot = a*cos(asin(z2/a))*(-z1^2 + u); % = v
    
    dzdt = [z1_dot; z2_dot];
end