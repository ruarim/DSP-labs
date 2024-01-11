Fs = 2048; % Sampling frequency
N = 32; % Number of samples
n = 0:N-1; % Sample indices

% Generate the sine wave
x = sin(2 * pi * 128 * n / Fs) + 0.2 * sin(2 * pi * 220 * n / Fs) + 0.01 * cos(2 * pi * 525 * n / Fs);

w_rec = my_rec(N); % Rectangular window
w_tri = my_triang(N-1); % Triangular window
w_sine = my_sin(N); % Sine window
w_hann = my_hann(N); % Hann window

% Create figure and plot for each window
padding = 2048;
figure;
subplot(2,2,1);
plotWindowedSpectrumPadded(w_rec, 'Rectangular Window', x, Fs, padding);

subplot(2,2,2);
plotWindowedSpectrumPadded(w_tri, 'Triangular Window', x(1:31), Fs, padding);

subplot(2,2,3);
plotWindowedSpectrumPadded(w_sine, 'Sine Window', x, Fs, padding);

subplot(2,2,4);
plotWindowedSpectrumPadded(w_hann, 'Hann Window', x, Fs, padding);


function plotWindowedSpectrumPadded(window, titleStr, x, Fs, N)
    x_w = x .* window';
    X = fft(x_w, N);
    absX = 20 * log10(abs(X)./max(abs(X)));
    k = (0:N-1) * Fs / N;
    plot(k(1:N/2+1), absX(1:N/2+1));
    title(titleStr);
    xlabel('Frequency (Hz)');
    ylabel('Normalized Magnitude');
    xlim([0, Fs/2]);
end

% Function to apply window, compute FFT, and plot
function plotWindowedSpectrum(window, titleStr, x, Fs, N)
    x_w = x .* window';
    X = fft(x_w, N);
    absX = abs(X)./max(abs(X));
    k = (0:N-1) * Fs / N;
    stem(k(1:N/2+1), absX(1:N/2+1));
    title(titleStr);
    xlabel('Frequency (Hz)');
    ylabel('Normalized Magnitude');
    xlim([0, Fs/2]);
end

function [w] = my_rec(N)
w = ones(N, 1);
end

function [w] = my_triang(N)
% Initialize the window with zeros
w = zeros(N,1);

% Calculate the triangular values
for n = 0:N-1
    w(n+1) = (N-1)/2 - abs(n - (N-1)/2);
end

% Normalize the window
w = w * 2 / (N-1);
end

function [w] = my_sin(N)
n = 0:N-1;
w = sin(pi * n / (N-1)).';
end

function [w] = my_hann(N)
n = 0:N-1;
w = 0.5 * (1 - cos(2 * pi * n /(N-1))).';
end