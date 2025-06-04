import numpy as np

class Ball():
    def __init__(self):
        print("made a ball")

        # state = x, v
        self.state = np.array([10, 0])
        self.m = 1

    def __str__(self):
        return f"x = {np.round(self.state[0],2)}, v = {np.round(self.state[1],2)}"

    def dyn(self, state):
        ## xdot equations

        v = state[1]

        g = 9.8
        a = -self.m * g

        xdot = np.array([v, a])
        return xdot
    