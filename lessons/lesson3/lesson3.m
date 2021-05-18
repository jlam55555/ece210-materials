%% Lesson 3
%
%% Review of Basic Indexing
x = [2 4 8 16 32 64 128]
x(3)
x(4:6)
x(:)
x(end)

%% Vectors indexing vectors
% You can use a vector to index another vector. This can be useful if there
% is a specific index pattern you want from a vector

x([1 3 5 7])           % Returns a vector with the 1st, 3rd, 5th, and 7th
                        % entries of x
x(1:2:7);               % Same thing uses the colon operator to create the
                        % index vector
x([2:4 3:6]);
x([1:4]) = 7;           % Changes the values from the 1st and 4th entries
                        % of x to 7

%% Indexing matrices with 2 subscripts
% You can index a matrix using two values as one would normally do

A = [16 2 3 13; 5 11 10 8; 9 7 6 12; 4 14 15 1]

A(1,1);                 % Returns entry in first row and first column
A(1:3,1:2);             % Returns the entries in the first three rows AND
                        % first two columns
A(end,:);

% What if I want to index the (2,1), (3,2), (4,4) entries?

A([2 3 4],[1 2 4]);     % Will this work?

%% Linear Indexing
% Instead you should index linearly! Linear indexing only uses one
% subscript

A(:)                    % What does this return and in what form and order?
%%
% Matlab linearly indexes a matrix by going down the columns one by one
%%
A(14)                   % What value does this return?

%%
% So to do what we had set out to do earlier we need to index like this:

A([2 7 16])

%%
% But lucky enough, MATLAB has a function that would calculate the linear
% index for you!

ind = sub2ind(size(A),[2 3 4],[1 2 4])
A(ind)

%% Logical Indexing
% Before we discuss logical indexing, we need to address the idea of logic
% in MATLAB. You should all know what and, or, and not is from DLD. In
% MATLAB, you can apply such concepts for logical arrays. Logical arrays
% are arrays of 0(false) and 1(true). Note that an array of 0 and 1 might
% not necessary be a logical array, but you can convert a normal array to a
% logical array.

B = eye(4)               % Regular identity matrix
C = logical([1 1 1 1; 1 0 0 0; 1 0 0 0; 1 0 0 0]) % Logical entries
islogical(B);

islogical(C);

%%
B = logical(B);               % Converts B into a logical array

%%
% Elementwise logical operators
B & C;                    % and(B,C) is equivalent to B&C
B | C;                    % or(B,C) is equivalent to B|C
~(B & C);                 % not(and(B,C)) is equivalent to ~(B&C)
not(B & C);               % you can use both representations intermittenly

%%
true(2,5);                % creates a 2x5 logical matrix of trues(1s)

%%
false(2,5);

%%
not(2)                   % not logical entries

%%
not(0)

%% Logical Indexing **VERY IMPORTANT**
% Another indexing variation, logical indexing, has proven to be both
% useful and expressive. In logical indexing, you use a single, logical
% array for the matrix subscript. MATLAB extracts the matrix elements
% corresponding to the nonzero values of the logical array. The output is
% always in the form of a column vector. For example, A(A > 12) extracts
% all the elements of A that are greater than 12.

A(A > 12)               % returns entries of A which are greater than 12 in
                        % a column vector

%%
% Let's see how MATLAB does this

A > 12                  % returns a logical array with entries
                        % corresponding to the entries of A

%%
% When an array is indexed with logicals, MATLAB converts the logical array
% into a vector of linear indices corresponding to the linear indices of
% the trues in the logical array

A(ans)

%%
% To return the linear indices, use find which returns nonzero indices

find(A > 12)

%% Functions
% In MATLAB, there are 2 types of functions -- anonymous functions and
% normal function. Writing functions is very important in MATLAB. Namely,
% if you have 10 lines of code that is going to be applied 1000 times with
% different variables names, you shouldn't have to write 10,000 lines of
% code! There are 2 types of functions in MATLAB, namely anonymous and
% normal functions.

%% Anonymous Functions
% Anonymous functions are functions that do not need a separate file,
% however they must be one line

cube = @(x) y + x.^3;

f = @(x, y) x.^2 + y.^2;

% cube is the function handler which is created by the @ symbol. The input
% variables are listed in the parentheses separated by commas

a = 4;
cube(a);

% Existing variable can also be included in the anonymous function. See the
% MATLAB documentation for more details regarding this and other
% information regarding anonymous functions

%%
HelloWorld("Jon", "Lam");

%%
distance(3, 4)
myFunction()

%% Normal Functions
% Normal functions are usually placed in a separate file. To call a
% function in a separate file, the file must be in the same folder or added
% to the MATLAB path.

% Functions have their own workspace so you cannot reference variables
% in a function which haven't been initialized in the function yet.

% Additionally, functions can be placed at the end of a normal MATLAB
% script file, see the documentation for more details

% There are also things called private functions which have additional
% restrictions to them, see the documentation for more details

function [res1, res2] = HelloWorld(name1, name2)
    fprintf("Hello, world! %s %s\n", name1, name2);
    res1 = 3;
    res2 = [5 6];
end