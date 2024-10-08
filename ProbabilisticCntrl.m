%LaValle Mobile Robotics
% Tricycle dynamics
% Euler approximation
% Nondeterministic Control Systems
% Injected noise in the control

%Plot the PDF to see the final locations of the tricycles
% It's cool to get a normal distribution as the noise was normally
% distributed
clear; clc;

tspan = [0 5];
state0 = [0, 0, 0]';
u = [1, 0]; %drive straight

carts = 5;
steps = 25;

state = zeros(carts, steps);

for exp = 1:100
    x = [0; 0; 0];
    for i = 1:25
        w = [0.1*rand(1)-0.05, 0.1*rand(1)-0.05];
    
        dxdt = trike(x(:, i), u, w);
        x(:, i+1) = dxdt + x(:, i);
    end
    test(exp) = {x};

    plot(x(1, :), x(2,:), 'k')
    hold on
end

xlabel('x pos')
ylabel('y pos')

for car = 1:length(test)
    
    curr_car = test{car};
    last_y = curr_car(2,end);
    all_final_y(car) = last_y;
end 
figure(2)
histogram(all_final_y, 20)
title("PDF of final Y position of each tricycle")
xlabel('y final pos')
ylabel('Amount of times found in this bin')

function dxdt = trike(state, u, w)
    l = 1;

    x = state(1);
    y = state(2);
    theta = state(3);

    s = u(1);
    phi = u(2);
    w1 = w(1);
    w2 = w(2);

    dxdt = [(s + w1)*cos(theta); (s + w1)* sin(theta); (s + w1)/l*tan(phi + w2)];
end