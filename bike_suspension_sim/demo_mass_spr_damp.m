m = 1;
c = 0.5;
k = 4.0;
fs = 400;%hz

s = tf('s');
sys = 1/(m*s^2 + c*s + k);

sys_d = c2d(sys, 1/fs, 'zoh')

bode(sys_d, sys)
legend('sys_d', 'sys')