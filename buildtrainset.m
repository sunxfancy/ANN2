
% 创建数据集
%% buildtrainset: 用来创建神经网络适合的训练集
function [inputs outputs] = buildtrainset(imgs, number)
	i = 1;
	for k = 1 : 10
		for j = 1 : number(k)
			input = imgs{k, j};
			input_size = numel(input);
			%% 我不知道我这reshape到底哪错了
			inputs(i, :) = reshape(input', input_size, 1);
			outputs(i, :) = zeros(10, 1);
			outputs(i, k) = 1;
			i = i + 1;
		end
	end
end