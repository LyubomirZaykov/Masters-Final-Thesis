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
dirs=[acaciaDir;lavenderDir;lindenDir;rapeseedDir;thistleDir];
%----------------------------------------------------%
%Extracting lenght of the folders(count of .jpeg files)
%Since we have 35 samples from each pollen kind, we will use one uniform
%variable, otherwise, we have to extract and use each size separately
uniLenght=size(dirs,1);

%----------------------------------------------------%
%Extract vectors of pollen images names with location
images=locationExtract(uniLenght,dirs)';


%-------------------------------------l---------------%
PollenValues=[];
labels=nameExtract(size(dirs,1),dirs);
%
PollenValues=[];
for i=1:uniLenght
currentImage=imread(images(i));
currentImage=im2gray(currentImage);
curentGCLM=graycomatrix(currentImage,'Offset',[0 1; -1 1; -1 0; -1 -1]);
resizedGCLM=reshape(curentGCLM,[1,8*8*4]);
PollenValues=[PollenValues;resizedGCLM];
PollenFeatures(i)=struct('Name',labels(i),...
                       'GCLM_Feature',PollenValues);
end
mapcaplot(PollenValues,labels)
[pc, zscores, pcvars] = pca(PollenValues);
Nvar=pcvars./sum(pcvars) * 100;
Ncum=cumsum(pcvars./sum(pcvars) * 100);
             
figure
xAcacia=[]; yAcacia=[];  zAcacia=[]; xTilia=[]; yTilia=[]; zTilia=[]; 
xLavender=[];  yLavender=[]; zLavender=[];
% xLavandulaMultifida=[];     yLavandulaMultifida=[];    zLavandulaMultifida=[];
xBrassica=[]; yBrassica=[]; zBrassica=[]; xThistle=[]; yThistle=[]; zThistle=[]; 
for i=1:uniLenght
    if PollenFeatures(i).Name.contains('Acacia') 
        xAcacia=[xAcacia, zscores(i,1)]; yAcacia=[yAcacia, zscores(i,2)]; 
        zAcacia=[zAcacia, zscores(i,3)]; 

    elseif PollenFeatures(i).Name.contains('tilia')  
        xTilia=[xTilia, zscores(i,1)]; yTilia=[yTilia, zscores(i,2)]; 
        zTilia=[zTilia, zscores(i,3)];         

    elseif PollenFeatures(i).Name.contains('Lav')  
        xLavender=[xLavender, zscores(i,1)]; 
        yLavender=[yLavender, zscores(i,2)];  
        zLavender=[zLavender, zscores(i,3)];

    
    elseif PollenFeatures(i).Name.contains('Rapeseed')  
        xBrassica=[xBrassica, zscores(i,1)]; yBrassica=[yBrassica, zscores(i,2)];  
        zBrassica=[zBrassica, zscores(i,3)];        

    elseif PollenFeatures(i).Name.contains('MBod')  
        xThistle=[xThistle, zscores(i,1)]; yThistle=[yThistle, zscores(i,2)];  
        zThistle=[zThistle, zscores(i,3)];      
           
    end
end
plot(xAcacia,yAcacia,'bo','MarkerFaceColor','b'), hold on,
plot(xTilia,yTilia,'g^','MarkerFaceColor','g'), hold on,
plot(xLavender,yLavender,'m>','MarkerFaceColor','m'), hold on
%plot(xBrassica,yBrassica,'ks','MarkerFaceColor','y'), hold on,
plot(xBrassica,yBrassica,'cs','MarkerFaceColor','c'), hold on,
plot(xThistle,yThistle,'rv','MarkerFaceColor','r'), hold on,
xlabel('First Principal Component');
ylabel('Second Principal Component');
title('Principal Component Scatter Plot');
legend('Acacia','Linden','Lavender','Canola','Thistle',...
       'Location','NW')

figure
plot3(xAcacia,yAcacia,zAcacia,'bo','MarkerFaceColor','b'), hold on,
plot3(xTilia,yTilia,zTilia,'g^','MarkerFaceColor','g'), hold on,
plot3(xLavender,yLavender,zLavender,'m>','MarkerFaceColor','m'), hold on
%plot3(xBrassica,yBrassica,zBrassica,'ks','MarkerFaceColor','y'), hold on,
plot3(xBrassica,yBrassica,zBrassica,'cs','MarkerFaceColor','c'), hold on,
plot3(xThistle,yThistle,zThistle,'rv','MarkerFaceColor','r'), hold on,
xlabel('First Principal Component');
ylabel('Second Principal Component');
zlabel('Third Principal Component');
title('Principal Component Scatter Plot');
legend('Acacia','Linden','Lavender','Canola','Thistle',...
       'Location','NW')
