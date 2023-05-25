function [images]=nameExtract(length,directory)
vector=string.empty;
for i=1:length
   currentImageName=fullfile(directory(i).name);
   currName=string(currentImageName);
   currName=erase(currName,'.jpg');
   vector(i)=currName;
end
images=vector;
end