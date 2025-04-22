import numpy as np
import matplotlib.pyplot as plt
import math

from numerical_integrators import numerical_integration_methods
from governing_eqns import flat_earth_eom

from vehicle_models.sphere import spheres

r_sphere_m = 0.08
m_sphere_kg = 5
J_sphere_kgm2 = 0.4*m_sphere_kg*r_sphere_m**2

#amod = {"m_kg": 1, \
#        "Jxz_b_kgm2": 0, \
#            "Jxx_b_kgm2": J_sphere_kgm2, \
#                "Jyy_b_kgm2": J_sphere_kgm2, \
#                    "Jzz_b_kgm2": J_sphere_kgm2}

vmod = spheres.BowlingBall()

print(f"The analytical terminal velocity is{vmod['Vterm_mps']:.2f} m/s.")

amod = vmod # for now

# set inital conditions
u0_bf_mps = 0.001
v0_bf_mps = 0
w0_bf_mps = 0
p0_bf_rps = 0
q0_bf_rps = 0
r0_bf_rps = 0
phi0_rad = 0 * math.pi/180
theta0_rad = -90 * math.pi/180
psi0_rad = 0
p10_n_m = 0
p20_n_m = 0
p30_n_m = -10000

x0 = np.array([
    u0_bf_mps, # x-axis body-fixed vel (m/s)
    v0_bf_mps, # y-axis body-fixed vel (m/s)
    w0_bf_mps, # z-axis body-fixed vel (m/s)
    p0_bf_rps, # roll rate (rad/s)
    q0_bf_rps, # pitch rate (rad/s)
    r0_bf_rps, # yaw rate (rad/s)
    phi0_rad, # roll ang (rad)
    theta0_rad, # pitch ang (rad)
    psi0_rad, # yaw ang (rad)
    p10_n_m, # x-axis pos (N*m)
    p20_n_m, # y-axis pos (N*m)
    p30_n_m # z-axis pos (N*m)
])

# initial condition array is a columm vector
x0 = x0.transpose(); nx0 = x0.size

# set time conditions
t0_s = 0.0
tf_s = 10.0 # 185
h_s = 0.01 # time step

## Numerically approximate the solutions to the governing equations

# preallocate the solution array
t_s = np.arange(t0_s, tf_s + h_s, h_s); nt_s = t_s.size
x = np.zeros((nx0, nt_s))

# assign the initial cond to the soln array
x[:, 0] = x0

# perform forward euler integration === Run Simulation
t_s, x = numerical_integration_methods.forward_euler(flat_earth_eom.flat_earth_eom, t_s, x, h_s, vmod, amod)

True_Airspeed_mps = np.zeros((nt_s, 1))
for i, elememt in enumerate(t_s):
    True_Airspeed_mps[i, 0] = math.sqrt(x[0, i]**2 + x[1, i]**2 + x[2, i]**2)

# Altitidue, speed of sound, and air density
Altitude_m = np.zeros((nt_s, 1))
Cs_mps = np.zeros((nt_s, 1))
Rho_kgpm3 = np.zeros((nt_s, 1))

for i, ele in enumerate(t_s):
    Altitude_m[i, 0] = -x[11, i]
    #Cs_mps[i, 0] = fastInterp1()
    #Rho_kgpm3[i, 0] = fastInterp1()

# Angle of Attack
alpha_rad = np.zeros((nt_s, 1))
for i, ele in enumerate(t_s):

    if x[0, i] == 0 and x[2, i] == 0:
        w_over_v = 0
    else:
        w_over_v = x[2, i]/x[0, i]
    
    alpha_rad[i, 0] = math.atan(w_over_v)

# Angle of side-slip
beta_rad = np.zeros((nt_s, 1))
for i, ele in enumerate(t_s):
    if x[1, i] == 0 and True_Airspeed_mps[i, 0] == 0:
        v_over_VT = 0
    else:
        v_over_VT = x[1, i]/True_Airspeed_mps[i, 0]

    beta_rad[i, 0] = math.asin(v_over_VT)

# Mach Number
Mach = np.zeros((nt_s, 1))
for i, ele in enumerate(t_s):
    Mach[i, 0] = True_Airspeed_mps[i, 0]/Cs_mps[i, 0]

print(f"numerical terminal velocity is {x[0, -1]:.2f} m/s.")

# data plotting
fig, axes = plt.subplots(2, 4, figsize=(10,6)) # 1 row, 2 cols

# axial velocity u^b_CM/n
axes[0, 0].plot(t_s, x[0,:])
axes[0, 0].set_xlabel('Time [s]')
axes[0, 0].set_ylabel('u [m/s]')
axes[0, 0].grid(True)

# axial velocity v^b_CM/n
axes[0, 1].plot(t_s, x[1,:])
axes[0, 1].set_xlabel('Time [s]')
axes[0, 1].set_ylabel('v [m/s]')
axes[0, 1].grid(True)

# axial velocity w^b_CM/n
axes[0, 2].plot(t_s, x[2,:])
axes[0, 2].set_xlabel('Time [s]')
axes[0, 2].set_ylabel('w [m/s]')
axes[0, 2].grid(True)

# roll angle, phi
axes[0, 3].plot(t_s, x[6,:])
axes[0, 3].set_xlabel('Time [s]')
axes[0, 3].set_ylabel('phi [rad]')
axes[0, 3].grid(True)

# roll rate, p^b_b/n
axes[1, 0].plot(t_s, x[3,:])
axes[1, 0].set_xlabel('Time [s]')
axes[1, 0].set_ylabel('p [rad/s]')
axes[1, 0].grid(True)

# pitch rate, q^b_b/n
axes[1, 1].plot(t_s, x[4,:])
axes[1, 1].set_xlabel('Time [s]')
axes[1, 1].set_ylabel('q [rad/s]')
axes[1, 1].grid(True)

# yaw rate, r^b_b/n
axes[1, 2].plot(t_s, x[5,:])
axes[1, 2].set_xlabel('Time [s]')
axes[1, 2].set_ylabel('r [rad/s]')
axes[1, 2].grid(True)

# pitch angle, theta
axes[1, 3].plot(t_s, x[7,:])
axes[1, 3].set_xlabel('Time [s]')
axes[1, 3].set_ylabel('theta [rad]')
axes[1, 3].grid(True)

plt.tight_layout()
#plt.savefig('saved_figures/sphere_drop_test_1.png')


ax2 = plt.figure(2).add_subplot(projection='3d')
ax2.plot(x[9,:], x[10,:], x[11,:], label = 'traj')
ax2.legend()
plt.show()

print("Simulation Complete")