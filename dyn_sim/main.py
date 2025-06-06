import numpy as np
import matplotlib.pyplot as plt

import num_int
from vehicle import Ball


if __name__ == "__main__":
    print("running simulation")

    myBall = Ball()
    myBall2 = Ball()

    print(f"initial conditions:", myBall)

    h = 0.1

    euler_ball_state = [myBall.state]
    rk_ball_state = [myBall2.state]

    for i in range(100):

        #sim euler
        new_state = num_int.Euler(myBall, h)
        myBall.state = new_state
        print(f"step {i}: ", myBall)

        #sim rk
        new_state2 = num_int.RungeKutta(myBall2, h)
        myBall2.state = new_state2
        print(f"step {i}: ", myBall2)

        #save data
        euler_ball_state.append(new_state)
        rk_ball_state.append(new_state2)


    euler_ball_state = np.array(euler_ball_state)
    rk_ball_state = np.array(rk_ball_state)

    plt.figure(1)
    plt.subplot(2, 1, 1)
    plt.plot(euler_ball_state[:,0])
    plt.plot(rk_ball_state[:,0])
    plt.title("Position")

    plt.subplot(2,1,2)
    plt.plot(euler_ball_state[:,1])
    plt.plot(rk_ball_state[:,1])
    plt.title("Velocity")

    plt.legend(['euler', 'rk'])
    plt.show()