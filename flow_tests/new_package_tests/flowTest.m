clc; clear all; close all;

% Set up global ROS callback variables
% Flow matrices
global OF_u OF_v
global rows cols
global x_vals y_vals
% Tangential Vel
global vel_vec

% Record variable
global record

rosshutdown
% connect to ROS
setenv('ROS_MASTER_URI', 'http://tegra-ubuntu:11311/');

% SITL
%setenv('ROS_MASTER_URI','http://flowbots:11311/');
rosinit

OF = rossubscriber('/optic_flow', @ROSNewFlowCallback);
%% Run Data Collect
% Set up subscribers
% Callback for cmd_vel and cmd_vel_time
OF_u_mat = rossubscriber('/wasp_node/dense_u', @ROSDenseUCallback);
OF_v_mat = rossubscriber('/wasp_node/dense_v', @ROSDenseVCallback);
%%
gamma = linspace(0, 2*pi, 50);
record_freq = 2;
record_rate = 1/record_freq;

figure
while(true)
    for i = 1:50
        tang_flow(i) = OF_u(i)*cos(gamma(i)) - OF_v(i)*sin(gamma(i));
    end
    plot(gamma, tang_flow);
    xlim([0 2*pi]);
    ylim([-2 2]);
    pause(.1);
end


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













