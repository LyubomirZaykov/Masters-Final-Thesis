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
coefs=zeros(175,3);
for i=1:size(imagesNames,2)
i
currImage=imread(imagesNames(1,i));
resizedImage=imresize(currImage,[512,512]);
currCoef=fd(resizedImage);
coefs(i,1)=currCoef(1);
coefs(i,2)=currCoef(2);
coefs(i,3)=currCoef(1)/currCoef(2);
end
coefs;

