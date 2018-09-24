%% SYDE675 LAB1
clear all; close all; clc;

%% class 4

%% Load data of class 4
r_Class4 = load('assignment1Case4.mat');
rAClass4 = r_Class4.a;
rBClass4 = r_Class4.b;
h = figure
plot(rAClass4(:,1),rAClass4(:,2),'r*');
hold on
plot(rBClass4(:,1),rBClass4(:,2),'g+');
title('Class 4');

%% MED
meanClass4A = mean(rAClass4);
meanClass4B = mean(rBClass4);
u_class4 = linspace(150, 450, 1000);
v_class4 = linspace(20, 320, 1000);
z_class4 = zeros(length(u_class4), length(v_class4));
for i = 1:length(u_class4)
        for j = 1:length(v_class4)
            z_class4(i,j) = ((u_class4(i)- meanClass4A(1))^2 + (v_class4(j)...
                - meanClass4A(2))^2) - ((u_class4(i)- meanClass4B(1))^2 + (v_class4(j)- meanClass4B(2))^2);
        end
end
z_class4 = z_class4';
contour(u_class4,v_class4,z_class4,[0, 0], 'LineWidth', 1,'LineColor','b','DisplayName','MED');

%% GED
u1_class4 = linspace(150, 450, 100);
v1_class4 = linspace(20, 320, 100);
valClass4A = cov(rAClass4);
valClass4B = cov(rBClass4);
z1_class4 = zeros(length(u1_class4), length(v1_class4));
for i = 1:length(u1_class4)
     for j = 1:length(v1_class4)
         z1_class4(i,j) = ([u1_class4(i) v1_class4(j)]- meanClass4A)*inv(valClass4A)...
             *([u1_class4(i) v1_class4(j)]- meanClass4A)'- ([u1_class4(i) v1_class4(j)]...
             - meanClass4B)*inv(valClass4B)*([u1_class4(i) v1_class4(j)]- meanClass4B)';

     end
end
z1_class4 = z1_class4';
contour(u1_class4,v1_class4,z1_class4,[0, 0], 'LineWidth', 1,'LineColor','g','DisplayName','GED');
legend('show');


saveas(h,'class4.png');
