module	uart_bps_rx(
	input		wire			sclk					,
	input		wire			rst_n					,
	input		wire			rx_flag				,
	input		wire			tx_flag				,
	output	reg				rx_bit_flag		,
	output	reg[3:0]	rx_bit_cnt		,
	output	reg				tx_bit_flag		,
	output	reg[3:0]	tx_bit_cnt	

);
/*******************************9600波特率*******************************/
//parameter		BPS_DIV		=	13'd5207	;	//9600波特率
//parameter		BPS_DIV_2	=	13'd2603	;	//9600波特率
/******************************115200波特率******************************/
parameter		BPS_DIV		=	13'd434		;	//115200波特率
parameter		BPS_DIV_2	=	13'd217		;	//115200波特率


reg[12:0]		rx_baud_cnt;
reg[12:0]		tx_baud_cnt;

//******************rx设置******************//	
//rx_baud_cnt计数器
always@(posedge	sclk	or	negedge	rst_n)
		if(rst_n==0)
				rx_baud_cnt	<=	0;
		else	if(rx_baud_cnt==BPS_DIV)
				rx_baud_cnt	<=	0;
		else	if(rx_flag==0)
				rx_baud_cnt	<=	0;
		else	if(rx_flag==1)
				rx_baud_cnt	<=	rx_baud_cnt+1;
				
//rx_bit_flag采集数据的使能信号
always@(posedge	sclk	or	negedge	rst_n)
		if(rst_n==0)
				rx_bit_flag	<=	0;
		else	if(rx_baud_cnt==BPS_DIV_2)
				rx_bit_flag	<=	1;
		else	
				rx_bit_flag	<=	0;
				
//rx_bit_cnt用来计数采集到第几个bit
always@(posedge	sclk	or	negedge	rst_n)
		if(rst_n==0)
				rx_bit_cnt	<=	0;
		else	if(rx_bit_cnt==9&&rx_bit_flag==1)
				rx_bit_cnt	<=	0;
		else	if(rx_bit_flag==1)
				rx_bit_cnt	<=	rx_bit_cnt+1;
				
				
//******************tx设置******************//				
//tx_baud_cnt计数器
always@(posedge	sclk	or	negedge	rst_n)
		if(rst_n==0)
				tx_baud_cnt	<=	0;
		else	if(tx_baud_cnt==BPS_DIV)
				tx_baud_cnt	<=	0;
		else	if(tx_flag==0)
				tx_baud_cnt	<=	0;
		else	if(tx_flag==1)
				tx_baud_cnt	<=	tx_baud_cnt+1;
				
//tx_bit_flag采集数据的使能信号
always@(posedge	sclk	or	negedge	rst_n)
		if(rst_n==0)
				tx_bit_flag	<=	0;
		else	if(tx_baud_cnt==BPS_DIV_2)
				tx_bit_flag	<=	1;
		else	
				tx_bit_flag	<=	0;
				
//tx_bit_cnt用来计数采集到第几个bit
always@(posedge	sclk	or	negedge	rst_n)
		if(rst_n==0)
				tx_bit_cnt	<=	0;
		else	if(tx_bit_cnt==9&&tx_bit_flag==1)
				tx_bit_cnt	<=	0;
		else	if(tx_bit_flag==1)
				tx_bit_cnt	<=	tx_bit_cnt+1;
				
endmodule