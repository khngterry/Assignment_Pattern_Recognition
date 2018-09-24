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
h = figure
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


saveas(h,'class2_erro_GED.png');

%% error GED
Class = [rAClass2; rBClass2];
% add labels
Class(1:200, 3) = 1;
Class(201:400, 3) = 2;
error_GED2 = zeros(40,1);

for n = 1:40
    v = 5*n;
    u = (5*n-4);
    sample2A = rAClass2(u:v,:);
    sample2B = rAClass2(u:v,:);
    meanClass2A = mean(sample2A);
    meanClass2B = mean(sample2B);
    valClass2A = cov(sample2A);
    valClass2B = cov(sample2B);
    z = zeros(length(Class),1);
    for i = 1:400   
             z(i) = ([Class(i,1) Class(i,2)]- meanClass2A)*inv(valClass2A)*...
                 ([Class(i,1) Class(i,2)]- meanClass2A)'- ...
                 ([Class(i,1) Class(i,2)]- meanClass2B)*inv(valClass2B)...
             *([Class(i,1) Class(i,2)]- meanClass2B)';    
         
            if z(i)>0
                z(i) = 2;
            else
                z(i) = 1;
            end
    end
    % get rid of training samples
    z(u:v,:) = Class(u:v,3);
    z(200+u:200+v) = Class(200+u:200+v,3);
    % calculate error rate
    error_GED2(n) = sum(abs(z(1:200)-1)+abs(z(201:400)-2))/380;
end
% RESULT
muError_GED2 = mean(error_GED2);
varError_GED2 = std(error_GED2);