function ROSStampedCmdVelCallback(~, message)
global cmd_vel
global cmd_angular_vel
global cmd_vel_time

cmd_vel = [message.Twist.Linear.X message.Twist.Linear.Y message.Twist.Linear.Z];
cmd_angular_vel = [message.Twist.Angular.X message.Twist.Angular.Y message.Twist.Angular.Z];
cmd_vel_time = message.Header.Stamp.Sec + message.Header.Stamp.Nsec/1000000000;
end