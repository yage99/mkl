function createfigure(name,format, handle)
%CREATEFIGURE(X1, Y1)
%  X1:  x 数据的矢量
%  Y1:  y 数据的矢量
 
%  由 MATLAB 于 20-Aug-2014 01:53:41 自动生成
 a = open(name);
 h = get(a, 'children');
 h = get(h(2), 'children');
 data = get(h, {'xdata', 'ydata'});
 X1 = data{1};
 Y1 = data{2};
 close(a);
 hold on;
% 创建 plot
plot(handle, X1,Y1, format);
 
% 创建 xlabel
xlabel('False Positive');
 
% 创建 ylabel
ylabel('True Positive');
 
% 创建 legend
%legend(num2str(name));
end
