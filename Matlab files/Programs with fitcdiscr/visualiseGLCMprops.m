function visualiseGLCMprops(labels,features)
x1=features(:,1);
x2=features(:,2);
x3=features(:,3);
x4=features(:,4);
figure
tiledlayout(2,2);
nexttile
h=gscatter(x1,x2,labels,'rgbmy','ox^sd'); 
set(h,'LineWidth',2,'MarkerSize',2);
title('4 GLCM Properties');
xlabel('First property');
ylabel('Second property');
nexttile
h=gscatter(x2,x3,labels,'rgbmy','ox^sd'); 
set(h,'LineWidth',2,'MarkerSize',2);
title('4 GLCM Properties');
xlabel('Second property');
ylabel('Third property');
nexttile
h=gscatter(x3,x4,labels,'rgbmy','ox^sd'); 
set(h,'LineWidth',2,'MarkerSize',2);
title('4 GLCM Properties');
xlabel('Third property');
ylabel('Fourth property');
nexttile
h=gscatter(x1,x4,labels,'rgbmy','ox^sd'); 
set(h,'LineWidth',2,'MarkerSize',2);
title('4 GLCM Properties');
xlabel('First property');
ylabel('Fourth property');
end