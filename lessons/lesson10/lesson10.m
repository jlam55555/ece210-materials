%% State Space
% ref: https://www.mathworks.com/help/control/ref/ss.html

% m input variables
% p output variables
% n state variables

% System can be represented as four matrices:
%    n m
% n[ A B ]
% p[ C D ]
% 
% Where,
% A nxn
% B nxm
% C pxn
% D pxm

%% Discrete
% x[n+1] = Ax[n] + Bu[n]
% y[n] = Cx[n] + Du[n]
%
% or in the Z domain,
% zX(z) = AX(z) + BU(z)
% Y(z) = CX(z) + DU(z)

% State transition matrix: Phi(n) = A^n

% If 0 input: x[n] = A^n*x[0]
% Need |eig(A)| < 1

A = [1/5 1/3; 1/2 2/3]; % stable
% A = [1 1/3; 1/2 2/3];  % unstable
eig(A)                  % computes the eigenvalues of a matrix

t = 1:1000;
v = zeros(1,1000);
An = A;
for i = 1:1000
    An = An*A;
    v(i) = norm(An,'fro');
end

figure;
semilogy(t,v);

%% ss2tf
% SISO
B = [1 ;1]; % 2x1 -> 1 input
C = [1 1];  % 1x2 -> 1 output
D = 0;

% Remember: H(z) = C((zI-A)^-1)B+D
[b,a] = ss2tf(A,B,C,D);

[z,p,k] = tf2zpk(b,a)   % poles = eig(A)

%% MIMO
% With MIMO systems, there is a transfer function for each input -> output.
% Thus the transfer function is actually a transfer function matrix, each
% entry being a transfer function between an input an output.
% We represent the transfer function from input j to output i by Hij.

% 2 inputs, 2 outputs
B = eye(2);
C = eye(2);
D = zeros(2);

[b,a] = ss2tf(A,B,C,D,2)

% Here there are 2 inputs and 2 outputs. For ss2tf, you can't return a
% whole transfer function matrix. You can only return the transfer
% functions for each input separately.
% Here, there are 2 transfer functions for each input since there are 2
% outputs. The denominator vector, a, is shared between the transfer
% functions and the numerators are stored in a matrix with row j
% corresponding to Hij

%% tf2ss
% Only one input
b = [0 2 3; 1 2 1];
a = [1 0.4 1];

[A,B,C,D] = tf2ss(b,a)

%% Continuous
% x'(t) = Ax(t) + Bu(t)
% y(t) = Cx(t) + Du(t)

% State transition matrix: Phi(t) = e^At

% If 0 input: x(t) = e^At*x(0)
% Need Re(eig(A)) < 0

% A = [1/5 1/3; 1/2 2/3];     % unstable
A = [-1/5 1/3; -1/2 -2/3]; % stable
eig(A)

t = 1:1000;
v = zeros(1,1000);
for i = 1:1000
    Aexp = expm(A*i);
    v(i) = norm(Aexp,'fro');
end

figure;
semilogy(t,v)

% Similarly, the transfer function matrix for the state space system is:
% H(s) = C((sI-A)^-1)B+D.

%% State Space Example
x = ones(3,1);  % state variables

%%
load A.mat
abs(eig(A))

%%
C = [1 -1 1;
     0 1 0;
     0 -1 0];
 
B = [1/4 1/4 0;
     1/4 1/2 1/4;
     0 1/4 1/2];
 
D = eye(3);

%% Simulating State Space
X = zeros(100,1);
Y = X;
Z = Y;
U = Z;
V = U;
W = V;
for k = 1:10000
    u = zeros(3,1);     % input
    y = C*x + D*u;
    x = A*x + B*u;
    X(k) = real(x(1));
    Y(k) = real(x(2));
    Z(k) = real(x(3));
    U(k) = real(y(1));
    V(k) = real(y(2));
    W(k) = real(y(3));
end
%%
plot([X,Y,Z])
legend('X','Y','Z')
%%
plot([U,V,W])
legend('U','V','W')
%%
comet3(X,Y,Z)

%%
comet3(U,V,W)
