function [images]=locationExtract(length,directory)
vector=string.empty;
for i=1:length
   currentImageName=fullfile(directory(i).name);
   currName=string(currentImageName);
   if currName.contains('Acacia')
       currName=strcat('Acacia\',currName);
   end
    if currName.contains('Lav')
       currName=strcat('Lavender\',currName);
    end
    if currName.contains('tilia')
       currName=strcat('Linden\',currName);
    end
   if currName.contains('Rapeseed')
       currName=strcat('Rapeseed\',currName);
   end
    if currName.contains('MBod')
       currName=strcat('Thistle\',currName);
    end
   vector(i)=currName;
end
images=vector;
end