

def Euler(model, h, cntrl = None):
    # h = step size

    x = model.state
    x_dot = model.dyn(x)

    clsd_loop = x_dot + cntrl

    next_state = x + h * x_dot

    return next_state

def RungeKutta(model, h):

    x = model.state

    k1 = model.dyn(x)# opted for autonomous to t
    k2 = model.dyn(x + h *k1/2) #, t + h/2
    k3 = model.dyn(x + h * k2/2)#, t + h/2
    k4 = model.dyn(x + h*k3)#, t + h

    next_state = x + h/6 * (k1 + 2*k2 + 2*k3 + k4)

    return next_state