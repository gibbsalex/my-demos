%This is the first attempt at using a function to solve bicycle model
%dynamics
%[x_end, y_end, theta_end, delta_end] = bikeRear(L, v, phi, x, y, delta, theta, dt)
%states: x, y, theta


function [x_end, y_end, theta_end] = bikeRear(L, v, x, y, delta, theta, dt)
    
    x_dot = v*cos(theta);
    y_dot = v*sin(theta);
    
    R = L/tan(delta); %Radius to ICR
    
    theta_dot = v / (L/tan(delta)); %rotation rate
    
    x_end = x + x_dot * dt;
    y_end = y + y_dot * dt;
    theta_end = theta + theta_dot*dt;

end