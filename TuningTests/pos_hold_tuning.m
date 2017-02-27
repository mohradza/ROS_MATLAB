% Test for tuning a PID controller on a multi-rotor system
% Test Parameters (must be updated in QGC):
% P_xy = 
% P_z = 
% Overall Sensitivity (1-10): 

clc; clear all; close all;



% Set up global ROS callback variables

% Pose Data
global pos orient pose_time
% Commanded Pose Data
global cmd_pos cmd_orient cmd_pose_time
% Mocap DAta
global mocap_pose mocap_orient mocap_time
% Start/stop recording data
global record

rosshutdown
% connect to ROS
setenv('ROS_MASTER_URI', 'http://tegra-ubuntu:11311/');

%% Set up subscribers
rosinit
% Callback for pos and pos_time
pos_cb = rossubscriber('/mavros/local_position/pose', @ROSStampedPoseCallback);

% Callback for cmd_pos and cmd_pose_time
cmd_pos_cb = rossubscriber('/mavros/setpoint_position/local', @ROSStampedCmdPoseCallback);

% Callback for mocap pose data
mocap_pos_cb = rosssubscriber('/mavros/mocap/pose', @ROSStampedMocapCallback)

% Callback for record
record_data_cd = rossubscriber('/MATLAB/record', @ROSRecordCallback);

%% Start Recording Data
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
disp('Starting to record data...')
maneuver_start_time = pose_time;
record_rate = 10;
% Record the data:
while(record)
    % Record Time data
    time(i) = pose_time - maneuver_start_time;
    
    % Gather X data
    x_pos(i) = pos(1);
    cmd_x_pos(i) = cmd_pos(1)
    mocap_x(i) = mocap_pose(1)
    
    % Gather Y data
    y_pos(i) = pos(2);
    cmd_y_pos(i) = cmd_pos(2);
    mocap_y(i) = mocap_pose(2);
    
    % Gather Z Data
    z_pos(i) = pos(3);
    cmd_z_pos(i) = cmd_pos(3);
    mocap_z(i) = mocap_pose(3);
    
    i = i + 1;
    pause(1/record_rate);
end
test_over = true;


%% Plot the Data
figure(2)
subplot(3,1,1)
plot(time, x_pos, 'b')
hold on
plot(time, cmd_x_pos, 'r')
plot(time, mocap_x, 'k')
hold off
xlabel('Time (s)')
ylabel('X Position')
ylim([-1 1])


subplot(3,1,2)
plot(time, y_pos, 'b')
hold on
plot(time, cmd_y_pos, 'r')
plot(time, mocap_y, 'k')
hold off
xlabel('Time (s)')
ylabel('Y Position')
ylim([-1 1])

subplot(3,1,3)
plot(time, z_pos, 'b')
hold on
plot(time, cmd_z_pos, 'r')
plot(time, mocap_z, 'k')
hold off
xlabel('Time (s)')
ylabel('Z Position')
ylim([0 2])





