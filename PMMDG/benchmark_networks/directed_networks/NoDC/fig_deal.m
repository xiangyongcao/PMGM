%plot your figure before
%%%%%%%%%%%%%%%%%%%%%
%  set(gcf,'Units','centimeters','Position',[10 10 20 15]);%����ͼƬ��СΪ7cm��5cm
%get hanlde to current axis���ص�ǰͼ�εĵ�ǰ������ľ��,
%(the first element is the relative distance of the axes to the left edge of the figure,...
%the second the vertical distance from the bottom, and then the width and height;
% set(gca,'Position',[.13 .17 .80 .74]);%����xy����ͼƬ��ռ�ı���
set(get(gca,'XLabel'),'FontSize',20);%ͼ������Ϊ8 point��С5��
set(get(gca,'YLabel'),'FontSize',20);
% set(get(gca,'ZLabel'),'FontSize',25);
set(get(gca,'TITLE'),'FontSize',15);
set(gca,'fontsize',13);
set(gca,'linewidth',1); %�����ߴ�0.5��
% set(gca,'box','off');%Controls the box around the plotting area
set(get(gca,'Children'),'linewidth',2);%����ͼ���߿�1.5��
% set(gca,'xticklabel',xticklabel);
% set(gca,'yticklabel',yticklabel);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
