from .config import *

# I / O
ctx.

def addWheelSpot(x: int, y: int)-> None:
    pass

def addNonWheelSpot(x: int, y: int) -> None:
    pass

# spots
for x in range(WIDTH):
    for y in range(HEIGHT):
        if (x+y) % 2 == 0 and WHEELS_EVEN:
            addWheelSpot(x, y)
        else:
            addNonWheelSpot(x, y)
        
# pins
