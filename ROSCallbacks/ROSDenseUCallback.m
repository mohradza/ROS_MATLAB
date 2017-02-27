function ROSDenseUCallback(~, message)

global OF_u
global rows 
global cols 
rows = message.Layout.Dim(1).Size;
cols = message.Layout.Dim(2).Size;
% center_x = round(cols/2);
% center_y = round(rows/2);
% inner_radius = 340;
% 
% gamma = linspace(0, 2*pi, 50);
% inner_radius = 340;
% sum_OF = zeros(1,length(gamma));
% for r = 1:5
%    radius = inner_radius + (r-1)*10;
%    for i = 1:length(gamma)
%       x_val = center_x - round(radius*sin(gamma(i)));
%       y_val = center_y + round(radius*cos(gamma(i)));
% 
%       index = (y_val-1)*cols + x_val; 
%       OF(r,i) = -1*message.Data(index);
%    end
%    sum_OF = sum_OF + OF(r,:);
% end
% OF_u = sum_OF/5;
 end