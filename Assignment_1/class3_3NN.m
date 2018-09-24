%% SYDE 675 LAB_1
clear all; close all; clc;

%% class 1
muAClass1 = [0,0];
sigmaAClass1 = [3,1; 1,2];
muBClass1 = [3,0];
sigmaBClass1 = [7,-3; -3,4];

%% load data
rAClass1 = mvnrnd(muAClass1, sigmaAClass1, 200);
rBClass1 = mvnrnd(muBClass1, sigmaBClass1, 200);
h2 = figure
plot(rAClass1(:,1),rAClass1(:,2),'r*');
hold on
plot(rBClass1(:,1),rBClass1(:,2),'g+'); 
title('Class 3-3NN');


%% MAP

u2 = linspace(-4, 7, 400);
v2 = linspace(-4, 7, 400);
z2 = zeros(length(u2), length(v2));
for i = 1:length(u2)
     for j = 1:length(v2)      
         z2(i,j) = 1/(2*pi*(abs(det(sigmaAClass1)))^0.5)*exp(-0.5*([u2(i) v2(j)]...
             - muAClass1)*inv(sigmaAClass1)*([u2(i) v2(j)]- muAClass1)')...
             - 1/(2*pi*(abs(det(sigmaBClass1)))^0.5)*exp(-0.5*([u2(i) v2(j)] ...
             - muBClass1)*inv(sigmaBClass1)*([u2(i) v2(j)]- muBClass1)');
     end
end
z2 = z2';
contour(u2,v2,z2,[0, 0], 'LineWidth', 1,'LineColor','k','DisplayName','MAP'); 
legend('show');

%% 3-nn
u4 = linspace(-5, 8, 100);
v4 = linspace(-6, 6, 100);
X = zeros(400,2);
Y = zeros(400,1);
X = [rAClass1; rBClass1];
Y(1:200) = 1;
Y(201:400) = 2;
mdl = fitcknn(X,Y,'NumNeighbors',3);
for i = 1:length(u4)
     for j = 1:length(v4)     
         label(i,j) = predict(mdl,[u4(i),v4(j)]) - 2;
     end
end
label = label';

hold on

contour(u4,v4,label,[0, 0], 'LineWidth', 1,'LineColor','b','DisplayName','3NN'); 


legend('show');
saveas(h2,'class3_3NN.png');