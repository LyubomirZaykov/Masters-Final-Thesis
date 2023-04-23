clear all
% Use subroutine PhotoNorm01.m

% ------------- Initialization ---------------
rand('seed',0); rand(20,1);
nTilia=22; sizeTilia_Aver=33; deltaSizeTilia=2; 
sizeTilia=sizeTilia_Aver.*ones(nTilia,1)+(rand(nTilia,1)-0.5).*2.*deltaSizeTilia;
Tilia=struct('Name','Tilia','Photo',{'Tilia_platyphyllos1.jpg';'Tilia_platyphyllos2.jpg';...
             'Tilia_platyphyllos3.jpg';'Tilia_platyphyllos4.jpg';'Tilia_platyphyllos5.jpg';...
             'Tilia_platyphyllos6.jpg';'Tilia_platyphyllos7.jpg';'TiliaEuSARSA1.jpg';...
             'TiliaEuSARSA2.jpg';'TiliaEuSARSA3.jpg';'TiliaEuSARSA4.jpg';'TiliaEuSARSA5.jpg';...
             'TiliaEuSARSA6.jpg';'TiliaEuSARSA7.jpg';'TiliaEuSARSA8.jpg';...
             'TiliaCordata_PollenWarndiest1.jpg';'TiliaCordata_PollenWarndiest2.jpg';...
             'TiliaCordata_PollenWarndiest3.jpg';'TiliaCordata_PollenWarndiest4.jpg';...
             'TiliaCordata_PollenWarndiest5.jpg';'TiliaCordata_PollenWarndiest6.jpg';...
             'Tilia_DiscoverLife1.jpg'},...
             'AverageSize',num2cell(sizeTilia),'SizeCategory','M');
             %'AverageSize',num2cell([31.*ones(7,1);34.7.*ones(8,1);32.*ones(6,1);33]),'SizeCategory','M');

nAcacia=17; sizeAcacia_Aver=30; deltaSizeAcacia=2; 
sizeAcacia=sizeAcacia_Aver.*ones(nAcacia,1)+(rand(nAcacia,1)-0.5).*2.*deltaSizeAcacia;             
Acacia=struct('Name','Acacia','Photo',{'Robinia_pseudoacacia1.jpg';'Robinia_pseudoacacia2.jpg';...
            'Robinia_pseudoacacia3.jpg';'Robinia_pseudoacacia4.jpg';'Robinia_pseudoacacia5.jpg';...
            'Robinia_pseudoacacia6.jpg';'AcaciaSARS1.jpg';'AcaciaPalDat1.jpg';...
            'Robinia_Cornel1.jpg';'Robinia_Cornel2.jpg';'Robinia_PollenWarndiest1.jpg';...
            'Robinia_PollenWarndiest2.jpg';'Robinia_PollenWarndiest3.jpg';'Robinia_PollenWarndiest4.jpg';...
            'Robinia_PollenWarndiest5.jpg';'Robinia_PollenWarndiest6.jpg';'Robinia_DiscoverLife1.jpg'},...
            'AverageSize',num2cell(sizeAcacia),'SizeCategory','M');
            %'AverageSize',num2cell([30.*ones(6,1);24;27;[32;32];30.*ones(6,1);30]),'SizeCategory','M');
            
nLavenderAngusti=13; sizeLavenderAngusti_Aver=37;  deltaSizeLavenderAngusti=2.5; % deltaSizeLavenderAngusti=4;
sizeLavenderAngusti=sizeLavenderAngusti_Aver.*ones(nLavenderAngusti,1)+(rand(nLavenderAngusti,1)-0.5).*2.*deltaSizeLavenderAngusti;            
LavenderAngusti=struct('Name','LavandulaAngustifolia','Photo',{'Lavandula_angustifolia1.jpg';...
            'Lavandula_angustifolia2.jpg';'Lavandula_angustifolia3.jpg';'Lavandula_angustifolia4.jpg';...
            'Lavandula_angustifolia5.jpg';'LavandSARS1.jpg';'LavandSARS2.jpg';...
            'Lavandula_Gallery_3Sa.jpg';'Lavandula_Gallery_3Sb.jpg';'Lavandula_Gallery_3Sc.jpg';...
            'Lavandula_Gallery_6_1a.jpg';'Lavandula_Gallery_6_1b.jpg';'Lavandula_Gallery_6_1c.jpg'},...
            'AverageSize',num2cell(sizeLavenderAngusti),'SizeCategory','M'); %-----------------size=20 ??
            %'AverageSize',num2cell([37.*ones(5,1);33;33;20.*ones(6,1)]),'SizeCategory','M'); %-----------------size=20 ??
            
