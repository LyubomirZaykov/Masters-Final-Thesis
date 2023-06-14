function visualiseQdaData(md,features)
x1=features(:,1);
x2=features(:,2);
x3=features(:,3);
x4=features(:,4);
x5=features(:,5);
pred=md.predict(features);
figure
tiledlayout(2,2);
nexttile
h=gscatter(x1,x2,pred,'rgbmy','ox^sd'); 
set(h,'LineWidth',2,'MarkerSize',2);
title('QDA Classifier using Principal Components');
xlabel('First principal component');
ylabel('Second principal component');
nexttile
h=gscatter(x2,x3,pred,'rgbmy','ox^sd'); 
set(h,'LineWidth',2,'MarkerSize',2);
title('QDA Classifier using Principal Components');
xlabel('Second principal component');
ylabel('Third principal component');
nexttile
h=gscatter(x3,x4,pred,'rgbmy','ox^sd'); 
set(h,'LineWidth',2,'MarkerSize',2);
title('QDA Classifier using Principal Components');
xlabel('Third principal component');
ylabel('Fourth principal component');
nexttile
h=gscatter(x4,x5,pred,'rgbmy','ox^sd'); 
set(h,'LineWidth',2,'MarkerSize',2);
title('QDA Classifier using Principal Components');
xlabel('Fourth principal component');
ylabel('Fifth principal component');
end