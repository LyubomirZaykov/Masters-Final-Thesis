function [Inorm] = PhotoNorm0255(I)

%PhotoNorm01 -  Normalize image I between [0; 255] (gray)
%  Image I may be uint8 

%Idouble=double(I);
Imin=min(min(I));
Imax=max(max(I));
deltaI=Imax-Imin;
Inorm=(I-Imin)./deltaI; % Normalized image between [0; 255]

end