nLavenderMultifida=5; sizeLavenderMultifida_Aver=36; deltaSizeLavenderMultifida=2.5; %deltaSizeLavenderMultifida=4; 
sizeLavenderMultifida=sizeLavenderMultifida_Aver.*ones(nLavenderMultifida,1)+(rand(nLavenderMultifida,1)-0.5).*2.*deltaSizeLavenderMultifida;            
LavenderMultifida=struct('Name','LavandulaMultifida','Photo',{'Lavandula_multifida1.jpg';...
            'Lavandula_multifida2.jpg';'Lavandula_multifida3.jpg';'Lavand4MultifPalDat1.jpg';...
            'Lavandula_DiscoverLife1.jpg'},...
            'AverageSize',num2cell(sizeLavenderMultifida),'SizeCategory','M');
            %'AverageSize',num2cell([48.*ones(3,1);48;45]),'SizeCategory','M');
            
nBrassica=16; sizeBrassica_Aver=25; deltaSizeBrassica=3; 
sizeBrassica=sizeBrassica_Aver.*ones(nBrassica,1)+(rand(nBrassica,1)-0.5).*2.*deltaSizeBrassica;            
Brassica=struct('Name','Brassica','Photo',{'Brassica_napus1.jpg';'Brassica_napus2.jpg';...
            'Brassica_napus3.jpg';'Brassica_napus4.jpg';'Brassica_napus5.jpg';...
            'Brassica_napus6.jpg';'BrassicaRapaSARS1.jpg';'BrassicaRapaSARS2.jpg';...
            'BrassicaPalDat1.jpg';'BrassicaPalDat2.jpg';'BrassicaPalDat3.jpg';...
            'Brassica_PollenWarndiest1.jpg';'Brassica_PollenWarndiest2.jpg';...
            'Brassica_PollenWarndiest3.jpg';'Brassica_PollenWarndiest4.jpg';...
            'Brassica_PollenWarndiest5.jpg'},...
            'AverageSize',num2cell(sizeBrassica),'SizeCategory','M');
            %'AverageSize',num2cell([27.*ones(6,1);[27;27];[33;33;33];24.*ones(5,1)]),'SizeCategory','M');
            
nThistleCirsium=20; sizeThistleCirsium_Aver=38; deltaSizeThistleCirsium=2.5; % deltaSizeThistleCirsium=4;  
sizeThistleCirsium=sizeThistleCirsium_Aver.*ones(nThistleCirsium,1)+(rand(nThistleCirsium,1)-0.5).*2.*deltaSizeThistleCirsium;                      
ThistleCirsium=struct('Name','CirsiumArvense','Photo',{'Cirsium_arvense1.jpg';'Cirsium_arvense6.jpg';...
             'Cirsium_arvense7.jpg';'Cirsium_arvense12.jpg';'Cirsium_arvense17.jpg';...
             'Cirsium_arvense18.jpg';'Cirsium_arvense19.jpg';...
             'Cirsium_Gallery_2_1a.jpg';'Cirsium_Gallery_2_1b.jpg';'Cirsium_Gallery_2_1c.jpg';...
             'Cirsium_Gallery_2_2b.jpg';'Cirsium_Gallery_2_2c.jpg';'Cirsium_Gallery_2_2e.jpg';...
             'Cirsium_Gallery_2_3b.jpg';'Cirsium_Gallery_2_3c.jpg';'Cirsium_Gallery_2_3d.jpg';...
             'Cirsium_Gallery_2_4b.jpg';'Cirsium_Gallery_2_4c.jpg';'Cirsium_Gallery_2_4d.jpg';...
             'Cirsium_DiscoverLife1.jpg'},...
             'AverageSize',num2cell(sizeThistleCirsium),'SizeCategory','M');   
             %'AverageSize',num2cell([38.*ones(7,1);35.*ones(3,1);34.*ones(3,1);42.*ones(3,1);40.*ones(3,1);38]),'SizeCategory','M');
