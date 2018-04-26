module		fram_ctrl(
		input		wire			sclk				,
		input		wire			rst_n				,
		input		wire[7:0]	rx_data			,
		input		wire			rx_flag			,
		input		wire			ce_end_flag	,
		output	reg[7:0]	tx_data			,
		output	reg				tx_flag1	

);

reg[3:0]		cnt_7				;
reg[15:0]		data_cnt		;
reg					data_flag		;
reg					wr_end_flag	;
reg[5:0]		state				;
reg[15:0]		cnt_10_baud	;

parameter	IDLE 				=	0	;
parameter	S_55 				=	1	;
parameter	S_D5 				=	2	;
parameter	S_WR_ADDR 	=	3	;
parameter	S_CE_ADDR 	=	4	;
parameter	S_WR_DATA		=	5	;
parameter	S_CE_TIME		=	6	;
parameter	TEN_BAUD		=	52079;


//cnt_7定义
always@(posedge	sclk	or	negedge	rst_n)
	if(rst_n==0)
			cnt_7		<=		0;
	else	if(rx_data==8'h55&&rx_flag==1&&state==IDLE)
			cnt_7		<=		cnt_7+1;
	else	if(rx_data!=8'h55&&rx_flag==1)
			cnt_7		<=		0;		

//状态机定义
always@(posedge	sclk	or	negedge	rst_n)
if(rst_n==0)
		state		<=		IDLE;
else	case(state)
		IDLE  			:	if(cnt_7==7)	
										state			<=	S_55;	
		S_55  			:	if(rx_flag==1 	 &&rx_data==8'hd5)	
										state	<=	S_D5;	  
									else	if(rx_flag==1 	 &&rx_data!=8'hd5)	
										state	<=	IDLE;	
		S_D5  			:	if(rx_flag==1 	 &&rx_data==8'haa)	
										state	<=	S_WR_ADDR;
									else	if(rx_flag==1 	 &&rx_data==8'h55)	
										state	<=	S_CE_ADDR;	 
									else	if(rx_flag==1)	
										state	<=	IDLE;
		S_WR_ADDR  	:	if(data_cnt==2&&rx_flag==1)
										state	<=	S_WR_DATA	;
									else	
										state	<=	state	;
		S_CE_ADDR  	:	if(data_cnt==2&&rx_flag==1)
										state	<=	S_CE_TIME	;	
									else	
										state	<=	state	;		
		S_WR_DATA		:	if(wr_end_flag==1)	
										state	<=	IDLE	;
									else	
										state	<=	state	;	
		S_CE_TIME		:	if(ce_end_flag==1)
										state	<=	IDLE	;
									else	
										state	<=	state	;								
	default:state	<=IDLE;	
		endcase
		
//cnt_10_baud定义
always@(posedge	sclk	or	negedge	rst_n)
	if(rst_n==0)
			cnt_10_baud		<=		0;
	else	if(cnt_10_baud==TEN_BAUD)
			cnt_10_baud		<=		0;
	else	if(rx_flag==1)
			cnt_10_baud		<=		0;
	else	
			cnt_10_baud		<=		cnt_10_baud+1;
			
//wr_end_flag定义
always@(posedge	sclk	or	negedge	rst_n)
	if(rst_n==0)
			wr_end_flag		<=		0;
	else	if(cnt_10_baud==TEN_BAUD)
			wr_end_flag		<=		1;
	else	
			wr_end_flag		<=		0;
			
//tx_data
always@(posedge	sclk	or	negedge	rst_n)
	if(rst_n==0)
			tx_data		<=		0;
	else	if(wr_end_flag==1)
			tx_data		<=		8'haa;
	else	if(ce_end_flag==1)
			tx_data		<=		8'h55;
			
//tx_flag1
always@(posedge	sclk	or	negedge	rst_n)
	if(rst_n==0)
			tx_flag1		<=		0;
	else	if(wr_end_flag==1)
			tx_flag1		<=		1;
	else	if(ce_end_flag==1)
			tx_flag1		<=		1;
	else	
			tx_flag1		<=		0;
			
			
			
			
endmodule