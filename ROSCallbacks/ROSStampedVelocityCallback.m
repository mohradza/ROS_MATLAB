function ROSStampedVelocityCallback(~, message)
global vel
global angular_vel
global vel_time

vel = [message.Twist.Linear.X message.Twist.Linear.Y message.Twist.Linear.Z];
angular_vel = [message.Twist.Angular.X message.Twist.Angular.Y message.Twist.Angular.Z];
vel_time = message.Header.Stamp.Sec + message.Header.Stamp.Nsec/1000000000;
end