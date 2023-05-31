# Modelsim DO文件的使用

## 简介

​    **DO文件是一次执行多条命令的脚本。这个脚本可以像带有相关参数的一系列ModelSim命令一样简单，或者是带有变量，执行条件等等的Tcl程序。可在GUI里或系统命令提示符后执行Do文件。这种好处也许在小设计中没怎么表现，<u>但是如果在一个大的工程中，常常需要对一个设计单元进行反复的调试和仿真，但是仿真时的设置是不变的，这时如果使用了do文件，把仿真中使用到的命令都保存下来了，就可以节省大量的人力，提高了工作效率。</u>**

## DO文件基本指令

```verilog

# 在当前目录下建立一个work目录
vlib  work

# 将目前的逻辑工作库work和实际工作库work映射对应
vmap work work

# 编译文件
vlog test.v
vlog tb_test.v

# 仿真work库中名为 tb_test 的模块，最小时间单位为1ns
vsim  work.tb_test  -t 1ns

# 将testbench文件tb_test.v中模块tb_test下所有的信号变量加到波形文件中去，注意在"*"前要加空格。
add  wave/tb_test/ *

# 或者可以逐个添加
add wave /tb_test/clk
add wave /tb_test/rst_n

# 甚至可以改变颜色
add wave -noupdate -color yellow /tb_test/clk
add wave -noupdate -color orange /tb_test/rst_n

# 仿真时长为2000个时间单位
run 2000

```

注意：

+ do文件的注释为#，且不能添加在代码之后，需另起一行。
+ 当出现 No objects found matching ...... 错误时，需要在Modelsim安装目录下找到modelsim.ini文件，将VoptFlow = 1注释掉或者把1改为0







