function ROSFlowCallback(~, message)

global OF_vec
global vel_vec
global flow_size

OF_vec = message.U;
vel_vec = message.X;

end