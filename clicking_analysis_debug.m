%% initialize the workspace

clear all; close all; clc;

%% load the file

% this loads a variable called "data" in the workspace
% you can change what file you want to analyze here
load('clicking_dataset_1.mat')

% the variable "data" is a structure that contains 3 vectors
time = data.time;
middle = data.middle;
index = data.index;

% the vector "time" is the time of the clicking task, around 20 seconds.
% the vectors "middle" and "index" are vectors of 0s and 1s (0 means mouse
% button is NOT pressed, and 1 means button IS pressed), for the middle and
% index fingers respectively.

% %% visualizing data
% 
% % method 1
% % plot the middle and the index fingers on separate axes
% % 1 means button is pressed, 0 means button is not pressed
figure(1);
subplot(2,1,1);plot(time,middle,'b');ylim([-.1 1.1]);ylabel('Middle finger')
subplot(2,1,2);plot(time,index,'r');ylim([-.1 1.1]);ylabel('Index finger');xlabel('Time (seconds)')

% % method 2
% % plot the middle and the index fingers on the same axes
% % 1 means MIDDLE finger button is pressed, -1 means INDEX finger button is
% % pressed, 0 means no button is pressed
figure(2);
plot(time,middle,'b',time,-index,'r');legend('Middle finger','Index finger')
ylim([-1.1 1.1]);ylabel('Clicking data');xlabel('Time (seconds)')



   