module DSP (
	input [17:0] A,B,D,BCIN,
	input [47:0] C,PCIN,
	input [7:0] OPMODE,
	input CLK,CARRYIN,RSTA,RSTB,RSTM,RSTP,RSTC,RSTD,RSTCARRYIN,RSTOPMODE,
	input CEA,CEB,CEM,CEP,CEC,CED,CECARRYIN,CEOPMODE,
	output [17:0] BCOUT,
	output [47:0] PCOUT,P,
	output [35:0]M,
	output CARRYOUT,CARRYOUTF
	);
 /**Output of each BLOCK */  
 
wire D_reg_output; 
wire B0_reg_output; 
wire A0_reg_output; 
wire C_reg_output; 
wire B1_reg_output; 
wire A1_reg_output; 
wire M_reg_output;
    


/*module BLOCK_MUX_DFF #(parameter N = 1) (input [N-1:0]D , CLK, reset,output reg [N-1:0]Q); */


/******** <  D Reg ********/
BLOCK_MUX_DFF #(.N(18)) D_REG_18 (D , CED , RSTD ,D_reg_output ); //NOTE: D_reg_output SHOULD BE A WIRE
						/*	************EXPLAINING**********************	*/
/* WE ONLY USE REGISTERS WHILE BUILDING THE BLOCK ITSELF AS YOU SEE WE USED IT INSIDE THE (block_MUX_DFF.V) FILE BUT WHEN THE BLOCK FROM OUTSIDE WE PASS WIRES TO IT NOT REGISTER												*/
/******** < END D Reg ********/



/******** < MUX before the B0 Reg ********/
wire B0_input ;
wire B_SEL;
assign B0_input = B_SEL?BCIN:B;
/******** < ENd of the MUX ********/

/******** <  B0 Reg ********/
BLOCK_MUX_DFF #(.N(18)) B0_REG_18 (B , CEB , RSTB ,B0_reg_output );
/******** <  END B0 Reg ********/


/******** <  A Reg ********/
BLOCK_MUX_DFF #(.N(18)) A0_REG_18 (A , CEA , RSTA ,A0_reg_output );
/******** <  END A Reg ********/


/******** <  C Reg ********/
BLOCK_MUX_DFF #(.N(48)) C_REG_48 (C , CEC , RSTC ,C_reg_output );
/******** <  END C Reg ********/



reg [17:0] w1; //wire oof the mux(opMode4)



always @(posedge CLK ) begin
    if(OPMODE[4])begin //if OPMODE == 1 adder will work
      if(OPMODE[6])  //if OPMODE == 1 SUB will work ( D - B)
	  		w1<=D_reg_output - B0_reg_output;
		else    //if OPMODE6 == 0 ADD WILL work (D+B)
			w1<=D_reg_output + B0_reg_output;
		
	
	  
    end else begin
		w1<=B0_reg_output; //bypass the B0_reg_output
	  end
    

    
end

/******** <  B1 Reg ********/  // the B1 takes the same clk & reset as B0
BLOCK_MUX_DFF #(.N(18)) B1_REG_18 (w1 , CEB , RSTB ,B1_reg_output );
/******** <  END B1 Reg ********/


/******** <  A1 Reg ********/  // the B1 takes the same clk & reset as B0
BLOCK_MUX_DFF #(.N(18)) A1_REG_18 (A0_reg_output , CEA , RSTA ,A1_reg_output );
/******** <  END A1 Reg ********/



reg [35:0]w2; //The wire after multiplier
//**********<The multiplier BLOCK***************/
always@(posedge CLK) begin
	w2<= A1_reg_output * B1_reg_output;
end



/******** <  M Reg ********/  // the B1 takes the same clk & reset as B0
BLOCK_MUX_DFF #(.N(36)) M_REG_18 (w2 , CEM , RSTM ,M_reg_output );
/******** <  END M Reg ********/






/*************************Explaination*************************/
/* inside always we can make the (reg=wire) directly without using assign
/* so to take the data from the wire M_reg_output we need to recieve it inside a reg in the always        */
/*because inside always should be reg! as we know */
/*that's why I created [35:0]temp to recieve the data from the wire then after always I will assign the value of this reg to the M wire output*/
/************< TriState Buffer**********/
reg[35:0]temp;
always@(posedge CLK)begin
	temp= M_reg_output;
end
assign temp = M;






endmodule