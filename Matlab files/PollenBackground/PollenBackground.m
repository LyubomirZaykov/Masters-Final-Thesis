% Cleanup/initialization
clc;    % Clear the command window.
close all;  % Close all figures (except those of imtool.)
clear all;  % Erase all existing variables. Or clearvars if you want.
%workspace;  % Make sure the workspace panel is showing.
%format long g;
%format compact;
%fontSize = 12;

% --------------- Input images - pollen data Files -------------------
inpict = imread('Rapa4.jpg'); %!
%inpict = imread('Rapa9.jpg'); %!
%inpict = imread('Rapa19_a.jpg'); %!
%inpict = imread('Rapa29.jpg');%!
% inpict = imread('Rapa30.jpg');

% inpict = imread('Acacia13.jpg');%!
%inpict = imread('Acacia26.jpg');%!
%inpict = imread('Acacia31.jpg');%!
%inpict = imread('Acacia34.jpg');
%inpict = imread('Acacia35.jpg');

% inpict = imread('Tilia28.jpg');
%inpict = imread('Tilia29.jpg');
%inpict = imread('Tilia30.jpg');
%inpict = imread('Tilia34_a.jpg');
%inpict = imread('Tilia36.jpg');

% inpict = imread('Thistle01.jpg');
%inpict = imread('Thistle08.jpg');
%inpict = imread('Thistle09.jpg'); %!
%inpict = imread('Thistle10.jpg');
%inpict = imread('Thistle11.jpg');

% inpict = imread('Lavender01.jpg');
%inpict = imread('Lavender02.jpg');
%inpict = imread('Lavender03.jpg');
%inpict = imread('Lavender04.jpg');
%inpict = imread('Lavender05.jpg');

% ------------ Normalize input images to 256x256 pixels -------------------
nDesPix=256; %Desired pixel size in final normalized image 256x256  
I = rgb2gray(inpict);   

nxPixel=size(I,2); nyPixel=size(I,1);
[xx,yy] = meshgrid(1:nxPixel,1:nyPixel);
nXI=nDesPix; nYI=nDesPix; % For example: nXI=256; nYI=256;   
deltaXI=(nxPixel-1)./(nXI-1); 
deltaYI=(nyPixel-1)./(nYI-1);
[XXI,YYI] = meshgrid(1:deltaXI:nxPixel,1:deltaYI:nyPixel);
    
% Bicubic interpolation to reduce data 
% Gray image:
I256 = interp2(xx,yy,double(I),XXI,YYI,'cubic'); %nDesPix=256
inpictGray= uint8(I256);  % --------- Gray image 256x256 pixels -----------
% RGB image:
I = inpict;  I256=zeros(nDesPix,nDesPix,3); 
I256(:,:,1) = interp2(xx,yy,double(I(:,:,1)),XXI,YYI,'cubic'); 
I256(:,:,2) = interp2(xx,yy,double(I(:,:,2)),XXI,YYI,'cubic');
I256(:,:,3) = interp2(xx,yy,double(I(:,:,3)),XXI,YYI,'cubic');
inpict=uint8(I256);   % ----------- RGB image 256x256 pixels --------------

% -------------------- Background color ----------------------------------    
[row,column,color]=size(inpict);
rowFiltBack=30; columnFiltBack=30; 
TopLeft=inpict(1:rowFiltBack,1:columnFiltBack,:);
TopRight=inpict(1:rowFiltBack,column-columnFiltBack:column,:);
BottomLeft=inpict(row-rowFiltBack:row,1:columnFiltBack,:);
BottomRight=inpict(row-rowFiltBack:row,column-columnFiltBack:column,:);

