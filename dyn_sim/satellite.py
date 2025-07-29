import numpy as np
import matplotlib.pyplot as plt

class Cube():
    def __init__(self, h, x, m, w, d):
        self.h = h
        self.m = m
        self.w = w
        self.d = d
        self.I = 1/12 * self.m * (w**2 + d**2)# cuboid thru center
        self.x = np.array([x]) # state = theta, theta_d

    def dyn(self, torq):

        x_dot = np.array([self.x[-1][1], 1/self.I * torq]) # theta_dot, theta_ddot

        return x_dot

    def euler(self, torq):

        x_t1 = self.x[-1]
        x_t2 = x_t1 + self.h * self.dyn(torq)

        self.x = np.append(self.x, [x_t2], axis = 0)


if __name__ == "__main__":

    x0 = np.array([np.pi/6, 0])
    h = 0.1

    sat = Cube(h = h, x = x0, m = 10, w = 2, d = 3)

    x_d = np.array([np.pi/4, 0])


    for i in range(500):
        err = x_d - sat.x[-1]
        Kp = .1
        Kd = 2
        u = Kp * err[0] + Kd * err[1]
        sat.euler(u)

    print(sat.x)

    plt.plot(sat.x)
    plt.hlines(y=np.pi/4, xmin=0, xmax=i, colors= 'r')
    plt.show()
    

