import numpy as np

class Torquer():
    def __init__(self, m, r, h, state0 = np.array([0, 0])):

        assert h != 0 # divide by zero error in dyn

        self.h = h # time constant
        self.m = m
        self.r = r
        self.I = 1/2 * m * r **2 # rotational inertia of flywheel
        self.state = state0 # theta, theta_dot

    def dyn(self, motor_u):

        # motor_u (new motor input = new motor speed)
        # a.k.a theta_dot_u
        theta_dot = self.state[1]

        theta_ddot = (theta_dot - motor_u) / self.h
        torq = 1 / self.I * theta_ddot

        theta_ddot = torq

        x_dot = np.array([[theta_dot], [theta_ddot]])

        return x_dot