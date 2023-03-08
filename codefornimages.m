for n=1:2
  m=imread(['C:\Users\HP\Desktop\project\My_Dataset\im' num2str(n) '.jpeg']);
%figure();
%imshow(m);
sam=m;
a=imadjust(rgb2gray(m));
[r c]=size(m);
BW = edge(a,'canny');
 %imshow(BW);
[H,T,R] = hough(BW);
figure();
imshow(H,[],'XData',T,'YData',R,...
         'InitialMagnification','fit');

xlabel('\theta'), ylabel('\rho');

axis on, axis normal, hold on;

P  = houghpeaks(H,1,'threshold',ceil(0.9*max(H(:))));
x = T(P(:,2)); y = R(P(:,1));

plot(x,y,'s','color','white');

lines = houghlines(BW,T,R,P,'FillGap',0.8*c,'MinLength',40);

figure();
imshow(m);
hold on;
for m = 1:length(lines)
   xy = [lines(m).point1; lines(m).point2];
   plot(xy(:,1),xy(:,2),'LineWidth',5,'Color','green');
end
figure();
if(lines.theta<0)

g=imrotate_white(a,(90-abs(lines.theta)));

else

    g=(imrotate_white(a,lines.theta-90));

end

figure();
imshow(sam);
title('before')
imwrite(sam,sprintf('Before_0%d.tif',n));
figure();imshow(g);
title('after')

imwrite(g,sprintf('After_0%d.tif',n));
end