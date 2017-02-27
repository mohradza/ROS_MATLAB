function ROSDenseUCallback(~, message)

global OF_u


rows = message.Layout.Dim(0).Size;
cols = message.Layout.Dim(1).Size;

for i = 0:rows
   for j = 0:cols
      OF_u(i,j) = message.Data(i*cols + j); 
   end
    
end

end