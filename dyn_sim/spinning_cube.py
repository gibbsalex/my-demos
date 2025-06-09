import numpy as np
import matplotlib.pyplot as plt

import num_int
from vehicle import Cube
from actuator import Torquer

if __name__ == "__main__":
    h = 0.1
    
    cube_sat = Cube()
    torq = Torquer(m = 1, r = 1, h = h)

    print("IC: ", cube_sat)

    x_t = np.array([5,1,0,0,0,0])

    for i in range(10):
        
        u = -10 * (x_t - cube_sat.state)
        u_x = np.array(u[0], u[3])

        dyn_model = cube_sat.dyn()

        dyn_act1 = np.array([[1, 0], [0, 0], [0, 0], [0, 1], [0, 0], [0, 0]]) @ torq.dyn(u_x)
        
        clsd_loop = dyn_model + dyn_act1
        
        
        new_state = num_int.Euler(clsd_loop, h)
        
        cube_sat.save_to_history(new_state)

        cube_sat.state = new_state

        print(f"step {i}:", cube_sat)
    
    cube_sat.plot_me()