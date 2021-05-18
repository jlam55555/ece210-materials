%% Lesson 10
clc; clear; close all;

%% Objectives:
% This will be a "cheat sheet" of everything we've learned this semester!
% - Review of all old lessons
% - Introduce MATLAB App Designer

%% Lesson 1: The Basics
% Basic operators, number representations
% + - * / % \ ^
(1+2j)^3;

% constants
% - pi, i (j)
i^(pi*2j);

% math functions
% - trig functions (sin, cos, atan, atan2, sinc)
% - complex number operators (real, imag, conj, angle, abs)
conj(1-2j);
angle(exp(3j));

% good practice
% - use sections and comments appropriately
% - put at top of every script file:
%       clc; clear; close all;

% matrix operations
% - basic matrix notation
% - elementwise +/-, elementwise .*, ./, .^
% - matrix *, ^
% - transpose A.'
% - conjugate transpose A'
% - matrix functions (trace, size, eye, magic, ones, zeros, repmat)
A = magic(5);
B = randi(5, 5);
A * B;
A .* B;

% generating matrices
% - linspace
% - colon operator
% - zeros/ones
range1 = linspace(0, 1, 1000);
range2 = 0:1e-3:1;

% notes on syntax
% - matrix rows can be comma- or space-delimited
% - semicolon to suppress output
% - double %% (followed by space) at beginning of line to indicate section
% - can break lines using ellipsis (...)
% - parentheses sometimes optional: hold on is equivalent to hold('on');

%% Lesson 2: Vectorization and For Loops
% Functions often can have vector inputs, will return vector outputs
t = linspace(1,10,1e3);
y = sin(t);

% Some more vector operations
% - sum, diff, cumsum, trapz, min, mean, geomean
sum(1:100);

% Numerical integration and differentiation
dx = 1e-3;
x = 0:dx:1;
y = x .^ 2;
y_integral = cumsum(y) * dx;
y_derivative = [0 diff(y)] / dx;
plot(x, y, x, y_integral, x, y_derivative);
legend('y', 'integral of y', 'derivative of y');

% Meshgrid
a = 1:3;
b = 4:5;
[A, B] = meshgrid(a, b);
Y1 = 2*A + 3*B;

% broadcasting
Y2 = 2*a + 3*b.';

% Basic indexing and some matrix operations
% - (see next section)
% - can extend or delete parts of matrix like so:
A = [1; 3];
A(:,2) = [2; 4];
A(1,:) = [];

% For loops: iterate over a range
% - meh performance
% - typically better to vectorize when possible
% - preallocate when using a loop

%% Lesson 3a: Indexing
% Basic indexing
% - Index with a scalar or vector
% - Indexing begins at 1, ends at special keyword "end"
% - Index each dimension independently
A = magic(5);
A(end, 1);
A(:, 2);
A(1:3, 3:end);

% Linear indexing
% - Can index N-D array with single index
% - Column-major order
% - Use sub2ind to convert indices to linear indices
A(:);
A(5);

% Logical indexing (very important for vectorization!)
% - Use a logical operator or function that returns a logical array
% - This logical array can be used to index itself or other arrays
% - Find returns all true indices in logical array
A > 5;
A(A > 5);

B = A-5;
B(A > 5);

find(A > 5);

%% Lesson 3b: Functions
% Anonymous functions
% - More concise (but limited to single line)
% - Can capture outside variables
f = @(x) x.^2;

% "Regular" functions
% - Can be at bottom of file or in other file
% - If in other file, only first function is public, should be same
%   name as the file
% - syntax:
%       function [returnVal1, returnVal2] = functionName(param1, param2)
%           doSomething();
%           returnVal1 = someValue;
%           returnVal2 = someValue;
%       end

%% Lesson 4a: Control Flow Statements
% for loop iterates over a range
for i=1:5
    i
end

% while iterates while condition is true
i=1;
while i<=5
    i
    i = i+1;
end

% if/elseif/else does exactly what you think it does
if i < 2
    'i < 2'
elseif i < 5
    '2 <= i < 5'
else
    'i >= 5'
end

%% Lesson 4b: Plotting
% Functions
% - 2D: plot, stem, scatter, histogram
% - 3D: plot3, surf, mesh
samples = randn(1000, 1);
histogram(samples);

% Figures
% - subplot() and tiledlayout()/nexttile()
% - title, xlabel, ylabel, xlim, ylim, legend
% - grid on/off, axes on/off
% - hold on/off
% - Special characters in figure text (e.g., \mu)

%% Lesson 5a: Datatypes
% Datatypes (may not be exhaustive):
% - real numbers (floating-point): double, single
% - integers: (u)int8, (u)int16, (u)int32, (u)int64
% - logical (boolean)
% - cell array
% - string
% - symbolic (lesson 8)
% - structs and objects
log = logical([0 1 0 1]);   % converting data types

% Find information about variables using whos()
A = 4;
whos A; % or whos('A')

% Be careful of datatypes! Choosing the wrong data type can:
% - Cause a parameter to a function to be treated incorrectly
% - Have too little precision (=> overflow or underflow)
% - Take up too much space (=> run out of RAM)

