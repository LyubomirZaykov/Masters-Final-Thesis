%%
%Инициализация
%Initializing
clear all;
clc
close all;
%%
%Старт на брояча/Start of the timewatch
tic

%%
%Извличане на всички файлове с .jpeg разширение от съответните папки и обединяването им в променливата 'dirs'

%Extract all names of the .jpg images in the current folders and unite them in the variable 'dirs'
acaciaDir=dir('Acacia\*.jpg');
lavenderDir=dir('Lavender\*.jpg');
lindenDir=dir('Linden\*.jpg');
rapeseedDir=dir('Rapeseed\*.jpg');
thistleDir=dir('Thistle\*.jpg');
dirs=[acaciaDir;lavenderDir;lindenDir;rapeseedDir;thistleDir];

%%
%Извличане на дължината на променливата 'dirs' с цел присвояването на стойността на и на променливата 
% 'uniLength', която ще се използва по-напред в програмата

%Extracting the length of the variable 'dirs' in order to assign the length to a variable 'uniLength, as it
% will be used further in the program
uniLenght=size(dirs,1);

%%
%Извличане на 'string' масив с местоположенията на отделните снимки, с цел прочитането им от програмата

%Extract string array of pollen image location in order to be able to read the images from the drive
imageLocations=locationExtract(uniLenght,dirs)';

%%
%Извличане на 'string' масив с етикети, използвани за обучението и тестването на класификатора с Дискриминантен анализ

%Extract string array of labels, used for training and testing the DA (discriminant analysis) classificator
labels=nameExtract(size(dirs,1),dirs)';

%%
%Празна матрица за съхранението на признаците за класификация
%Empty matrix for storing features for classification
PollenFeatures=[];
GaborFeatures=[];

gaborArray = gabor([4 8],[0 45 90 135]);
for i=1:uniLenght
%%
%Прочитане на снимката, преобразуването ѝ в едноцветна

%Reading the image, convert it to gray 
currentImage=imread(imageLocations(i));
inpict=currentImage;  % RGB image

%Определяне на праг за фона на базата на 30х30 пиксела в 4-те ъгълъ на образа 
[row,column,color]=size(inpict);
rowFiltBack=30; columnFiltBack=30; 
TopLeft=inpict(1:rowFiltBack,1:columnFiltBack,:);
TopRight=inpict(1:rowFiltBack,column-columnFiltBack:column,:);
BottomLeft=inpict(row-rowFiltBack:row,1:columnFiltBack,:);
BottomRight=inpict(row-rowFiltBack:row,column-columnFiltBack:column,:);
Corners4=[[TopLeft,TopRight];[BottomLeft,BottomRight]];

grayCorners4=rgb2gray(Corners4); % Convert 4 corners to gray: 0-255
sMinG=min(grayCorners4(:,:,1),[],'all');
threshold=sMinG;

currentImage=rgb2gray(currentImage); % Convert image to gray: 0-255
currenGaborImage=imresize(currentImage,[30 30]);
curentGabor=imgaborfilt(currenGaborImage,gaborArray);

resizedGabor=reshape(curentGabor,[1,30*30*8]);
GaborFeatures=[GaborFeatures;resizedGabor];
inpictGray=currentImage;  % Gray image
maskG = inpictGray(:,:,:) >=threshold; % look for background regions  
mask = bwareafilt(maskG,1); % pick the largest object (the background)

%%
% --------- VARIANT 0:  Binarize by threshold "sMinG" ------------------------
outpictWB=ones(size(inpictGray)); % empty white image
outpictWB(mask(:,:,1)) = 0; % White object on the black background 

% --------- VARIANT 1: "Imbinarize" with 'global' ----------------------------- 
inpictBW1 = imbinarize(inpictGray,'global'); % convert to Black and White
TopLeftBW1=inpictBW1(1:rowFiltBack,1:columnFiltBack,:);
if sum(TopLeftBW1)/(rowFiltBack.*columnFiltBack)<0.25; %Averaged White TopLeft corner
    inpictBW1=not(inpictBW1);
end

% -------- VARIANT 2: "Imbinarize" on "rangefilt" with 'adaptive'--------------
J = rangefilt(inpictGray); 
inpictBWa = imbinarize(J,'adaptive','ForegroundPolarity','bright','Sensitivity',0.6); %convert to Black and White  

