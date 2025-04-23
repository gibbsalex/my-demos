import matplotlib.pyplot as plt

def state_layout(t_s, x):

    # data plotting
    fig, axes = plt.subplots(2, 4, figsize=(10,6)) # 1 row, 2 cols

    # axial velocity u^b_CM/n
    axes[0, 0].plot(t_s, x[0,:])
    axes[0, 0].set_xlabel('Time [s]')
    axes[0, 0].set_ylabel('u [m/s] - x axial vel')
    axes[0, 0].grid(True)

    # axial velocity v^b_CM/n
    axes[0, 1].plot(t_s, x[1,:])
    axes[0, 1].set_xlabel('Time [s]')
    axes[0, 1].set_ylabel('v [m/s] - y axial vel')
    axes[0, 1].grid(True)

    # axial velocity w^b_CM/n
    axes[0, 2].plot(t_s, x[2,:])
    axes[0, 2].set_xlabel('Time [s]')
    axes[0, 2].set_ylabel('w [m/s] - z axial vel')
    axes[0, 2].grid(True)

    # roll angle, phi
    axes[0, 3].plot(t_s, x[6,:])
    axes[0, 3].set_xlabel('Time [s]')
    axes[0, 3].set_ylabel('phi [rad] - roll')
    axes[0, 3].grid(True)

    # roll rate, p^b_b/n
    axes[1, 0].plot(t_s, x[3,:])
    axes[1, 0].set_xlabel('Time [s]')
    axes[1, 0].set_ylabel('p [rad/s] - x ang vel')
    axes[1, 0].grid(True)

    # pitch rate, q^b_b/n
    axes[1, 1].plot(t_s, x[4,:])
    axes[1, 1].set_xlabel('Time [s]')
    axes[1, 1].set_ylabel('q [rad/s] - y ang vel')
    axes[1, 1].grid(True)

    # yaw rate, r^b_b/n
    axes[1, 2].plot(t_s, x[5,:])
    axes[1, 2].set_xlabel('Time [s]')
    axes[1, 2].set_ylabel('r [rad/s] - z ang vel')
    axes[1, 2].grid(True)

    # pitch angle, theta
    axes[1, 3].plot(t_s, x[7,:])
    axes[1, 3].set_xlabel('Time [s]')
    axes[1, 3].set_ylabel('theta [rad] - pitch')
    axes[1, 3].grid(True)

    plt.tight_layout()

def traj_plot(x):
    assert x.shape[0] >= 12, f"x must have at least 12 rows, but has {x.shape[0]}"

    ax2 = plt.figure(2).add_subplot(projection='3d')
    ax2.plot(x[9,:], x[10,:], x[11,:], label = 'traj')
    ax2.legend()
    ax2.set_title('Trajectory Plot')
    ax2.set_xlabel('x')
    ax2.set_ylabel('y')
    ax2.set_zlabel('z')
    plt.show()