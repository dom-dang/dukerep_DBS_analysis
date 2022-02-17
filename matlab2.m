%% create variables

% variable names CANNOT have a space in the name
% empty Data = will NOT work as a variable name
emptyData = []; % create a variable without assigning a value
x_point = 10;
y_point = 8;
% putting a semicolon ; at the end of a line suppresses the line
% this means that when you run the code, nothing will print in the command
% window
% try running this script (editor > green arrow at the top of the screen)
x_vector = [1 2 3 7 8] % horizontal vector
x_vector_vertical = [4; 5; 6] % vertical vector
y_vector = [9 11 14 19 22]; % horizontal vector
matrix = [1 5 7 8; 9 10 34 2] % 2 row by 4 column matrix

%% change value of 1 or more element(s) in a vector or matrix
% test_matrix(r,c) --> this returns the element in the matrix called
% "test_matrix" that is located in row r and column c
test_matrix = [2 5 3 7 54; 88 56 11 6 4]

% write an expression to extract the number 88 from test_matrix
test_matrix(2, 1) 

% you can also change the value of an element in a matrix
% test_matrix(r,c) = new number
% change the number 6 from test_matrix to 99
test_matrix(2, 4) = 99

% write an expression to extract the number 7 from test_matrix and assign
% it to a new variable called "extractedData"
extractedData = test_matrix(1, 4)


%% plotting data
figure;plot(x_vector,y_vector,'ko') % this plots black circles
xlabel('x');ylabel('y');title('Graph')

figure;plot(x_vector,y_vector,'r-') % this plots red lines
xlabel('x');ylabel('y');title('Graph')

% this plots red lines and black circlces
figure;plot(x_vector,y_vector,'r-')
hold on;plot(x_vector,y_vector,'ko')
xlabel('x');ylabel('y');title('Graph')

%% useful functions

% max(vector) gives you the maximum value of the elements in a vector
max(x_vector)

% min(vector) gives you the minimum value of the elements in a vector
min(x_vector)

% mean(vector) gives you the average value of the elements in a vector
mean(x_vector)

% length(vector) gives you the length of a vector
length_of_vector = length(x_vector)

% numel(vector) gives you the number of elements in a vector (similar to
% length, but also works for a matrix)
num = numel(x_vector)

% size(matrix) gives you the size of a matrix
size_of_matrix = size(matrix)

% the find function gives you the index (location) where a vector meets the
% given criteria
% example:
% find which values of x_vector are greater than 5, and change them to 0
x_vector = [1 2 3 7 8]
location = find(x_vector>5)
% location = [4 5] --> this means that the 4th and 5th elements of x_vector
% are greater than 5
x_vector(location) = 0
% this is setting the value of x_vector at "location" to zero

%% if statements and for loops

% if statements can be used to ONLY run code IF a condition is met

% for loops can be used to repeat the same operation multiple times (for
% example, for every element in a vector)

test = randn(1,10) % generates a vector of 10 random elements (1 row and 10 columns)
% TIP: type "help randn" in the command window (with the space!) and enter
% this will display an explanation of what the function "randn" does
% this works for all MATLAB built-in functions

% write code to change:
% any elements of "test" that are negative to -8,
% any elements of "test" that are positive but less than 1 to 7,
% and all other elements of "test" to 100

test % display the vector test before the for loop (to check your work)
for i = 1:length(test)
    
    if test(i) < 0
        test(i) = -8;
    elseif (test(i) > 0) & (test(i) < 1)
        test(i) = 7;
    else
        test(i) = 100;
    end
    
end
test % display the vector test after the for loop (to check your work)

%% assignemnt Q1

% write code that creates a new variable (named helloWorld) and assigns elements to that
% variable only when the value of each element of vector_q1 is greater
% than 5. The value of the elements assigned to the new variable should be
% 3*x^2 where x is the current value of vector_q1
vector_q1 = [1 3 11 2 4 6 9 7]
helloworld = [];
% if your code is correct, the answer should be 
% helloWorld = [363 108 243 147]
for i = 1:length(vector_q1)
    if vector_q1(i) > 5
        helloworld = [helloworld, 3*vector_q1(i)^2];
    end
    
end 
helloworld

%% assignment Q2

% write code to count how many elements in the vector are bigger than the
% previous element in the vector (compare each pair)
% there are multiple ways to do this!
% if your code is correct, the answer is 4 
count = 0;
vector_q2 = [2 6 7 2 3 1 7]
for i = 2:length(vector_q2)
    if vector_q2(i) > vector_q2(i-1)
        count = count + 1;
    end 
end 

count