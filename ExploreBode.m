clear; clc; close all;
m1 = 2054/4;
m2 = 1;
def = 0.024638
k = def * m1*9.8;
b = 1;

H1 = tf([b k 0], [m1 b k]);

bode(H1)
hold on;

m = 1;
k = 1;
c = 0.5;
H2 = tf([1], [m c k]);
bode(H2);
