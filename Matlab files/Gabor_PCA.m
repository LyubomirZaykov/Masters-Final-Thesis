clear all
% Use subroutine PhotoNorm01.m

% ------------- Initialization ---------------
Tilia=struct('Name','Tilia','Photo',{'Tilia_platyphyllos1.jpg';'Tilia_platyphyllos2.jpg';...
             'Tilia_platyphyllos3.jpg';'Tilia_platyphyllos4.jpg';'Tilia_platyphyllos5.jpg';...
             'Tilia_platyphyllos6.jpg';'Tilia_platyphyllos7.jpg'},...
             'AverageSize',32,'SizeCategory','M');
Acacia=struct('Name','Acacia','Photo',{'Robinia_pseudoacacia1.jpg';'Robinia_pseudoacacia2.jpg';...
            'Robinia_pseudoacacia3.jpg';'Robinia_pseudoacacia4.jpg';'Robinia_pseudoacacia5.jpg';...
            'Robinia_pseudoacacia6.jpg'},'AverageSize',30,'SizeCategory','M');
LavenderAngusti=struct('Name','LavandulaAngustifolia','Photo',{'Lavandula_angustifolia1.jpg';...
            'Lavandula_angustifolia2.jpg';'Lavandula_angustifolia3.jpg';'Lavandula_angustifolia4.jpg';...
            'Lavandula_angustifolia5.jpg'},'AverageSize',37,'SizeCategory','M');
LavenderMultifida=struct('Name','LavandulaMultifida','Photo',{'Lavandula_multifida1.jpg';...
            'Lavandula_multifida2.jpg';'Lavandula_multifida3.jpg'},'AverageSize',48,'SizeCategory','M');
Brassica=struct('Name','Brassica','Photo',{'Brassica_napus1.jpg';'Brassica_napus2.jpg';...
            'Brassica_napus3.jpg';'Brassica_napus4.jpg';'Brassica_napus5.jpg';...
            'Brassica_napus6.jpg'},'AverageSize',27,'SizeCategory','M');
ThistleCirsium=struct('Name','CirsiumArvense','Photo',{'Cirsium_arvense1.jpg';'Cirsium_arvense6.jpg';...
             'Cirsium_arvense7.jpg';'Cirsium_arvense12.jpg';'Cirsium_arvense17.jpg';...
             'Cirsium_arvense18.jpg';'Cirsium_arvense19.jpg'},'AverageSize',38,'SizeCategory','M');
Pollens = [Tilia; Acacia; LavenderAngusti; LavenderMultifida; Brassica; ThistleCirsium];
%Pollens = [Tilia; Acacia; LavenderAngusti; LavenderMultifida];
%%Pollens = [Tilia; Acacia; Brassica];
%%Pollens = [Tilia; Acacia; ThistleCirsium];
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
    
    %PollenFeatures(it)=struct('Name',Pollens(it).Name,...
    %                   'GaborFeatures_and_size',[Features Pollens(it).AverageSize.*ones(1,ceil(0.05.*size(Features,2)))]);
    
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

save GabFeaturesDat

%iTilia=1:7;
%iAcacia=8:13;
%iLavandula=14:21;
%iBrassica=22:27;
%iCirsium=28:34;
%iGFS=[43,44,45];

TitlePollens={'Tilia_platyphyllos1';'Tilia_platyphyllos2';'Tilia_platyphyllos3';...
             'Tilia_platyphyllos4';'Tilia_platyphyllos5';'Tilia_platyphyllos6';'Tilia_platyphyllos7';...
             'Robinia_pseudoacacia1';'Robinia_pseudoacacia2';'Robinia_pseudoacacia3';...
             'Robinia_pseudoacacia4';'Robinia_pseudoacacia5';'Robinia_pseudoacacia6';...
             'Lavandula_angustifolia1';'Lavandula_angustifolia2';'Lavandula_angustifolia3';...
             'Lavandula_angustifolia4';'Lavandula_angustifolia5';...
             'Lavandula_multifida1';'Lavandula_multifida2';'Lavandula_multifida3';...
             'Brassica_napus1';'Brassica_napus2';'Brassica_napus3';'Brassica_napus4';...
             'Brassica_napus5';'Brassica_napus6';...
             'Cirsium_arvense1';'Cirsium_arvense6';'Cirsium_arvense7';'Cirsium_arvense12';...
             'Cirsium_arvense17';'Cirsium_arvense18';'Cirsium_arvense19'};
TitlePollens=TitlePollens(1:nPatterns,:);  

PollenValues=[];
for it=1:nPatterns
    PollenValues=[PollenValues;PollenFeatures(it).GaborFeatures_and_size]; %Features fom Gabor Bank
end
         
mapcaplot(PollenValues,TitlePollens)
[pc, zscores, pcvars] = princomp(PollenValues);
Nvar=pcvars./sum(pcvars) * 100;
Ncum=cumsum(pcvars./sum(pcvars) * 100);

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

