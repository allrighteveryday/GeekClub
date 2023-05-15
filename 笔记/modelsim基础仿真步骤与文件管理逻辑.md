

# modelsim基础仿真步骤

1.新建项目
2.添加文件：
	a.设计文件（.v）
	b.仿真文件（.vt）
	注意文件内部的主model名要与文件名保持一致！
3.编译所有文件
4.开始仿真：
	1.回到library页面，点击work的“+”号
	2.下拉菜单中，右键仿真文件，点击simulate
	3.在菜单栏目中调出：
		object（信号）
		wave（波形图）
	4.将object中需要观测的信号拖拽到wave面板中
	5.点击run
	6.重来：restart
5.退出当前仿真：菜单栏点击simulate，下拉菜单中点击 End Simulate

# modelsim文件管理逻辑

modelsim常用的文件管理逻辑
无论怎样，都得先有一个文件夹，用作存放一个工程中所需要的文件
1.以项目形式管理
	a.点击new -> project，选择即将新建的project存放的位置
	b.上一步后软件自动为该project创建了library
	c.接下来就可以在project面板中添加文件
	d.关闭project后，下次要以project的形式打开的话，点击菜单栏open，在文件类型处选择(*).mpf，即project file打开
2.不用项目形式管理，直接基于library
	a.先切换工作目录至你想要的路径底下(change directory)
	b.点击new -> library
	c.新建library后，library为空(empty)，需要编译该工作目录下的文件，才不为空
	d.菜单栏compile -> compile....，选择所需要的文件
	e.编译成功后新建的library旁边会有加号，点击出现下拉菜单，即为所编译出来的模块



