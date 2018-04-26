module	online_lever(
		input			wire			sclk		,
		input			wire			rst_n		,//��λ����sw_4
		input			wire			key_in1	,//��������sw_1(��1)	
		input			wire			key_in2	,//icap����sw_2(��2)
		input			wire			rx			,
		output		wire			tx			,
		output		wire			cs_n		,
		output		wire			sdi			,
		output		wire			sck		
);

wire[7:0]		write_data; 
wire				rx_flag		;
wire[7:0]		rx_data		;
wire				wr_cs_n		;
wire				wr_sdi		;  
wire				wr_sck		;
wire				se_cs_n		;
wire				se_sck		;	
wire				se_sdi		;	


assign sdi = se_sdi|wr_sdi;
assign cs_n = se_cs_n&wr_cs_n;  
assign sck = se_sck|wr_sck;


//uart����
uart_top	U0(
.sclk		(sclk	),
.rst_n	(rst_n)	, 
.rx     (rx   ) ,
.po_data(write_data),
.po_flag(rx_flag),
.tx			(tx		)	//tx���а�λ����
);

spi_byte_write	U1(
.sclk				(sclk				),
.rst_n			(rst_n			),
.rx					(rx					),
.write_data	(write_data	), 
.rx_flag		(rx_flag		),
.rx_data		(rx_data		),
.tx					(tx					),
.cs_n				(wr_cs_n		),
.sdi				(wr_sdi	  	),
.sck		    (wr_sck	  	)
		
);

spi_ce	U2(
.sclk		(sclk		),
.rst_n	(rst_n	),
.key_in	(key_in1	),
.cs_n		(se_cs_n),
.sck		(se_sck	),
.sdi		(se_sdi	)
);

icap_top	U3(
.sclk		(sclk		),
.rst_n	(rst_n	)	,
.key_in	(key_in2	)

);




endmodule