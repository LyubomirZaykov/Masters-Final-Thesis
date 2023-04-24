clear all
% Use subroutine PhotoNorm01.m

% ------------- Initialization ---------------
Tilia=struct('Name','Tilia','Photo',{'Linden\Tilia1.jpg';'Linden\Tilia2.jpg';'Linden\Tilia3.jpg';...
    'Linden\Tilia4.jpg';'Linden\Tilia5.jpg';'Linden\Tilia6.jpg';'Linden\Tilia7.jpg';...
    'Linden\Tilia8.jpg';'Linden\Tilia9.jpg';'Linden\Tilia10.jpg';'Linden\Tilia11.jpg';...
    'Linden\Tilia12.jpg';'Linden\Tilia13.jpg';'Linden\Tilia14.jpg';'Linden\Tilia15.jpg';...
    'Linden\Tilia16.jpg';'Linden\Tilia17.jpg';'Linden\Tilia18.jpg';'Linden\Tilia19.jpg';...
    'Linden\Tilia20.jpg';'Linden\Tilia21.jpg';'Linden\Tilia22.jpg';'Linden\Tilia23.jpg';...
    'Linden\Tilia24.jpg';'Linden\Tilia25.jpg';'Linden\Tilia26.jpg';'Linden\Tilia27.jpg';...
    'Linden\Tilia28.jpg';'Linden\Tilia29.jpg';'Linden\Tilia30.jpg';'Linden\Tilia31.jpg';...
    'Linden\Tilia32.jpg';'Linden\Tilia33.jpg';'Linden\Tilia34.jpg';'Linden\Tilia35.jpg'},...
             'AverageSize',32,'SizeCategory','M');
Acacia=struct('Name','Acacia','Photo',{'Acacia\Acacia1.jpg';'Acacia\Acacia2.jpg';'Acacia\Acacia3.jpg';...
    'Acacia\Acacia4.jpg';'Acacia\Acacia5.jpg';'Acacia\Acacia6.jpg';'Acacia\Acacia7.jpg';...
    'Acacia\Acacia8.jpg';'Acacia\Acacia9.jpg';'Acacia\Acacia10.jpg';'Acacia\Acacia11.jpg';...
    'Acacia\Acacia12.jpg';'Acacia\Acacia13.jpg';'Acacia\Acacia14.jpg';'Acacia\Acacia15.jpg';...
    'Acacia\Acacia16.jpg';'Acacia\Acacia17.jpg';'Acacia\Acacia18.jpg';'Acacia\Acacia19.jpg';...
    'Acacia\Acacia20.jpg';'Acacia\Acacia21.jpg';'Acacia\Acacia22.jpg';'Acacia\Acacia23.jpg';...
    'Acacia\Acacia24.jpg';'Acacia\Acacia25.jpg';'Acacia\Acacia26.jpg';'Acacia\Acacia27.jpg';...
    'Acacia\Acacia28.jpg';'Acacia\Acacia29.jpg';'Acacia\Acacia30.jpg';'Acacia\Acacia31.jpg';...
    'Acacia\Acacia32.jpg';'Acacia\Acacia33.jpg';'Acacia\Acacia34.jpg';'Acacia\Acacia35.jpg'},...
    'AverageSize',30,'SizeCategory','M');
Lavender=struct('Name','Lavender','Photo',{'Lavender\Lav1.jpg';'Lavender\Lav2.jpg';...
    'Lavender\Lav3.jpg';'Lavender\Lav4.jpg';'Lavender\Lav5.jpg';'Lavender\Lav6.jpg';...
    'Lavender\Lav7.jpg';'Lavender\Lav8.jpg';'Lavender\Lav9.jpg';'Lavender\Lav10.jpg';...
    'Lavender\Lav11.jpg';'Lavender\Lav12.jpg';'Lavender\Lav13.jpg';'Lavender\Lav14.jpg';...
    'Lavender\Lav15.jpg';'Lavender\Lav16.jpg';'Lavender\Lav17.jpg';'Lavender\Lav18.jpg';...
    'Lavender\Lav19.jpg';'Lavender\Lav20.jpg';'Lavender\Lav21.jpg';'Lavender\Lav22.jpg';...
    'Lavender\Lav23.jpg';'Lavender\Lav24.jpg';'Lavender\Lav25.jpg';'Lavender\Lav26.jpg';...
    'Lavender\Lav27.jpg';'Lavender\Lav28.jpg';'Lavender\Lav29.jpg';'Lavender\Lav30.jpg';...
    'Lavender\Lav31.jpg';'Lavender\Lav32.jpg';'Lavender\Lav33.jpg';'Lavender\Lav34.jpg';...
    'Lavender\Lav35.jpg'},'AverageSize',37,'SizeCategory','M');
