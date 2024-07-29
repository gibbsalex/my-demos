import collimator
#from collimator import library

import numpy as np
import matplotlib.pyplot as plt

def make_oscillator(x0, v0, k):
    # Create a diagram builder
    builder = collimator.DiagramBuilder()

    # Add all the blocks to the diagram
    position = builder.add(c.library.Integrator(x0, name="position"))
    velocity = builder.add(c.library.Integrator(v0, name="velocity"))
    spring_constant = builder.add(c.library.Gain(k, name="spring_constant"))
    net_force = builder.add(c.library.Adder(2, operators="+-", name="net_force"))
    Step_0 = builder.add(
        c.library.Step(start_value=0.0, end_value=1.0, step_time=1.0, name="Step_0")
    )

    # Connect the blocks
    builder.connect(position.output_ports[0], spring_constant.input_ports[0])
    builder.connect(Step_0.output_ports[0], net_force.input_ports[0])
    builder.connect(spring_constant.output_ports[0], net_force.input_ports[1])
    builder.connect(net_force.output_ports[0], velocity.input_ports[0])
    builder.connect(velocity.output_ports[0], position.input_ports[0])

    # Build the diagram
    diagram = builder.build(name="oscillator")

    return diagram


# Define some parameters
x0 = 0.0  # Initial position [m]
v0 = 0.0  # Initial velocity [m/s]
k = 10.0  # Spring constant [N/m]

# Create the block diagram
diagram = make_oscillator(x0, v0, k)

# Show the blocks in the diagram
diagram.pprint()

# We can recover the blocks by indexing into the diagram by name
position = diagram["position"]
velocity = diagram["velocity"]
spring_constant = diagram["spring_constant"]
Step_0 = diagram["Step_0"]
net_force = diagram["net_force"]