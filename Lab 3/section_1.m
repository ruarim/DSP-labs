Fs = 2048; % Sampling frequency
N = 32; % Number of samples
n = 0:N-1; % Sample indices

% Generate the sine wave
x = sin(2 * pi * 128  * n / Fs) + 0.2 * sin(2 * pi * 220 * n / Fs) + 0.01 * cos(2 * pi * 525 * n / Fs);

zeros_n = Fs / 2 - N;

% Pad with zeros
x_padded = [x, zeros(1, zeros_n)];

X_1 = fft(x_padded);
X_2 = fft(x);

plot_magnitude(X_1, X_2,  Fs, length(x_padded), length(x));


function plot_magnitude(X_1, X_2,  Fs, N_1, N_2)
% Define the frequency vector for positive frequencies
k_1 = Fs * (0:(N_1/2))/N_1;
k_2 = Fs * (0:(N_2/2))/N_2;

% Compute the magnitude of the FFT
absX_1 = abs(X_1);
absX_2 = abs(X_2);

figure;
% Plot the magnitude of the FFT
line(k_1, absX_1(1:length(k_1)))
hold
stem(k_2, absX_2(1:length(k_2)));
title('Magnitude of FFT');
xlabel('Frequency (Hz)');
ylabel('Magnitude');
xlim([0,1024]);
end