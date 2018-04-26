# FPGA-multiboot
通过SPI协议实现FPGA multiboot功能(FPGA multiboot function through SPI protocol)   
----------  
## 项目概况(Project Overview)  
本项目把程序的固化芯片（flash）分为多个存储区间，第一个区间内的程序功能包含可以修改flash内其他区域的程序，以及可以跳转至其他存储区域。现在其他区域存储一个LED灯的简单程序，通过串口发送擦除该区域的命令，则该区域内点亮一个LED等的功能则会被清楚，我们可以再次通过串口发送另外一个功能的程序到该区域，之后启动程序跳转功能模块，FPGA会执行第二次的程序，这样就可以完成在不通过程序下载的方式升级FPGA的控制程序。    
This project divides the solidified flash (flash) of the program into multiple storage sections. The program function in the first section contains programs that can modify other areas in the flash and can jump to other storage areas. Now other areas store a simple program of LED lights, send the command to erase the area through the serial port, then the function of lighting an LED in the area will be clear, we can send another function to the program through the serial port again. In the area, after the program jump function block is started, the FPGA executes the second program, so that the FPGA control program can be upgraded without downloading the program.
## 结构框图(Structure Diagram)  
![结构框图](https://github.com/chinkwo/FPGA-multiboot/blob/master/img-folder/%E7%BB%93%E6%9E%84%E6%A1%86%E5%9B%BE.png)  
## 效果描述(Effect Description)  
在第二个存储区域内放置一段代码，对该区域升级后，可以变成其他的效果。  
Put a piece of code in the second storage area, after the upgrade of the area, can become other effects.
## 应用案例(Applications)  
FPGA一般使用flash作为程序固话芯片，我们通过该项目可以升级FPGA可执行程序，而不需要通过下载接口烧录程序，这种功能适用于很多需要重复修改产品功能的场合。  
FPGA generally uses flash as the program fixed chip. We can upgrade the FPGA executable program through this project without burning the program through the download interface. This function is applicable to many occasions that need to repeatedly modify the product function.
