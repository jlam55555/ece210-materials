%% Lesson 6
% Written by Brenda So, edited by Samuel Maltz

%% Objective
% After this class, you should be able to:
%%
%
% * Have a overview idea of the z transform 
% * Know how to plot pole zero plots of the z transform, and what to infer
% * Know how to input a signal to the transfer function of z transform

%% Review
x = [2 4 7 2 0 8 5];
stem(x);
title("Discrete Time signal");

%% Overview of the z transform
% The z transform converts a discrete time signal, which can be represented
% in real or complex numbers, into a sequence of complex exponentials.
% There are two key motivations of the z transform:

%%
% * By identifying the impulse response of the system we can determine how
% it would perform in different frequencies
% * By identifying the presence of increasing or decreasing oscillations in
% the impulse response of a system we can determine whether the system
% could be stable or not

%% Polynomials in MATLAB
% Before we step into z transform, we should take a look at what functions
% are there in MATLAB to evaluate polynomials. There are 4 major functions
% to know about -- polyval, root/poly and conv.

%% polyval
% Allows you to evaluate polynomials at specified values
%%
p = [2 -2 0 -3]     % 2x^3-2x^2 -3 
x = -5:.05:5;
a = polyval(p,x);
a2 = 2*x.^3 - 2*x.^2 - 3;

figure
subplot(2,1,1);
plot(x,a)
title('Using polyval')
hold on;
subplot(2,1,2);
plot(x,a2)
title('Using algebraic expression')
%%
% The graphs are the same!

%% roots/poly
% These two functions are ~inverses! They allow you
% to find the roots / coefficients of a vector of numbers
%%
r = roots(p)
p1 = poly(r)

%% residue
% Will apply later in the Signals course. Pretty much partial fractions
% from Calc I.

b = [-4 8];
a = [1 6 8];
[r,p,k] = residue(b,a)

[bb,aa] = residue(r,p,k)  % can go both ways

%% conv
% If Fontaine's talked about it, you mostly heard of convolution when you
% multiply in the frequency domain, i.e. when you feed a signal through a
% system, you need to multiply in the frequency domain. It is also used
% when you MULTIPLY TWO POLYNOMIALS TOGETHER!!!

%%
a = [1 2 -3 4];      
b = [5 0 3 -2];      
p2 = conv(a,b)       % Use convolution

x = -5:.05:5;

% a little experiment
figure
subplot(2,1,1);
plot(x,polyval(a,x).*polyval(b,x))
title('Multiplying polynomial values')
hold on;
subplot(2,1,2);
plot(x,polyval(p2,x))
title('Using conv on coefficients')

%% Z transform 
% One of the things we usually evaluate in the z transform is the pole zero
% plot, since the pz plot can talk about stability and causality in
% different regions of convergence. Let us just look at one simple example
% of a pole zero plot

%% Z transform - generate a pole zero plot
% There are multiple ways to generate the pole zero plot. If you are
% interested, you should look up tf2zp (and its inverse, zp2tf), pzplot,
% etc. We are going to introduce the most simple function -- zplane. In the
% example, b1 and a1 and coefficients of the numerator and denominator,
% i.e, the transfer function. The Transfer function can be interpreted as
% the ratio between output (denominator) and input (numerator). At home, 
% you are going to explore how to use tf2zp

b1 = [1];       % numerator
a1 = [1 -0.5];  % denominator
figure;
zplane(b1, a1)

%% BE CAREFUL!
% If the input vectors are COLUMN vectors, they would be interpreted as
% poles and zeros, and if they are ROW vectors, they would be interpreted
% as Coefficients of the transfer function. 

%% BE CAREFUL!
% zplane takes negative power coefficients, while tf2zp (the one used
% in the homework) uses positive power coefficients. 

% in particular, note that polynomials with negative power efficients are
% LEFT-ALIGNED, while polynomials with positive power coefficients are
% RIGHT-ALIGNED. E.g., for positive coefficients b1 and [0 b1] are the
% same polynomial, but not so if negative coefficients. See the following
% example.

% 1/(1-0.5z^-1) = z/(z-0.5)
figure();
zplane(b1, a1);

% (0+z^-1)/(1-z^-1) = 1/(z-0.5)
figure();
zplane([0 b1], a1);

%% tf2zp and zp2tf
b = [2 3 0];
a = [1 1/sqrt(2) 1/4];

[z,p,k] = tf2zp(b,a)

%%
figure;
zplane(z,p)
%%
[b,a] = zp2tf(z,p,k)

%% tf2zpk

[z,p,k] = tf2zpk(b,a)
figure;
zplane(z,p)

%% Z transform - More examples!

