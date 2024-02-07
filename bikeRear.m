%This is the first attempt at using a function to solve bicycle model
%dynamics
%[x_end, y_end, theta_end, delta_end] = bikeRear(L, v, phi, x, y, delta, theta, dt)


function [x_end, y_end, theta_end, delta_end] = bikeRear(L, v, phi, x, y, delta, theta, dt)
    
    x_dot = v*cos(theta);
    y_dot = v*sin(theta);
    
    R = L/tan(delta); %Radius to ICR
    
    theta_dot = v / (L/tan(delta)); %rotation rate
    

    delta_dot = phi*dt;
    
    x_end = x + x_dot * dt;
    y_end = y + y_dot * dt;
    theta_end = theta + theta_dot*dt;
    delta_end = delta + delta_dot*dt;


end