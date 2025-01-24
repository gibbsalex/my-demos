%% Determine lengths of linkages in bike frame
% convert the pixel count to lengths 
clear; clc;


A = [2089, 784];
B = [1661, 991];
C = [1534, 1051];
D = [1463, 1071];
E = [1672, 1110];
F = [709, 1467];
G = [806, 1502];
H = [1549, 1386];
I = [1590, 1494];

pts = [A; B; C; D; E; F; G; H];
%plot(pts(:, 1), -1*pts(:, 2), "*");

%convert
A_in = [pixToInch(A(1)), pixToInch(A(2))];
B_in = [pixToInch(B(1)), pixToInch(B(2))];
C_in = [pixToInch(C(1)), pixToInch(C(2))];
D_in = [pixToInch(D(1)), pixToInch(D(2))];
E_in = [pixToInch(E(1)), pixToInch(E(2))];
F_in = [pixToInch(F(1)), pixToInch(F(2))];
G_in = [pixToInch(G(1)), pixToInch(G(2))];
H_in = [pixToInch(H(1)), pixToInch(H(2))];
I_in = [pixToInch(I(1)), pixToInch(I(2))];

pts_in = [A_in; B_in; C_in; D_in; E_in; F_in; G_in; H_in; I_in];
plot(pts_in(:, 1), -1*pts_in(:, 2), "*");



%l1 A to B
l1 = link(A_in(1), B_in(1), A_in(2), B_in(2))
%l2 B to C
l2 = link(B_in(1), C_in(1), B_in(2), C_in(2))
%l3 C to D
l3 = link(C_in(1), D_in(1), C_in(2), D_in(2))
%l4 C to E
l4 = link(C_in(1), E_in(1), C_in(2), E_in(2))
%l5 D to F
l5 = link(D_in(1), F_in(1), D_in(2), F_in(2))
%l6 F to G
l6 = link(F_in(1), G_in(1), F_in(2), G_in(2))
%l7 G t H
l7 = link(G_in(1), H_in(1), G_in(2), H_in(2))

%% Simplified Model
% H, G, D, E


%% Functions
function in = pixToInch(pix)
    % Relative distance based off back wheel
    % 855 to 2061 = 27.5"
    % 2061 - 855 = 1206
    in = pix/1206 * 27.5;
end