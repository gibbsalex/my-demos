# hold the class for the BowlingBall Vehicle Model
# more sphere things should be able to be added here

import math

class BowlingBall():
    
    Vterm_mps = 0
    r_sphere_m = 0.08
    m_sphere_kg = 5
    J_sphere_kgm2 = 0.4*m_sphere_kg*r_sphere_m**2

    m_kg = 1
    Jxz_b_kgm2 = 0
    Jxx_b_kgm2 = J_sphere_kgm2
    Jyy_b_kgm2 = J_sphere_kgm2
    Jzz_b_kgm2 = J_sphere_kgm2

    CD_approx = 1 # needs to be revised
    Aref_m2 = math.pi * r_sphere_m**2

    def __init__(self):
        print("BowlingBall Created")
    