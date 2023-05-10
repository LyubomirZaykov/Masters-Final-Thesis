function [images]=nameExtract(length,directory,dirName)
vector=string.empty;
for i=1:length
   currentImageName=fullfile(dirName,directory(i).name);
   currName=string(currentImageName);
   vector(i)=currName;
end
images=vector;
end