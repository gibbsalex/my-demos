# MTB Rear Shock Suspension System Identification

## Abstract
Use System Identification techniques to parameterize the model of the mass-spring-damper that is in the rear-suspension of a mountain bike.

## Introduction

### Motivation
Determining the model of the suspension system could improve the performance of the bike by giving the rider more control through more accurate dampening.

Provide feedback to the rider on how to tune their bike to the optimal settings(air/spring pressure, damping firmness setting)

Ideally the bode plot would attenuate the roughest frequencies. This looks like negative amplitude on the bode plot.

### Background

Current Technology: Automotive Industry | active damping, bose magic carpet suspension. Bike Industry | active valve, automatic inertial valve adjustment, Fox DHX Live Valve Neo, RockShox Flight Attendant. Consumer Electronics | Apple Active Noise Cancellation.

Fox DHX Live Valve Neo: Opens and closes the firmness of the rear-shock. Two sensors mounted on the front and rear brakes. Sensors are accelerometers. System determines if you are in Climb, Flat, Descend. Each scenario has a different threshold to switch from open to closed. The system will also stay open for longer depending on the scenario after an impact. (https://enduro-mtb.com/en/fox-live-valve-neo-shock-test/). My response: This system isn't actively damping disturbances, it seems to react by changing to different scenarios. I am wondering about the capability of the mechanism in the shock to shift quickly in order to respond in real-time.

Bose Magic Carpet Suspension: ClearPath uses active-valve dampers and magnetic fluid.  (https://www.thedrive.com/news/legendary-bose-magic-carpet-suspension-is-finally-going-global). My response: They might be scanning the road ahead. Using lidar to see what to expect would be helpful to cars but not applicable to a mountain bike application.

## Methods
Goal: Identify the system response to inputs.

A good way to get an idea of the system response is to investigate the bode plot. The bode plot shows quantitative information about delays, model-order, and signal amplification/attenuation. 

Bounded Goal: Plot a Bode plot of the system response, to analyze which frequencies of signals get amplified or attenuated.

### Definitions

System: The plant that takes the input signal and turns it into the output.

Input: The input to the plant is the force felt to the rear wheel.

Output: The output of the plant is the displacement of the unsprung-mass, or the section of the frame that the rider holds on to.

System Response: the frequencies of the input that are passed through the system to the output.

### Step 1: Determine the Transfer Function X(s)/F(s)
Objective --- 
Plot the Bode plot of the TF: X(s)/F(s) to understand the quantitative behavior(order and delays).
#### Idea 1.1: Spectral Analysis (SPA)


Build a TF from frequency domain analysis
$$
G(e^{j\omega_m}) = \frac{\Phi_{yu}(\omega_m)}{\Phi_{uu}(\omega_m)}
$$
where:
$$
\Phi_{yu}(\omega) = \lim_{N \to \infin} \mathbb{E} \{P^N_{yu}(\omega)\}\\

P^N_{yu}(\omega) = DTFT\{ \hat R^N_{yu}(\tau)\}
$$

Tools:
SciPy Toolbox

Terms:
Empirical Transfer Function Estimate (ETFE)
Spectral Analysis(SPA)
Convergence of ETFE to SPA through using a weighting window to smooth a neighborhood of frequencies.

#### Idea 1.2: Building an Auto Regressive Exogeneous(ARX) Model

Objective ---
Estimate the parameters in a transfer function through least-squares.

Dynamic model is a linear Infinite Impulse Response Filter(IIR)

1. Determine ARX, IIR model order (number of zeros, number of poles).
2. Run the least-squares estimate to get the parameters of the model.
3. Put in TF form, and plot.

### Step 2: Plot the Transfer Function on a Bode Plot

Tools:

semilogx()
SciPy Bode()

### Step 3: Test the Reliability of Data
Test consistency of convergence

## Results

## Further Research

1. Control of the suspension such that stability is maintained when disturbances are placed as forces on the rear suspension. Stability of the system is defined as the fixed point of the plant that the rider holds in neutral position. Using MPC to control the current state back to the fixed point.

2. Neural Networks to map the input data to the output data.

3. Rider-to-bike Relationship: Does the rider trust a shock that changes suspension characteristics.

## Resources