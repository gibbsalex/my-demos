import numpy as np
import gym

class MPPI:
    def __init__(self, env, K, T, U, lambda_=1.0, noise_mu=0, noise_sigma=1, u_init=1, noise_gaussian=True, downward_start=True):
        self.K = K
        self.T = T
        self.lambda_ = lambda_
        self.noise_mu = noise_mu
        self.noise_sigma = noise_sigma
        self.U = U
        self.u_init = u_init
        self.cost_total = np.zeros(shape=(self.K))

if __name__ == "__main__":

    ENV_NAME = "Pendulum-v1"
    TIMESTEPS = 20
    N_SAMPLES = 1000
    ACTION_LOW = -2.0
    ACTION_HIGH = 2.0

    noise_mu = 0
    noise_sigma = 10
    lambda_ = 1

    U = np.random.uniform(low=ACTION_LOW, high=ACTION_HIGH, size=TIMESTEPS)

    env = gym.make(ENV_NAME)
    env.reset()

    mppi_gym = MPPI(
        env=env,
        K=N_SAMPLES,
        T=TIMESTEPS,
        U=U,
        lambda_=lambda_,
        noise_mu=noise_mu,
        noise_sigma=noise_sigma,
        u_init = 0,
        noise_gaussian=True,
    )

    #mppi_gm.control(iter=1000)



    env.close()