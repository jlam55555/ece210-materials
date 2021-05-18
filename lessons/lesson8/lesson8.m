clear; clc; close all;

%% Symbolic Toolbox
% The symbolic toolbox is useful if you want an exact expression of a
% function. In MATLAB, we often numerically evaluate functions, hence the
% symbolic toolbox could be useful in providing analytic solutions (when it
% can). You can think of it as storing the structure of an expression for
% evaluation using placeholders for the variables.

%% Create symbolic variables
syms x z

%% Creating expressions
v = x + 2
w = x*z

%%
subs(v,x,3)

%%
syms r
subs(w,z,r)

%% Solve
solve(x + 3 == 5,x)

%%
syms a b c 
solve(a*x^2 + b*x + c,x)

%%
eqs = [x + z == 14, x - z == 6]
soln = solve(eqs,[x z])
soln.x
soln.z

%% set assumptions on a symvar
syms n positive
solve(n^2 == 4,n)

% this is the shorthand syntax; see also assume() function

%% Simplify
simplify(exp(log(x)))

% also simplifyFraction for more efficient simplification of fractions only

%% Collect
collect((x + 2)*(x + 3),x)

%% Combine
% tries to rewrite products of powers in the expression as a single power
combine(x^4*x^3)

% Has other options such as 'log' and 'sincos'

%% Expand
expand((x + 5)^3)

% similar to collect, but expands all variables

%% Partfrac
partfrac((x^7+x^2)/(x^3 - 3*x + 2))

%% poly2sym and sym2poly
p = [1 2 3 4];
psym = poly2sym(p,x)

%%
q = sym2poly(psym)

%% Create symbolic functions
syms f(y)

f(y) = y^2;

f(4)

%% Compose
syms g(y)
g(y) = sin(y);

h = compose(f,g)

%% finverse
f(y) = exp(y);

finverse(f)

%% Differentiation
syms x y z
v = x^2 + 16*x + 5;
dvdx = diff(v)
dvdx_3 = subs(dvdx, x,3)

%% Partial differentiation
w = -x^3 + x^2 + 3*y + 25*sin(x*y);
dwdx = diff(w,x)
dwdy = diff(w,y)

% third order derivative w.r.t. x
dw3dx3 = diff(w,x,3)

% warning: diff assumes derivatives commute (ie 2nd partials exist and
% cont.)

% Vector operations exist as well such as: curl, divergence, gradient,
% laplacian, jacobian, hessian...

%% Diff eq
syms y(t) a
dsolve(diff(y) == a*y,t)

%%
dsolve(diff(y) == a*y,y(0) == 5)    % with initial conditions

%% Integration
v = x^2 + 16*x + 5;
V = int(v)

%% Integration with limits
syms a b
Vab = int(v,a,b)

%%
V01 = int(v,0,1)

%% z transform
syms a n z
f = a^n;
ztrans(f)

%%
% Can even handle matrices!
syms m
n = 4;
A = m.^((0:n)'*(0:n))
D = diff(A)

%% BE CAREFUL!
% Although we have used diff before, the diff used previously and the diff
% used in this context is not the same. Type 'help diff' and 'help
% sym/diff' (or 'help sym.diff') if you want to learn more about it!

%% Laplace Transform
syms t a s
f = exp(-a*t);
laplace(f)

%% Inverse Laplace Transform
ilaplace(-4*s+8/(s^2+6*s+8))

%% Fourier Transform
f = dirac(x) + sin(x);
fourier(f)

%% Inverse Fourier Transform
syms w

% fourier transform of cosine(t)
expr = dirac(w+1) + dirac(w-1);
ift = ifourier(expr)
simplify(ift)

%% Note: performance
syms x v
v = x^3 + 5*x^2 - 3*x + 9;
t = 1:1e4;

tic;
X = t.^3 + 5*t.^2 - 3*t + 9;
toc;

tic;
Y = subs(v,x,t);
toc;

% symbolic computation and data structures are expensive! Use sparingly!