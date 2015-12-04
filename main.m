%% 本软件是用来学习神经网络的

img0928 = imread('train/0928.jpg');

%% 图片预处理，切割操作

imgs = cutting(img0928, true);
imgs_size = length(imgs)
for i = 1 : imgs_size
	figure;
	imshow(imgs{i});
end


train_dir=dir('train/*.jpg');
for i = 1: length(train_dir)
	str_name = train_dir(i).name;
	imgs_name{i} = str_name(1:4);
end
imgs_sample = cell(10);
imgs_sample_num = zeros(1,10);
max_size = [0 0];


%% 将数字分类放置
for i = 1 : length(imgs_name)
	img_name = imgs_name{i};
	imgs = cutting(imread(['train/',img_name,'.jpg']), false);
	if (length(imgs) == length(img_name))
		imgs_num_size = length(img_name);
		for j = 1 : imgs_num_size
			tmp_num = str2num(img_name(j)) + 1;
			imgs_sample_num(tmp_num) = imgs_sample_num(tmp_num) + 1;
			imgs_sample{tmp_num, imgs_sample_num(tmp_num)} = imgs{j};
			tmp_size = size(imgs{j});
			if max_size(1,1) < tmp_size(1,1); max_size(1,1) = tmp_size(1,1); end
			if max_size(1,2) < tmp_size(1,2); max_size(1,2) = tmp_size(1,2); end
		end
	end
end

max_size = [16 16];

%% 归一化所有样本，使其等大小
for i = 1 : 10
	for j = 1 : imgs_sample_num(i)
		temp = zeros(max_size);
		imgs_size = size(imgs_sample{i, j});
		temp(1:imgs_size(1,1), 1:imgs_size(1,2)) = imgs_sample{i, j};
		imgs_sample{i, j} = temp;
		% figure;
		% imshow(temp);
	end
end

%% 擦，终于实现了分类，居然连链表都没有

% 学习对比各神经网络的学习效果

%bp网络
runbp(imgs_sample, imgs_sample_num, max_size);

%卷积网络 对应15×12的图片使用卷积网络进行识别
runcnn(imgs_sample, imgs_sample_num, max_size);


%% matlab代码不可维护的重要原因是他缺乏数据结构的概念
%% 不懂得管理数据的人难以写出可维护性高的代码

