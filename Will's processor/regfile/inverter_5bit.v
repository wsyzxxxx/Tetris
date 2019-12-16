module inverter_5bit(in, out);
    //input
    input[4:0] in;

    //output
    output[4:0] out;

    //circuit
    not invert0(out[0], in[0]);
    not invert1(out[1], in[1]);
    not invert2(out[2], in[2]);
    not invert3(out[3], in[3]);
    not invert4(out[4], in[4]);
endmodule