grid on
%AZ=105; EL=43; view(AZ,EL)
%AZ=-67; EL=40; view(AZ,EL)
%AZ=-81; EL=36; view(AZ,EL)


% ------------------------- LDA classifier ----------------------------- 
nLinden=size(lindenDir,1); nAcacia=size(acaciaDir,1); nLavender=size(lavenderDir,1); 
nRapeseed=size(rapeseedDir,1); nThistle=size(thistleDir,1);
B=[1.*ones(1,nAcacia),2.*ones(1,nLavender),3.*ones(1,nLinden),...
    4.*ones(1,nRapeseed),5.*ones(1,nThistle)];
zscores3=zscores(:,1:3);
nMostri=size(zscores3,1); 

% pc_arr=[]; zscores_arr=[]; pcvars_arr=[];
CurrentScore_arr=[];
% DecisionThreshold=0.01;

ClassTabTest=zeros(5,5);    % ClassTabTest=zeros(3,3);
IndexTabTest11=[]; IndexTabTest12=[]; IndexTabTest13=[]; IndexTabTest14=[]; IndexTabTest15=[]; 
IndexTabTest21=[]; IndexTabTest22=[]; IndexTabTest23=[]; IndexTabTest24=[]; IndexTabTest25=[]; 
IndexTabTest31=[]; IndexTabTest32=[]; IndexTabTest33=[]; IndexTabTest34=[]; IndexTabTest35=[]; 
IndexTabTest41=[]; IndexTabTest42=[]; IndexTabTest43=[]; IndexTabTest44=[]; IndexTabTest45=[]; 
IndexTabTest51=[]; IndexTabTest52=[]; IndexTabTest53=[]; IndexTabTest54=[]; IndexTabTest55=[]; 
LowAccuracyTest=0; IndexLowAccuracyTest=[]; 

numberClassPredict=zeros(1,nMostri); 
maxP_arr=[]; maxP_Index_arr=[]; Paposts_arr=[];

for is=1:nMostri
    is
    
    % -------------------------------------------------------------
    CurrentValue=PollenValues(is,:);  
    CurrentScore=zscores3(is,:);
    CurrentScore_arr=[CurrentScore_arr;CurrentScore];
    
    PollenValues_L=PollenValues; PollenValues_L(is,:)=[];
    [pc, zscores, pcvars] = pca(PollenValues_L);
    zscores3_L=zscores(:,1:3);
    
    % -------------------------- Initialization --------------------------- 
    nSamples=nMostri-1;
 
    dataClasses=zscores3_L; % Learning Input Data (zscores_L(:,1:3))
    numberClasses=B'; numberClasses(is)=[]; % Learning Output Data

    nTest=1;
    dataClassTest=CurrentScore; % Learning Input Data;     
    numberClassTest=B(1,is); % Testing Output Data

dataClass1=[]; dataClass2=[]; dataClass3=[]; dataClass4=[]; dataClass5=[];
indexClass1=[]; indexClass2=[]; indexClass3=[]; indexClass4=[]; indexClass5=[]; 
yd_arr=[];

for i=1:nSamples
     if numberClasses(i,1)==1 
         dataClass1=[dataClass1; dataClasses(i,:)];  indexClass1=[indexClass1;i]; yd=[1 0 0 0 0]; 
     elseif numberClasses(i,1)==2 
         dataClass2=[dataClass2; dataClasses(i,:)];  indexClass2=[indexClass2;i]; yd=[0 1 0 0 0]; 
     elseif numberClasses(i,1)==3 
         dataClass3=[dataClass3; dataClasses(i,:)];  indexClass3=[indexClass3;i]; yd=[0 0 1 0 0]; 
     elseif numberClasses(i,1)==4 
         dataClass4=[dataClass4; dataClasses(i,:)];  indexClass4=[indexClass4;i]; yd=[0 0 0 1 0]; 
     elseif numberClasses(i,1)==5 
         dataClass5=[dataClass5; dataClasses(i,:)];  indexClass5=[indexClass5;i]; yd=[0 0 0 0 1]; 
     end
     yd_arr=[yd_arr; yd];
end
nClass1=size(dataClass1,1); nClass2=size(dataClass2,1); nClass3=size(dataClass3,1);
nClass4=size(dataClass4,1); nClass5=size(dataClass5,1);
nLevel=size(dataClasses,2);

% ------------------------------  LDA -------------------------------
% Linear Discriminant Analysis

%LinClass = classify(dataClassTest,dataClasses,numberClasses,'linear');
LinClass = classify(dataClassTest,dataClasses,numberClasses,'quadratic');
bad = ~strcmp(LinClass,numberClassTest);

