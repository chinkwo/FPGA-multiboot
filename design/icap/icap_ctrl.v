module	icap_ctrl(
		input			wire			sclk			,
		input			wire			rst_n			,
		input			wire			key_flag
		
);

reg[15:0]		conf_data	;
reg[3:0]		data_cnt	;
reg					ce				;
reg					write			;
reg					flag			;
wire[15:0]	i					;
wire				BUSY			;
wire				o					;

//flag
always@(posedge	sclk	or	negedge	rst_n)
		if(rst_n==0)
				flag	<=	0	;
		else	if(key_flag==1)
				flag	<=	1;
		else	if(data_cnt==13)
				flag	<=	0;
				
//ce
always@(posedge	sclk	or	negedge	rst_n)
		if(rst_n==0)
				ce	<=	1	;
		else	if(data_cnt==1)
				ce	<=	0;
		else	if(conf_data==16'h2000)
				ce	<=	1;

//write
always@(posedge	sclk	or	negedge	rst_n)
		if(rst_n==0)
				write	<=	1	; 
		else	if(data_cnt==1)
				write	<=	0;
		else	if(conf_data==16'h2000)
				write	<=	1;				

//data_cnt
always@(posedge	sclk	or	negedge	rst_n)
		if(rst_n==0)
				data_cnt	<=	0	;
		else	if(data_cnt==13)
				data_cnt	<=	0;
		else	if(flag==1)
				data_cnt	<=	data_cnt+1'b1;
		else	
				data_cnt	<=	0;	
				
//conf_data
always@(posedge	sclk	or	negedge	rst_n)
		if(rst_n==0)
				conf_data	<=	16'hffff	;	
		else	case(data_cnt)
					0 :	conf_data	<=	16'hffff;	
					1 :	conf_data	<=	16'haa99;	
					2 :	conf_data	<=	16'h5566;	
					3 :	conf_data	<=	16'h3261;	
					4 :	conf_data	<=	16'h0000;	
					5 :	conf_data	<=	16'h3281;	
					6 :	conf_data	<=	16'h0340;	
					7 :	conf_data	<=	16'h32a1;	
					8 :	conf_data	<=	16'h0000;	
					9 :	conf_data	<=	16'h32c1;	
					10:	conf_data	<=	16'h0000;	
					11:	conf_data	<=	16'h30a1;	
					12:	conf_data	<=	16'h000e;	
					13:	conf_data	<=	16'h2000;	
						default:	conf_data	<=	16'hffff;
				endcase

//i
assign	i	=	{conf_data[8],conf_data[9],conf_data[10],conf_data[11],conf_data[12],conf_data[13],conf_data[14],conf_data[15],
						 conf_data[0],conf_data[1],conf_data[2],conf_data[3],conf_data[4],conf_data[5],conf_data[6],conf_data[7]};

//ICAPÔ­ÓïÀý»¯
   ICAP_SPARTAN6 #(
      .DEVICE_ID(27'h4001093),     // Specifies the pre-programmed Device ID value
      .SIM_CFG_FILE_NAME("NONE")  // Specifies the Raw Bitstream (RBT) file to be parsed by the simulation
                                  // model
   )
   ICAP_SPARTAN6_inst (
      .BUSY(BUSY),   // 1-bit output: Busy/Ready output
      .O(o),         // 16-bit output: Configuartion data output bus
      .CE(ce),       // 1-bit input: Active-Low ICAP Enable input
      .CLK(sclk),     // 1-bit input: Clock input
      .I(i),         // 16-bit input: Configuration data input bus
      .WRITE(write)  // 1-bit input: Read/Write control input
   );


endmodule