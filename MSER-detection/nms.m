function pick = nms(boxes, overlap)  
  
% pick = nms(boxes, overlap)     ���룺 boxesΪ���к�ѡ������½Ǻ����Ͻ�x��y���ꡣoverlapΪ������Ϊ�趨����ֵ��
% Non-maximum suppression.       ����� pick�������б��������Ŀ�
% Greedily select high-scoring detections and skip detections  
% that are significantly covered by a previously selected detection.  
  
if isempty(boxes)  
  pick = [];  
else  
  x1 = boxes(:,1);          %���к�ѡ������½Ƕ���x   
  y1 = boxes(:,2);          %���к�ѡ������½Ƕ���y   
  x2 = boxes(:,3);          %���к�ѡ������ϽǶ���x   
  y2 = boxes(:,4);          %���к�ѡ������ϽǶ���y  
 % s = boxes(:,end);         %���к�ѡ������Ŷȣ����԰���1�л��߶��У����ڱ�ʾ��ͬ׼������Ŷ�  
  area = (x2-x1+1) .* (y2-y1+1);   %���к�ѡ������  
  
  [vals, I] = sort(area);      %�����к�ѡ����д�С��������valsΪ���������IΪ������ǩ  
  pick = [];  
  while ~isempty(I)  
    last = length(I);       %last�����ǩI�ĳ��ȣ������һ��Ԫ�ص�λ�ã���matlab�����1��ʼ������  
    i = I(last);            %���к�ѡ��������Ŷ���ߵ��Ǹ��ı�ǩ��ֵ��i  
    pick = [pick; i];       %��i����pick�У�pick���������NMS������box����ţ������������
    suppress = [last];      %��I��������Ŷȵı�ǩ��I��λ�ø�ֵ��suppress��suppress����Ϊ���ƴ��־��  
    for pos = 1:last-1      %��1�������ڶ�������ѭ��  
      j = I(pos);           %�õ�posλ�õı�ǩ����ֵ��j  
      xx1 = max(x1(i), x1(j));%���Ͻ�����x������������Ĺ�������  
      yy1 = max(y1(i), y1(j));%���Ͻ�����y  
      xx2 = min(x2(i), x2(j));%���½���С��x  
      yy2 = min(y2(i), y2(j));%���½���С��y  
      w = xx2-xx1+1;          %��������Ŀ��  
      h = yy2-yy1+1;          %��������ĸ߶�  
      if w > 0 && h > 0     %w,hȫ��>0��֤��2����ѡ���ཻ  
        o = w * h / area(j);%����overlap��ֵ��������ռ��ѡ��j���������  
        if o > overlap      %����������õ���ֵ��ȥ����ѡ��j����Ϊ��ѡ��i�����Ŷ����  
          suppress = [suppress; pos];   %���ڹ涨��ֵ�ͼ��뵽suppress������ɾ���Ŀ�
        end  
      end  
    end  
    I(suppress) = [];%����ɾ���Ŀ�ɾ����I��ʣ��δ����Ŀ򡣵�IΪ�ս���ѭ��  
  end    
end