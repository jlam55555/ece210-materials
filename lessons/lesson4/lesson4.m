%% Lesson 4
%
% In this lesson we will cover:
%
% - Control sequences (for, while, if, try, catch)
% - Plotting
%
%% Control Sequences
%
% Similar to C, MATLAB has control sequence commands. Last class we
% explored for loops and the difference between for loops and
% vectorization. Even though vectorization is more computationally 
% efficient than loops, sometimes for loops, and other control sequences,
% are necessary, such as to perform simulations. However, assuming that
% everyone has an understanding of control sequences, I would not delve
% too deep into the discussion of the mechanics of if and while statements,
% but rather, I would show you the semantics of the statements. 

%% For loops (A review)

total=0;
for i=1:10
    total = total + i;
end
total

%% If...Else Statements

vgpa = 1.76;
wgpa = 2.52;
xgpa = 3.55;
ygpa = 3.76;
zgpa = 3.83;
gpa = vgpa;
if gpa < 2
    fprintf('You are in DANGER!!!\n')
elseif gpa >= 2 && gpa < 3.5
    fprintf('You are safe.\n')
elseif gpa >= 3.5 && gpa < 3.7
    fprintf('Cum Laude\n')
elseif gpa >= 3.7 && gpa < 3.8
    fprintf('Magna Cum Laude\n')
elseif gpa >= 3.8 && gpa < 4
    fprintf('Summa Cum Laude\n')
else
    fprintf("invalid gpa\n")
end

%% While loop

total=0;
i=0;
while i<=10
    total = total + i;
    i = i+1;
end
total

%% Try and Catch blocks
%
% Try and catch blocks are particularly useful if you don't know whether a 
% certain statement would occur and the new code depends on that certain 
% line of code. Try and catch allows you to "catch" errors and display 
% error statements.

try
    a = [1 2; 3 4];
    b = [1 2 3 4];
    c = a*b          % Can't do this! not the same dimensions!
catch err
    fprintf('You are trying to do something which is not allowed');
    % you can check documation for more things you you can do and
    % information you can get from the error
end

%% Plotting
%
% We are going to go through several plotting schemes, and explore how you
% can customize plotting. We would go through 2D plotting, surface
% plotting, subplot, stem plot and 3D plotting

%% 2D plotting

x = -10:0.1:10;
y = x.^3;
plot(x,y,'DisplayName','x^3');              % plotting line graph
xlabel('x axis');
ylabel('y axis');
title('Example 1');
grid on;
%axis([-10 10 -10 10]);
xlim([-10 10]);
ylim([-10 10]);

hold on;    % plotting more than 1 plot on 1 figure rather than overwriting

y2 = x.^2;
plot(x, y2, 'DisplayName','x^2');
legend('show');                             % 'DisplayName does this

%%
% Example 2: Plotting sine and cosine

t = 0:.1:10;
d1 = sin(t);
d2 = cos(t);

figure 
% plot(t,[d1.' d2.']) % plot(t,d1,t,d2)

% plot(t,d1,t,d2)
hold on;
plot(t, d1);
plot(t, d2);
hold off;

title('Trig Functions')
xlabel('time \mus') % \mus is a special symbol. Other examples include:
                    % \beta, \pi, \leq, \infty 
ylabel('voltage')
legend('sin','cos')

exportgraphics(gcf(), "test.png")

%% Here we are going to get a bit fancy and change up some stuff. 
figure;

plot(t,d1,'b-.',t,d2,'rp') % We are changing up the line pattern and color
title('Trig Functions')
xlabel('time \mus') % \mus is a special symbol. Other examples include:
                    % \beta, \pi, \leq, \infty 
ylabel('voltage')
legend('sin','cos')
xticks(0:pi/2:10)
xticklabels({'0','\pi/2','\pi','3\pi/2','2\pi', '5\pi/2','3\pi'})

% Many other options availible for plotting. Check the documentation or
% search online for options.

%% Subplots
% Subplots exist for stylistic purposes. Let's say you have a signal and
% you want to plot the magnitude and phase of the signal itself. It would
% make more sense if the magnitude and phase plots exist in the same
% figure. There are several examples fo subplot below to explain how it
% works. Note that linear indexing of plots is different from normal linear
% indexing.

figure;
subplot(2,2,1)                    % subplot(# of rows, # of columns, index)
plot(t,d1)
hold on;
plot(t,d2)
title('Normal plot')

subplot(2,2,2)                    % index runs down rows, not columns!
plot(t,d1,'b-.',t,d2,'rp')
title('Customized plot')

% Stem plots
% stem plots are particularly useful when you are representing digital
% signals, hence it is good (and necessary) to learn them too!
% subplot(2,2,[3 4])                % takes up two slots
subplot(2, 1, 2);
stem(t,d1)
hold on;
stem(t,d2)
title('Stem plots')

sgtitle('Subplots')

%% Tiling -- like subplots
figure();
tiledlayout(2, 2);

nexttile();
plot(t, d1);

nexttile();
plot(t, d2);

%% 3D and surface plots

% 3D plotting (curves): The helix
t = linspace(0,10*pi);
figure;
plot3(sin(t),cos(t),t)
xlabel('sin(t)');
ylabel('cos(t)');
zlabel('t')
text(0,0,0,'origin')
grid on;
title('Helix')

%% Surface plot
a1 = -2:0.25:2;
b1 = a1;
[A1,B1] = meshgrid(a1);
% Here we plot the surface of f(x) = x*exp^-(x.^2+y.^2)
F = A1.*exp(-A1.^2-B1.^2);
figure;
surf(A1,B1,F)

%% Mesh plot
% A different look
figure;
mesh(A1,B1,F)
