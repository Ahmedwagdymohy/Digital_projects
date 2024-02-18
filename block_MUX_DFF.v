module BLOCK_MUX_DFF #(parameter N = 1) (
    input [N-1:0]D , CLK, reset,
    output reg [N-1:0]Q
);
wire sel;
reg Q1;
always@(posedge CLK)begin
    if(reset)begin
        Q1<=0;
    end else begin
        Q1<=D;
    end
end
assign Q=sel?D:Q1;
    
endmodule //end of the mainBlock