module DSP_TB;
    // Inputs//
reg [17:0] A, B, D, BCIN;
reg [47:0] C, PCIN;
reg CARRYIN, CLK, RSTA, RSTB, RSTM, RSTP, RSTC, RSTD, RSTCARRYIN, RSTOPMODE, CEA, CEB, CEM, CEP, CEC, CED, CECARRYIN, CEOPMODE;
reg [7:0] OPMODE;

    // Outputs//
wire CARRYOUT, CARRYOUTF;
wire [17:0] BCOUT;
wire [47:0] P, PCOUT;
wire [35:0] M;

// Instantiate the DSP module
DSP dut (
        .A(A), .B(B), .D(D), .BCIN(BCIN),.C(C), .PCIN(PCIN),
        .CARRYIN(CARRYIN), .CLK(CLK), .RSTA(RSTA), .RSTB(RSTB), .RSTM(RSTM),
        .RSTP(RSTP), .RSTC(RSTC), .RSTD(RSTD), .RSTCARRYIN(RSTCARRYIN), .RSTOPMODE(RSTOPMODE), 
        .CEA(CEA), .CEB(CEB), .CEM(CEM), .CEP(CEP), .CEC(CEC), .CED(CED), .CECARRYIN(CECARRYIN), 
        .CEOPMODE(CEOPMODE),.OPMODE(OPMODE),
        .CARRYOUT(CARRYOUT),.CARRYOUTF(CARRYOUTF),
        .BCOUT(BCOUT),
        .P(P),.PCOUT(PCOUT),.M(M)
    );
    integer i;
    // Clock generation
    initial begin 
		CLK=0;
		forever
		#5 CLK=~CLK;
	end

    // Test_Bench
    initial begin
        // Initialize inputs
        A = 0;
        B = 0;
        D = 0;
        BCIN = 0;C = 0;
        PCIN = 0;CARRYIN = 0;
        CLK = 0;RSTA = 0;RSTB = 0;RSTM = 0;RSTP = 0;RSTC = 0;RSTD = 0;RSTCARRYIN = 0;RSTOPMODE = 0;
        CEA = 0;CEB = 0;CEM = 0;CEP = 0;CEC = 0;CED = 0;
        CECARRYIN = 0;CEOPMODE = 0;OPMODE = 0;

        // Apply reset
        #10 RSTA = 1;
        #10 RSTB = 1;
        #10 RSTM = 1;
        #10 RSTP = 1;
        #10 RSTC = 1;
        #10 RSTD = 1;
        #10 RSTCARRYIN = 1;
        #10 RSTOPMODE = 1;
        #10 CEA = 1;
        #10 CEB = 1;
        #10 CEM = 1;
        #10 CEP = 1;
        #10 CEC = 1;
        #10 CED = 1;
        #10 CECARRYIN = 1;
        #10 CEOPMODE = 1;
        for (i = 0; i < 10; i = i + 1) begin
                #10 A = $random;
                #10 B = $random;
                #10 D = $random;
                #10 BCIN = $random;
                #10 C = $random;
                #10 PCIN = $random;
                #10 CARRYIN = $random;
                #10 OPMODE = $random;
            end

       

        #10;
        #10 RSTA = 0;
        #10 RSTB = 0;
        #10 RSTM = 0;
        #10 RSTP = 0;
        #10 RSTC = 0;
        #10 RSTD = 0;
        #10 RSTCARRYIN = 0;
        #10 RSTOPMODE = 0;
        #10 CEA = 0;
        #10 CEB = 0;
        #10 CEM = 0;
        #10 CEP = 0;
        #10 CEC = 0;
        #10 CED = 0;
        #10 CECARRYIN = 0;
        #10 CEOPMODE = 0;
        for (i = 0; i < 10; i = i + 1) begin
                #10 A = $random;
                #10 B = $random;
                #10 D = $random;
                #10 BCIN = $random;
                #10 C = $random;
                #10 PCIN = $random;
                #10 CARRYIN = $random;
                #10 OPMODE = $random;
            end
        #10;
        #10 RSTA =$random;
        #10 RSTB = $random;
        #10 RSTM = $random;
        #10 RSTP = $random;
        #10 RSTC = $random;
        #10 RSTD = $random;
        #10 RSTCARRYIN = $random;
        #10 RSTOPMODE = $random;
        #10 CEA = $random;
        #10 CEB = $random;
        #10 CEM = $random;
        #10 CEP = $random;
        #10 CEC = $random;
        #10 CED = $random;
        #10 CECARRYIN = $random;
        #10 CEOPMODE = $random;
        for (i = 0; i < 10; i = i + 1) begin
                #10 A = $random;
                #10 B = $random;
                #10 D = $random;
                #10 BCIN = $random;
                #10 C = $random;
                #10 PCIN = $random;
                #10 CARRYIN = $random;
                #10 OPMODE = $random;
            end
    end

    // Monitor
    always @(posedge CLK) begin
        $display("A = %b, B = %b, D = %b, BCIN = %b, C = %b, PCIN = %b, CARRYIN = %b, OPMODE = %b, CARRYOUT = %b, CARRYOUTF = %b, BCOUT = %b, P = %b, PCOUT = %b, M = %b", 
            A, B, D, BCIN, C, PCIN, CARRYIN, OPMODE, CARRYOUT, CARRYOUTF, BCOUT, P, PCOUT, M);
    end

endmodule
