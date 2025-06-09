import numpy as np
import matplotlib.pyplot as plt

class Vehicle():
    # parent class, maybe physical parameters in the init
    # maybe track state number
    def __init__(self, state = 0):
        self.state = state
        self.state_history = [state]
    
    def __str__(self):
        # print all states, titles are helpful
        pass

    def save_to_history(self, new_state):
        self.state_history.append(new_state)

    def set_inital_cond(self, state):
        pass

    def dyn(self):
        #this is unique for all, but required for all
        pass

    def plotter(self):
        pass


class Ball():
    def __init__(self, x = 10, v = 0):
        print("made a ball")

        # state = x, v
        self.state = np.array([x, v])
        self.m = 1
        self.state_history = [self.state]

    def __str__(self):
        return f"x = {np.round(self.state[0],2)}, v = {np.round(self.state[1],2)}"

    def dyn(self, state):
        ## xdot equations

        v = state[1]

        g = 9.8
        a = -self.m * g

        xdot = np.array([v, a])
        return xdot
    
    def save_to_history(self, new_state):
        self.state_history.append(new_state)
    

class Cube():
    def __init__(self, th_x = 10, th_y = 0, th_z = 0, omg_x = 0, omg_y = 0, omg_z = 0):
        print("made a cube")

        self.state = np.array([th_x, th_y, th_z, omg_x, omg_y, omg_z]) # state = th_x, th_y, th_z, omg_x, omg_y, omg_z
        # state translation(to add later)
        self.r = 0.5 # m
        self.m = 1
        self.I = np.array([1/12 * self.m * (self.r**2 + self.r**2), 1/12 * self.m * (self.r**2 + self.r**2), 1/12 * self.m * (self.r**2 + self.r**2)]) # I_x, I_y, I_z 
        # rotational inertia(to add later)
        self.state_history = [self.state]

    def __str__(self):
        return f"th_x = {np.round(self.state[0],2)}, th_y = {np.round(self.state[1],2)}, th_z = {np.round(self.state[2],2)}, omg_x = {np.round(self.state[3],2)}, omg_y = {np.round(self.state[4],2)}, omg_z = {np.round(self.state[5],2)}"
    
    def dyn(self):

        omg_x = self.state[3]
        omg_y = self.state[4]
        omg_z = self.state[5]

        # sum M = I * alpha
        a_x = 0 # right now zero but it should be sum of torque / I_rot
        a_y = 0
        a_z = 0

        xdot = np.array([omg_x, omg_y, omg_z, a_x, a_y, a_z])

        return xdot
    
    def save_to_history(self, new_state):
        self.state_history.append(new_state)

    def plot_me(self):

        self.state_history = np.array(self.state_history)

        plt.figure()
        plt.subplot(2,1,1)
        plt.plot(self.state_history[0])
        plt.plot(self.state_history[1])
        plt.plot(self.state_history[2])
        plt.legend(['th_x', 'th_y', 'th_z'])


        plt.grid(True)

        plt.subplot(2,1,2)
        plt.plot(self.state_history[3])
        plt.plot(self.state_history[4])
        plt.plot(self.state_history[5])
        plt.legend(['omg_x', 'omg_y', 'omg_z'])
        plt.grid(True)


        plt.show()