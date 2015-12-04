function y = runcnn(imgs_sample, imgs_sample_num, max_size)

	path(path, 'DeepLearnToolbox-master/CNN/')
	path(path, 'DeepLearnToolbox-master/util/')
	% 网络训练集构造
	[a, b] = buildtrainset_cnn(imgs_sample, imgs_sample_num);

	% 16×16的原图片

	cnn.layers = {
	    struct('type', 'i') %input layer
	    struct('type', 'c', 'outputmaps', 6, 'kernelsize', 5) %convolution layer
	    struct('type', 's', 'scale', 2) %sub sampling layer
	    struct('type', 'c', 'outputmaps', 12, 'kernelsize', 5) %convolution layer
	    struct('type', 's', 'scale', 2) %sub sampling layer
	};
	cnn = cnnsetup(cnn, a, b);

	% 学习率  
	opts.alpha = 2;  
	% 每次挑出一个batchsize的batch来训练，也就是每用batchsize个样本就调整一次权值，而不是  
	% 把所有样本都输入了，计算所有样本的误差了才调整一次权值  
	opts.batchsize = size(a, 3);   
	% 训练次数，用同样的样本集。我训练的时候：  
	% 1的时候 11.41% error  
	% 5的时候 4.2% error  
	% 10的时候 2.73% error  
	opts.numepochs = 2000;

	% cnn = cnntrain(cnn, a, b, opts);
	load cnn_save cnn;


	% 测试
	image_dir=dir('image/*.jpg');
	for i = 1: length(image_dir)
		str_name = image_dir(i).name;
		imgs_test{i} = str_name(1:4);
	end


	rightnum = 0;
	sumnum = 0;

	for i = 1 : length(imgs_test)
		img_name = imgs_test{i};
		imgs = cutting(imread(['image/',img_name,'.jpg']), false);
		if (length(imgs) == length(img_name))
			for j = 1 : length(img_name)
				tmp_num = str2num(img_name(j)) + 1;

				%% 等大小化
				temp = zeros(max_size);
				imgs_size = size(imgs{j});
				temp(1:imgs_size(1,1), 1:imgs_size(1,2)) = imgs{j};
				imgs{j} = temp;

				input_size = size(temp);
				testInput(:, :, j) = reshape(temp', input_size(1,1), input_size(1,2));
			end
		
			% 然后就用测试样本来测试  
			 
			cnn = cnnff(cnn, testInput);
			cnn.o
		    [~, mans] = max(cnn.o);

		    img_name
		    mans = mans-1
		    % [~, a] = max(y);
		    % bad = find(mans ~= a);

		
		end
	end

	%plot mean squared error  
	plot(cnn.rL);  
end
