%% initialize the workspace

clear all; close all; clc;

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

    for t = 1:(length(differenceM) - 1)
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

    for d = 1:(length(differenceI) - 1)
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
    indexVariation = (indexSTD/indexMean);
    
    y = [y; middleVariation indexVariation];

end

%% Combined fingers 

xComb = []; 
yComb = []; 

for i = 1:15
    fileName = "clicking_dataset_" + i + ".mat";
    load(fileName)
    time = data.time;
    middle = data.middle;
    index = data.index;
    xComb = [xComb i]; 
    
    differenceM = diff(middle);
    differenceI = diff(index);
    durationComb = [];
    durationCombStart = 0; 
    durationCombEnd = 0; 
    
    lengthComb = 0;
    if length(differenceM) < length(differenceI)
        lengthComb = length(differenceM);
    else 
        lengthComb = length(differenceI);
    end
   
    for t = 1:lengthComb
        if (differenceM(t)) < 0
            %difference is < 0, the end of the patient pressing the mouse 
            durationCombStart = time(t);
            for i = t+1:lengthComb
                if (differenceI(t)) > 0
                    %difference is > 0, the start of the patient pressing the mouse 
                    durationCombEnd = time(t);
                    durationComb = [durationComb, (durationCombEnd - durationCombStart)] 
                end 
            end
        end
    end 
    
    combSTD = std(durationComb);
    combMean = mean(durationComb);
    combVariation = (combSTD/combMean)
    
    yComb = [yComb; combVariation]
end   
%%
figure(1);
bar(xComb, yComb)

title('Click Variation for 15 Datasets')
xlabel("Datasets") 
ylabel("Click Variation") 
