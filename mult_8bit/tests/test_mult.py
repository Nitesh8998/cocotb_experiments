"""
    this is a test for 8 bit wallace tree multiplier

"""
import cocotb
from cocotb.triggers import Timer
from cocotb.result import TestFailure
from mult_model import mult_model
import random

@cocotb.test()
def mult_test(dut):
    """Test for random number"""
    yield Timer(3)

    for i in range(10):
        a = random.randint(0,2^8-1)
        b = random.randint(0,2^8-1)

        dut.a = a
        dut.b = b

        dut._log.info("a=%d b=%d" %(a,b))
        yield Timer(2)

        dut._log.info("p=%d" %(int(dut.p)))

        if int(dut.p) != mult_model(a,b):
            raise TestFailure(
                    "Randomised test failed with: %s + %s = %s" %
                    (int(dut.A), int(dut.B), int(dut.X)))
        dut._log.info("sum value from the register %d" %(int(dut.s1.sum)))

        
    
