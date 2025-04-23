# hold the class for the BowlingBall Vehicle Model
# more sphere things should be able to be added here

import math

class BowlingBall():
    
    r_sphere_m = 0.08
    m_kg = 5
    J_sphere_kgm2 = 0.4*m_kg*r_sphere_m**2

    Jxz_b_kgm2 = 0
    Jxx_b_kgm2 = J_sphere_kgm2
    Jyy_b_kgm2 = J_sphere_kgm2
    Jzz_b_kgm2 = J_sphere_kgm2

    CD_approx = 0.5 # drag coefficient
    Aref_m2 = math.pi * r_sphere_m**2 # frontal aero of the sphere, useful for drag calcs
    rho_static = 1.2 # static airdensity, maybe update

    Vterm_mps = math.sqrt((2*9.8 * m_kg) / (CD_approx * Aref_m2 * rho_static))

    def __init__(self):
        print("BowlingBall Created")
    