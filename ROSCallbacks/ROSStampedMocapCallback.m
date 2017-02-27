function ROSStampedMocapCallback(~, message)

global mocap_pose_time
global mocap_pos
global mocap_orient

mocap_pos = [message.Pose.Position.X message.Pose.Position.Y message.Pose.Position.Z];
mocap_orient = [message.Pose.Orientation.X message.Pose.Orientation.Y message.Pose.Orientation.Z];
mocap_pose_time = message.Header.Stamp.Sec + message.Header.Stamp.Nsec/1000000000;

end