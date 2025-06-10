import numpy as np
import matplotlib.pyplot as plt

# ball bounce example
# actuator sense when close and applies impact ground contact

class Model():
    def __init__(self, h, x):
        self.h = h
        self.x = [x]
        self.dyn = np.zeros(x.shape) # going to keep as nonlinear structure

    def set_plant(self, plant_dyn):
        if self.x[-1].shape == plant_dyn.shape:
            self.dyn = plant_dyn
        else:
            print("plant dimensions do not align with state")
    
    def add_actuator(self, actuator):
        if actuator.shape == self.dyn.shape:
            self.dyn = self.dyn + actuator
        else:
            print("actuator does not match plant shape")
            print(f"plant: {self.dyn.shape}, act: {actuator.shape}")

    def euler(self):

        x_t2 = self.x[-1] + self.h * self.dyn

        if x_t2[0] < 0: # check if ball has bounced
            x_t2 = -1 * x_t2
        
        self.x.append(x_t2)

    def rk4(self):

        x_t1 = self.x[-1]

        k1 = self.dyn # how do we get this to depend on state
        k2 = self.dyn # x + h * k1/2
        k3 = self.dyn # x + h * k2/2
        k4 = self.dyn # x + h * k3

        x_t2 = x_t1 + self.h/6 * (k1 + 2*k2 + 2*k3 + k4)

        self.x.append(x_t2)

    def plotter(self):
        print(self.x)
        vals = np.stack(self.x, axis = 1)
        print(vals)
        print(vals.shape)
        #plt.plot(vals)




if __name__ == "__main__":
    
    # Falling Ball: dynamics example does not depend on state
    x0 = np.array([[1], [0]])# state = x, v
    ball = Model(h = 0.1, x = x0)

    m = 10
    g = 9.8

    ball.set_plant(np.array([ball.x[-1][1], [-m*g]]))

    act1 = np.array([[0], [10000]]) #actuator is a constant positive force
    ball.add_actuator(act1)
    #print(ball.x)

    ball.euler()
    #print(ball.x)

    ball.plotter()


    # Dynamics that depend on state
    #ball.rk4()
    #print(ball.x)