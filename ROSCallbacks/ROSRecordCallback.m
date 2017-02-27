function ROSRecordCallback(~, message)
global record

record = message.Data;
end