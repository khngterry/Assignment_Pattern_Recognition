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
h = figure
plot(rAClass1(:,1),rAClass1(:,2),'r*');
hold on
plot(rBClass1(:,1),rBClass1(:,2),'g+'); 
title('Class 3-NN');

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

% NN
u2_class1 = linspace(-5, 7, 400);
v2_class1 = linspace(-3, 7, 400);
z2_class1 = zeros(length(u2_class1), length(v2_class1));
temp = zeros(400,1);
for m = 1:length(u2_class1)
    for n = 1:length(v2_class1)
        z2_A_class1 = zeros(size(rAClass1,1), 1); 
        z2_B_class1 = zeros(size(rAClass1,1), 1);
        for i = 1:size(rAClass1,1)
                z2_A_class1(i) = (u2_class1(m)-rAClass1(i,1))^2+(v2_class1(n)-rAClass1(i,2))^2;
                z2_B_class1(i) = (u2_class1(m)-rBClass1(i,1))^2+(v2_class1(n)-rBClass1(i,2))^2;        
        end
        z2_class1(m,n) = min(z2_A_class1)-min(z2_B_class1);       
    end
end
z2_class1 = z2_class1';
contour(u2_class1,v2_class1,z2_class1,[0, 0], 'LineWidth', 1,'LineColor','b','DisplayName','NN'); 
legend('show');


saveas(h,'class3_NN.png');