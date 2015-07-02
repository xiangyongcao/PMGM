%plot your figure before
%%%%%%%%%%%%%%%%%%%%%
%  set(gcf,'Units','centimeters','Position',[10 10 20 15]);%设置图片大小为7cm×5cm
%get hanlde to current axis返回当前图形的当前坐标轴的句柄,
%(the first element is the relative distance of the axes to the left edge of the figure,...
%the second the vertical distance from the bottom, and then the width and height;
% set(gca,'Position',[.13 .17 .80 .74]);%设置xy轴在图片中占的比例
set(get(gca,'XLabel'),'FontSize',20);%图上文字为8 point或小5号
set(get(gca,'YLabel'),'FontSize',20);
% set(get(gca,'ZLabel'),'FontSize',25);
set(get(gca,'TITLE'),'FontSize',15);
set(gca,'fontsize',13);
set(gca,'linewidth',1); %坐标线粗0.5磅
% set(gca,'box','off');%Controls the box around the plotting area
set(get(gca,'Children'),'linewidth',2);%设置图中线宽1.5磅
% set(gca,'xticklabel',xticklabel);
% set(gca,'yticklabel',yticklabel);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
