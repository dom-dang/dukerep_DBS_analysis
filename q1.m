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
q1_matrix = myFirstFunc(q1_matrix); 

% print q1_matrix in the command window to check if you got the right
q1_matrix

%% insert code here for "myFirstFunc" from Q1

function in = myFirstFunc(in)
    for i = 1:size(in,1)
        if sum(in(i,:)) > 100
            for d = 1:length(i)
                in(i, d) = 5.*in(i,d)^(1/2);
            end
        end 
    end
end 
    