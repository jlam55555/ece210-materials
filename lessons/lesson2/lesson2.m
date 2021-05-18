%% Lesson 2
%
% Objectives:
% * Understand how to perform vector operations in MATLAB
% * Understand arithmetic and basic functions in MATLAB
% * Know how to use for statements

clc; clear;

%% Vector Operations
% In lesson 1, we see how to make a vector with the colon operator and
% linspace, however, if MATLAB only allows us to use these two operations
% on vectors, it would be pretty useless. MATLAB is often used to perform
% numerical analysis, hence it would be very useful if we can input vectors
% into functions and use that to generate another vector. Luckily, that's
% what MATLAB is for! Note that when you perform an operation, they are
% element wise operation for vectors. 

x = 0:0.01:2*pi;    % You create a vector
y = sin(x);         % Here, you perform a transformation from one vector
                    % to another
xlen = length(x)
ylen = length(y)    % xlen and ylen is equal!
plot(x,y)
title('y vs. x')

%% Exercise 1 : Vector Operations
T = 1e-6;
t = 0:T:2e-3;
f0 = 50;
b = 10e6;
y1 = 10*cos(2*pi*f0*t + pi*b*t.^2);

figure;
plot(t,y1)

%% Basic Indexing in MATLAB
% To inspect certain values in vectors x and y, we can use indexing. Note
% in MATLAB, indices start at 1, not 0. Hence in matlab, the last index 
% would be the length of the vector itself.

%% Exercise 2 : Basic Indexing

x(1)                    % first element of x
x(1:3)                  % elements 1,2 and 3 (inclusive!)
x(:)                    % entire x
x(end)                  % last element of x
 
%% Other vector operations
% Of course, we can perform more complicated arithmetic operations on
% vectors, just like what we can do with scalars. What's more, there are
% pre-built functions in matlab that allows us to obtain certain
% statistics. There's a lot of such functions but we are only showing a few
% commonly used operations here

sum(x)                  % sum of the elements of x
mean(x)                 % average of the elements of x
min(x)                  % minimum element of x
diff(x)                 % difference between adjacent elements of x

%% Practical example of vector operations: Numerical Estimation of
% integrals and derivatives

%% Approximate Derivatives
% Here we will look at some approximate numerical methods
x = linspace(-2,2,100);
y = x.^2;
plot(x,y)
title('x^2')

%%
% Now, we can approximate the derivative as a quotient with small intervals
% 
% An easy way to do this in MATLAB is the diff command which returns the 
% difference between every pair of consecutive numbers in a vector (or each
% column of an array).
dydx = diff(y)./diff(x);
plot(x(1:end-1),dydx)          

%% Approximate Integrals
% Now suppose we want to approximate the cumulative integral of a function. 
% 
% The _cumsum_ function in MATLAB returns the running sum of a vector
% Use _cumsum_ to approximate the running integral of y.

%% Excercise 5. Cumulative Integral

Y = cumsum(y*(4/100));   % delta x = (2 - (-2))/100
plot(x,Y)

%% 
% Now, use the approximate derivative to get the original function, y back 
% as _yhat _and plot it.  You may need to use/create another variable for
% the x axis when plotting.
yhat = diff(Y)./diff(x);
plot(x(1:end-1),yhat)

%% Matrix
% Matrix is closely related to vectors, and we have also explored some
% matrix operations last class. This class, we are going to explore
% functions that are very useful but are hard to grasp for beginners,
% namely reshape, meshgrid, row-wise and column-wise operations.

%% Reshape
% When you are reshaping an array / matrix, the first dimension is filled
% first, and then the second dimension, so on and so forth

M = 1:100;
N1 = reshape(M,2,2,[]);    % It would create a 2*2*25 matrix
N2 = reshape(M,[2,2,25]);  % Same as N1
N2(:,:,25)                 % Gives you 97,98,99,100
N2(:,1,25)                 % Gives you 97 and 98

%% Meshgrid
% Meshgrid is quite hard to understand. Think of it as a way to replicate
% arrays, like the following example:
a = 1:3;
b = 1:5;
[A,B] = meshgrid(a,b)

%% 
% You have created two arrays A and B, note that in A, the vector a is
% copied row-wise, while the vector b is transposed and copied column-wise.
% This is useful, because when you lay one above the other, you essentially
% create a CARTESIAN PRODUCT, and it is useful when we need to plot a 3D
% graph.
% 
% Here is a more complicated example to show you when meshgrid is useful
a1 = -2:0.25:2;
b1 = a1;
[A1,B1] = meshgrid(a1);

% Here we plot the surface of f(x) = x*exp^(x.^2+y.^2)
F = A1.*exp(-A1.^2-B1.^2);
surf(A1, B1, F)

%% Row-wise / Column-wise operations
% Vector operations can also be performed on matrices. Often this either
% means the operation is performed on all the entries of the matrix as a
% whole or with respect to a certain dimension

H = magic(4)     % create the magical matrix H
sum(H,1)         % column wise sum, note that this is a row vector(default)
fliplr(H)        % flip H from left to right
flipud(H)        % flip H upside down
H(1,:) = fliplr(H(1,:)) % flip only ONE row left to right
H(1,:) = []      % delete the first row

%% Exercise 7 : Matrix Operations
H2 = randi(20,4,5)    % random 4x5 matrix with integers from 1 to 20
sum(H2(:,2))
mean(H2(3,:))
C = reshape(H2,2,2,5)
C(2,:,:) = []

%% Control Sequence - For loops
% Similar to other languages, MATLAB have if, while and for control
% sequences. For loops is one of the commonly used control sequences in
% MATLAB. We will continue the discussion of if and while in the next
% lesson

clear;
n = 100000;
% D = zeros(1,100000);    % This is called pre-allocation
                          % try uncommenting this line to see the
                          % difference
D(1) = 1;
D(2) = 2;
tic
for i = 3:n
    D(i) = D(i-1) + D(i-2);
end
toc

%% BE CAREFUL!
% For loops are considered the more inefficient type of operation in MATLAB 
% Do not use it unless it is completely necessary. The action of using
% vectors to perform operations is called VECTORIZATION. You are going to
% explore more on computational efficiency in the next lesson.