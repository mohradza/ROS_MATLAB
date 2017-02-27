clc; clear all; close all;

% Set up global ROS callback variables
% System Velocity Data
global vel vel_time
% Commanded Velocities
global cmd_vel cmd_vel_time
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
    x_vel(i) = vel(1);
    y_vel(i) = vel(2);
    z_vel(i) = vel(3);
    
    % Store commanded velocities
    cmd_x_vel(i) = cmd_vel(1);
    cmd_y_vel(i) = cmd_vel(2);
    cmd_z_vel(i) = cmd_vel(3);
    
    i = i + 1;
    pause(.0333);
end

save('x_vel','x_vel');
save('y_vel','y_vel');
save('z_vel','z_vel');
save('time','time');
save('cmd_x_vel','cmd_x_vel');
save('cmd_y_vel','cmd_y_vel');
save('cmd_z_vel','cmd_z_vel');

%% Plot the Data
load('time')
load('x_vel')
load('y_vel')
load('z_vel')
load('cmd_x_vel')
load('cmd_y_vel')
load('cmd_z_vel')

figure(1)
plot(time, x_vel, 'b')
hold on
plot(time, cmd_x_vel, 'r')
hold off
xlabel('Time (s)')
ylabel('X Velocity')
ylim([-.5 .5])





