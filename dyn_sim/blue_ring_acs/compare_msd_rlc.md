Low Pass Filter Structures:

### Impedance of a System:
Mechanical:
Mass-Spring-Damper

Electrical:
Resistor-Capacitor-Inductor

### Variables:
Mechanical:
force, position, velocity

Electrical:
current, voltage

### System Response

mass spring ---
Force ---> [Spring k] ---> Mass
m a + k x = F_applied
Behavior: Delay in spring force doesnt keep up with high-frequency forces. Acts as a low-pass filter for force.
omega_n = sqrt(k/m)

mass damper --- 
Force ---> [Damper b] ---> Mass
m a + bv = F_applied
Behavior: High-frequency forces are strongly restricted. Acts as a low-pass filter for displacement.

mass spring damper ---
Force ---> [Spring k] ---> [Damper b] ---> Mass
kx = bv = ma = F_applied
Displacement: Added
Force: Shared
Behavior: mass inertia dominates, but the system response depends on the ratio of the components.

mass spring damper --- 
            [Spring k]
          ┌───/\/\/\───┐
Force --->│            │---> Mass
          └─[Damper b]─┘
ma + kx + bv = F_applied
-- Displacement: Shared
-- Force: Added, mass feels kx + bv
Acts as a second order 




Electrical:
resistor capacitor |