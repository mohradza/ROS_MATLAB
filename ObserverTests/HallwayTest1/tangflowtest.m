clc; clear all; close all;

% Set up global ROS callback variables
% Tangential flow vector
global nearness
global record
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
observer_topic = rossubscriber('/nearness', @ROSNearnessCallback);
vel_topic = rossubscriber('/mavros/local_position/velocity', @ROSStampedVelocityCallback);
record_topic = rossubscriber('MATLAB/record', @ROSRecordCallback);
%vel = rossubscriber('/mavros/local_position/velocity')
%% Record Data
record_freq = 6;
record_rate = 1/record_freq;

start_time = vel_time;
i = 1;
while(true)
    if(i== 1)
        disp('recording')
    end
    
    %if (sum(OF_tang ~= last_tang_msg) > 1)
       time_s(i) =  vel_time - start_time;
       velocity_data_x(i) = vel(1);
       velocity_data_y(i) = vel(2);
       velocity_data_yaw(i) = angular_vel(3);
       nearness_data(i,:) = nearness;
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
    plot(gamma, nearness_data(c,:));
    xlim([0 2*pi]);
    ylim([-10 10]);
    title(['time: ', num2str(time_s(c))])
    pause();
    c= c + 1;
end


%%
figure
plot(time_s, velocity_data_y,'b')
hold on
plot(time_s, velocity_data_x,'r')
plot(time_s, velocity_data_yaw,'g')
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













