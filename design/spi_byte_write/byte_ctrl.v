module	byte_ctrl(
		input			wire				sclk			,
		input			wire				rst_n			,
		input			wire				rx_flag		,
		input			wire[7:0]		write_data,
		output		reg					cs_n			,
		output		wire					sdi				,
		output		reg					sck				

);
reg					add_flag	;
reg[1:0]		cnt_4			;
reg[5:0]		cnt_32		;
reg[2:0]		state			;
reg[8:0]		state_cnt	;
reg[2:0]		bit_cnt		;
reg[7:0]		sdi_data	;
reg[23:0]		ADDR			;
parameter		WREN_INST	=	8'h06	;
parameter		PP_INST	=	8'h02	;	
parameter		IDLE	=	0;
parameter		WREN	=		1	;
parameter		DELAY	=	2;
parameter		WRITE	=	3;
parameter		DATA_END	=	1+5;
parameter		ADDR_RST	=	24'h40_00_00;
//ADDR定义
always@(posedge	sclk	or	negedge	rst_n)
		if(rst_n==0)
				ADDR	<=	ADDR_RST;
		else	if(state==WRITE&&state_cnt==DATA_END&&cnt_32==31)
				ADDR	<=	ADDR+1;
				
//cnt_4定义
always@(posedge	sclk	or	negedge	rst_n)
		if(rst_n==0)
				cnt_4	<=	0;
		else	if(cnt_4==3)
				cnt_4	<=	0;
		else	if(state==WREN&&state_cnt==1)
				cnt_4	<=	cnt_4+1;
		else	if(state==WRITE&&state_cnt>=1&&state_cnt<=DATA_END-1)
					cnt_4	<=	cnt_4+1;
//add_flag定义
always@(posedge	sclk	or	negedge	rst_n)
		if(rst_n==0)
				add_flag	<=	0;	
		else	if(rx_flag==1)
				add_flag	<=	1;
		else	if(state==WRITE&&state_cnt==DATA_END&&cnt_32==31)
				add_flag	<=	0;
								
//cnt_32定义
always@(posedge	sclk	or	negedge	rst_n)
		if(rst_n==0)
				cnt_32	<=	0;
		else	if(cnt_32==31)
				cnt_32	<=	0;
		else	if(add_flag==1)
				cnt_32	<=	cnt_32+1;
				
//cs_n定义
always@(posedge	sclk	or	negedge	rst_n)
		if(rst_n==0)
				cs_n	<=	1;
		else	if(rx_flag==1)
				cs_n	<=	0;
		else	if(state==WREN&&state_cnt==2&&cnt_32==31)
				cs_n	<=	1;
		else	if(state==DELAY&&cnt_32==31)
				cs_n	<=	0;
		else	if(state==WRITE&&state_cnt==DATA_END&&cnt_32==31)
				cs_n	<=	1;

//状态机定义
always@(posedge	sclk	or	negedge	rst_n)
		if(rst_n==0)
			begin
				state	<=	IDLE;
				state_cnt<=	0;
			end
		else	case(state)
							IDLE	:	if(rx_flag==1)		
												begin
													state	<=	WREN	;
													state_cnt	<=	0;
												end
							WREN	:	if(state_cnt==2&&cnt_32==31)		
												begin
													state	<=	DELAY	;
													state_cnt	<=	0;
												end
											else	if(cnt_32==31)
													state_cnt	<=	state_cnt+1;		
							DELAY	:	if(cnt_32==31)		
												begin
													state	<=	WRITE	;
													state_cnt	<=	0;
												end	
											else	if(cnt_32==31)
													state_cnt	<=	state_cnt+1;
							WRITE	:	if(state_cnt==DATA_END&&cnt_32==31)		
												begin
													state	<=	IDLE	;
													state_cnt	<=	0;
												end	
											else	if(cnt_32==31)
													state_cnt	<=	state_cnt+1;	
										default	:begin	
																state	<=	IDLE	;
																state_cnt<=	0;
														 end
					endcase	
												
//sck定义
always@(posedge	sclk	or	negedge	rst_n)
		if(rst_n==0)
				sck	<=	0;
		else	if(cnt_4==1)
				sck	<=	1;
		else	if(cnt_4==3)
				sck	<=	0;
				
//bit_cnt定义
always@(posedge	sclk	or	negedge	rst_n)
		if(rst_n==0)
				bit_cnt	<=	0;
		else	if(bit_cnt==7&&cnt_4==3)
				bit_cnt	<=	0;
		else	if(cnt_4==3)
				bit_cnt	<=	bit_cnt	+	1;
				
//sdi_data定义
always@(posedge	sclk	or	negedge	rst_n)
		if(rst_n==0)
				sdi_data	<=	1;
		else	if(state==WREN&&state_cnt==0&&cnt_32==31)
				sdi_data	<=	WREN_INST;
		else	if(state==WRITE&&state_cnt==0&&cnt_32==31)
					sdi_data	<=	PP_INST;
		else	if(state==WRITE&&state_cnt==1&&cnt_32==31)
					sdi_data	<=	ADDR[23:16];
		else	if(state==WRITE&&state_cnt==2&&cnt_32==31)
					sdi_data	<=	ADDR[15:8];
		else	if(state==WRITE&&state_cnt==3&&cnt_32==31)
					sdi_data	<=	ADDR[7:0];
		else	if(state==WRITE&&state_cnt>4)
					sdi_data	<=	write_data;
					
				
//sdi定义
//always@(posedge	sclk	or	negedge	rst_n)
//		if(rst_n==0)
//			sdi	<=	0;
//		else	if(cs_n==0&&sck==1)
//			sdi	<=	sdi_data[7-bit_cnt];
assign	sdi	=	sdi_data[7-bit_cnt];
				
endmodule