Pollens = [Tilia; Acacia; LavenderAngusti; LavenderMultifida; Brassica; ThistleCirsium];
%Pollens = [Tilia; Acacia; LavenderAngusti; LavenderMultifida];
%%Pollens = [Tilia; Acacia; Brassica];
%%Pollens = [Tilia; Acacia; ThistleCirsium];

Pollens = [Tilia; Acacia; LavenderAngusti; LavenderMultifida; Brassica; ThistleCirsium];
[nPatterns,mTemp]=size(Pollens);

gaborArray = gabor([4 8],[0 45 90 135]);

for it=1:nPatterns
    I = imread(Pollens(it).Photo);
    I = rgb2gray(I);
    Inorm=PhotoNorm01(I); % Normalized image between [0; 1]
    Inorm=2.*(Inorm-0.5);  % Normalized image between [-1; 1]

    % -------------Normalization of image (100 pxels)------------
    nxPixel=size(I,2); nyPixel=size(I,1);
    [xx,yy] = meshgrid(1:nxPixel,1:nyPixel);
    if nxPixel>nyPixel
        nXI=100; nYI=floor(nyPixel.*nXI./nxPixel);
    else
        nYI=100; nXI=floor(nxPixel.*nYI./nyPixel);
    end
    deltaXI=nxPixel./nXI;
    deltaYI=nyPixel./nYI;
    [XXI,YYI] = meshgrid(1:deltaXI:nxPixel,1:deltaYI:nyPixel);
    Inorm=PhotoNorm01(I); % Normalized image between [0; 1]
    Inorm=2.*(Inorm-0.5);  % Normalized image between [-1; 1]

    % --- Bicubic interpolation to reduce data(down-sample)---
    I100 = interp2(xx,yy,Inorm,XXI,YYI,'cubic'); 

    % ------------- Gabor filter parameters --------------
    I2 = I100;
    gaborMag_Bank = imgaborfilt(I2,gaborArray);

    % ---------------Down-samples (30x30 pxels)----------------
    [ny100,nx100,nBank]=size(gaborMag_Bank);
    XXImax=XXI(1,nx100); YYImax=YYI(ny100,1);
    nXI30=30; nYI30=30;
    deltaXI30=XXImax./nXI30; deltaYI30=YYImax./nYI30;
    [XXI30,YYI30] = meshgrid(1:deltaXI30:XXImax,1:deltaYI30:YYImax);
    gaborMag_Bank30=zeros(nYI30,nXI30,nBank);
    for p = 1:8, %nBank=8?
        gaborMag_Bank30(:,:,p) = interp2(XXI,YYI,gaborMag_Bank(:,:,p),XXI30,YYI30,'cubic'); 
    end

    % -------Features extraction and down-samples (30x30 pxels)--------
    Features2=zeros(nBank,nXI30.*nYI30+2);
    Features=[];
    for p = 1:8
        Features1=[];
        for i=1:nXI30
            for j=1:nYI30
                Features1=[Features1 gaborMag_Bank30(j,i,p)]; 
            end
        end
        theta = gaborArray(p).Orientation;
        lambda = gaborArray(p).Wavelength;
        Features1=[Features1 theta lambda];
        Features2(p,:)=Features1;
        Features=[Features Features1];
    end
    
  
    % Take into accout pollen size - add size with weighted frequence coefficient - 5% from Features volume
    PollenSize_WeightedFreq=Pollens(it).AverageSize.*ones(1,ceil(0.05.*size(Features,2)));
    PollenFeatures(it)=struct('Name',Pollens(it).Name,...
                       'GaborFeatures_and_size',[Features  PollenSize_WeightedFreq]);
    
    clear I Inorm nxPixel nyPixel xx yy nXI nYI deltaXI deltaYI XXI YYI I2 I100 
    clear gaborMag_Bank ny100 nx100 nBank XXImax YYImax nXI30 nYI30 deltaXI30 deltaYI30 
    clear XXI30 YYI30 gaborMag_Bank30 Features1 Features2 Features
    
    %size(PollenFeatures)
    %pause
