function ROSStampedCmdPoseCallback(~, message)

global cmd_pos
global cmd_orient
global cmd_pose_time

cmd_pos = [message.Pose.Position.X message.Pose.Position.Y message.Pose.Position.Z];
cmd_orient = [message.Pose.Orientation.X message.Pose.Orientation.Y message.Pose.Orientation.Z];
cmd_pose_time = message.Header.Stamp.Sec + message.Header.Stamp.Nsec/1000000000;

end