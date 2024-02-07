%Plotting the bicycle model - might be overkill?
%[x_f, y_f, x_r, y_r] = plotBike(x, y, L, theta)

function [x_f, y_f, x_r, y_r] = plotBike(x, y, L, theta)

plot(x, y, "-*")
hold on

x_r = x;
y_r = y;
x_f = L*cos(theta) + x;
y_f = L*sin(theta) + y;

for step = [1:10]
    plot([x_r(step), x_f(step)], [y_r(step), y_f(step)])
end