Canola=struct('Name','Brassica','Photo',{'Canola\Rapa1.jpg';'Canola\Rapa2.jpg';'Canola\Rapa3.jpg';...
    'Canola\Rapa4.jpg';'Canola\Rapa5.jpg';'Canola\Rapa6.jpg';'Canola\Rapa7.jpg';'Canola\Rapa8.jpg';...
    'Canola\Rapa9.jpg';'Canola\Rapa10.jpg';'Canola\Rapa11.jpg';'Canola\Rapa12.jpg';'Canola\Rapa13.jpg';...
    'Canola\Rapa14.jpg';'Canola\Rapa15.jpg';'Canola\Rapa16.jpg';'Canola\Rapa17.jpg';'Canola\Rapa18.jpg';...
    'Canola\Rapa19.jpg';'Canola\Rapa20.jpg';'Canola\Rapa21.jpg';'Canola\Rapa22.jpg';'Canola\Rapa23.jpg';...
    'Canola\Rapa24.jpg';'Canola\Rapa25.jpg';'Canola\Rapa26.jpg';'Canola\Rapa27.jpg';'Canola\Rapa28.jpg';...
    'Canola\Rapa29.jpg';'Canola\Rapa30.jpg';'Canola\Rapa31.jpg';'Canola\Rapa32.jpg';'Canola\Rapa33.jpg';...
    'Canola\Rapa34.jpg';'Canola\Rapa35.jpg'},'AverageSize',27,'SizeCategory','M');
Thistle=struct('Name','Thistle','Photo',{'Thistle\MBod1.jpg';'Thistle\MBod2.jpg';'Thistle\MBod3.jpg';...
    'Thistle\MBod4.jpg';'Thistle\MBod5.jpg';'Thistle\MBod6.jpg';'Thistle\MBod7.jpg';'Thistle\MBod8.jpg';...
    'Thistle\MBod9.jpg';'Thistle\MBod10.jpg';'Thistle\MBod11.jpg';'Thistle\MBod12.jpg';'Thistle\MBod13.jpg';...
    'Thistle\MBod14.jpg';'Thistle\MBod15.jpg';'Thistle\MBod16.jpg';'Thistle\MBod17.jpg';'Thistle\MBod18.jpg';...
    'Thistle\MBod19.jpg';'Thistle\MBod20.jpg';'Thistle\MBod21.jpg';'Thistle\MBod22.jpg';'Thistle\MBod23.jpg';...
    'Thistle\MBod24.jpg';'Thistle\MBod25.jpg';'Thistle\MBod26.jpg';'Thistle\MBod27.jpg';'Thistle\MBod28.jpg';...
    'Thistle\MBod29.jpg';'Thistle\MBod30.jpg';'Thistle\MBod31.jpg';'Thistle\MBod32.jpg';'Thistle\MBod33.jpg';...
    'Thistle\MBod34.jpg';'Thistle\MBod35.jpg'},'AverageSize',38,'SizeCategory','M');

Pollens = [Tilia; Acacia; Lavender; Canola; Thistle];
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
    for p = 1:8 %nBank=8?
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