% ------ Aposteriornite veroqtnosti po otnoshenie na testvashtata izvadka ------
decision=zeros(1,nTest); 
if LinClass==1, Papost1=1; Papost2=0; Papost3=0; Papost4=0; Papost5=0; 
elseif LinClass==2, Papost1=0; Papost2=1; Papost3=0; Papost4=0; Papost5=0; 
elseif LinClass==3, Papost1=0; Papost2=0; Papost3=1; Papost4=0; Papost5=0; 
elseif LinClass==4, Papost1=0; Papost2=0; Papost3=0; Papost4=1; Papost5=0; 
elseif LinClass==5, Papost1=0; Papost2=0; Papost3=0; Papost4=0; Papost5=1; 
end
Paposts=[Papost1 Papost2 Papost3 Papost4 Papost5];         
[maxP,maxP_Index]=max(Paposts);
decision(:,1)=maxP_Index;
maxP_arr=[maxP_arr maxP]; 
maxP_Index_arr=[maxP_Index_arr maxP_Index];
Paposts_arr=[Paposts_arr; Paposts];
    

% ------ Obshtata greshka pri klasifikaciqta za testvashtata izvadka -------
% ------------- (chestotata na greshno klasificiranite obekti)--------------
%errors=find(numberClassTest~=decision'),%old
errors=find(numberClassTest~=decision),
%TotalError=100*(length(errors)/length(numberClassTest)), %old

% -------------------------- Validation ------------------------------ 
% -------------- Verify predicted classes in test data ---------------

%for is=1:nTest
       yPredictTest=Paposts_arr(is,:); %vector?
       yPredictMax=maxP_arr(is); %scalar?
       Index_yMax=maxP_Index_arr(is);

       if (Index_yMax==1)&(sum(yPredictTest)~=0)
        if numberClassTest==1
            ClassTabTest(1,1)=ClassTabTest(1,1)+1;
            IndexTabTest11=[IndexTabTest11 is];
        elseif numberClassTest==2
            ClassTabTest(1,2)=ClassTabTest(1,2)+1;
            IndexTabTest12=[IndexTabTest12 is];
        elseif numberClassTest==3
            ClassTabTest(1,3)=ClassTabTest(1,3)+1;
            IndexTabTest13=[IndexTabTest13 is];
        elseif numberClassTest==4
            ClassTabTest(1,4)=ClassTabTest(1,4)+1;
            IndexTabTest14=[IndexTabTest14 is];
        elseif numberClassTest==5
            ClassTabTest(1,5)=ClassTabTest(1,5)+1;
            IndexTabTest15=[IndexTabTest15 is];
        else, 1
        end

       elseif (Index_yMax==2)&(sum(yPredictTest)~=0)
        if numberClassTest==1
            ClassTabTest(2,1)=ClassTabTest(2,1)+1;
            IndexTabTest21=[IndexTabTest21 is];
        elseif numberClassTest==2
            ClassTabTest(2,2)=ClassTabTest(2,2)+1;
            IndexTabTest22=[IndexTabTest22 is];
        elseif numberClassTest==3
            ClassTabTest(2,3)=ClassTabTest(2,3)+1;
            IndexTabTest23=[IndexTabTest23 is];
        elseif numberClassTest==4
            ClassTabTest(2,4)=ClassTabTest(2,4)+1;
            IndexTabTest24=[IndexTabTest24 is];
        elseif numberClassTest==5
            ClassTabTest(2,5)=ClassTabTest(2,5)+1;
            IndexTabTest25=[IndexTabTest25 is];
        else, 2
        end

       elseif (Index_yMax==3)&(sum(yPredictTest)~=0)
        if numberClassTest==1
            ClassTabTest(3,1)=ClassTabTest(3,1)+1;
            IndexTabTest31=[IndexTabTest31 is];
        elseif numberClassTest==2
            ClassTabTest(3,2)=ClassTabTest(3,2)+1;
            IndexTabTest32=[IndexTabTest32 is];
        elseif numberClassTest==3
            ClassTabTest(3,3)=ClassTabTest(3,3)+1;
            IndexTabTest33=[IndexTabTest33 is];
        elseif numberClassTest==4
            ClassTabTest(3,4)=ClassTabTest(3,4)+1;
            IndexTabTest34=[IndexTabTest34 is];
        elseif numberClassTest==5
            ClassTabTest(3,5)=ClassTabTest(3,5)+1;
            IndexTabTest35=[IndexTabTest35 is];
        else, 3
        end

       elseif (Index_yMax==4)&(sum(yPredictTest)~=0)
        if numberClassTest==1
            ClassTabTest(4,1)=ClassTabTest(4,1)+1;
            IndexTabTest41=[IndexTabTest41 is];
        elseif numberClassTest==2
            ClassTabTest(4,2)=ClassTabTest(4,2)+1;
            IndexTabTest42=[IndexTabTest42 is];
        elseif numberClassTest==3
            ClassTabTest(4,3)=ClassTabTest(4,3)+1;
            IndexTabTest43=[IndexTabTest43 is];
        elseif numberClassTest==4
            ClassTabTest(4,4)=ClassTabTest(4,4)+1;
            IndexTabTest44=[IndexTabTest44 is];
        elseif numberClassTest==5
            ClassTabTest(4,5)=ClassTabTest(4,5)+1;
            IndexTabTest45=[IndexTabTest45 is];
        else, 4
        end
        
       elseif (Index_yMax==5)&(sum(yPredictTest)~=0)
        if numberClassTest==1
            ClassTabTest(5,1)=ClassTabTest(5,1)+1;
            IndexTabTest51=[IndexTabTest51 is];
        elseif numberClassTest==2
            ClassTabTest(5,2)=ClassTabTest(5,2)+1;
            IndexTabTest52=[IndexTabTest52 is];
        elseif numberClassTest==3
            ClassTabTest(5,3)=ClassTabTest(5,3)+1;
            IndexTabTest53=[IndexTabTest53 is];
        elseif numberClassTest==4
            ClassTabTest(5,4)=ClassTabTest(5,4)+1;
            IndexTabTest54=[IndexTabTest54 is];
        elseif numberClassTest==5
            ClassTabTest(5,5)=ClassTabTest(5,5)+1;
            IndexTabTest55=[IndexTabTest55 is];
        else, 5
        end
         
      else
        LowAccuracyTest=LowAccuracyTest+1;
        IndexLowAccuracyTest=[IndexLowAccuracyTest is];
      end, % if
%end, % for is=1:nTest

end

ClassTabTest
LowAccuracyTest

AllSuccess=ClassTabTest(1,1)+ClassTabTest(2,2)+ClassTabTest(3,3)+ClassTabTest(4,4)+ClassTabTest(5,5);
AllTest=sum(sum(ClassTabTest)); AllTest=AllTest+LowAccuracyTest;
Success=AllSuccess./AllTest.*100

figure
xAcacia=[];	yAcacia=[];	zAcacia=[];      
xTilia=[];	yTilia=[];	zTilia=[]; 
%xLavandulaAngustifolia=[];  yLavandulaAngustifolia=[]; zLavandulaAngustifolia=[];
%xLavandulaMultifida=[];     yLavandulaMultifida=[];    zLavandulaMultifida=[];
xLavandula=[];	yLavandula=[];	zLavandula=[];
xBrassica=[];   yBrassica=[];   zBrassica=[]; 
xThistle=[];    yThistle=[];    zThistle=[]; 
for i=1:nMostri
    if maxP_Index_arr(i)==1, 
        xAcacia=[xAcacia, CurrentScore_arr(i,1)]; 
        yAcacia=[yAcacia, CurrentScore_arr(i,2)]; 
        zAcacia=[zAcacia, CurrentScore_arr(i,3)];
    elseif maxP_Index_arr(i)==2, 
        xTilia=[xTilia, CurrentScore_arr(i,1)]; 
        yTilia=[yTilia, CurrentScore_arr(i,2)];         
        zTilia=[zTilia, CurrentScore_arr(i,3)];
    elseif maxP_Index_arr(i)==3, 
        xLavandula=[xLavandula, CurrentScore_arr(i,1)]; 
        yLavandula=[yLavandula, CurrentScore_arr(i,2)];         
        zLavandula=[zLavandula, CurrentScore_arr(i,3)];
    elseif maxP_Index_arr(i)==4, 
        xBrassica=[xBrassica, CurrentScore_arr(i,1)]; 
        yBrassica=[yBrassica, CurrentScore_arr(i,2)];         
        zBrassica=[zBrassica, CurrentScore_arr(i,3)];
    elseif maxP_Index_arr(i)==5, 
        xThistle=[xThistle, CurrentScore_arr(i,1)]; 
        yThistle=[yThistle, CurrentScore_arr(i,2)];         
        zThistle=[zThistle, CurrentScore_arr(i,3)];
    end
end

plot3(xAcacia,yAcacia,zAcacia,'bo','MarkerFaceColor','b'), hold on,
plot3(xTilia,yTilia,zTilia,'g^','MarkerFaceColor','g'), hold on,
plot3(xLavandula,yLavandula,zLavandula,'m>','MarkerFaceColor','m'), hold on
plot3(xBrassica,yBrassica,zBrassica,'cs','MarkerFaceColor','c'), hold on,
plot3(xThistle,yThistle,zThistle,'rv','MarkerFaceColor','r'), hold on,
xlabel('First Principal Component');
ylabel('Second Principal Component');
zlabel('Third Principal Component');
title('LDA Scatter Plot');
legend('Acacia','Linden','Lavender','Canola','Thistle',...
       'Location','NW')
grid on

save LDA_Gabor
