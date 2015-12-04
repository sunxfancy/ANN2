%% 首先使用bp神经网络，输入是图片，中间隐藏节点15个，输出节点10个
%% 利用BP网络识别验证码, 自适应学习率bp算法
function y = bpann(input, output)
	net = newff( minmax(input) , [20 10] , { 'logsig' 'purelin' } , 'traingdx' ); 
	net.trainparam.show = 50 ;
	net.trainparam.epochs = 2000 ;
	net.trainparam.goal = 0.01 ;
	net.trainParam.lr = 0.01 ;
	size(input)
	size(output)
	y = train( net, input , output ) ;
end

