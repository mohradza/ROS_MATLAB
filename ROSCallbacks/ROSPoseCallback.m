function ROSPoseCallback(~, message)

global pos
global orient

pos = [message.Pose.Position.X message.Pose.Position.Y message.Pose.Position.Z];
orient = [message.Pose.Orientation.X message.Pose.Orientation.Y message.Pose.Orientation.Z];

end