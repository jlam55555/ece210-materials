clear;clc;close all;

%%
load handel
audiowrite('handel.wav',y,Fs)
[y, Fs] = audioread('handel.wav');  % Fs = sample freq.
sound(y, Fs);
T = 1/Fs;
t = 0:T:(length(y)-1)*T;

%% loud noise warning!!!
Fnoise = 2500;
noise = 0.2*sin(2*pi*t*Fnoise).';  % additive "noise" with freq. 2.5kHz
y = noise + y;
% sound(y, Fs);

%%
N= 2^15;
S = fft(y, N);                       % N point dft (best to use power of 2)
S = fftshift(abs(S))/N;

% fftshift is necessary since MATLAB returns from fft the zeroth frequency
% at the first index, then the positive frequencies, then the negative
% frequencies when what you probably want is the zeroth frequency centered
% between the negative and positive frequencies.

F = Fs.*(-N/2:N/2-1)/N;

% Each frequency index represents a "bin" of frequencies between -Fs/2 and
% Fs/2 (so index i represents i*Fs/N).

figure
plot(F,S);
title('Fourier Transform of Audio')
xlabel('Frequency (Hz)')
ylabel('Magnitude')


%% Alternative way to generate FFT plots:
% slightly-less accurate but more readable version of F
wd = linspace(-pi, pi, N+1);
wd = wd(1:end-1);
F2 = wd * Fs / (2 * pi);

% some flexibility in scaling factor: see
% https://www.mathworks.com/matlabcentral/answers/15770-scaling-the-fft-and-the-ifft#answer_21372
S = fftshift(fft(y)) / Fs;

% this S is complex; you can take either abs() or angle() of it to get
% magnitude and phase responses, respectively


%% Filter Overview
% Remember order = # of delay elements, want to minimize
% There are 4 main types of filters:
%   Lowpass - passes low frequencies through
%   Highpass - passes high frequencies through
%   Bandpass - passes a specific band
%   Bandstop - stops a specific band from going through
%
% There are primarily 4 implementations of filters
%   Butterworth - maxflat passband, monotonic passband & stopband
%   Chebychev I - equiripple passband, monotonic stopband
%   Chebychev II - monotonic passband, equiripple stopband
%   Elliptic - minimum order, equiripple passband & stopband

%% Filter Design (GUI)
filterDesigner          % then export to workspace as numerator and
                        % denominator (not SOS for now)

%%
flt = bandstop2500()

y1 = filter(flt, y);
% sound(y1, Fs)

S1 = fft(y1,N);
S1 = fftshift(abs(S1))/N;

figure
plot(F,S1);
title('Fourier Transform of Audio')
xlabel('Frequency (Hz)')
ylabel('Magnitude')

%% Filter Design (Code)
Fs = 44100;
Apass = 1;
Astop = 80;
Fpass = 1e3;
Fstop = 1e4;
wpass = Fpass/(Fs/2); %normalized to nyquist freq.
wstop = Fstop/(Fs/2); %normalized to nyquist freq.

%%
n = buttord(wpass,wstop,Apass,Astop);   % computes the minimum order
                                        % for butterworth filter
[b,a] = butter(n,wpass);
[H,W] = freqz(b,a);

% convert frequency to range 0 to Fs/2
f = W.*Fs/2/pi;
figure;
semilogx(f,20*log10(abs(H)));
xlim([1e2 1e5]);
ylim([-100 5]);
grid on;
title('Butterworth Lowpass Filter');
xlabel('Frequency (Hz)');
ylabel('Magnitude (dB)');

%% Image Example
% Low pass filtering
% Here we look at images. Think frequencies spatially. High frequency
% represents fast change in the image, low frequency represents slight
% change. Also frequenies have two dimensions, vertial and horizontal.

x = imread('lena.tiff');
imshow(x);

%%
F = fftshift(fft2(x));

hpf_mask = zeros(size(F));
[H,W] = size(F);
hpf_mask(floor(H/2-H/10):floor(H/2+H/10),floor(W/2-W/10):floor(W/2+W/10)) = 1;

figure
subplot(121)
imshow(log(abs(F))/max(log(abs(F(:)))))
title('Fourier transform');

subplot(122)
imshow(hpf_mask)
title('HPF mask');

%%
im_filtered_fft = hpf_mask.*F;                      % high frequencies removed
f = ifft2(ifftshift(im_filtered_fft));
imshow(log(abs(im_filtered_fft))/max(log(abs(im_filtered_fft(:)))))
title('Filtered FFT')

%%
% altered image vs old image
% check out how the new image looks a bit blurry. That's because we removed
% the high frequency band! All "edges" are less noticable.
figure
subplot(121)
fnorm = abs(f)/max(abs(f(:)));
imshow(fnorm)
title('High frequencies removed');

subplot(122)
xnorm = abs(double(x))/max(double(x(:)));
imshow(xnorm)
title('Original image');

%% Basic Edge Detection
% The difference between the old image and the new image: The edges!
sharp_image = abs(0.9*fnorm-xnorm);
sharp_image_norm = sharp_image/max(sharp_image(:));
imshow(sharp_image_norm)

%%
% Pinpoints these changes
edge_image = zeros(size(sharp_image_norm));
edge_image(sharp_image_norm > 3.5*std(sharp_image_norm(:))) = 1;
imshow(edge_image)