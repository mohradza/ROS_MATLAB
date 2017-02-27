clc; clear all; close all;

% Set up global ROS callback variables
% Tangential flow vector
global OF_tang

global vel
global angular_vel
global vel_time

rosshutdown
% connect to ROS
setenv('ROS_MASTER_URI', 'http://tegra-ubuntu:11311/');

% SITL
%setenv(   !synclient HorizTwoFingerScroll=0'ROS_MASTER_URI','http://flowbots:11311/');
rosinit
% pose = rossubscriber('/mavros/local_position/pose')
OF_topic = rossubscriber('/optic_flow', @ROSNewFlowCallback);
vel_topic = rossubscriber('/mavros/local_position/velocity', @ROSStampedVelocityCallback);
%vel = rossubscriber('/mavros/local_position/velocity')
%% Record Data
record_freq = 6;
record_rate = 1/record_freq;

start_time = vel_time;
i = 1;
last_tang_msg = OF_tang;
while(true)
    if(i== 1)
        disp('recording')
    end
    
    %if (sum(OF_tang ~= last_tang_msg) > 1)
       time_s(i) =  vel_time - start_time;
       velocity_data_x(i) = vel(1);
       velocity_data_y(i) = vel(2);
       velocity_data_yaw(i) = angular_vel(3);
       OF_tang_data(i,:) = OF_tang;
       last_tang_msg = OF_tang;
       i = i + 1;
    %end
    pause(record_rate)
end


%%
gamma = linspace(0, 2*pi, 50);
record_freq = 4;
record_rate = 1/record_freq;

figure
c = 1;
while(c < i)
    plot(gamma, OF_tang_data(c,:));
    xlim([0 2*pi]);
    ylim([-10 10]);
    pause(.2);
    c= c + 1;
end


%%
figure
plot(time_s, OF_tang_data(:,1),'b')
hold on
plot(time_s, velocity_data_x,'r')
hold off





%%
figure
plot(x_vals,y_vals)
ylim([0 rows])
xlim([0 cols])

%% Plot the data
figure
for j = 1:i
    plot(gamma, OF_vec);
    xlabel('Gamma (rads)');
    ylabel('OF')
    pause(record_Rate);
end













