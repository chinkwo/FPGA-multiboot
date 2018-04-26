module	spi_byte_write(
		input			wire			sclk	,
		input			wire			rst_n	,
		input			wire				rx				,
		input			wire[7:0]		write_data, 
		input			wire				rx_flag		,
		input			wire[7:0]		rx_data		,
		output		wire				tx				,
		output		wire				cs_n			,
		output		wire				sdi				,
		output		wire				sck		
		
);
 
//wire[7:0]		write_data; 
//wire				rx_flag		;
//wire[7:0]		rx_data		;

////uart例化
//uart_top	U0(
//.sclk		(sclk	),
//.rst_n	(rst_n)	, 
//.rx     (rx   ) ,
//.po_data(write_data),
//.po_flag(rx_flag),
//.tx			(tx		)	//tx并行八位数据
//);

//pp_ctrl例化 
byte_ctrl	U1(
.sclk				(sclk				),//from top
.rst_n			(rst_n			),//from	top
.rx_flag		(rx_flag		),//from	U2
.write_data	(write_data		),//from	U2
.cs_n				(cs_n				),//to		top
.sdi				(sdi				),//to		top
.sck				(sck				)//to		top
);


endmodule	