b2 = [1];
a2 = [1 -1.5];
b3 = [1 -1 0.25];
a3 = [1 -23/10 1.2];

% Example 1 : One pole, outer region is stable and causal
figure;
subplot(3,1,1);
zplane(b1,a1);
title('$$H_1(z)=\frac{z}{z-\frac{1}{2}}$$','interpreter','latex')
% Example 2 : One pole, outer region is causal but not stable, inner region
% is stable but not causal
subplot(3,1,2);
zplane(b2,a2);
title('$$H_2(z)=\frac{z}{z-\frac{3}{2}}$$','interpreter','latex')
% Example 3 : Two poles, outer region is causal, middle region is stable
subplot(3,1,3);
zplane(b3,a3);
title('$$H_3(z)=\frac{(z-\frac{1}{2})^2}{(z-\frac{4}{5})(z-\frac{3}{2})}$$',...
    'interpreter','latex')

%% On Stability and Causality
% The system is stable iff the region contains the unit circle
% The system is causal iff the region contains infinity 
% If there is an infinity to the pole, then it's not stable
% If all the poles are in the unit circle, then the system could be both
% stable and causal
%% Z transform - Impulse Response
% The impulse response is useful because the fourier transform of the
% impulse response allows us to evaluate what is going to happen at
% different frequencies.
% h[n] = (1/2)^n
[h1,t] = impz(b1,a1,8);     % h is the IMPULSE RESPONSE
figure;
impz(b1,a1,32);            % for visualization

%% Z transform - Convolution
% After you obtain the impulse response, you can see what happens to the
% signal by convolving the impulse response with a signal
n = 0:1:5;
x1 = (1/2).^n;
y1 = conv(x1,h1);
figure;
subplot(2,1,1);
stem(y1);
title('Convolution between x_1 and h_1');
subplot(2,1,2);
y2 = filter(b1,a1,x1);
stem(y2);
title('Filter with b_1,a_1 and x_1');
xlim([0 14]);

%% freqz: digital freq response

[H,w] = freqz(b1,a1);

Hdb = 20*log10(abs(H));
Hph = rad2deg(unwrap(angle(H)));

figure;
subplot(2,1,1);
plot(w,Hdb);
xlabel("Frequency (rad)");
ylabel("|H| (dB)");
xlim([0 pi]);
xticks([0 pi/2 pi]);
xticklabels({'0', '\pi/2', '\pi'});
title("Magnitude Response");

subplot(2,1,2);
plot(w,Hph);
xlabel("Frequency (rad)");
ylabel("Phase (deg)");
xlim([0 pi]);
xticks([0 pi/2 pi]);
xticklabels({'0', '\pi/2', '\pi'});
title("Phase Response");

%%
n = 1024;
fs = 20000;
[H,f] = freqz(b1,a1,n,fs);

Hdb = 20*log10(abs(H));
Hph = rad2deg(unwrap(angle(H)));

figure;
subplot(2,1,1);
plot(f,Hdb);
xlabel("Frequency (Hz)");
ylabel("|H| (dB)")
xlim([0 fs/2]);
title("Magnitude Response");

subplot(2,1,2);
plot(f,Hph);
xlabel("Frequency (Hz)");
ylabel("Phase (deg)");
xlim([0 fs/2]);
title("Phase Response");

%%
zer = -0.5; 
pol = 0.9*exp(j*2*pi*[-0.3 0.3]');

figure;
zplane(zer,pol)

[b4,a4] = zp2tf(zer,pol,1);

[H,w] = freqz(b4,a4);

Hdb = 20*log10(abs(H));
Hph = rad2deg(unwrap(angle(H)));

figure;
subplot(2,1,1);
plot(w,Hdb);
xlabel("Frequency (rad)");
ylabel("|H| (dB)");
xlim([0 pi]);
xticks([0 pi/2 pi]);
xticklabels({'0', '\pi/2', '\pi'});
title("Magnitude Response");

subplot(2,1,2);
plot(w,Hph);
xlabel("Frequency (rad)");
ylabel("Phase (deg)");
xlim([0 pi]);
xticks([0 pi/2 pi]);
xticklabels({'0', '\pi/2', '\pi'});
title("Phase Response");

%% freqs

a = [1 0.4 1];
b = [0.2 0.3 1];

w = logspace(-1,1);
H = freqs(b,a,w);

Hdb = 20*log10(abs(H));
Hph = rad2deg(unwrap(angle(H)));

figure;
subplot(2,1,1);
semilogx(w,Hdb);
xlabel("Frequency (rad/s)");
ylabel("|H| (dB)");
title("Magnitude Response");

subplot(2,1,2);
semilogx(w,Hph);
xlabel("Frequency (rad/s)");
ylabel("Phase (deg)");
title("Phase Response");