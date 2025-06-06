
import matplotlib.pyplot as plt

import num_int
from vehicle import Cube

if __name__ == "__main__":
    cube_sat = Cube()

    print("IC: ", cube_sat)

    h = 0.1

    for i in range(10):
        new_state = num_int.Euler(cube_sat, h)
        
        cube_sat.save_to_history(new_state)

        cube_sat.state = new_state

        print(f"step {i}:", cube_sat)
    
    cube_sat.plot_me()