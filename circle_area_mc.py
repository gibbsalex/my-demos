import matplotlib.pyplot as plt
import random
import numpy as np
import time

def generate_pt():

    x = random.uniform(-1, 1)
    y = random.uniform(-1, 1)

    return x, y

if __name__ ==  "__main__":
    print("starting sim")

    

    # Define square corners
    x = [-1, 1, 1, -1, -1]
    y = [-1, -1, 1, 1, -1]

    c1 = plt.Circle((0,0), 1, edgecolor='red', fill=False, linewidth=2)

    # Plot the square
    plt.plot(x, y, 'b-')  # 'b-' means blue solid line
    plt.axhline(0, color='gray', linewidth=0.5)  # x-axis
    plt.axvline(0, color='gray', linewidth=0.5)  # y-axis
    plt.gca().add_patch(c1)
    plt.gca().set_aspect('equal')  # Keep square aspect ratio
    plt.grid(True)
    plt.title("Square Around Origin")

    total_pts = 1000
    pts_in_circle = 0
    for i in range(total_pts):
        xtest, ytest = generate_pt()

        plt.plot(xtest, ytest, "*")

        if (xtest - 0)**2 + (ytest - 0)**2 < 1**2:
            pts_in_circle += 1

    ratio = pts_in_circle / total_pts
    print(ratio)
    print("Square Area is 1 x 1 = 1")
    print(f"Circle Area = {ratio * 1} | actual area = {(np.pi * 0.5**2):.2f}")
    

    plt.show()