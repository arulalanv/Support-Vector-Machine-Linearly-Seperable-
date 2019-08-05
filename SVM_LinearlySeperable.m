%% SVM Classifier - Lineraly Seperable
close all;
clear all;
clc;

%% Input Vectors
% Positive labelled vectors
x1 = [3  3 6  6;
      1 -1 1 -1];
% Negative labelled vectors
x2 = [1 0  0 -1;
      0 1 -1  0];

%% Finding the distance between the two vectors
dist = zeros(4,4);
for i = 1:4
    for j = 1:4
        dist(i,j) = sqrt((x2(1,j)-x1(1,i))^2 + (x2(2,j)-x1(2,i))^2);
    end
end
%% Finding the support vectors
mindist = min(min(dist));
spos = zeros(1,4);
sneg = zeros(1,4);
for i = 1:4
    for j = 1:4
        if dist(i,j) == mindist
            spos(i) = 1;
            sneg(j) = 1;
        end
    end
end
%% Initializing the support vectors
k = 1;
for i = 1:4
    if spos(i) == 1
        s(:,k) = x1(:,i);
        class(1,k) = 1;         % Positive Class - +1
        k = k + 1;
    end
    if sneg(i) == 1
        s(:,k) = x2(:,i);
        class(1,k) = -1;        % Negative Class - -1
        k = k + 1;
    end
end
%% Adding a bias
sdash = s;
sdash(3,:) = 1;
%% Solving for alpha
no_s = k-1;
for i = 1:no_s
    for j = 1:no_s
        s_coeff(i,j) = sum(sdash(:,i).*sdash(:,j));
    end
end
syms x y z real
S = solve(s_coeff(1,1)*x + s_coeff(1,2)*y + s_coeff(1,3)*z == class(1,1),...
          s_coeff(2,1)*x + s_coeff(2,2)*y + s_coeff(2,3)*z == class(1,2),...
          s_coeff(3,1)*x + s_coeff(3,2)*y + s_coeff(3,3)*z == class(1,3));

alpha1 = S.x;
alpha2 = S.y;
alpha3 = S.z;
wdash = alpha1 * sdash(:,1) + alpha2 * sdash(:,2) + alpha3 * sdash(:,3);
w = [wdash(1);wdash(2)];
b = wdash(3);
figure(1);
for i = 1:4
    plot(x1(1,i), x1(2,i),'*','MarkerSize',10,...
                              'MarkerEdgeColor','k',...
                              'MarkerFaceColor','g');grid on;
    set(gca, 'xlim',[-7 7], 'ylim',[-5 5]);%GCA-GET CURRENT ACCESS
    if i == 1
        hold on;
    end
    if spos(i) == 1
        plot(x1(1,i), x1(2,i),'o','MarkerSize',10,...
                                  'MarkerEdgeColor','k',...
                                  'MarkerFaceColor','r');
    end
end
for i = 1:4
    plot(x2(1,i), x2(2,i),'o','MarkerSize',10,...
                              'MarkerEdgeColor','k',...
                              'MarkerFaceColor','g');
    if sneg(i) == 1
        plot(x2(1,i), x2(2,i),'o','MarkerSize',10,...
                                  'MarkerEdgeColor','k',...
                                  'MarkerFaceColor','r');
    end
end
title('SVM - Linearly Seperable');
xx = -10:1:10;
yy = w * xx + b;
plot(-yy(2,:), yy(1,:), 'r', 'LineWidth', 2);