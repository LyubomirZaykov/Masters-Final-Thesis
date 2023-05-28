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
for i=1:uniLenght
%%
%Прочитане на снимката, преобразуването ѝ в едноцветна

%Reading the image, convert it to gray 
currentImage=imread(imageLocations(i));
currentImage=rgb2gray(currentImage);
% current=imresize(currentImage,[30 30]);
%%
% Изчисляване на 'gray level co-occurence matrix' на всяка снимка с разстояние 1 по хоризонтално,
% вертикално, на 45 и 135 градуса, посредством метода 'graycomatrix'.Извличането на характерните признаци
%става с функцията 'graycoprops'
%Calculating the 'gray level co-occurence matrix' on each picture with dimension of 1 on horizontal, vertical
%on 45 and 135 degrees, using method 'graycomatrix'. Extracting the specific features is done with the method
% 'graycoprops'
curentGCLM=graycomatrix(currentImage,'NumLevels',8,'Offset',[0 1; -1 1; -1 0; -1 -1]);
curentGCLM=curentGCLM(:,:,1)+curentGCLM(:,:,2)+curentGCLM(:,:,3)+curentGCLM(:,:,4);
% curentGCLM=graycomatrix(currentImage,'Offset',[0 1; -1 1; -1 0]);
%curentGCLM=graycomatrix(currentImage,'Offset',[0 1; -1 1]);
% curentGCLM=graycomatrix(currentImage,'Offset',[0 1]);
% currProps=graycoprops(curentGCLM);
% props=[currProps.Contrast,currProps.Correlation,currProps.Energy,currProps.Homogeneity];
resizedGCLM=reshape(curentGCLM,[1,8*8]);
PollenFeatures=[PollenFeatures;resizedGCLM];
end
mapcaplot(PollenFeatures,labels);
[pc, score, pcvars]=pca(PollenFeatures);
scores=score(:,1:9);%%При 8 се получават най - добрите резултати //quadratic
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
PollenFeaturesTest=scores(k,:);
labelTest=labels(k);
PollenFeaturesLearn=scores; PollenFeaturesLearn(k,:)=[];
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