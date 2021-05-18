%% Lesson 5
%
% In this lecture we will be discussing
%
% - MATLAB datatypes
% - MATLAB character arrays and strings
% - MATLAB Object-Oriented Programming
% - File I/O in MATLAB

%% Data Types
%
% There are several basic data types in MATLAB:
%
% - single, double (floating pt. 32 and 64 bit respectively)
% - int8, int16, int32, int64 (different size integers)
% - uint8, uint16, uint32, uint64 (different size unsigned intergers)
% - logicals
% - char arrays, strings
% - cell arrays

%%
% You can get the data type of a variable using the class function.

a = 10;
class(a)

%%
b = int8(a);
class(b)

%% Data Type Sizes
% Different data types take up different amounts of space in your memory
% and hard drive.  Let's take a look at some standard sizes in MATLAB.

clear
A = randn(1,'double');
B = randn(1,'single');
C = true(1);
D = 'D';

%%
whos                              % lists info of the variables in the current workspace

% If your data is getting to large, it can help to cast as a single.
% Logicals take up a whole byte.

%% Different Interpretations
% Be careful with what data types you feed into built in functions.
% MATLAB will have different responses to different types.

imshow(uint8(255*rand(128,128,3)))

%%
imshow(double(rand(128,128,3)))

%% Overflow and Underflow
% With floating point, we are trying to represent real numbers.  Obviously
% there must be some spacing between representable numbers, let's take a
% look.

L = logspace(-400,400,4096);
loglog(L,eps(L),single(L),eps(single(L)))

% As the plot proves, doubles have a much larger extent as well as more
% precision at each point.  Let's see how this applies in practice.

%%
eps(1)

%%
(1 + 0.5001*eps(1)) - 1   % Some rounding errors

%%
(1 + 0.4999*eps(1)) - 1

%%
1 + 1e16 == 1e16

%%
single(10^50)             % Overflow!

%%
single(10^-50)            % Underflow!

%%
uint8(256)

%%
int8(-129)

%% Cell Arrays
% Cell arrays are useful when you have data that is not well structured.
% However, it is also relatively slow and hard to deal with compared to
% matrices.  You should use them sparingly.

courses = {'', 'Modern Physics', 'Signals and Systems', ...
           'Complex Analysis', 'Drawing and Sketching for Engineers';...
           'Grades', 70 + 3*randn(132,1), 80 + 3*randn(41,1), ...
           40 + 3*randn(20,1), 100*ones(29,1);...
           'Teachers', {'Debroy';'Yecko'},{'Fontaine'},{'Smyth'},{'Dell'}}
       
%% Difference between {} and ()
courses(1,2)
courses{1,2}
courses{2,2}(3:5,1)
courses(3,2)
courses{3,2}
courses{3,2}{1}(1)

%% Character Arrays and Strings

clear
myString = 'Hello World!';
whos