TitlePollens={'Tilia1';'Tilia2';'Tilia3';'Tilia4';'Tilia5';'Tilia6';'Tilia7';'Tilia8';'Tilia9';'Tilia10';...
'Tilia11';'Tilia12';'Tilia13';'Tilia14';'Tilia15';'Tilia16';'Tilia17';'Tilia18';'Tilia19';'Tilia20';...
'Tilia21';'Tilia22';'Tilia23';'Tilia24';'Tilia25';'Tilia26';'Tilia27';'Tilia28';'Tilia29';'Tilia30';...
'Tilia31';'Tilia32';'Tilia33';'Tilia34';'Tilia35';...
'Acacia1';'Acacia2';'Acacia3';'Acacia4';'Acacia5';'Acacia6';'Acacia7';'Acacia8';...
'Acacia9';'Acacia10';'Acacia11';'Acacia12';'Acacia13';'Acacia14';'Acacia15';'Acacia16';...
'Acacia17';'Acacia18';'Acacia19';'Acacia20';'Acacia21';'Acacia22';'Acacia23';'Acacia24';...
'Acacia25';'Acacia26';'Acacia27';'Acacia28';'Acacia29';'Acacia30';'Acacia31';'Acacia32';...
'Acacia33';'Acacia34';'Acacia35';...
'Lav1';'Lav2';'Lav3';'Lav4';'Lav5';'Lav6';'Lav7';'Lav8';'Lav9';'Lav10';'Lav11';...
'Lav12';'Lav13';'Lav14';'Lav15';'Lav16';'Lav17';'Lav18';'Lav19';'Lav20';'Lav21';...
'Lav22';'Lav23';'Lav24';'Lav25';'Lav26';'Lav27';'Lav28';'Lav29';'Lav30';'Lav31';...
'Lav32';'Lav33';'Lav34';'Lav35';...
'Rapa1';'Rapa2';'Rapa3';'Rapa4';'Rapa5';'Rapa6';'Rapa7';'Rapa8';'Rapa9';'Rapa10';...
'Rapa11';'Rapa12';'Rapa13';'Rapa14';'Rapa15';'Rapa16';'Rapa17';'Rapa18';'Rapa19';...
'Rapa20';'Rapa21';'Rapa22';'Rapa23';'Rapa24';'Rapa25';'Rapa26';'Rapa27';'Rapa28';...
'Rapa29';'Rapa30';'Rapa31';'Rapa32';'Rapa33';'Rapa34';'Rapa35';...
'MBod1';'MBod2';'MBod3';'MBod4';'MBod5';'MBod6';'MBod7';'MBod8';'MBod9';'MBod10';...
'MBod11';'MBod12';'MBod13';'MBod14';'MBod15';'MBod16';'MBod17';'MBod18';'MBod19';...
'MBod20';'MBod21';'MBod22';'MBod23';'MBod24';'MBod25';'MBod26';'MBod27';'MBod28';...
'MBod29';'MBod30';'MBod31';'MBod32';'MBod33';'MBod34';'MBod35'};
TitlePollens=TitlePollens(1:nPatterns,:);  

PollenValues=[];
for it=1:nPatterns
    PollenValues=[PollenValues;PollenFeatures(it).GaborFeatures_and_size]; %Features fom Gabor Bank
end
         
mapcaplot(PollenValues,TitlePollens)
[pc, zscores, pcvars] = pca(PollenValues);
Nvar=pcvars./sum(pcvars) * 100;
Ncum=cumsum(pcvars./sum(pcvars) * 100);

figure
xAcacia=[]; yAcacia=[];  zAcacia=[];     xTilia=[]; yTilia=[]; zTilia=[]; 
xLavandulaAngustifolia=[];  yLavandulaAngustifolia=[]; zLavandulaAngustifolia=[];
xLavandulaMultifida=[];     yLavandulaMultifida=[];    zLavandulaMultifida=[];
xBrassica=[]; yBrassica=[]; zBrassica=[]; xCirsium=[]; yCirsium=[]; zCirsium=[]; 
for i=1:nPatterns
    if find(strcmp(PollenFeatures(i).Name,'Acacia')) 
        xAcacia=[xAcacia, zscores(i,1)]; yAcacia=[yAcacia, zscores(i,2)]; 
        zAcacia=[zAcacia, zscores(i,3)]; 

    elseif find(strcmp(PollenFeatures(i).Name,'Tilia')) 
        xTilia=[xTilia, zscores(i,1)]; yTilia=[yTilia, zscores(i,2)]; 
        zTilia=[zTilia, zscores(i,3)];         

    elseif find(strcmp(PollenFeatures(i).Name,'Lavender')) 
        xLavandulaAngustifolia=[xLavandulaAngustifolia, zscores(i,1)]; 
        yLavandulaAngustifolia=[yLavandulaAngustifolia, zscores(i,2)];  
        zLavandulaAngustifolia=[zLavandulaAngustifolia, zscores(i,3)];
% 
%     elseif find(strcmp(PollenFeatures(i).Name,'LavandulaMultifida')) 
%         xLavandulaMultifida=[xLavandulaMultifida, zscores(i,1)]; 
%         yLavandulaMultifida=[yLavandulaMultifida, zscores(i,2)];  
%         zLavandulaMultifida=[zLavandulaMultifida, zscores(i,3)]; 
   
    elseif find(strcmp(PollenFeatures(i).Name,'Brassica')) 
        xBrassica=[xBrassica, zscores(i,1)]; yBrassica=[yBrassica, zscores(i,2)];  
        zBrassica=[zBrassica, zscores(i,3)];        

    elseif find(strcmp(PollenFeatures(i).Name,'Thistle')) 
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
legend('Acacia','Tilia','Lavender','Brassica','Thistle',...
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
legend('Acacia','Tilia','Lavender','Brassica','Thistle',...
       'Location','NW')
grid on

