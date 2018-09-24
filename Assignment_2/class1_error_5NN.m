%% SYDE 675 LAB_1
clear all; close all; clc;

%% class 1
muAClass1 = [0,0];
sigmaAClass1 = [1,0; 0,1];
muBClass1 = [3,0];
sigmaBClass1 = [1,0; 0,1];

%% load data
rAClass1 = mvnrnd(muAClass1, sigmaAClass1, 200);
rBClass1 = mvnrnd(muBClass1, sigmaBClass1, 200);
h3 = figure
plot(rAClass1(:,1),rAClass1(:,2),'r*');
hold on
plot(rBClass1(:,1),rBClass1(:,2),'g+'); 
title('Class 1');

%% MED
meanClass1A = mean(rAClass1)
meanClass1B = mean(rBClass1)
u = linspace(-4, 7, 400);
v = linspace(-4, 7, 400);
z = zeros(length(u), length(v));
for i = 1:length(u)
        for j = 1:length(v)
            z(i,j) = ((u(i)- meanClass1A(1))^2 + (v(j)- meanClass1A(2))^2)...
                - ((u(i)- meanClass1B(1))^2 + (v(j)- meanClass1B(2))^2);
        end
end
z = z';
contour(u,v,z,[0, 0], 'LineWidth', 1,'LineColor','b','DisplayName','MED');

plot(meanClass1A(1),meanClass1A(2),'gs','MarkerSize',10,'MarkerFaceColor',...
    [0,0,0],...
    'DisplayName','mean of sample A');
plot(meanClass1B(1),meanClass1B(2),'cs','MarkerSize',10,'MarkerFaceColor',...
    [0,0,0],...
    'DisplayName','mean of sample B');

%% GED
u1 = linspace(-4, 7, 400);
v1 = linspace(-4, 7, 400);
valClass1A = cov(rAClass1)
valClass1B = cov(rBClass1)
z1 = zeros(length(u1), length(v1));
for i = 1:length(u1)
     for j = 1:length(v1)
         z1(i,j) = ([u1(i) v1(j)]- meanClass1A)*inv(valClass1A)*([u1(i) v1(j)]...
             - meanClass1A)'- ([u1(i) v1(j)]- meanClass1B)*inv(valClass1B)...
             *([u1(i) v1(j)]- meanClass1B)';
             
     end
end
z1 = z1';
contour(u1,v1,z1,[0, 0], 'LineWidth', 1,'LineColor','g','DisplayName','GED'); 
legend('show');

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

%% 5-nn
u5 = linspace(-5, 8, 100);
v5 = linspace(-6, 6, 100);
X1 = zeros(400,2);
Y1 = zeros(400,1);
X1 = [rAClass1; rBClass1];
Y1(1:200) = 1;
Y1(201:400) = 2;
mdl1 = fitcknn(X1,Y1,'NumNeighbors',5);
for i = 1:length(u5)
     for j = 1:length(v5)     
         label1(i,j) = predict(mdl1,[u5(i),v5(j)]) - 2;
     end
end
label1 = label1';

hold on

contour(u5,v5,label1,[0, 0], 'LineWidth', 1,'LineColor','y','DisplayName','5-NN'); 
legend('show');

saveas(h3,'class3_error_5NN.png');

%% error 5NN
Class = [rAClass1;rBClass1];
Class(1:200,3) = 1;
Class(201:400,3) = 2;
error_5NN1 = zeros(40,1);
label = zeros(length(Class),1);

for n = 1:40
    % choose 10 samples from class A and B 
    v = 5*n;
    u = (5*n-4);
    sample1A = rAClass1(u:v,:);
    sample1B = rBClass1(u:v,:);
    sample = [sample1A;sample1B];
    % add labels
    sample(1:5,3) = 1;
    sample(6:10,3) = 2;    
    % training 
    mdl = fitcknn(sample(:,1:2),sample(:,3),'NumNeighbors', 5);
    
    for i = 1:400 
         label(i) = predict(mdl,[Class(i,1),Class(i,2)]);
    end
    
label(u:v,:) = Class(u:v,3);
label(200+u:200+v) = Class(200+u:200+v,3);
error_5NN1(n) = sum(abs(label(1:200)-1)+abs(label(201:400)-2))/380;
end

muError_5NN1 = mean(error_5NN1);
varError_5NN1 = std(error_5NN1);