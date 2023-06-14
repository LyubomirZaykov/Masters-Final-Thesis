%%
%Инициализация
%Initializing
clear all;
clc
close all;
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
%%
%Инициализация на масив от 2х4 стойности с Габор филтри, съдърщажи две дължини на вълната и 4 ориентации

%Initialization of 2x4 matrix with Gabor filters, containing two wavelengths and four orientations
gaborArray = gabor([4 8],[0 45 90 135]);
for i=1:uniLenght
%%
%Прочитане на снимката, преобразуването ѝ в едноцветна и преоразмеряването ѝ в размер 30х30пиксела
%Reading the image, convert it to gray and resize it to square 30x30px

currentImage=imread(imageLocations(i));
currentImage=rgb2gray(currentImage);
% gabFilterVisualize=imgaborfilt(currentImage,gaborArray);
% if i==1
% figure(1)
%     tiledlayout(2,4);
%     nexttile
%     imshow(gabFilterVisualize(:,:,1),[],'InitialMagnification','fit');
%     title("λ=4; 0 degrees")
%     nexttile
%     imshow(gabFilterVisualize(:,:,2),[],'InitialMagnification','fit');
%     title("λ=8; 0 degrees")
%      nexttile
%     imshow(gabFilterVisualize(:,:,3),[],'InitialMagnification','fit');
%     title("λ=4; 45 degrees")
%     nexttile
%     imshow(gabFilterVisualize(:,:,4),[],'InitialMagnification','fit');
%     title("λ=8; 45 degrees")
%      nexttile
%     imshow(gabFilterVisualize(:,:,5),[],'InitialMagnification','fit');
%     title("λ=4; 90 degrees")
%     nexttile
%     imshow(gabFilterVisualize(:,:,6),[],'InitialMagnification','fit');
%     title("λ=8; 90 degrees")
%      nexttile
%     imshow(gabFilterVisualize(:,:,7),[],'InitialMagnification','fit');
%     title("λ=4; 135 degrees")
%     nexttile
%     imshow(gabFilterVisualize(:,:,8),[],'InitialMagnification','fit');
%     title("λ=8; 135 degrees")
% end
currentImage=imresize(currentImage,[30 30]);

%%
%Прилагането на филтъра на Габор върху конкретното изображение, прилагайки филтрите от масива 'gaborArray'
%Apply the Gabor filter over current image, applying the filters from the 'gaborArray'
currentGabFilt=imgaborfilt(currentImage,gaborArray);

%%
%Промяната на формата на матрицата с признаци, получени от филтъра на Габор във вектор-ред с размери 1х7200%

%Change the shape of matrix with features, gathered from Gabor filter into  row-vector with dim. 1x7200%
currentGabFeature=reshape(currentGabFilt,[1,30*30*8]);

%%
%Натрупването на характерните признаци от всички изображения в променливата 'PollenFeatures'
%Accumulate the distinctive features from all images into the variable 'PollenFeatures'
PollenFeatures=[PollenFeatures;currentGabFeature];
end

[pc, score, pcvars]=pca(PollenFeatures);
% msgfSum=sum(pcvars(1:30));
% msgf=(pcvars(1:30)/sum(pcvars))*100;
% pareto(msgf);
% currentTitle = [num2str(sum(msgf)),' % от дисперсията, обхванат от първите 30 главни компонента'];
% title('Процент дисперсия, обхванат от отделните главни компоненти');
% xlabel('Главен компонент');
% ylabel('% дисперсия');
scores=score(:,1:35);%с 15 е най - добрия резултат
visualisePcaData(labels,scores);
%%
%Функцията 'fitcdiscr' извършва обучение на модела 'md',използвайки линеен дискриминантен анализна подадените 
%данни от променливата 'PollenFeatures',представляваща признаците, получени от филтъра на Габор

%The method 'fitcdiscr' performs training of the model 'md' using linear discriminant analysis on the input
%data from the variable 'PollenFeatures', which stores the features from Gabor filters%
predictLabelsLDA=[];
for k=1:uniLenght
k
PollenFeaturesTest=scores(k,:);
labelTest=labels(k);
PollenFeaturesLearn=scores; PollenFeaturesLearn(k,:)=[];
labelsL=labels; labelsL(k,:)=[];
md=fitcdiscr(PollenFeaturesLearn,labelsL,DiscrimType="linear");
%%
%След като е обучен моделът, ще бъде направен опит да предскаже всеки един полен, подавайки му всички признаци,
% използвани за обучението на модела, един по един. Резултатуте ще бъдат оценени%
%Once the model is learned, it will be asked for prediction for every pollen feature from the dataset and
%results will be evaluated
currentPredictionLDA=md.predict(PollenFeaturesTest);
predictLabelsLDA=[predictLabelsLDA; currentPredictionLDA];
end
visualiseLdaData(md,PollenFeaturesLearn);

%%
% Кастване(силово преобразуване) на получените предсказания в 'string формат в променливата 'predicted'%

%Casting the predictions into string format in the variable 'predicted'
predictedLDA=string(predictLabelsLDA);
%%
%Оценка на получените резултати в % предсказани полени
%Evaluating the results in terms of % predicted pollens
IbadLDA=~strcmp(predictedLDA,labels);
SuccessRateLDA=100-(sum(IbadLDA)/uniLenght)*100
%%
%Изчисляване и визуализация на 'confusion matrix'
%Calculation and visualisation of the 'confusion matrix'
% [confusionmatrix, matrixlabels]=confusionmat(labels,predicted);
figure(4)
cm=confusionchart(labels,predictedLDA);

%%
%Край на брояча/ End of timewatch
toc