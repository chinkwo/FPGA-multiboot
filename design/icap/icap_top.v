module	icap_top(
		input			wire			sclk		,
		input			wire			rst_n		,
		input			wire			key_in	

);
wire		key_flag	;

//key_debounceÀı»¯
key_debounce		U0(
.rst_n		(rst_n		),
.sclk			(sclk			),
.key			(key_in		),
.key_flag (key_flag )
);

icap_ctrl	U1(
.sclk			(sclk			),
.rst_n		(rst_n		),
.key_flag (key_flag )		
);


endmodule		