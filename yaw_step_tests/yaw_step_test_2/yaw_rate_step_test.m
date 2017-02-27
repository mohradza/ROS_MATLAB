clc; clear all; close all;

% Set up global ROS callback variables
% System Velocity Data
global angular_vel vel_time
% Commanded Velocities
global cmd_angular_vel cmd_vel_time
% Record variable
global record

rosshutdown
% connect to ROS
setenv('ROS_MASTER_URI', 'http://tegra-ubuntu:11311/');

% SITL
%setenv('ROS_MASTER_URI','http://flowbots:11311/');
rosinit
%% Run Data Collect
% Set up subscribers
% Callback for cmd_vel and cmd_vel_time
cmd_vel_cb = rossubscriber('/mavros/setpoint_velocity/cmd_vel', @ROSStampedCmdVelCallback);

% Callback for vel and vel_time
vel_cb = rossubscriber('/mavros/local_position/odom', @ROSStampedVelocityCallback);

% Callback for record
record_data_db = rossubscriber('/MATLAB/record', @ROSRecordCallback);

% Start recording data after system arms
i = 1;
start_time_ROS = vel_time;
test_over = false;
record = false;

while(~record && ~test_over)
   % Do nothing
   disp('Waiting...')
   pause(.5);
end
disp('Starting to record data...')
maneuver_start_time = vel_time;
while(record)
    time(i) = vel_time - maneuver_start_time;
    % Store current velocity
    yaw_rate(i) = angular_vel(3);
    
    % Store commanded velocities
    
    cmd_yaw_rate(i) = cmd_angular_vel(3);
    
    i = i + 1;
    pause(.0333);
end
test_over = true;

save('yaw_rate','yaw_rate');
save('time','time');
save('cmd_yaw_rate','cmd_yaw_rate');

%% Plot the Data
load('time')
load('yaw_rate')
load('cmd_yaw_rate')

figure(1)
plot(time, yaw_rate, 'b')
hold on
plot(time, cmd_yaw_rate, 'r')
hold off
xlabel('Time (s)')
ylabel('X Velocity')
ylim([-.5 .5])





