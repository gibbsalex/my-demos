import numpy as np
import random

class NN():
    def __init__(self):
        print("NN awake")
        self.lr = int()
        self.bias = int()
        self.weights = [random.random(), random.random(), random.random()]

    def heavyside(self, x):
        output = 0

        if x > 0:
            output = 1
        else:
            output = 0

        return output

    def perceptron(self, input1, input2, output):
        outP = self.weights[0]*input1 + self.weights[1]*input2 + self.weights[2]*self.bias

        outP = self.heavyside(outP)

        error = output - outP

        self.weights[0] += error*input1 * self.lr
        self.weights[1] += error*input2 * self.lr
        self.weights[2] += error*self.bias * self.lr 

    def test(self, input1, input2):
        return self.weights[0]*input1 + self.weights[1]*input2 + self.weights[2]*self.bias

if __name__ == "__main__":

    sillyNN = NN()
    sillyNN.lr = 1
    sillyNN.bias = 1

    for i in range(50):
        sillyNN.perceptron(1, 1, 1)
        sillyNN.perceptron(1, 0, 1)
        sillyNN.perceptron(0, 1, 1)
        sillyNN.perceptron(0, 0, 0)


    ans1 = sillyNN.test(1, 1)
    print(f"correct ans = 1, bot ans = {ans1}")
    
    ans2 = sillyNN.test(1, 0)
    print(f"correct ans = 1, bot ans = {ans2}")

    ans3 = sillyNN.test(0, 1)
    print(f"correct ans = 1, bot ans = {ans3}")

    ans4 = sillyNN.test(0, 0)
    print(f"correct ans = 0, bot ans = {ans4}")

