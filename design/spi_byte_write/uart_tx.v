module	uart_tx(
		input		wire				sclk				,
		input		wire				rst_n				,
		input		wire				po_flag			,
		input		wire[7:0]		po_data			,
		input		wire				tx_bit_flag	,
		input		wire[3:0]		tx_bit_cnt	,
		output	reg					tx_flag		,
		output	reg					tx_data				
);



//tx_flag���壬��po_flagΪ��ʱ���ߣ������ݴ�����ɺ�����
always@(posedge	sclk	or	negedge	rst_n)
		if(rst_n==0)
				tx_flag	<=	0;
		else	if(po_flag==1)
				tx_flag	<=	1;
		else	if(tx_bit_flag==1&&tx_bit_cnt==9)		//ʹ���ź��ڼ�⵽rx��ʼλ��ʱ�����ߵ�ƽ
				tx_flag	<=	0;									//����λ���ݲɼ���ɺ����͵�ƽ	
				
//rx
always@(posedge	sclk	or	negedge	rst_n)
		if(rst_n==0)
				tx_data	<=	1'b1	;
		else	if(tx_bit_flag==1)
				case(tx_bit_cnt)
								0:	tx_data	<=	1'b0			;
								1:	tx_data	<=	po_data[0];
								2:	tx_data	<=	po_data[1];
								3:	tx_data	<=	po_data[2];
								4:	tx_data	<=	po_data[3];
								5:	tx_data	<=	po_data[4];
								6:	tx_data	<=	po_data[5];
								7:	tx_data	<=	po_data[6];
								8:	tx_data	<=	po_data[7];
								9:	tx_data	<=	1'b1			;		
					default:  tx_data	<=	1'b1			;	
				endcase
				
endmodule
				                            
