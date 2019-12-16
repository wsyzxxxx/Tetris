# Project Checkpoint 2

 - Author: Wei Xue
 - Date: Sept. 17th, 2019
 - Course: ECE 550DK, Dukekunshan University, JS, China
 - Term: Fall 2019
 - Professor: Prof. Xin Li

## Duke Community Standard, Affirmation
I understand that each `git` commit I create in this repository is a submission. I affirm that each submission complies with the Duke Community Standard and the guidelines set forth for this assignment. I further acknowledge that any content not included in this commit under the version control system cannot be considered as a part of my submission. Finally, I understand that a submission is considered submitted when it has been pushed to the server.m



## Simple Description about Design

1. **adder**

   The adder is implemented as a 32-bit Carry Select Adder, which uses a 4-bit Ripple Carry Adder as the basic building block. 

   And then, I build a 8-bit Carry Select Adder using two basic blocks, which only adds one mux delay to the total delays. 

   Next, I build a 16-bit Carry Select Adder similarly from two 8-bit adders.

   Finally, I build the 32-bit Carry Select from two 16-bit ones.

   The building procedure refers to the process in the lecture slides as below.

   
   
   Besides, to get the value of `overflow`, I need compare the value of the sign bit of `a` and `b` and the sign `bit` of `sum`.
   
   To be explicit, I draw a simplified truth table below.

| a[31] == b[31] (sign bit) | sum[31] (sign bit) | overflow |
| :-----------------------: | :----------------: | :------: |
|             0             |  (doesn't matter)  |    0     |
|        1(0 and 0)         |         0          |    0     |
|        1(1 and 1)         |         1          |    0     |
|        1(0 and 0)         |         1          |    1     |
|        1(1 and 1)         |         0          |    1     |

​		From the truth table, I can construct the circuit with two `xor gates`, an `inverter` and one `and gate` to get the `overflow`.



2. **substractor**

   The subtraction is the same as adding to some extent. The number in the computer are stored by 2's complement. So when doing subtracting, we can just add its negative value by the adder.

   ```mathematica
   a - b = a + (-b)
   ```

   That is to say, I need to calculate the negative value of the operand `b` by 2's complement.

   First, I use `not gate` to inverse every bit of `b` into `inverse b`.

   Then, I directly add `a` and `inverse b` with a carry-in of `1` using the adder, which means I add `a` to `-b` in the 2's complement.

   Then I got the result.

   

   Besides, to get the value of `isNotEqual`, the only thing I need to check every bit of the `result`. If there is one bit which value is not `0`, the` isNotEqual` must be `true or 1`. Otherwise, the` isNotEqual` is `false or 0`.

   

   What's more, to get the value of `isLessThan`, I need to add two gate. 

   Similarly, like the overflow, construct a simpliefied truth table.
   
| a[31] == b[31] (sign bit) | result[31] (sign bit) | isLessThan |
| :-----------------------: | :-------------------: | :--------: |
|             1             |           1           |     1      |
|             1             |           0           |     0      |
|        0(1 and 0)         |   (doesn't matter)    |     1      |
|        0(0 and 1)         |   (doesn't matter)    |     0      |

​		Then I can construct the circuit with one `xor gate` and one `mux`.

​		The `overflow `of substractor has been got from the adder.



3. **32-bit and** and **32-bit or**

   These two operation is very simple. I just calculate the result bit by bit, and then get the result.

   

4. **shifter**

   About shifter, first I need to implement a shifter following the steps in the slides. For a 32-bit shifter, I need to build 5 layers of 32 shifters. That is `5 * 32 = 160` shifters. And following the steps, I can get the result.


   About left-shift and right-shift, one idea is to use the same set of shifter, just inverse the bits of inputs and outputs. But I tried to add another `160` shifters to implement the different shift operations.

   Besides, cosidering arithmetic right shift, I need to record the most significant bit of input `a`, to implement the shift.

   

5. **operation selector**

   I just need to consider the first three bits of the `ctrl_ALUopcode`, So I need to apply three layers of mux to choose the output of the right circuit.