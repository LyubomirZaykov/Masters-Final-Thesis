function coefs=fd(image)
%
% The program will calculate the fractal dimension of a 512x512 image
% using the box counting method.
%
% The code is just for beginners for getting an idea of box-counting
% method.
%
%=========================================================================
% the image is read and first its changed to grayscale image and then to 
% black and white
% image=imread(imageNames(1,index));
image=rgb2gray(image);
% imageSize=size(image,1);
% thresholdPoint1=uint16(image(25,25));
% thresholdPoint2=uint16(image(25,imageSize-25));
% thresholdPoint3=uint16(image(imageSize-25,25));
% thresholdPoint4=uint16(image(imageSize-25,imageSize-25));
% threshold=((thresholdPoint1+thresholdPoint2+thresholdPoint3+thresholdPoint4)/4)-10;
% image=image>threshold;
image=edge(image,'canny');
% imageNew=imresize(image,[512,512]);
% image=imageNew;
% initialises the varaibles for plotting the graph. scale is used to
% store
% the scaling factors and the count is used to store the number of boxes
% which contains parts of the image. For a given scale(1,i) value, the number
% of boxes occupied by the image will be available at count(1,i)
scale=zeros(1,9);
count=zeros(1,9);
[width,height,cols]=size(image);
% since the program is for a 512x512 image, the limit is set 
% to 9 since 2^9=512
for i=1:9
   % scaling factors are taken as 2,4,8,16... 512. 
   
   % For each scaling factor, the total number of pieces are to be calculated,
   % and the number of pieces which contain the black dots (pixels) among them are to
   % be counted.
    
   % For eg, when the scaling factor is 2, it means the image is divided in to
   % half, hence we will get 4 pieces. And have to see how many of pieces
   % have the black dots. 
   sf=2^i;
   pieces=sf^2;
   pieceWidth=width/sf;
   pieceHeight=height/sf;
   
   %initially we assume, we have 0 black pieces
   blackPieces=0;
   
   % Now we have to iterate through each pieces to see how many pieces have the
   % black dots (pixel) in it. We will consider the collection of pieces as
   % a matrix. We are counting from 0 for the ease of calculations.
   for pieceIndex=0:pieces-1
       
       % row and column indices of each pieces are calculated to estimate the
       % xy cordinates of the starting and ending of each piece.
       pieceRow=idivide(int32(pieceIndex), int32(sf));
       pieceCol=rem(pieceIndex,sf);
       xmin=(pieceCol*pieceWidth)+1;
       xmax=(xmin+pieceWidth)-1;
       ymin=(pieceRow*pieceHeight)+1;
       ymax=(ymin+pieceHeight)-1;
       
       % each piece is extracted and stored in another array for
       % convenience.
       eachPiece=image(ymin:ymax,xmin:xmax);
       %each piece obtained is plotted on a plot for getting a view 
       %of the splitting of the whole image.
       %subplot(sf,sf,pieceIndex+1), imshow(eachPiece);
       
       % now, we will check whether the piece has some black dots in it.
       % then the count of the black pieces will be incremented.
       if (min(min(eachPiece))== 0)
           blackPieces=blackPieces+1;
       end
   end
   
   % the count of pieces which contains the black dots for a given scaling value 
   % will be obtained here and will be stored in the respective variables.
%    fprintf('%d\t->\t%d\n', sf, blackPieces);
   scale(1,i)=sf;
   count(1,i)=blackPieces;
end
% Now the process is over, the graph is plotted and the fractal dimension
% is calculated using the 'ployfit' function.
% plot(log(scale),log(count));
coefs=polyfit(log(scale),log(count),1);
end
