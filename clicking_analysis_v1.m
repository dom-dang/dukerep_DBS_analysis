%% initialize the workspace

clear all; close all; clc;

%% load the file

% this loads a variable called "data" in the workspace
% you can change what file you want to analyze here
load('clicking_dataset_1.mat')

% the variable "data" is a structure that contains 3 vectors
% time = data.time;
% middle = data.middle;
% index = data.index;

% the vector "time" is the time of the clicking task, around 20 seconds.
% the vectors "middle" and "index" are vectors of 0s and 1s (0 means mouse
% button is NOT pressed, and 1 means button IS pressed), for the middle and
% index fingers respectively.

% %% visualizing data
% 
% % method 1
% % plot the middle and the index fingers on separate axes
% % 1 means button is pressed, 0 means button is not pressed
% figure(1);
% subplot(2,1,1);plot(time,middle,'b');ylim([-.1 1.1]);ylabel('Middle finger')
% subplot(2,1,2);plot(time,index,'r');ylim([-.1 1.1]);ylabel('Index finger');xlabel('Time (seconds)')
% 
% % method 2
% % plot the middle and the index fingers on the same axes
% % 1 means MIDDLE finger button is pressed, -1 means INDEX finger button is
% % pressed, 0 means no button is pressed
% figure(2);
% plot(time,middle,'b',time,-index,'r');legend('Middle finger','Index finger')
% ylim([-1.1 1.1]);ylabel('Clicking data');xlabel('Time (seconds)')

%% Analysis Code
x = []; 
y = []; 
cpsGraph = [];
scores = []; 

for i = 1:15
    fileName = "clicking_dataset_" + i + ".mat";
    totalMClicks = 0; 
    totalIClicks = 0; 
    indivScore = 0; 
    load(fileName)    
    x = [x i]; 
    
    time = data.time;
    middle = data.middle;
    index = data.index;

    differenceM = diff(middle);
    durationMiddle = [];
    durationMStart = 0; 
    durationMEnd = 0; 

    for t = 1:(length(differenceM))
        if (differenceM(t)) > 0
            %difference is > 0, the start of the patient pressing the mouse 
            durationMStart = time(t);
        end
        if (differenceM(t)) < 0
            %difference is < 0, the end of the patient pressing the mouse 
            durationMEnd = time(t);
            durationMiddle = [durationMiddle, (durationMEnd - durationMStart)];
            totalMClicks = totalMClicks + 1; 
        end
    end 

    %calculating variation for middle finger click 
    middleSTD = std(durationMiddle);
    middleMean = mean(durationMiddle); 
    middleVariation = (middleSTD/middleMean); 
    
    
    %start of Index finger calculations 
    differenceI = diff(index);
    durationIndex = [];
    durationIStart = 0; 
    durationIEnd = 0; 

    for d = 1:(length(differenceI))
        if (differenceI(d)) > 0
            %difference is > 0, the start of the patient pressing the mouse 
            durationIStart = time(d);
        end
        if (differenceI(d)) < 0
            %difference is < 0, the end of the patient pressing the mouse 
            durationIEnd = time(d);
            durationIndex = [durationIndex, (durationIEnd - durationIStart)];
            totalIClicks = totalIClicks + 1; 
        end
    end 

    indexSTD = std(durationIndex);
    indexMean = mean(durationIndex);
    indexVariation = (indexSTD/indexMean)
    
    y = [y; middleVariation indexVariation];
    
    totalTime = time(end);
    %cps = clicks per second 
    cpsM = totalMClicks/totalTime;
    cpsI = totalIClicks/totalTime;

    cpsGraph = [cpsGraph; cpsM cpsI];
end 

%% not clicking analysis
xNC = []; 
yNC = []; 

for i = 1:15
    fileNameNC = "clicking_dataset_" + i + ".mat"; 
    load(fileNameNC)    
    xNC = [xNC i]; 
    
    time = data.time;
    middle = data.middle;
    index = data.index;

    differenceMNC = diff(middle);
    durationMiddleNC = [];
    durationMStart = 0; 
    durationMEnd = 0; 

    for t = 1:(length(differenceMNC))
        if (differenceMNC(t)) < 0
            %difference is > 0, the start of the patient pressing the mouse 
            durationMStart = time(t);
        end
        if (differenceMNC(t)) > 0
            %difference is < 0, the end of the patient pressing the mouse 
            durationMEnd = time(t);
            durationMiddleNC = [durationMiddleNC, (durationMEnd - durationMStart)];
        end
    end 

    %calculating variation for middle finger click 
    middleSTDNC = std(durationMiddleNC);
    middleMeanNC = mean(durationMiddleNC); 
    middleVariationNC = (middleSTDNC/middleMeanNC); 
    
    
    %start of Index finger calculations 
    differenceINC = diff(index);
    durationIndexNC = [];
    durationIStart = 0; 
    durationIEnd = 0; 

    for d = 1:(length(differenceINC))
        if (differenceINC(d)) < 0
            %difference is > 0, the start of the patient pressing the mouse 
            durationIStart = time(d);
        end
        if (differenceINC(d)) > 0
            %difference is < 0, the end of the patient pressing the mouse 
            durationIEnd = time(d);
            durationIndexNC = [durationIndexNC, (durationIEnd - durationIStart)];
        end
    end 

    indexSTDNC = std(durationIndexNC);
    indexMeanNC = mean(durationIndexNC);
    indexVariationNC = (indexSTDNC/indexMeanNC)
    
    yNC = [yNC; middleVariationNC indexVariationNC];
    
    scores = [scores; indivScore + (middleVariation + indexVariation) + (middleVariationNC + indexVariationNC) - (cpsM + cpsI)] 

end 
%% Graphs 

figure(1);
bar(x, y)

title('Click Variation for 15 Datasets')
xlabel("Datasets") 
ylabel("Click Variation") 
legend('Middle Finger Variation','Index Finger Variation')


figure(2);
bar(xNC, yNC)

title('No Click Variation for 15 Datasets')
xlabel("Datasets") 
ylabel("No Click Variation") 
legend('Middle Finger Variation','Index Finger Variation')


figure(3); 
bar(x, cpsGraph)

title('Clicks per Second for 15 Datasets')
xlabel("Datasets") 
ylabel("Click per Second (m/s)") 
legend('Middle Finger Variation','Index Finger Variation')
   

figure(4); 
bar(x, scores)

title('New Overall Score for 15 Datasets')
xlabel("Datasets") 
ylabel("Score") 

