function [images]=nameExtract(length,directory)
vector=string.empty;
for i=1:length
   currentImageName=fullfile(directory(i).name);
   currName=string(currentImageName);
   l=strlength(currName);
   currName=currName.eraseBetween(l-5,l);
   currName=erase(currName,'.jpg');
   vector(i)=currName;
end
images=vector;
end