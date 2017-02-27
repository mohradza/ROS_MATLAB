%% Test how big our rings should be to capture the flow we want

clc; clear all; close all;


A = imread('frame0000.jpg');
figure
imshow(A);

center_x = round(1228/2);
center_y = round(920/2);
gamma = linspace(0, 2*pi, 100);
inner_radius = 340;
gamma = linspace(0, 2*pi, 100);

for r = 1:5
   radius = inner_radius + (r-1)*10;
   for i = 1:length(gamma)
      x_val(r,i) = center_x - round(radius*sin(gamma(i)));
      y_val(r,i) = center_y + round(radius*cos(gamma(i)));

      %index = (y_val-1)*cols + x_val; 
      %OF(r,i) = -1*message.Data(index);
   end
   %sum_OF = sum_OF + OF(r,:);
end

hold on
for r = 1:5
plot(x_val(r,:), y_val(r,:),'r')
end
hold off












