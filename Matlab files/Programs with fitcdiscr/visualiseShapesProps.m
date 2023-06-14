function visualiseShapesProps(labels,features)
x1=features(:,1);
x2=features(:,2);
x3=features(:,3);
x4=features(:,4);
x5=features(:,5);
x6=features(:,6);
x7=features(:,7);
x8=features(:,8);
figure(1)
tiledlayout(2,2);
nexttile
h=gscatter(x1,x2,labels,'rgbmy','ox^sd'); 
set(h,'LineWidth',2,'MarkerSize',2);
title('Shapes properties');
xlabel('First property');
ylabel('Second property');
nexttile
h=gscatter(x2,x3,labels,'rgbmy','ox^sd'); 
set(h,'LineWidth',2,'MarkerSize',2);
title('Shapes properties');
xlabel('Second property');
ylabel('Third property');
nexttile
h=gscatter(x3,x4,labels,'rgbmy','ox^sd'); 
set(h,'LineWidth',2,'MarkerSize',2);
title('Shapes properties');
xlabel('Third property');
ylabel('Fourth property');
nexttile
h=gscatter(x4,x5,labels,'rgbmy','ox^sd'); 
set(h,'LineWidth',2,'MarkerSize',2);
title('Shapes properties');
xlabel('First property');
ylabel('Fourth property');

figure(2)
tiledlayout(2,2);
nexttile
h=gscatter(x5,x6,labels,'rgbmy','ox^sd'); 
set(h,'LineWidth',2,'MarkerSize',2);
title('Shapes properties');
xlabel('Fifth property');
ylabel('Sixth property');
nexttile
h=gscatter(x7,x8,labels,'rgbmy','ox^sd'); 
set(h,'LineWidth',2,'MarkerSize',2);
title('Shapes properties');
xlabel('Seventh property');
ylabel('Eight property');
nexttile
h=gscatter(x1,x8,labels,'rgbmy','ox^sd'); 
set(h,'LineWidth',2,'MarkerSize',2);
title('Shapes properties');
xlabel('First property');
ylabel('Eight property');
nexttile
h=gscatter(x2,x7,labels,'rgbmy','ox^sd'); 
set(h,'LineWidth',2,'MarkerSize',2);
title('Shapes properties');
xlabel('Second property');
ylabel('Seventh property');

figure(3)
tiledlayout(2,2);
nexttile
h=gscatter(x3,x5,labels,'rgbmy','ox^sd'); 
set(h,'LineWidth',2,'MarkerSize',2);
title('Shapes properties');
xlabel('Third property');
ylabel('Fifth property');
nexttile
h=gscatter(x4,x6,labels,'rgbmy','ox^sd'); 
set(h,'LineWidth',2,'MarkerSize',2);
title('Shapes properties');
xlabel('Fourth property');
ylabel('Sixth property');
nexttile
h=gscatter(x5,x7,labels,'rgbmy','ox^sd'); 
set(h,'LineWidth',2,'MarkerSize',2);
title('Shapes properties');
xlabel('Fifth property');
ylabel('Seventh property');
nexttile
h=gscatter(x6,x8,labels,'rgbmy','ox^sd'); 
set(h,'LineWidth',2,'MarkerSize',2);
title('Shapes properties');
xlabel('Sixth property');
ylabel('Eigth property');
end