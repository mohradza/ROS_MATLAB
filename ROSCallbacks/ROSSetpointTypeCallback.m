function ROSSetpointTypeCallback(~, message)

global setpoint_type

setpoint_type = message.Pose.Position.X;

end