%% Lesson 5b: Strings and Cell Arrays
% "hello" and 'hello' are different!
% - left is a string, right is a char array
% - left is a single unit, right is equivalent to ['h' 'e' 'l' 'l' 'o']
% - both are USUALLY interpreted the same, but not always. Consider:
["hello" "world"]   % array of strings
['hello' 'world']   % same as horcat(['h' 'e' 'l' 'l' 'o'], ['w' ... 'd'])

% functions for strings or char arrays
% - split, strfind, strip

% most of the time, we use "arrays" (or "matrices") to store a list of data
% - however, this only allows for a single data type
% - cell arrays overcome this limitation, allowing heterogeneous datatypes
% - use () to index a cell in a cell array, {} to index the CONTENTS of
%   a cell in a cell array (similar to pointer indexing in C)

%% Lesson 5c: Object-Oriented MATLAB (Classes, Objects and Structs)
% keep multiple values together under a composite variable

% structs have their structure defined on the spot
% - like an object literal in other programming languages like Javascript
% - multiple syntaxes: refer to lesson 5

% objects are defined via a "class" ("prototype" of the object)
% - classes can both have data and function members
% - refer to lesson 5 for syntax
% - we'll see this when we go over App Designer today

%% Lesson 5d: Basic File I/O
% (lesson 5 really ought to be split over two lectures)

% text I/O
% - fopen, fread, fprintf, fclose, textscan

% audio I/O and playback
% - audioread, audiowrite
% - sound, soundsc

% image I/O and viewing
% - imread, imwrite
% - imshow

% saving/loading workspace variables (.mat is optional)
% - save someFile.mat
% - load someFile.mat

%% Lesson 6: The z-domain
% dealing with polynomials (numerically):
% - polyval, roots, poly, residue, conv (multiplying polynomials)

% z-transform
% - multiple ways to represent a (discrete-time) system:
%   - transfer function (tf) coefficients: b=denominator, a=numerator
%   - zeros-poles-gain (zpk)
%   - second-order sections (SOS)
%   - impulse response (impz)
% - convert between these! zpk2tf, tf2zpk, tf2sos, etc.

% plot information about a system:
% - zplane: pole-zero plot (determine stable/causal)
% - freqz: frequency response plot
% - impz: impulse response

% laplace transform
% - many similarly-named functions, e.g., freqs
% - we usually do things in z-domain b/c samples are discrete (digital)

%% Lesson 7: Filters and the Filter Designer
% filterdesigner
% - design and export filter
% - apply filter using filter()

% manually design filter
% - for common IIR filters (ellip, cheby1, cheby2, butter), have to first
%   design order (ellipord, cheby1ord, ...)
% - apply filter using filter()

% plotting FFT
x = randn(100000, 1);
Fs = 50e3;

FFT = fftshift(fft(x)) / Fs;
f = linspace(-Fs/2, Fs/2, length(FFT));
figure();
subplot(2, 1, 1);
plot(f, 20*log10(abs(FFT)));
subplot(2, 1, 2);
plot(f, unwrap(angle(FFT)));

%% generate an elliptic filter, save to elliptic.m
filterDesigner;

%%
y = filter(elliptic(), x);

FFT = fftshift(fft(y)) / Fs;
f = linspace(-Fs/2, Fs/2, length(FFT));
figure();
subplot(2, 1, 1);
plot(f, 20*log10(abs(FFT)));
subplot(2, 1, 2);
plot(f, unwrap(angle(FFT)));

%% Lesson 8: The Symbolic Toolbox
% syms
% - lots of new functions: subs, solve, collect, combine, expand, partfrac
% - restrict solution set by setting "assumptions" on symbolic variables
syms x y;
x = y+2;

% symbolic functions
% - compose, finverse, diff, int, dsolve, ztrans, laplace, ilaplace
f(y)=2*y;

%% Lesson 9: Stochasticity
% Use vectorization and logical indexing to improve performance and keep
% code neat and concise

% functions to randomly sample from different distributions:
% - rand, randi, randn
% - unidrnd, exprnd, poissrnd, normrnd, etc.

% expected value of the sum of M D-sided dice roles
N = 1e5;
D = 6;
M = 10;
samples = randi(D, N, M);
mean_sum = mean(sum(samples, 2));

% PDF of distributions
% - unidpdf, exppdf, poislesson11spdf, normpdf, etc.
x = -3:1e-3:3;
plot(x, normpdf(x, 0, 1));

%% Lesson 10: App Designer (Today's Lesson)

% We know how to use MATLAB in from MATLAB scripts in the MATLAB editor,
% but what if we want to be able to run a MATLAB program from a GUI
% (graphical user interface)?

% MATLAB "Apps" allow you to do this. MATLAB apps, like the Filter Designer
% App we've used, allow you to design a graphical application using MATLAB
% logic. You can deploy it so that users can use it in MATLAB (like the
% filter designer tool), or you can even deploy it outside MATLAB as a web
% application or standalone desktop application!

% What's more, it's easy to design an app in MATLAB using the appdesigner()
% tool. All you need to do is drag-and-drop GUI components and add handlers
% (callbacks), and then you're done! You can then export it to a .m file,
% share it as a MATLAB App, or distribute it as a web app or executable.
appdesigner;