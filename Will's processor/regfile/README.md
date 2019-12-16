# Project Checkpoint 2
 - Author: Will / Wei Xue
 - Course: ECE550DK
 - Term: Fall 2019
 - Professor: Prof.Xin Li

### Some datails about the implementation
1. **DFFE block**
    It is very hard to construct a `DFFE` block only using structural verilog, so I choose to use the behavioral verilog to build it. And it is not too hard to write code, since the logic is very simple. When `reset` is up, I need to asynchronously set the `q` to zero and set `q` to in the posedge of the clock.

2. **register**
    To build a 32-bit register, the only thing I need to do is to put 32 `DFFE`s together to make the register 32-bit in width. All the signals are equally connected to every `DFFE` to make them behave as a whole register.

3. **decoder**
    To make a 5to32 decoder, there is no easy method by just using structural verilog, so I had to write every bit and the corresponding code by hand, line by line.

4. **write and read ports**
    The ports are not so complex, I just need to add some `decoders` and logica `gates` to the circuits so that they can work as we desired.
    For the read ports, I need to also add some tristates, just by using the code like:
    ```
    assign out = ctrl_code ? reg_data : 1'bz;
    ```
    I can make it work properly.

5. **regfile**
    The rest work is just to put above parts together, and add a great number of wires to connect every parts. One thing that is easy to forget is, register `$0` is always zero no matter what inputs, I make it by set the reset signal of `$0` always high.

### Estimation about the time
* Actually, I think for write ports part, the delay mainly is in the `decoder`, which is about `5~6` gates delays in this part. For read ports part, it's the same, about `5-6` gates dalays. And the register part, it is a lot of `DFFE`s in parallel, so the delay is also very small. Then I think the circuit can really work well with the 50MHz clock.
