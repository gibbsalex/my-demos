import numpy as np


# build model
# delta_x = omega_dot

I_1, I_2, I_3 = 1000, 1100, 1200

delta_t = 0.01  # time step

M_1 = 0
M_2 = 0
M_3 = 0
M = np.array([[M_1], [M_2], [M_3]])  # shape (3,1)


## STATE VECTOR WILL BE ROLL, PITCH, YAW
x = np.zeros((3,2)) # initial conditions for the state vector

curr_x = x[:, -1].reshape(-1, 1)  # last column of x

omg = (curr_x - x[:, -2].reshape(-1, 1)) / delta_t
omg_1, omg_2, omg_3 = omg  # angular velocities

## Euler's Equations for Rigid Body Dynamics
# x = omega, ang vel
accel_1 = 1/I_1 * (M_1 - (I_3 - I_2) * omg_2 * omg_3)
accel_2 = 1/I_2 * (M_2 - (I_1 - I_3) * omg_3 * omg_1)
accel_3 = 1/I_3 * (M_3 - (I_2 - I_1) * omg_1 * omg_2)

## Step response, orient the attitude to 15 degrees
# Desired State
x_d = np.array([[np.pi/6], [0], [0]])  # target roll, pitch, yaw (15 degrees in radians)

# Build Controller
# u = K * error
K_p, K_i, K_d = 10, 10, 10

e, e_i, e_d = x_d - curr_x, np.zeros((3,1)), np.zeros((3,1))  # error, integral of error, derivative of error
M_1 = K_p * e + K_i * e_i + K_d * e_d
M_2 = K_p * e + K_i * e_i + K_d * e_d
M_3 = K_p * e + K_i * e_i + K_d * e_d

# Simulate the system using Euler Integration
# x_t+1 = x_t + delta_x * delta_t
next_x = curr_x.reshape(-1, 1) + np.array([[accel_1], [accel_2], [accel_3]]) * delta_t
x = np.hstack((x, next_x.reshape(-1, 1)))  # append the new state to x

t = 0  # initial time
while(t < 10):
    # Update the current state
    curr_x = x[:, -1]
    
    # Calculate angular velocities
    omg = (curr_x - x[:, -2]) / delta_t

    omg_1, omg_2, omg_3 = omg
    
    # Update accelerations
    accel_1 = 1/I_1 * (M_1 - (I_3 - I_2) * omg_2 * omg_3)


    accel_2 = 1/I_2 * (M_2 - (I_1 - I_3) * omg_3 * omg_1)
    accel_3 = 1/I_3 * (M_3 - (I_2 - I_1) * omg_1 * omg_2)
    
    # Update next state
    next_x = curr_x.reshape(-1, 1) + np.array([[accel_1], [accel_2], [accel_3]]) * delta_t
    
    
    x = np.hstack((x, next_x.reshape(-1, 1)))
    
    t += delta_t


## DATA VIZ
# Plot state over time
# vpython?