%%
%------------'VARIANT 1 + VARIANT 2' Two layer binarized image -----------------
% Two layer binarized image (VARIANT 1 + VARIANT 2)
inpict2Layer=or(inpictBW1,inpictBWa);
inpict2Layer = imfill(inpict2Layer,'holes');  % Fill holes.
inpict2Layer = bwareafilt(inpict2Layer, 1); % Extract largest blob.
[labeledImage2Layer, numBlobs2Layer] = bwlabel(inpict2Layer); % Label the image

%%
%------------'VARIANT 0 + VARIANT 1 + VARIANT 2' Three layer binarized image -----------------
inpict3Layer=or(outpictWB,inpict2Layer);
inpict3Layer = imfill(inpict3Layer,'holes');  % Fill holes.
inpict3Layer = bwareafilt(inpict3Layer, 1); % Extract largest blob.
[labeledImage3Layer, numBlobs3Layer] = bwlabel(inpict3Layer); % Label the image

%%
%--------------- Black White Image Properties --------------------
propsBW = regionprops(labeledImage3Layer, 'All');
Feature1=propsBW.Eccentricity;
Feature2=propsBW.Circularity; %Roundness of object=(4*Area*pi)/(Perimeter^2) --> for circle=1
Feature3=propsBW.EquivDiameter; 
Feature4=propsBW.Extent;
Feature5=propsBW.MinorAxisLength./propsBW.MajorAxisLength;
Feature6=propsBW.MinFeretDiameter./propsBW.MaxFeretDiameter; 
Feature7=propsBW.Area;
Feature8=propsBW.Perimeter;
%%
% Извличането на характерните признаци
props=[Feature1,Feature2,Feature3,Feature4,Feature5,Feature6,Feature7,Feature8];
%props=[Feature1,Feature2,Feature3,Feature4,Feature5,Feature6,Feature7];
%props=[Feature2,Feature3,Feature4,Feature5,Feature6,Feature7];
%props=[Feature1,Feature3,Feature4,Feature5,Feature6,Feature7];
%props=[Feature1,Feature2,Feature3,Feature4,Feature5,Feature6];
%props=[Feature1,Feature2,Feature3,Feature4,Feature5];
PollenFeatures=[PollenFeatures;props];
end
[pc, score, pcvars]=pca(GaborFeatures);
scores=score(:,1:31);
PollenFeatures=[scores,PollenFeatures];
%%
%Функцията 'fitcdiscr' извършва обучение на модела 'md', използвайки квадратичен дискриминантен анализ на 
%подадените данни от променливата 'PollenFeatures',представляваща признаците: Контраст, Корелация, 
%Енергия и Хомогенност  
%The metod 'fitcdiscr' performs training of the model 'md', using quadratic discriminant analysis on the input
%data from the variable 'PollenFeatures' which stores the feaures:Contract, Correlation, Energy 
% and Homogeneity%
%TESTING LEAVE ONE OUT CROSS VALIDATION
predictLabels=[];
for k=1:uniLenght
k
PollenFeaturesTest=PollenFeatures(k,:);
labelTest=labels(k);
PollenFeaturesLearn=PollenFeatures; PollenFeaturesLearn(k,:)=[];
labelsL=labels; labelsL(k,:)=[];
md=fitcdiscr(PollenFeaturesLearn,labelsL,DiscrimType="quadratic");

%%
%След като е обучен моделът, ще бъде направен опит да предскаже всеки един полен, подавайки му всички признаци,
% използвани за обучението на модела, един по един. Резултатуте ще бъдат оценени%
%Once the model is learned, it will be asked for prediction for every pollen feature from the dataset and
%results will be evaluated

currentPrediction=md.predict(PollenFeaturesTest);
predictLabels=[predictLabels; currentPrediction];

end
%%
% Кастване(силово преобразуване) на получените предсказания в 'string формат в променливата 'predicted'%

%Casting the predictions into string format in the variable 'predicted'
predicted=string(predictLabels);

%%
%Оценка на получените резултати в % предсказани полени
%Evaluating the results in terms of % predicted pollens
Ibad=~strcmp(predicted,labels);
SuccessRate=100-(sum(Ibad)/uniLenght)*100

%%
%Изчисляване и визуализация на 'confusion matrix'
%Calculation and visualisation of the 'confusion matrix'
% [confusionmatrix, matrixlabels]=confusionmat(labels,predicted);
cm=confusionchart(labels,predicted);

%%
%Край на брояча/ End of timewatch
toc