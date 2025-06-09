class P():
    def __init__(self, Kp):
        self.Kp = Kp
    
    def cntrl(self, x_t, x_curr):
        u = self.Kp * (x_t - x_curr)

        return u