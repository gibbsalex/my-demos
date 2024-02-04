

class vehicle():
    def __init__(self, color, num1):
        self.color = color
        self.velocity = 0
        self.num1 = num1
        self.num2 = 2
    
    def add(self):
        global sum
        sum = self.num1 + self.num2
        return sum