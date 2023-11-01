%% Exploring PID controllers using RR Robotics
%Example following: http://robotics.ucsd.edu/RR.pdf
%See section 11.3.1 PID(Proportional-Integral-Derivative) controllers
clear; clc; close all;


K = 1; % Proportionallity Constant
Ti = 10; %Time constant for integral term. Typically Ti>Td
Td = 0.01; %TIme constant for the derivative term

%D = K * (1 + 1/(Ti*s) + Td * s)

%PID
D = K*Td* tf([1 1/Td 1/(Td*Ti)], [1 0] )
bode(D);% showing exponential integral and derivative action
hold on
legend("AutoUpdate","on")

%Proportional Controller
Dp = tf(K, 1)
bode(Dp)

%Derivative Controller
Dd = tf([K 0], [1])
bode(Dd)

%Integral Controller
Di = tf([K], [1 0])
bode(Di)

%Propotional Derivative Controller
Dpd = Dp + Dd
bode(Dpd)

%Proportinal Integral Controller
Dpi = Dp + Di
bode(Dpi)
%%
close all;
figure; 
rlocus(D)

K2 = 6;
D2 = K2*Td* tf([1 1/Td 1/(Td*Ti)], [1 0] )
figure;
rlocus(D2)


%% Changing Ti and Td
close all;

%Pg 11-18
%"Taking Ti -> inf and Td -> 0 reduces PID to a P controller
%Taking Ti -> inf or Td -> 0 reduces PID to a PD or PI

K_1 = [1]; % Proportionallity Constant
Ti_1 = [10]; %Time constant for integral term. Typically Ti>Td
Td_1 = 0.01; %TIme constant for the derivative term

K_2 = 1;
Ti_2 = 100;
Td_2 = 0.01;
%D = K * (1 + 1/(Ti*s) + Td * s)

%PID
D = K_1*Td_1* tf([1 1/Td_1 1/(Td_1*Ti_1)], [1 0] )
D2 = K_2*Td_2* tf([1 1/Td_2 1/(Td_2*Ti_2)], [1 0] )
bode(D);% showing exponential integral and derivative action
hold on; legend("AutoUpdate","on")

bode(D2)
bode(Dp)