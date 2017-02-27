clc; clear all; close all;

% Set up global ROS callback variables

% Pose Data
global pos pose_time
% Commanded Pose Data
global cmd_pos cmd_pose_time
% Start/stop recording data
global record

rosshutdown
% connect to ROS
%setenv('ROS_MASTER_URI', 'http://tegra-ubuntu:11311/');

% SITL
setenv('ROS_MASTER_URI','http://flowbots:11311/');
rosinit
%% Run Data Collect
% Set up subscribers

% Callback for pos and pos_time
pos_cb = rossubscriber('/mavros/local_position/pose', @ROSStampedPoseCallback);

% Callback for cmd_pos and cmd_pose_time
cmd_pos_cb = rossubscriber('/mavros/setpoint_position/local', @ROSStampedCmdPoseCallback);

% Callback for record
record_data_cd = rossubscriber('/MATLAB/record', @ROSRecordCallback);

% Wait for the system to get into maneuver position
setpoint_type = 0;
% Start recording data after system arms
i = 1;
start_time_ROS = pose_time;
test_over = false;
while(~record && ~test_over)
   % Do nothing
   disp('Waiting...')
   pause(.5);
end
disp('Exit')
maneuver_start_time = pose_time;
% Record the data:
while(record)
    time(i) = pose_time - maneuver_start_time;
    x_pos(i) = pos(1);
    cmd_x_pos(i) = cmd_pos(1);
    y_pos(i) = pos(2);
    cmd_y_pos(i) = cmd_pos(2);
    z_pos(i) = pos(3);
    cmd_z_pos(i) = cmd_pos(3);
    i = i + 1;
    pause(.0333);
    test_over = true;
end

% Save all the data:
% Save Positions
save('x_pos','x_pos');
save('y_pos','y_pos');
save('z_pos','z_pos');
% Save Commanded Positions
save('cmd_x_pos','cmd_x_pos');
save('cmd_y_pos','cmd_y_pos');
save('cmd_z_pos','cmd_z_pos');
% Save Time
save('time','time');


%% Plot the Data
load('x_pos')
load('y_pos')
load('z_pos')

load('cmd_x_pos')
load('cmd_y_pos')
load('cmd_z_pos')

load('time')
%%
figure(2)
subplot(3,1,1)
plot(time, x_pos, 'b')
hold on
plot(time, cmd_x_pos, 'r')
hold off
xlabel('Time (s)')
ylabel('X Position')
ylim([-2 2])


subplot(3,1,2)
plot(time, y_pos, 'b')
hold on
plot(time, cmd_y_pos, 'r')
hold off
xlabel('Time (s)')
ylabel('Y Position')
ylim([-2 2])

subplot(3,1,3)
plot(time, z_pos, 'b')
hold on
plot(time, cmd_z_pos, 'r')
hold off
xlabel('Time (s)')
ylabel('Z Position')
ylim([-2 2])