figure(1)
subplot(2, 2, 1);
imshow(inpict); 
hold on, x1=1; x2=columnFiltBack; y1=1; y2=rowFiltBack;
plot([x1 x2],[y1,y1],'g',[x1 x2],[y2,y2],'g',[x1 x1],[y1,y2],'g',[x2 x2],[y1,y2],'g')
hold on, x1=1; x2=columnFiltBack; y1=row-rowFiltBack; y2=row;
plot([x1 x2],[y1,y1],'g',[x1 x2],[y2,y2],'g',[x1 x1],[y1,y2],'g',[x2 x2],[y1,y2],'g')
hold on, x1=column-columnFiltBack; x2=column; y1=1; y2=rowFiltBack;
plot([x1 x2],[y1,y1],'g',[x1 x2],[y2,y2],'g',[x1 x1],[y1,y2],'g',[x2 x2],[y1,y2],'g')
hold on,  x1=column-columnFiltBack; x2=column; y1=row-rowFiltBack; y2=row;
plot([x1 x2],[y1,y1],'g',[x1 x2],[y2,y2],'g',[x1 x1],[y1,y2],'g',[x2 x2],[y1,y2],'g')
Corners4=[[TopLeft,TopRight];[BottomLeft,BottomRight]];

inpictGray=rgb2gray(inpict); % convert to gray:   0-255
%imshow(inpictGray)

grayCorners4=rgb2gray(Corners4); % convert to gray   0-255
sMinG=min(grayCorners4(:,:,1),[],'all'); %Zashto e tozi sintaksis ?
threshold=sMinG;
maskG = inpictGray(:,:,:) >=threshold; % look for background regions  
mask = bwareafilt(maskG,1); % pick the largest object (the background)

outpict = inpict;
outpict(mask(:,:,[1 1 1])) = 0; % fill background with black color for RGB image
subplot(2, 2, 2);
imshow(outpict), % --------- RGB object on the black background ------------

outpictG = inpictGray;
outpictG(mask(:,:,1)) = 0; % fill background with black color for gray image
subplot(2, 2, 3);
imshow(outpictG), % ------- Gray object on the black background -------------

subplot(2, 2, 4);
outpictWB=ones(size(inpictGray)); % empty white image
% ---- VARIANT 0 ---
outpictWB(mask(:,:,1)) = 0; % fill background with black color for empty white image
imshow(outpictWB), % ------- White object on the black background -------------
title('VARIANT 0');


figure(2)
% -------------------------- "Imbinarize" with 'global' -----------------------------
% ---- VARIANT 1 ---
inpictBW1 = imbinarize(inpictGray,'global'); % convert to Black and White
TopLeftBW1=inpictBW1(1:rowFiltBack,1:columnFiltBack,:);
if sum(TopLeftBW1)./(rowFiltBack.*columnFiltBack)<0.25, %Averaged White TopLeft corner
    inpictBW1=not(inpictBW1);
end
inpictBW1 = imfill(inpictBW1,'holes');  % Fill holes.
inpictBW1 = bwareafilt(inpictBW1, 1); % Extract largest blob.


[labeledImageGlobal, numBlobsGlobal] = bwlabel(inpictBW1); % Label the image
propsGlobal = regionprops(labeledImageGlobal,'All'); % Measures 
xCentroid1 = propsGlobal.Centroid(1); yCentroid1 = propsGlobal.Centroid(2); % Measure Centroid

subplot(2, 2, 1);
imshow(inpictBW1)
hold on; plot(xCentroid1, yCentroid1, 'r+', 'MarkerSize', 50, 'LineWidth', 2); % Put a cross on it.
title('VARIANT 1');

% -------------------------- "Imbinarize" with 'adaptive' -----------------------------
inpictBW2 = imbinarize(inpictGray,'adaptive','ForegroundPolarity','bright','Sensitivity',0.5); % convert to Black and White
%inpictBW2 = imbinarize(inpictGray,'adaptive','ForegroundPolarity','dark','Sensitivity',0.6); % convert to Black and White
inpictBW2 = imfill(inpictBW2,'holes');  % Fill holes.
inpictBW2 = bwareafilt(inpictBW2, 1); % Extract largest blob.

[labeledImageAdapt, numBlobsAdapt] = bwlabel(inpictBW2); % Label the image
propsAdapt = regionprops(labeledImageAdapt,'All'); % Measures 
xCentroid2 = propsAdapt.Centroid(1); yCentroid2 = propsAdapt.Centroid(2); % Measure Centroid

subplot(2, 2, 2);
imshow(inpictBW2)
hold on; plot(xCentroid2, yCentroid2, 'r+', 'MarkerSize', 50, 'LineWidth', 2); % Put a cross on it.