%%
stem(uint16(myString))
title([myString '''s' ' Numeric Code'])

%% sprintf
% The sprintf function is useful in formatting strings to be output like
% you would in C.

numberOfStudents = 20;
section = 'B';
averageGrade = mean(40 + randn(numberOfStudents,1));
sprintf('There are %d students in physics section %s with an average grade of %0.2f',...
        numberOfStudents,section,averageGrade)

%%
numberOfStudents = 41;
averageGrade = mean([-inf; 80 + randn(numberOfStudents,1)]);
sprintf('There are %04d students in signals with an average grade of...\n %0.2f',...
        numberOfStudents,averageGrade)
    
%%
plotTitles = ['Hello World!';...
              'This will never ';...
              'work!'];
          
%% String Arrays

plotLegends = [string('Hello World!');...
string('This will indeed ');...
string('work')]

%%
% or better

plotLegends = ["Hello World!";...
"This will indeed ";...
"work"]

%%
plot(rand(10,3))
legend(plotLegends)

%%
plotLegends(3)
plotLegends{3}(4)

% Why does the above work? Per the docs, "You can index into a string array
% using curly braces, {}, to access characters directly. Use curly braces
% when you need to access and modify characters within a string element.
% Indexing with curly braces provides compatibility for code that could
% work with either string arrays or cell arrays of character vectors. But
% whenever possible, use string functions to work with the characters in
% strings."

%% Parsing
% Using split, you can separate strings into a cell array or string array
% based on certain qualifications, most commonly whitespace.

t = ['The rain in Spain stays' newline 'mainly in the plain.']

split(t)
split(t,'n')

% You can also return the delimiters if you want
[cellArray, delimiters] = split(t,{'n' 'h'})

% You can also use the function strsplit, but it's not recommended
strsplit(t)

%% Finding Substrings
% In a similar fashion, you can search for patterns in strings using
% strfind.

idx = strfind(t,'in')          % indices of where substring is in the string

%% Objects and Classes
% MATLAB is an OOP language, the variety of toolboxes that MATLAB has
% (machine learning, filter, even fixed point numbers) are enclosed in
% classes. You might not need to write your own classes in your years of
% Cooper, but understanding how classes work in MATLAB would allow you to
% use those toolboxes effectively and efficiently.

x = randn(10000,1);
h = histogram(x);          % h is a histogram class

properties(h)

methods(h)

% Check out the documentation for more info on this histogram class and
% other classes

%% Structs and Objects
% Another thing you can write in MATLAB are your own structs. Structs are
% mini versions of objects. The main  difference is that objects have
% classes but structs do not. To make your own structs, you can do the
% following

sfield1 = 'a'; svalue1 = 5;
sfield2 = 'b'; svalue2 = [3 6];
sfield3 = 'c'; svalue3 = "Hello World";
sfield4 = 'd'; svalue4 = {'cell array'};

s = struct(sfield1,svalue1,sfield2,svalue2,sfield3,svalue3,sfield4,svalue4)

%%

s.a
s.b(2)

%% Struct with nonscalar cell array

tfield1 = 'f1';  tvalue1 = zeros(1,10);
tfield2 = 'f2';  tvalue2 = {'a', 'b'};
tfield3 = 'f3';  tvalue3 = {pi, pi.^2};
tfield4 = 'f4';  tvalue4 = {'fourth'};
t = struct(tfield1,tvalue1,tfield2,tvalue2,tfield3,tvalue3,tfield4,tvalue4)

%%
t(1)
t(2)

%%
% You can also create and fill a struct using dot notation
u = struct;
u.a = [1 3 5 7];
u.b = ["Hello","World!"];
u

%% File I/O
% Very often, you would need to process files that are not already in
% MATLAB. For instance, if you have a commo separated value file (csv),
% you would need to find a systematic way to load all your data into
% MATLAB. Moreover, you might also want to export figures and data from
% MATLAB, hence the need to learn file IO. I am only convering a subset of
% file IO in this MATLAB, more information can be found in the
% documentation.

%% Importing Data
load('mypic.mat');                % Import a .mat file

%%
fileID = fopen('grades.txt');             % Returns file indentifier >= 3 (0 = stdin, 1 = stdout, 2 = stderr)
C_text = textscan(fileID,'%s',4,'Delimiter','|')    % Import a textfile
C_data0 = textscan(fileID,'%d %f %f %f')
C_data0{1}

%% Exporting Data
save('allData')                  % saves your whole workspace into a .mat file

%%
fileID = fopen('myFile.txt','w');
fprintf(fileID,'1 Januar 2014, 20.2, 100.5 \n');
fprintf(fileID,'1 Februar 2014, 21.6, 102.7 \n');
fprintf(fileID,'1 März 2014, 20.7, 99.8 \n');
fclose(fileID);

%% Reading audio signal
[y, fs] = audioread("hallelujah.wav");

%% Playing an audio signal
soundsc(y, fs);

%% Exporting an audio signal
audiowrite("mySong.wav", y, fs);