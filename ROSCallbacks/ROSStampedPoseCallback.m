function ROSStampedPoseCallback(~, message)

global pose_time
global pos
global orient

pos = [message.Pose.Position.X message.Pose.Position.Y message.Pose.Position.Z];
orient = [message.Pose.Orientation.X message.Pose.Orientation.Y message.Pose.Orientation.Z];
pose_time = message.Header.Stamp.Sec + message.Header.Stamp.Nsec/1000000000;

end