%% SYDE 675 LAB_1
clear all; close all; clc;

%% class 1
muAClass3 = [0,0];
sigmaAClass3 = [3,1; 1,2];
muBClass3 = [3,0];
sigmaBClass3 = [7,-3; -3,4];

%% load data
rAClass3 = mvnrnd(muAClass3, sigmaAClass3, 200);
rBClass3 = mvnrnd(muBClass3, sigmaBClass3, 200);
h = figure
plot(rAClass3(:,1),rAClass3(:,2),'r*');
hold on
plot(rBClass3(:,1),rBClass3(:,2),'g+'); 
title('Class 3');

%% MED
meanClass3A = mean(rAClass3)
meanClass3B = mean(rBClass3)
u = linspace(-4, 7, 400);
v = linspace(-4, 7, 400);
z = zeros(length(u), length(v));
for i = 1:length(u)
        for j = 1:length(v)
            z(i,j) = ((u(i)- meanClass3A(1))^2 + (v(j)- meanClass3A(2))^2)...
                - ((u(i)- meanClass3B(1))^2 + (v(j)- meanClass3B(2))^2);
        end
end
z = z';
contour(u,v,z,[0, 0], 'LineWidth', 1,'LineColor','b','DisplayName','MED');

plot(meanClass3A(1),meanClass3A(2),'gs','MarkerSize',10,'MarkerFaceColor',...
    [0,0,0],...
    'DisplayName','mean of sample A');
plot(meanClass3B(1),meanClass3B(2),'cs','MarkerSize',10,'MarkerFaceColor',...
    [0,0,0],...
    'DisplayName','mean of sample B');

%% GED
u1 = linspace(-4, 7, 400);
v1 = linspace(-4, 7, 400);
valClass3A = cov(rAClass3)
valClass3B = cov(rBClass3)
z1 = zeros(length(u1), length(v1));
for i = 1:length(u1)
     for j = 1:length(v1)
         z1(i,j) = ([u1(i) v1(j)]- meanClass3A)*inv(valClass3A)*([u1(i) v1(j)]...
             - meanClass3A)'- ([u1(i) v1(j)]- meanClass3B)*inv(valClass3B)...
             *([u1(i) v1(j)]- meanClass3B)';
             
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
         z2(i,j) = 1/(2*pi*(abs(det(sigmaAClass3)))^0.5)*exp(-0.5*([u2(i) v2(j)]...
             - muAClass3)*inv(sigmaAClass3)*([u2(i) v2(j)]- muAClass3)')...
             - 1/(2*pi*(abs(det(sigmaBClass3)))^0.5)*exp(-0.5*([u2(i) v2(j)] ...
             - muBClass3)*inv(sigmaBClass3)*([u2(i) v2(j)]- muBClass3)');
     end
end
z2 = z2';
contour(u2,v2,z2,[0, 0], 'LineWidth', 1,'LineColor','k','DisplayName','MAP'); 
legend('show');

saveas(h,'class3_error_GED.png');

%% error GED
Class = [rAClass3; rBClass3];
% add labels
Class(1:200, 3) = 1;
Class(201:400, 3) = 2;
error_GED3 = zeros(40,1);

for n = 1:40
    v = 5*n;
    u = (5*n-4);
    sample3A = rAClass3(u:v,:);
    sample3B = rAClass3(u:v,:);
    meanClass3A = mean(sample3A);
    meanClass3B = mean(sample3B);
    valClass3A = cov(sample3A);
    valClass3B = cov(sample3B);
    z = zeros(length(Class),1);
    for i = 1:400   
             z(i) = ([Class(i,1) Class(i,2)]- meanClass3A)*inv(valClass3A)*...
                 ([Class(i,1) Class(i,2)]- meanClass3A)'- ...
                 ([Class(i,1) Class(i,2)]- meanClass3B)*inv(valClass3B)...
             *([Class(i,1) Class(i,2)]- meanClass3B)';    
         
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
    error_GED3(n) = sum(abs(z(1:200)-1)+abs(z(201:400)-2))/380;
end
% RESULT
muError_GED3 = mean(error_GED3);
varError_GED3 = std(error_GED3);