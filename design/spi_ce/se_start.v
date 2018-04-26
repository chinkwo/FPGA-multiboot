module	se_start(
		input			wire			sclk				,
		input			wire			rst_n				,
		input			wire			se_end			,
		input			wire			key_flag		,
		output		reg				ce_end_flag	,
		output		reg				se_start	
		
);
reg[27:0]		cnt_3s			;
reg					add_flag		;
reg[3:0]		se_cnt			;
reg					se_flag			;

parameter		T3S	=	149_999_999;
parameter		SECTOR	=	7	;//需要擦除的扇区数量(8个)

//se_cnt
always@(posedge	sclk	or	negedge	rst_n)
		if(rst_n==0)
			se_cnt	<=	0;
		else	if(se_cnt==SECTOR&&se_end==1)
			se_cnt	<=	0;
		else	if(se_end==1)
			se_cnt	<=	se_cnt	+1;
//se_flag
always@(posedge	sclk	or	negedge	rst_n)
		if(rst_n==0)
			se_flag	<=	0;
		else	if(key_flag==1)
			se_flag	<=	1;
		else	if(se_cnt==SECTOR&&se_end==1)		
			se_flag	<=	0;	

//add_flag定义
always@(posedge	sclk	or	negedge	rst_n)
		if(rst_n==0)
			add_flag	<=	0;
		else	if(se_end==1)
			add_flag	<=	1;
		else	if(cnt_3s==T3S)
			add_flag	<=	0;

//cnt_3s定义
always@(posedge	sclk	or	negedge	rst_n)
		if(rst_n==0)
			cnt_3s	<=	0;
		else	if(cnt_3s==T3S)
			cnt_3s	<=	0;
		else	if(add_flag==1)
			cnt_3s	<=	cnt_3s	+	1;
		else	
			cnt_3s	<=	0;
			
//se_start
always@(posedge	sclk	or	negedge	rst_n)
		if(rst_n==0)
			se_start	<=	0;
		else	if(key_flag==1||(cnt_3s==T3S&&se_flag==1))
			se_start	<=	1;
		else	
			se_start	<=	0;
			
//ce_end_flag
always@(posedge	sclk	or	negedge	rst_n)
		if(rst_n==0)
			ce_end_flag	<=	0; 
		else	if(se_cnt==SECTOR&&cnt_3s==T3S)
			ce_end_flag	<=	1;
		else
			ce_end_flag	<=	0;

endmodule