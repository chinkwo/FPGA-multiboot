module	uart_rx(
	input		wire			sclk				,
	input		wire			rst_n				,
	input		wire			rx					,//������������
	input		wire[3:0]	rx_bit_cnt	,//���ڼ���ɼ�����N��bit������
	input		wire			rx_bit_flag	,
	output	reg[7:0]	po_data			,//����İ�λ��������
	output	reg			rx_flag			,//ʹ���źţ����������ʼ���
	output	reg			po_flag			
	
);
 
 reg[7:0]	rx_data			;//rx_data2Ϊת����Ĳ������� 
 
//��������̬����
reg		rx_1;
reg		rx_2;
//���ⲿ������rx���ݽ�����ʱ����ʱ�����ڵõ�rx_2��ʵ���ϲɼ�����rx_2������
always@(posedge	sclk	or	negedge	rst_n)
		if(rst_n==0)
				rx_1	<=	1;
		else	
				rx_1	<=	rx;
//��rx_1�ٽ���һ��ʱ�����ڵ���ʱ��������99%���ϵ�����̬
always@(posedge	sclk	or	negedge	rst_n)
		if(rst_n==0)
				rx_2	<=	1;
		else	
				rx_2	<=	rx_1;
				
//rx_flagΪʹ���źţ���rx_flag==1ʱ�����ؼ�������ʼ����
always@(posedge	sclk	or	negedge	rst_n)
		if(rst_n==0)
				rx_flag	<=	0;
		else	if(rx_2==0)
				rx_flag	<=	1;
		else	if(rx_bit_flag==1&&rx_bit_cnt==9)		//ʹ���ź��ڼ�⵽rx��ʼλ��ʱ�����ߵ�ƽ
				rx_flag	<=	0;									//����λ���ݲɼ���ɺ����͵�ƽ
				
//rx_data���ã���rx_bit_flag==1ʱ����ʼ�ɼ�rx_2������
always@(posedge	sclk	or	negedge	rst_n)
		if(rst_n==0)
				rx_data	<=	0;
		else	if(rx_bit_cnt>=1&&rx_bit_cnt<=8&&rx_bit_flag==1)	//ͨ��λƴ�ӰѴ�������ת�ɲ��а�λ����
				rx_data	<=	{rx_2,rx_data[7:1]};					//�ɼ�����rx_2���ݷ���rx_data�����λ�����Կ���ѭ������һλ�õ����еİ�λ����

//po_data���壬��8��bit������ɺ󣬰�rx_data����po_data��Ϊ�������
always@(posedge	sclk	or	negedge	rst_n)
		if(rst_n==0)
				po_data	<=	0;
		else	if(rx_bit_flag==1&&rx_bit_cnt==9)
				po_data	<=	rx_data	;
				
//po_flag���壬����λ���ݴ�����ɺ�po_flag����һ��ʱ�����ڣ���po_flag==1��ʱ�򣬿�ʼ������ݣ���λ���У�
always@(posedge	sclk	or	negedge	rst_n)
		if(rst_n==0)
				po_flag	<=	0;
		else	if(rx_bit_flag==1&&rx_bit_cnt==9)		
				po_flag	<=	1;	
		else	
				po_flag	<=	0;								

				
endmodule	