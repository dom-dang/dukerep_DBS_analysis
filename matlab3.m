%% tutorial #2

%% referencing entire rows or columns of a matrix

matrix = [1 2 3; 4 5 6; 7 8 9; 10 11 12]

% calling column 1
c1 = matrix(:,1) % the : here means "all rows" and the 1 means "column 1"
% calling column 2
c2 = matrix(:,2) % the : here means "all rows" and the 2 means "column 2"

% calling row 2
r2 = matrix(2,:) % the 2 here means "row 2" and the : means "all columns"
% calling row 4
r4 = matrix(4,:) % the 4 here means "row 4" and the : means "all columns"

% you can also call the last column or the last row by writing "end"
lastRow = matrix(end,:)
lastCol = matrix(:,end)

%% "counters" in for loops

% sometimes we have an if tree inside a for loop (or a while loop, more
% later...) and want to count how many times the condition of the if tree
% is met during the for loop

% example:
% count how many rows of "matrix" have a sum that is greater than 7

% helpful tip: write down on a piece of paper everything that the for loop
% calculates by hand. For example:
% i = 1, row = matrix(1,:) = [1 2 3], rowSum = 6, rowSum > 7 --> not true!
% repeat

matrix = [1 2 3; 4 5 6; 7 8 9; 10 11 12]

counter = 0;
for i = 1:4
    % select the i-th row of the matrix
    row = matrix(i,:);
    
    % calcualte the sum of the i-th row
    rowSum = sum(row);
    
    % if tree
    if rowSum > 7
        counter = counter + 1;
    end
    
end
counter
%% for loops versus while loops - be careful!

% for loops will repeat the same operation a finite number of times, that
% you indicate ahead of time.
% while loops will keep repeating the same operation until a certain
% condition is me. if you don't write your code properly, while loops will
% run forever and you will need to force exit out of your code!

% example: write a while loop that adds a new random integer value (up to
% 100) to a variable called "newVector" until the size of the new variable
% is 45
% a while loop is not the most efficient way to do this, but we will use it
% for the purposes of explaining what a while loop is

sizeVec = 0;
index = 1;
newVector = []; % you need to create the new variable outside of the loop! 
% you should make it an empty variable, but it needs to exist!
while sizeVec < 45
    newVector(index) = randi(100); % randi(100) generates a random integeter up to 100
    index = index + 1;
    sizeVec = length(newVector); 
end
sizeVec

% another way to perform the same thing, but without using the variable
% index

sizeVec = 0;
newVector = []; % you need to create the new variable outside of the loop! 
% you should make it an empty variable, but it needs to exist!
while sizeVec < 45
    % this action concatenates (adds to the end of the vector) the new
    % element randi(100)
    newVector = [newVector randi(100)];
    sizeVec = length(newVector); 
end
sizeVec
newVector

%% functions

% If you know you will be performing a certain operation many times, and
% you want to be able to access that easily without having to write out all
% the steps all over again, you can write a function! In this example, the
% function will be pretty simple, but I have written functions with 100+
% lines of code. Functions are really helpful in making your code organized

% write a function that calculates 3*x^2+9 for a single value or vectors
% NOTE: functions need to be written at the end of the code on a script,
% and you need to run the whole script (instead of just "run section") for
% the code to see it

% use the function on a single value
val = 5
valOutput = practiceFunc(val)

% use the function on a vector 
vec = [3 7 2 9]
vecOutput = practiceFunc(vec)

%% Q1

% create a function called "myFirstFunc" that takes an input x (can be a
% single value or a vector) and computes the 5*sqrt(x)
% IMPORTANT: the function needs to be written at the end of the file

% for each row of the matrix "q1_matrix" compute 5*sqrt(x) (using the
% function you created earlier) only if the sum of all elements in that row
% is greater than 100. NOTE: if the sum of all elements is greater than
% 100, you will replace the original row of q1_matrix with a new vector,
% where each element in the vector is equal to 5*sqrt(the value of the
% original vector at that location)

% count how many rows of original matrix have sum over 100 - how many rows
% are you performing 5*sqrt(x) on?

% helpful tip:
% size(q1_matrix,1) = how many rows the matrix has
% size(q1_matrix,2) = how many columns the matrix has

q1_matrix = [100 200 53 54 26; 2 6 2 67 3; 88 23 2 56 3; 30 25 35 65 10; 1 1 1 1 1; 2 2 34 5 6]

% insert your code here
output = myFirstFunc(q1_matrix) 

% print q1_matrix in the command window to check if you got the right
% answer
q1_matrix

%% Q2

% using a while loop, randomly generate a number between 0 and 1 until you
% randomly generate a number that is equal to the target number 0.4567
% make sure you count how many iterations (how many times the while loop is
% executed, meaning how many random numbers you had to generate) it takes
% for you to reach the target
% the random number that is generated needs to be equal to 0.4567 with an
% error of 0.0001. this means that the random number 0.459 would NOT count
% (the error is 0.459 - 0.4567 = 0.0023 which is greater than 0.0001
% the random number 0.45678 would count! since the error would 
% be 0.45678 - 0.4567 = 0.00008 which is less than 0.0001 

% TIP: the code below generates a random number between 0 and 1
%number = rand;

% TIP: if your code keeps running forever (the bottom left corner of the
% screen says busy for a reallyyyyyy long time) you can force exit the code
% by clicking the command window and then pressing "CTRL" and "C"

% insert your code here
number = rand 
q2_counter = 0
while number < 0.4566 | number > 0.4568  
    number = rand;
    q2_counter = q2_counter + 1;
end 
number
% print the value q2_counter in the command window to see how many
% iterations it took to genereate the correct random number
q2_counter

%% write your functions here at the end of the code, then run the entire script

function out = practiceFunc(in) 
    out = 3.*in.^2+9;
end

% insert code here for "myFirstFunc" from Q1

function test = myFirstFunc(in)
    test = 0
    for i = 1:size(in,1)
        if sum(i) > 100
            test = test + 1 
        end 
    end 
 end 

