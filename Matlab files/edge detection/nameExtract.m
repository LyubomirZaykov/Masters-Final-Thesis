function [images]=nameExtract(length,directory)
vector=string.empty;
for i=1:length
   currentImageName=fullfile(directory(i).name);
   currName=string(currentImageName);
   vector(i)=currName;
end
images=vector;
end