module	key_debounce(
input	wire	rst_n,
input	wire	sclk,
input	wire	key,
output	reg	flag

);
parameter	MAX1=	500000;
parameter	MAX2=	499999;
reg	[19:0]	cnt1;
//ȡ10ms
always@(posedge	sclk	or	negedge	rst_n)
	if(rst_n==0) 
	cnt1	<=	0;
	else if(key==1)
	cnt1	<=	0;
	else if(cnt1==MAX1)
	cnt1	<=	MAX1;
	else if(key==0)
	cnt1	<=	cnt1+1;
//led
always@(posedge	sclk	or	negedge	rst_n)
	if(rst_n==0)
	flag	<=	0;
	else if((key==0)&&(cnt1==MAX2))
	flag	<=	1;
	else
	flag	<=	0;
endmodule
