
clear; clc;

D = [1463, 1071];
E = [1672, 1110];
G = [806, 1502];
H = [1549, 1386];

D_in = [pixToInch(D(1)), pixToInch(D(2))];
E_in = [pixToInch(E(1)), pixToInch(E(2))];
G_in = [pixToInch(G(1)), pixToInch(G(2))];
H_in = [pixToInch(H(1)), pixToInch(H(2))];

pts_in = [E_in; D_in; G_in; H_in];
plot(pts_in(:, 1), -1*pts_in(:, 2), "*-");
%%

% link1 = E to D
link1 = link(E_in(1), D_in(1), E_in(2), D_in(2));
% link2 = D to G
link2 = link(D_in(1), G_in(1), D_in(2), G_in(2));
% link3 = G to H
link3 = link(G_in(1), H_in(1), G_in(2), H_in(2));
% link4 = H to E
link4 = link(H_in(1), E_in(1), H_in(2), E_in(2));

links = [link1, link2, link3, link4];

%% check that this sums to zero in original configuration

x = link1.len*cos(link1.ang_init)+link2.len*cos(link2.ang_init)+link3.len*cos(link3.ang_init)+link4.len*cos(link4.ang_init)
y = link1.len*sin(link1.ang_init)+link2.len*sin(link2.ang_init)+link3.len*sin(link3.ang_init)+link4.len*sin(link4.ang_init)
%% need optimization toolbox - doesnt work because I added more params
%fun = @kine;
%th0 = [link1.ang_init, link2.ang_init, link3.ang_init, link4.ang_init];
%pos = fsolve(fun, th0)

%% test the next step

%find at this new th3(new wheel pos)
th3_input = link3.ang_init + pi/10

%init function at params
fun = @(th) kine(th, th3_input, links)
th0 = [link1.ang_init+0.001, link2.ang_init, link3.ang_init, link4.ang_init];
pos = fsolve(fun, th0)

%% plot results
%D,E,G,H

E = [0, 0]
D = [link1.len*cos(pos(1)), link1.len*sin(pos(1))]
G = [link2.len*cos(pos(2)) + D(1), link2.len*sin(pos(2)) + D(2)]
H = [link3.len*cos(pos(3)) + G(1), link3.len*sin(pos(3)) + G(2)]


pts_solns = [E; D; G; H]
figure(2)
plot(pts_solns(:,1), pts_solns(:, 2), "*-")

%% - Doesnt solve because our system is nonlinear
%syms th1 th2 th3 th4
%eq1 = link1.len*cos(th1)+link2.len*cos(th2)+link3.len*cos(th3)+link4.len*cos(th4) == 0;
%eq2 = link1.len*sin(th1)+link2.len*sin(th2)+link3.len*sin(th3)+link4.len*sin(th4) == 0;

%solu = solve([eq1, eq2], [th1, th2, th3, th4])

%% Functions
function in = pixToInch(pix)
    % Relative distance based off back wheel
    % 855 to 2061 = 27.5"
    % 2061 - 855 = 1206
    in = pix/1206 * 27.5;
end

function pos = kine(th, th3_input, links)
    
    % link1 = E to D
    link1 = links(1);
    % link2 = D to G
    link2 = links(2);
    % link3 = G to H
    link3 = links(3);
    % link4 = H to E
    link4 = links(4);

    pos(1) = link1.len*cos(th(1))+link2.len*cos(th(2))+link3.len*cos(th3_input)+link4.len*cos(link4.ang_init);
    pos(2) = link1.len*sin(th(1))+link2.len*sin(th(2))+link3.len*sin(th3_input)+link4.len*sin(link4.ang_init);
end