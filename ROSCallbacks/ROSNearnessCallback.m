function ROSNearnessCallback(~, message)

global nearness

nearness = message.Data;

end