
% 创建数据集

function [inputs outputs] = buildtrainset_cnn(imgs, number)
	i = 1;
	for k = 1 : 10
		for j = 1 : number(k)
			input = imgs{k, j};
			input_size = size(input);
			%% 我不知道我这reshape到底哪错了
			inputs(:, :, i) = reshape(input', input_size(1,1), input_size(1,2));
			outputs(:, i) = zeros(10, 1);
			outputs(k, i) = 1;
			i = i + 1;
		end
	end
end