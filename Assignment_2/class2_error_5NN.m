%% SYDE 675 LAB_1
clear all; close all; clc;

%% class 1
muAClass2 = [-1,0];
sigmaAClass2 = [4,3; 3,4];
muBClass2 = [1,0];
sigmaBClass2 = [4,3; 3,4];

%% load data
rAClass2 = mvnrnd(muAClass2, sigmaAClass2, 200);
rBClass2 = mvnrnd(muBClass2, sigmaBClass2, 200);
h3 = figure
plot(rAClass2(:,1),rAClass2(:,2),'r*');
hold on
plot(rBClass2(:,1),rBClass2(:,2),'g+'); 
title('Class 2');

%% MED
meanClass2A = mean(rAClass2)
meanClass2B = mean(rBClass2)
u = linspace(-7, 7, 400);
v = linspace(-7, 7, 400);
z = zeros(length(u), length(v));
for i = 1:length(u)
        for j = 1:length(v)
            z(i,j) = ((u(i)- meanClass2A(1))^2 + (v(j)- meanClass2A(2))^2)...
                - ((u(i)- meanClass2B(1))^2 + (v(j)- meanClass2B(2))^2);
        end
end
z = z';
contour(u,v,z,[0, 0], 'LineWidth', 1,'LineColor','b','DisplayName','MED');

plot(meanClass2A(1),meanClass2A(2),'gs','MarkerSize',10,'MarkerFaceColor',...
    [0,0,0],...
    'DisplayName','mean of sample A');
plot(meanClass2B(1),meanClass2B(2),'cs','MarkerSize',10,'MarkerFaceColor',...
    [0,0,0],...
    'DisplayName','mean of sample B');

%% GED
u1 = linspace(-7, 6, 400);
v1 = linspace(-7, 6, 400);
valClass2A = cov(rAClass2)
valClass2B = cov(rBClass2)
z1 = zeros(length(u1), length(v1));
for i = 1:length(u1)
     for j = 1:length(v1)
         z1(i,j) = ([u1(i) v1(j)]- meanClass2A)*inv(valClass2A)*([u1(i) v1(j)]...
             - meanClass2A)'- ([u1(i) v1(j)]- meanClass2B)*inv(valClass2B)...
             *([u1(i) v1(j)]- meanClass2B)';
             
     end
end
z1 = z1';
contour(u1,v1,z1,[0, 0], 'LineWidth', 1,'LineColor','g','DisplayName','GED'); 
legend('show');

%% MAP

u2 = linspace(-7, 6, 400);
v2 = linspace(-7, 6, 400);
z2 = zeros(length(u2), length(v2));
for i = 1:length(u2)
     for j = 1:length(v2)      
         z2(i,j) = 1/(2*pi*(abs(det(sigmaAClass2)))^0.5)*exp(-0.5*([u2(i) v2(j)]...
             - muAClass2)*inv(sigmaAClass2)*([u2(i) v2(j)]- muAClass2)')...
             - 1/(2*pi*(abs(det(sigmaBClass2)))^0.5)*exp(-0.5*([u2(i) v2(j)] ...
             - muBClass2)*inv(sigmaBClass2)*([u2(i) v2(j)]- muBClass2)');
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
X1 = [rAClass2; rBClass2];
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

saveas(h3,'class2_error_5NN.png');


%% error 5NN
Class = [rAClass2;rBClass2];
Class(1:200,3) = 1;
Class(201:400,3) = 2;
error_5NN2 = zeros(40,1);
label = zeros(length(Class),1);

for n = 1:40
    % choose 10 samples from class A and B 
    v = 5*n;
    u = (5*n-4);
    sample2A = rAClass2(u:v,:);
    sample2B = rBClass2(u:v,:);
    sample = [sample2A;sample2B];
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
error_5NN2(n) = sum(abs(label(1:200)-1)+abs(label(201:400)-2))/380;
end

muError_5NN2 = mean(error_5NN2);
varError_5NN2 = std(error_5NN2);