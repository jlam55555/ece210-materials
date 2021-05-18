clc; clear; close all;

% a lot was taken from this Stack Overflow answer
% https://stackoverflow.com/a/35259180

%% read in an image and perform some preprocessing
original = im2double(imread('lizard.jpg'));

% convert to single channel (b/w)
original = rgb2gray(original);

% prevent /0 error
original = original + 0.1;

figure();
imshow(original);
title('Original Image (converted to B/W)')

%% blur using a power spectral density
PSF = fspecial('gaussian', 20, 3);

blr = imfilter(original, PSF);
figure; imshow(blr); title('Blurred Image')

%% perform richardson-lucy deconvolution
iter = 25;

res_RL = RL_deconv(blr, PSF, iter);
res_RL2 = deconvlucy(blr, PSF, iter);

% show results
figure();
tiledlayout(1, 2, 'Padding', 'none', 'TileSpacing', 'compact');
nexttile();
imshow(original);
title('Original Image');
nexttile();
imshow(blr);
title('Blurred Image');

figure();
tiledlayout(1, 2, 'Padding', 'none', 'TileSpacing', 'compact');
nexttile();
imshow(res_RL);
title('Recovered Image (RL\_deconv)');
nexttile();
imshow(res_RL2);
title('Recovered Image (deconvlucy)');

%% edge detection using the canny filter
image_edge = edge(original, 'Canny');

figure();
tiledlayout(1, 2, 'Padding', 'none', 'TileSpacing', 'compact');
nexttile();
imshow(original);
title('Original Image');
nexttile();
imshow(image_edge);
title('Image Edges');

%% edge detection and orientation using sobel filter
sobel = fspecial('sobel');
sobel_hor = imfilter(original, sobel);
sobel_ver = imfilter(original, sobel.');

edge_intensity = sqrt(sobel_hor.^2 + sobel_ver.^2);
edge_direction = atan2(sobel_ver, sobel_hor);

figure();
tiledlayout(2, 2, 'Padding', 'none', 'TileSpacing', 'compact');
nexttile();
imshow(edge_intensity);
title('Edge Intensity');

nexttile();
angles = zeros([size(original), 3]);
angles(:,:,1) = (edge_direction + pi) / (2*pi);
angles(:,:,2) = edge_intensity;
angles(:,:,3) = edge_intensity;
imshow(hsv2rgb(angles));
nexttile();
imshow(sobel_ver);
title('Vertical Gradient');

nexttile();
imshow(sobel_hor);
title('Horizontal Gradient');

%% our own implementation of richardson lucy
function result = RL_deconv(image, PSF, iterations)
    % to utilise the conv2 function we must make sure the inputs are double
    image = double(image);
    PSF = double(PSF);
    
    % initial estimate
    latent_est = 0.5*ones(size(image));
    
    % spatially reversed psf
    PSF_HAT = PSF(end:-1:1,end:-1:1);
    
    % iterate towards ML estimate for the latent image
    for i= 1:iterations
        est_conv      = conv2(latent_est,PSF,'same');
        relative_blur = image./est_conv;
        error_est     = conv2(relative_blur,PSF_HAT,'same');
        latent_est    = latent_est.* error_est;
    end
    result = latent_est;
end