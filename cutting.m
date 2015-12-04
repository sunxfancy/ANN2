
% 图片分割器

function y = cutting(img, isshow)
	if nargin < 2; isshow = false; end
	if isshow;
		imshow(img); % 显示彩色图像
	end
	imgGray = rgb2gray(img); % 转为灰度图像

	thresh = graythresh(imgGray); % 自动确定二值化阀值 （这个不太好，有时会整体删除一个字）
	BW = 1 - im2bw(imgGray,thresh);   % 二值化
	I2 = bwareaopen(BW, 8, 8);	 % 去除连通分量中小于10的离散点

	varray = sum(I2); 
	imgsize = size(I2);

	if isshow
		figure; % 打开一个新的窗口显示灰度图像
		imshow(imgGray); % 显示转化后的灰度图像

		harray = sum(I2');
		x1 = 1 : imgsize(1, 1);
		x2 = 1 : imgsize(1, 2);
		figure; % 打开一个新的窗口显示分割图
		plot(x1, harray, 'r+-', x2, varray, 'y*-');

		figure; % 打开一个新的窗口显示灰度图像
		imshow(I2); % 显示转化后的灰度图像
	end

	va = mean(varray);    % 计算平均值
	harray = sum(I2'); 
	vb = mean(harray);

	%% matlab 设计的实在太烂！真是我有史以来见过的最烂的语言
	%% 函数只有搅成一坨的情况下才能正确运行
	%% 他们根部不知道如何用闭包，以及合理的封装对象
	
	isanum = false; 
	sumy = 0;
	for i = 1 : imgsize(1, 1)
		if harray(i) > vb;
			if isanum == false;
				isanum = true;
				cvb = i;
			end
		else
			if isanum;
				isanum = false;
				cve = i;
				sumy = sumy + 1;
				if isshow;
					hold on;
					plot([0 imgsize(1,2)], [cvb cvb],'r--');
					plot([0 imgsize(1,2)], [cve cve], 'r--');
				end
			end
		end
	end

	y = {}
	sumy = 0;
	for i = 1 : imgsize(1, 2);
		if varray(i) > va;
			if isanum == false;
				isanum = true;
				ctb = i;
			end
		else
			if isanum;
				isanum = false;
				cte = i;
				sumy = sumy + 1;
				if isshow;
					hold on;
					plot([ctb ctb], [0 imgsize(1,1)],'r--');
					plot([cte cte], [0 imgsize(1,1)],'r--');
				end
				t = I2(cvb:cve, ctb:cte);
				y{sumy} = t;
			end
		end
	end
end