%--------------- "Imbinarize" on "rangefilt" with 'global'/'adaptive'--------------------
J = rangefilt(inpictGray); 
% ---- 'global' ----
inpictBWg = imbinarize(J,'global'); % convert to Black and White
inpictBWg = imfill(inpictBWg,'holes');  % Fill holes.
inpictBWg = bwareafilt(inpictBWg, 1); % Extract largest blob.
[labeledImageGlobal1, numBlobsGlobal1] = bwlabel(inpictBWg); % Label the image
subplot(2, 2, 3); imshow(inpictBWg)

% ---- 'adaptive' ----
% ---- VARIANT 2 ---
inpictBWa = imbinarize(J,'adaptive','ForegroundPolarity','bright','Sensitivity',0.6); %convert to Black and White  
%inpictBWrange =inpictBWa;
inpictBWa = imfill(inpictBWa,'holes');  % Fill holes.
inpictBWa = bwareafilt(inpictBWa, 1); % Extract largest blob.
[labeledImageAdapt1, numBlobsAdapt1] = bwlabel(inpictBWa); % Label the image
subplot(2, 2, 4); imshow(inpictBWa)
title('VARIANT 2');

%--------------- 2 (or 3) layer binarized image --------------------
% Two layer binarized image (VARIANT 1 + VARIANT 2)
figure(3)
subplot(2, 2, 1);
inpict2Layer=or(inpictBW1,inpictBWa);
inpict2Layer = imfill(inpict2Layer,'holes');  % Fill holes.
inpict2Layer = bwareafilt(inpict2Layer, 1); % Extract largest blob.
[labeledImage2Layer, numBlobs2Layer] = bwlabel(inpict2Layer); % Label the image
imshow(inpict2Layer)
title('VARIANT 1 + VARIANT 2');

subplot(2, 2, 2);
% Tree layer binarized image (VARIANT 0 + VARIANT 1 + VARIANT 2)
inpict3Layer=or(outpictWB,inpict2Layer);
inpict3Layer = imfill(inpict3Layer,'holes');  % Fill holes.
inpict3Layer = bwareafilt(inpict3Layer, 1); % Extract largest blob.
[labeledImage3Layer, numBlobs3Layer] = bwlabel(inpict3Layer); % Label the image
imshow(inpict3Layer)
%title('(VARIANT 0 + VARIANT 1 + VARIANT 2)', 'FontSize', fontSize, 'Interpreter', 'None');
title('VARIANT 0 + VARIANT 1 + VARIANT 2');

subplot(2, 2, 3);
inpictBWrange=rangefilt(inpictBWa);
imshow(inpictBWrange)

subplot(2, 2, 4);
inpictBWedge=edge(inpictBWa,'canny');
imshow(inpictBWedge)

%--------------- Black White Image Ppoperties --------------------
propsBW = regionprops(labeledImage3Layer, 'All');

S=propsBW.Area;

xCentroid = propsBW.Centroid(1);
yCentroid = propsBW.Centroid(2);

%propsBW.BoundingBox;
%propsBW.SubarrayIdx;

MaxLength=propsBW.MajorAxisLength;
MinLength=propsBW.MinorAxisLength;

Elliptic=propsBW.Eccentricity;
Direction=propsBW.Orientation;

%propsBW.ConvexHull;
%propsBW.ConvexImage;

S_convex=propsBW.ConvexArea;
Circle=propsBW.Circularity;

%propsBW.Image;
%propsBW.FilledImage;
%propsBW.FilledArea;
%propsBW.EulerNumber;

%propsBW.Extrema;
%propsBW.EquivDiameter;
%propsBW.Solidity;
%propsBW.Extent;

%propsBW.PixelIdxList;
%propsBW.PixelList;

P=propsBW.Perimeter;
%propsBW.PerimeterOld;

MinF_Diameter=propsBW.MinFeretDiameter;
MinF_Angle=propsBW.MinFeretAngle;
MinF_Coordinates=propsBW.MinFeretCoordinates;

MaxF_Diameter=propsBW.MaxFeretDiameter;
MaxF_Angle=propsBW.MaxFeretAngle;
MaxF_Coordinates=propsBW.MaxFeretCoordinates;

ratio=S/P