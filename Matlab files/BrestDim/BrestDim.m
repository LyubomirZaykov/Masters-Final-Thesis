% Breаst image from mammogram

clear all

% RGB Scale
%figure(1), RGB = imread('Kat3_4_Case5_4142737.jpg');  imshow(RGB)
%figure(1), RGB = imread('Kat3_12_Case13_4150357.jpg');  imshow(RGB)
%figure(1), RGB = imread('Kat3_14_Case15_5211158.jpg');  imshow(RGB)

%figure(1), RGB = imread('Kat5_15_Case81_5105958.jpg');  imshow(RGB)
figure(1), RGB = imread('Kat5_28_Case94_5200409.jpg');  imshow(RGB)
%figure(1), RGB = imread('Kat5_31_Case97_5195255.jpg');  imshow(RGB)

nr=1;nc=5; XrXc=zeros(nr,nc,2); RGB_Cod=zeros(nr,nc,3); RGB_Scal=zeros(nr,nc,1); 
for ir=1:nr, for ic=1:nc, [xc,xr]=ginput(1); XrXc(ir,ic,:)=[ceil(xr);ceil(xc)]; end; end, 
for ir=1:nr, for ic=1:nc, RGB_Cod(ir,ic,:)=RGB(XrXc(ir,ic,1),XrXc(ir,ic,2),:); end; end, 
for ir=1:nr, for ic=1:nc, RGB_Scal(ir,ic,:)=ic; end; end, 

GrayTreshold=sum(round(sum(RGB_Cod)./nc))./3;
threshold=GrayTreshold


[nr,nc,nColor]=size(RGB); WhiteBlack=zeros(nr,nc,nColor); 
for ir=1:nr 
   for ic=1:nc 
      if (RGB(ir,ic,1)<=threshold)&&(RGB(ir,ic,2)<=threshold)&&(RGB(ir,ic,3)<=threshold)
          WhiteBlack(ir,ic,:)=[0 0 0];
      elseif (RGB(ir,ic,1)>threshold)&&(RGB(ir,ic,2)>threshold)&&(RGB(ir,ic,3)>threshold)
          WhiteBlack(ir,ic,:)=[1 1 1];
      else
          'error'
      end
   end
end

figure(2)
WhiteBlack(1,:,:)=zeros(1,nc,3); WhiteBlack(nr,:,:)=zeros(1,nc,3);
WhiteBlack(:,1,:)=zeros(nr,1,3); WhiteBlack(:,nc,:)=zeros(nr,1,3);
imshow(WhiteBlack)

ContourBlack=WhiteBlack;
for ir=1:nr, 
   for ic=1:nc, 
      if WhiteBlack(ir,ic,1)==1
        if (WhiteBlack(ir-1,ic-1,1)==0)||(WhiteBlack(ir-1,ic,1)==0)||(WhiteBlack(ir-1,ic+1,1)==0)||... 
           (WhiteBlack(ir,ic-1,1)==0)||(WhiteBlack(ir,ic+1,1)==0)||... 
           (WhiteBlack(ir+1,ic-1,1)==0)||(WhiteBlack(ir+1,ic,1)==0)||(WhiteBlack(ir+1,ic+1,1)==0)
                ContourBlack(ir,ic,:)=[1 1 1];
        else
                ContourBlack(ir,ic,:)=[0 0 0];
        end   
      end
   end
end

figure(3)
imshow(ContourBlack)

XrXc=zeros(1,2); 
[xc,xr]=ginput(1); XrXc(1,:)=[xr,xc];  
XrXc_Ceil(1,:)=[ceil(xr),ceil(xc)] 

X=[]; Y_temp=[];
% Resolution=1024; Step=1./Resolution; %1024=2^10;
for point=1:(10-1)
  Counter_plane=zeros(2.^point,2.^point);
  Resolution=2.^point; Step=1./Resolution;
  s=Step; X=[X log10(1./s)];
  for ir=1:2^point 
    for ic=1:2^point 
      breakRow=0;  
      for irTemp=(ir-1)*2.^(10-point)+1:ir*2.^(10-point)
        for icTemp=(ic-1)*2.^(10-point)+1:ic*2.^(10-point) 
          if ContourBlack(irTemp,icTemp,1)==1
              Counter_plane(ir,ic)=Counter_plane(ir,ic)+1; 
              breakRow=1; break
          end
        end % icTemp
        if breakRow==1, break, end
      end % irTemp    
    end % ic
  end % ir
  ySum=sum(sum(Counter_plane)); 
  Y_temp=[Y_temp ySum];
  %point
end %point 10
Y=log10(Y_temp);

figure(4)
plot(X,Y,X,Y,'ko')

figure(5)
%P = POLYFIT(X,Y,N) finds the coefficients of a polynomial P(X) of
%    degree N that fits the data Y best in a least-squares sense. P is a
%    row vector of length N+1 containing the polynomial coefficients in
%    descending powers, P(1)*X^N + P(2)*X^(N-1) +...+ P(N)*X + P(N+1).
%nX=size(X,2); X_regres=X(1,2:nX); Y_regres=Y(1,2:nX);
nX=size(X,2); X_regres=X; Y_regres=Y;
linearCoef = polyfit(X_regres,Y_regres,1); b1=linearCoef(1,1); b0=linearCoef(1,2);
linearFit = polyval(linearCoef,X_regres);
plot(X_regres,Y_regres,'s', X_regres,linearFit,'r-')
xlabel('X'); ylabel('Y');
Fractal_Dimension=b1
    
save GrayFrac threshold Fractal_Dimension RGB XrXc_Ceil
