# FPGA-multiboot
通过SPI协议实现FPGA multiboot功能(FPGA multiboot function through SPI protocol)   
----------  
## 开发环境(Development environment)  
ISE、modelsim、Spartan6-xc6slx9  
## 项目概况(Project Overview)  
本项目把程序的固化芯片（flash）分为多个存储区间，第一个区间内的程序功能包含可以修改flash内其他区域的程序，以及可以跳转至其他存储区域。现在其他区域存储一个LED灯的简单程序，通过串口发送擦除该区域的命令，则该区域内点亮一个LED等的功能则会被清楚，我们可以再次通过串口发送另外一个功能的程序到该区域，之后启动程序跳转功能模块，FPGA会执行第二次的程序，这样就可以完成在不通过程序下载的方式升级FPGA的控制程序。   
## 项目描述  
- 首先在ICAP原语中设置程序跳转的地址、设备ID等信息。
- 选择flash中第一区域要实现的功能程序，将UART串口数据传输模块和ICAP控制模块例化进第一个程序，并固化到第一区域内。
- 把ICAP例化进准备好的更新程序中，地址指向第一区域中。
- 在ISE中将需要更新的程序转化为BIN文件形式，通过串口助手将文件中的数据发送到第二区域内。
- 传输完成之后，通过KEY1控制程序跳转，若更新失败，通过KEY2控制程序跳转至第一区域的原程序中，继续进行更新。

## 结构框图(Structure Diagram)  
![结构框图](https://github.com/chinkwo/FPGA-multiboot/blob/master/img-folder/%E5%9C%A8%E7%BA%BF%E5%8D%87%E7%BA%A7%E7%BB%93%E6%9E%84%E5%9B%BE.png)  
## 效果描述(Effect Description)  
先在其他区域存储一个功能程序，通过串口发送擦除该区域的命令，则该区域内功能模块则会被清除，可以再次通过串口发送另外一个功能的程序到该区域，之后启动程序跳转功能模块，FPGA会执行第二次的程序，若更新后的程序出错，则控制按键返回第一个程序，继续进行更新操作，这样就可以完成在不通过程序下载的方式升级FPGA的控制程序。    
## 应用案例(Applications)  
FPGA一般使用flash作为程序固话芯片，我们通过该项目可以升级FPGA可执行程序，而不需要通过下载接口烧录程序，这种功能适用于很多需要重复修改产品功能的场合。  
