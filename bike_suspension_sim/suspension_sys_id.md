# MTB Rear Shock Suspension System Identification

## Abstract
Use System Identification techniques to parameterize the model of the mass-spring-damper that is in the rear-suspension of a mountain bike.

## Introduction

### Motivation
Determining the model of the suspension system could improve the performance of the bike by giving the rider more control through more accurate dampening.

Provide feedback to the rider on how to tune their bike to the optimal settings(air/spring pressure, damping firmness setting)

### Background

Current Research: Automotive Industry | active damping, bose magic carpet suspension. Bike Industry | active valve, automatic inertial valve adjustment, Fox DHX Live Valve Neo, RockShox Flight Attendant

Fox DHX Live Valve Neo: Opens and closes the firmness of the rear-shock. Two sensors mounted on the front and rear brakes. Sensors are accelerometers. System determines if you are in Climb, Flat, Descend. Each scenario has a different threshold to switch from open to closed. The system will also stay open for longer depending on the scenario after an impact. (https://enduro-mtb.com/en/fox-live-valve-neo-shock-test/)

## Methods
Goal: Identify the system response to inputs.

### Definitions

System: The plant that takes the input signal and turns it into the output.

Input: The input to the plant is the force felt to the 

Output: displacement of the frame that the rider holds on to

System Response: which frequencies of the input are passed through the system to the output.

### Spectral Analysis (SPA)

Objective --- 
Plot the Bode plot of the TF: X(s)/F(s) to understand the quantitative behavior(order and delays).

### Building an Auto Regressive Exogeneous(ARX) Model

Dynamic model is a linear Infinite Impulse Response Filter(IIR)

## Reliability of Data
Test consitency of convergence given lots of experiments

## Results

## Further Research

1. Control of the suspension such that stability is maintained when disturbances are placed as forces on the rear suspension. Stability of the system is defined as the fixed point of the plant that the rider holds in neutral position.

2. Neural Networks to map the input data to the output data.

3. Rider to bike trustworthiness in a shock that adapts and suspension that is shifting

## Resources