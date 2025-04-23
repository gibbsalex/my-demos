import numpy as np

def fastInterp1(x, y, x_s):
    
    if x_s > x[-1]:
        y_s = x[-1]
    elif x_s < x[0]:
        y_s = x[0]
    else:
        y_s = np.interp(x_s, x, y)
        
    return y_s