end

save GabFeaturesDat93


TitlePollens={'Tilia_platyphyllos1';'Tilia_platyphyllos2';'Tilia_platyphyllos3';...
             'Tilia_platyphyllos4';'Tilia_platyphyllos5';'Tilia_platyphyllos6';'Tilia_platyphyllos7';...
             'TiliaEuSARSA1';'TiliaEuSARSA2';'TiliaEuSARSA3';'TiliaEuSARSA4';...
             'TiliaEuSARSA5';'TiliaEuSARSA6';'TiliaEuSARSA7';'TiliaEuSARSA8';...
             'TiliaCordata_PollenWarndiest1';'TiliaCordata_PollenWarndiest2';...
             'TiliaCordata_PollenWarndiest3';'TiliaCordata_PollenWarndiest4';...
             'TiliaCordata_PollenWarndiest5';'TiliaCordata_PollenWarndiest6';...
             'Tilia_DiscoverLife1';...
             
             'Robinia_pseudoacacia1';'Robinia_pseudoacacia2';'Robinia_pseudoacacia3';...
             'Robinia_pseudoacacia4';'Robinia_pseudoacacia5';'Robinia_pseudoacacia6';...
             'AcaciaSARS1';'AcaciaPalDat1';...
             'Robinia_Cornel1';'Robinia_Cornel2';'Robinia_PollenWarndiest1';...
             'Robinia_PollenWarndiest2';'Robinia_PollenWarndiest3';'Robinia_PollenWarndiest4';...
             'Robinia_PollenWarndiest5';'Robinia_PollenWarndiest6';'Robinia_DiscoverLife1';...
            
             'Lavandula_angustifolia1';'Lavandula_angustifolia2';'Lavandula_angustifolia3';...
             'Lavandula_angustifolia4';'Lavandula_angustifolia5';...
             'LavandSARS1';'LavandSARS2';...
             'Lavandula_Gallery_3Sa';'Lavandula_Gallery_3Sb';'Lavandula_Gallery_3Sc';...
             'Lavandula_Gallery_6_1a';'Lavandula_Gallery_6_1b';'Lavandula_Gallery_6_1c';...
             
             'Lavandula_multifida1';'Lavandula_multifida2';'Lavandula_multifida3';...
             'Lavand4MultifPalDat1';'Lavandula_DiscoverLife1';...
             
             'Brassica_napus1';'Brassica_napus2';'Brassica_napus3';'Brassica_napus4';...
             'Brassica_napus5';'Brassica_napus6';'BrassicaRapaSARS1';'BrassicaRapaSARS2';...
             'BrassicaPalDat1';'BrassicaPalDat2';'BrassicaPalDat3';...
             'Brassica_PollenWarndiest1';'Brassica_PollenWarndiest2';...
             'Brassica_PollenWarndiest3';'Brassica_PollenWarndiest4';...
             'Brassica_PollenWarndiest5';...
             
             'Cirsium_arvense1';'Cirsium_arvense6';'Cirsium_arvense7';'Cirsium_arvense12';...
             'Cirsium_arvense17';'Cirsium_arvense18';'Cirsium_arvense19';...
             'Cirsium_Gallery_2_1a';'Cirsium_Gallery_2_1b';'Cirsium_Gallery_2_1c';...
             'Cirsium_Gallery_2_2b';'Cirsium_Gallery_2_2c';'Cirsium_Gallery_2_2e';...
             'Cirsium_Gallery_2_3b';'Cirsium_Gallery_2_3c';'Cirsium_Gallery_2_3d';...
             'Cirsium_Gallery_2_4b';'Cirsium_Gallery_2_4c';'Cirsium_Gallery_2_4d';...             
             'Cirsium_DiscoverLife1'};

