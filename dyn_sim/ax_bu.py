import numpy as np

# a simple example of a state-space propogation of a state
# A represents the plant dynamics
# x_t1 represents the plant state
# B represents the control dynamics
# u represents the control inputs

# organization of this is very simple
# the structure is very rigid
# what if we want to add more actuators
#   B will need to adapt to the number of actuators

if __name__ == "__main__":

    h = 0.1 # time step

    A = np.array([[1, 0, 0], [0, 1, 0], [0, 0, 1]]) # plant dynamics

    B = np.array([[1, 0, 0], [0, 1, 0], [0, 0, 1]])

    x_t1 = np.array([[1], [0], [0]])

    u = np.array([[1], [1], [1]])

    x_t2 = x_t1 + h * (A @ x_t1 + B @ u)

    print(x_t2)