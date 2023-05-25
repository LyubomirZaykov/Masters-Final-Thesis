function [Inorm] = PhotoNorm01(I)

%PhotoNorm01 -  Normalize image I between [0; 1]
%  Image I may be double precision (0.5=middle gray), 
%  or uint8  (127=middle gray)

Idouble=double(I);
Imin=min(min(Idouble));
Imax=max(max(Idouble));
deltaI=Imax-Imin;
Inorm=(Idouble-Imin)./deltaI; % Normalized image between [0; 1]

end