TitlePollens=TitlePollens(1:nPatterns,:);    

PollenValues=[];
for it=1:nPatterns
    PollenValues=[PollenValues;PollenFeatures(it).GaborFeatures_and_size]; %Features from Gabor Bank
end
         
mapcaplot(PollenValues,TitlePollens)
[pc, zscores, pcvars] = princomp(PollenValues);
Nvar=pcvars./sum(pcvars) * 100;
Ncum=cumsum(pcvars./sum(pcvars) * 100);
%[Nvar';Ncum']
             
figure
xAcacia=[]; yAcacia=[];  zAcacia=[];     xTilia=[]; yTilia=[]; zTilia=[]; 
xLavandulaAngustifolia=[];  yLavandulaAngustifolia=[]; zLavandulaAngustifolia=[];
xLavandulaMultifida=[];     yLavandulaMultifida=[];    zLavandulaMultifida=[];
xBrassica=[]; yBrassica=[]; zBrassica=[]; xCirsium=[]; yCirsium=[]; zCirsium=[]; 
for i=1:nPatterns
    if find(strcmp(PollenFeatures(i).Name,'Acacia')), 
        xAcacia=[xAcacia, zscores(i,1)]; yAcacia=[yAcacia, zscores(i,2)]; 
        zAcacia=[zAcacia, zscores(i,3)]; 

    elseif find(strcmp(PollenFeatures(i).Name,'Tilia')), 
        xTilia=[xTilia, zscores(i,1)]; yTilia=[yTilia, zscores(i,2)]; 
        zTilia=[zTilia, zscores(i,3)];         

    elseif find(strcmp(PollenFeatures(i).Name,'LavandulaAngustifolia')), 
        xLavandulaAngustifolia=[xLavandulaAngustifolia, zscores(i,1)]; 
        yLavandulaAngustifolia=[yLavandulaAngustifolia, zscores(i,2)];  
        zLavandulaAngustifolia=[zLavandulaAngustifolia, zscores(i,3)];

    elseif find(strcmp(PollenFeatures(i).Name,'LavandulaMultifida')), 
        xLavandulaMultifida=[xLavandulaMultifida, zscores(i,1)]; 
        yLavandulaMultifida=[yLavandulaMultifida, zscores(i,2)];  
        zLavandulaMultifida=[zLavandulaMultifida, zscores(i,3)]; 
   
    elseif find(strcmp(PollenFeatures(i).Name,'Brassica')), 
        xBrassica=[xBrassica, zscores(i,1)]; yBrassica=[yBrassica, zscores(i,2)];  
        zBrassica=[zBrassica, zscores(i,3)];        

    elseif find(strcmp(PollenFeatures(i).Name,'CirsiumArvense')), 
        xCirsium=[xCirsium, zscores(i,1)]; yCirsium=[yCirsium, zscores(i,2)];  
        zCirsium=[zCirsium, zscores(i,3)];      
           
    end
end
plot(xAcacia,yAcacia,'bo','MarkerFaceColor','b'), hold on,
plot(xTilia,yTilia,'g^','MarkerFaceColor','g'), hold on,
plot(xLavandulaAngustifolia,yLavandulaAngustifolia,'r>','MarkerFaceColor','r'), hold on
plot(xLavandulaMultifida,yLavandulaMultifida,'m<','MarkerFaceColor','m'), hold on
plot(xBrassica,yBrassica,'ks','MarkerFaceColor','y'), hold on,
plot(xCirsium,yCirsium,'cv','MarkerFaceColor','c'), hold on,
xlabel('First Principal Component');
ylabel('Second Principal Component');
title('Principal Component Scatter Plot');
legend('Acacia','Tilia','Lavandula Angustifolia','Lavandula Multifida','Brassica Napus','Cirsium Arvense',...
       'Location','NW')

