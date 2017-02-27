function ROSStateCallback(~, message)
global armed

armed = message.Armed;
end