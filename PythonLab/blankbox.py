##Following the python documentation

class vehicle():

    sharedlist = []

    def __init__(self, color, counter):
        self.color = color #This is a data attribute
        self.velocity = 0
        self.counter = counter
        self.num2 = 2
        #self.data = []
    
    def add(self): # Attribute Instance
        global sum
        sum = self.num1 + self.num2
        return sum
    
    def add_list(self, item):
        self.sharedlist.append(item)
    
bluecar = vehicle('blue', 5)
redcar = vehicle('red', 6)

while bluecar.counter < 10:
    bluecar.counter = bluecar.counter * 2
    print(bluecar.counter)

bluecar.sharedlist
redcar.sharedlist
bluecar.add_list("griddy") # Adds this too all sharedlists

redcar.sharedlist # SHift + enter compiles code on that line
redcar.sharedlist # Alt+shift+down copy and pastes the entire line