figure
plot3(xAcacia,yAcacia,zAcacia,'bo','MarkerFaceColor','b'), hold on,
plot3(xTilia,yTilia,zTilia,'g^','MarkerFaceColor','g'), hold on,
plot3(xLavandulaAngustifolia,yLavandulaAngustifolia,zLavandulaAngustifolia,'r>','MarkerFaceColor','r'), hold on
plot3(xLavandulaMultifida,yLavandulaMultifida,zLavandulaMultifida,'m<','MarkerFaceColor','m'), hold on
plot3(xBrassica,yBrassica,zBrassica,'ks','MarkerFaceColor','y'), hold on,
plot3(xCirsium,yCirsium,zCirsium,'cv','MarkerFaceColor','c'), hold on,
xlabel('First Principal Component');
ylabel('Second Principal Component');
zlabel('Third Principal Component');
title('Principal Component Scatter Plot');
legend('Acacia','Tilia','Lavandula Angustifolia','Lavandula Multifida','Brassica Napus','Cirsium Arvense',...
       'Location','NW')
grid on
%AZ=105; EL=43; view(AZ,EL)
%AZ=-67; EL=40; view(AZ,EL)
%AZ=-81; EL=36; view(AZ,EL)


% ------------------------- LDA classifier ----------------------------- 
%nTilia=size(Tilia,1); nAcacia=size(Acacia,1); nLavenderAngusti=size(LavenderAngusti,1); 
%nBrassica=size(Brassica,1); nThistleCirsium=size(ThistleCirsium,1); nLavenderMultifida=0;
B=[2.*ones(1,nTilia),1.*ones(1,nAcacia),3.*ones(1,(nLavenderAngusti+nLavenderMultifida)),...
    4.*ones(1,nBrassica),5.*ones(1,nThistleCirsium)];

zscores3=zscores(:,1:3);
nMostri=size(zscores3,1); 

pc_arr=[]; zscores_arr=[]; pcvars_arr=[];
CurrentScore_arr=[];
DecisionThreshold=0.01;

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
    [pc, zscores, pcvars] = princomp(PollenValues_L);
    zscores3_L=zscores(:,1:3); % The first three PC
    
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

LinClass = classify(dataClassTest,dataClasses,numberClasses,'linear');
%LinClass = classify(dataClassTest,dataClasses,numberClasses,'quadratic');
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

save LDA_Gabor

figure
xAcacia=[];	yAcacia=[];	zAcacia=[];      
xTilia=[];	yTilia=[];	zTilia=[]; 
%xLavandulaAngustifolia=[];  yLavandulaAngustifolia=[]; zLavandulaAngustifolia=[];
%xLavandulaMultifida=[];     yLavandulaMultifida=[];    zLavandulaMultifida=[];
xLavandula=[];	yLavandula=[];	zLavandula=[];
xBrassica=[];   yBrassica=[];   zBrassica=[]; 
xCirsium=[];    yCirsium=[];    zCirsium=[]; 
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
        xCirsium=[xCirsium, CurrentScore_arr(i,1)]; 
        yCirsium=[yCirsium, CurrentScore_arr(i,2)];         
        zCirsium=[zCirsium, CurrentScore_arr(i,3)];
    end
end

plot3(xAcacia,yAcacia,zAcacia,'bo','MarkerFaceColor','b'), hold on,
plot3(xTilia,yTilia,zTilia,'g^','MarkerFaceColor','g'), hold on,
plot3(xLavandula,yLavandula,zLavandula,'r>','MarkerFaceColor','r'), hold on
plot3(xBrassica,yBrassica,zBrassica,'ks','MarkerFaceColor','y'), hold on,
plot3(xCirsium,yCirsium,zCirsium,'cv','MarkerFaceColor','c'), hold on,
xlabel('First Principal Component');
ylabel('Second Principal Component');
zlabel('Third Principal Component');
title('LDA Scatter Plot');
legend('Acacia','Tilia','Lavandula','Brassica Napus','Cirsium Arvense',...
       'Location','NW')
grid on

%save LDA_Gabor


