Fs = 2048; % Sampling frequency
N = 32; % Number of samples
n = 0:N-1; % Sample indices
Hz_128 = 128; % Frequency of interest

% Generate the sine wave
x = sin(2 * pi * Hz_128 * n / Fs);

% Plot the sine wave
plot_wave(n, x, 'Sine Wave 128Hz');

% Compute the FFT
X = fft(x);
plot_magnitude(X, Fs, N);

% Compute the index corresponding to 128 Hz
index_128Hz = round(Hz_128 * N / Fs) + 1;

% Extract the phase at 128 Hz
theta_128Hz = angle(X(index_128Hz));

% Display the result
fprintf('The phase at 128 Hz is: %f radians\n', theta_128Hz);

Hz_220 = 220;

% Generate the sine wave
x = sin(2 * pi * Hz_220 * n / Fs);

% Plot the sine wave
plot_wave(n, x, 'Sine Wave 220Hz');

% Compute the FFT
X = fft(x);
plot_magnitude(X, Fs, N);


Y = ifft(X);
plot_wave(n,Y, 'Sine Wave 220Hz after ifft');


N_2 = 512;
n = 0:N_2-1; % Sample indices

% Generate the sine wave
x = sin(2 * pi * Hz_220 * n / Fs);

% Plot the sine wave
plot_wave(n, x, 'Sine Wave 220Hz 512 Samples');

% Compute the FFT
X = fft(x);
plot_magnitude(X, Fs, N_2);


function plot_magnitude(X, Fs, N)
% Define the frequency vector for positive frequencies
k = Fs * (0:(N/2))/N;

% Compute the magnitude of the FFT
absX = abs(X);

% Plot the magnitude of the FFT
figure;
stem(k, absX(1:length(k)));
title('Magnitude of FFT');
xlabel('Frequency (Hz)');
ylabel('Magnitude');
end

function plot_wave(n, x, label)
figure;
stem(n, x);
title(label);
xlabel('Sample Index');
ylabel('Amplitude');
end
