%% simple_attitude_rocket_sim parameters



I = 0.003;
F_t = 1; % thrust
d = 0.25; %m

%Linearized system
s = tf('s');
sys = (F_t * d) / ( I * s^2)