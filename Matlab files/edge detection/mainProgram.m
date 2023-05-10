%----------------------------------------------------%
%Initializing
clear all;
clc
close all;

%----------------------------------------------------%
%Extract all names of the .jpg images in the current folders
acaciaDir=dir('Acacia\*.jpg');
lavenderDir=dir('Lavender\*.jpg');
lindenDir=dir('Linden\*.jpg');
rapeseedDir=dir('Rapeseed\*.jpg');
thistleDir=dir('Thistle\*.jpg');

%----------------------------------------------------%
%Extracting lenght of the folders(count of .jpeg files)
%Since we have 35 samples from each pollen kind, we will use one uniform
%variable, otherwise, we have to extract and use each size separately
uniLenght=size(acaciaDir,1);

%----------------------------------------------------%
%Extract vectors of pollen images names with location
acaciaImages=locationExtract(uniLenght,acaciaDir,'Acacia');
lavenderImages=locationExtract(uniLenght,lavenderDir,'Lavender');
lindenImages=locationExtract(uniLenght,lindenDir,'Linden');
rapeseedImages=locationExtract(uniLenght,rapeseedDir,'Rapeseed');
thistleImages=locationExtract(uniLenght,thistleDir,'Thistle');

%-------------------------------------l---------------%
%Loading, resizing to 512x512 pixels all the images and measuring fractal
%dimensions (2 coefficients)
imagesNames=[acaciaImages, lavenderImages, lindenImages, rapeseedImages, thistleImages];
labels=int8.empty;
for i=1:size(imagesNames,2)
% i
if i>0&&i<36
 labels(i)=1;
end
if i>35&&i<71
 labels(i)=2;
end
if i>70&&i<106
 labels(i)=3;
end
if i>105&&i<141
 labels(i)=4;
end
if i>140&&i<176
 labels(i)=5;
end
currImage=imread(imagesNames(1,i));
% resizedImage=imresize(currImage,[512,512]);
currImage=im2gray(currImage);
currImage=edge(currImage,'canny');
images{i}=currImage;
end
%Tuk imam nqkakwa ideq da zahranq nevornnata mreva direktno s
%izobrajeniqta,no e na etap ideq
trainInput=images(:,[1:30,36:65,71:100,106:135,141:170]);
testInput=images(:,[31:35,66:70,101:105,136:140,171:175]);
trainLabels=labels(:,[1:30,36:65,71:100,106:135,141:170]);
testLabels=labels(:,[31:35,66:70,101:105,136:140,171:175]);
net=feedforwardnet(10,'trainbfg');
net=train(net,trainInput,trainLabels);
guessed=0;
for i=1:size(testInput,2)
expectedOutput=testLabels(1,i);
output=net(testInput(:,i));
roundOutput=round(output);
if expectedOutput==roundOutput
    guessed=guessed+1;
end
end
successRate=(guessed/25)*100;
successRate
g

