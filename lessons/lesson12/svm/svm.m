% simple SVM demo
% Jonathan Lam
clc();
clear();
close('all');

%% load data
% last column is features
xys = [
    0 3 -1;
    1 2 -1;
    2 1 -1;
    3 3 -1;
    5 1 -1;
    5 5 1;
    6 5 1;
    6 7 1;
    7 3 1;
    8 6 1;
    8 1 1;
];

x = xys(:, 1:end-1);
y = xys(:, end);

% separate positive and negative datapoints
posDps = x(y==1, :);
negDps = x(y==-1, :);

%% Showing the problem
figure();
hold('on');
scatter(posDps(:,1), posDps(:,2));
scatter(negDps(:,1), negDps(:,2));
hold('off');

%% SVM
n = size(xys, 1);

% generate matrices for minimization
P = (y * y.') .* (x * x.');
q = -ones(n, 1);

% generate matrices for inequality constraint (alpha >= 0)
% also can use LB parameter
A = -eye(n);
b = zeros(n, 1);

% generate matrices for equality constraint
Aeq = y.';
beq = 0;

% use quadprog package to generate alphas
alpha = quadprog(P, q, A, b, Aeq, beq, [], [], [], ...
    optimoptions('quadprog', 'Display', 'off'));

% calculate w from alpha
w = (x' .* y') * alpha;

% finding b parameter
% (y_n)(x_n * w + b) = 1 for (any) support vector, so b = y_n - w * x_n
svIndex = find(alpha > 1e-5, 1);
b = y(svIndex) - x(svIndex,:) * w;

% (for formulation with slack variable, see:
% http://ianyen.site/tutorial/SVM_Convex_Optimization.pdf#page=10)

%% display results
figure();
hold('on');
scatter(posDps(:,1), posDps(:,2));
scatter(negDps(:,1), negDps(:,2));

domain = (min(x(:,1)) - 1):(max(x(:,1)) + 1);
plot(domain, (w(1) .* domain + b)/(-w(2)));

% plotting gutters
plot(domain, (-1 + w(1) .* domain + b)/(-w(2)), 'g:');
plot(domain, (1 + w(1) .* domain + b)/(-w(2)), 'g:');
hold('off');