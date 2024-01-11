% Filter coefficients
b = [0.206572, 0.413144, 0.206572]; % Feedforward coefficients (x[n] terms)
a = [1, -0.369527, 0.195816];       % Feedback coefficients (y[n] terms)

% Impulse response:
x = [1, zeros(1, 19)]; % An impulse signal (1 followed by nineteen 0s)

% Apply the filter
y = filter(b, a, x);

figure; 
stem(y(1:16));
ylabel('Amplitude');
xlabel('Samples');
xlim([1,16]);

N_fft = 1024;

H = freqz(b,a,'whole', N_fft);

abs_H = abs(H);
freq = linspace(0, 0.5, N_fft);
magnitude = abs_H(1:N_fft);
figure;
plot_mag(freq, magnitude)

% Compute the group delay
g = grpdelay(b, a, N_fft, 'whole');

% Normalized frequency for plotting
figure;
plot_grpdelay(freq, g);

% Define the coefficient a
a = -0.9;

% Define the filter coefficients for A0(z)
b = [a, 1];   % Numerator coefficients: a + z^-1
a = [1, a];   % Denominator coefficients: 1 + az^-1

% Number of points for the frequency response
N_fft = 1024;

% Compute the frequency response
H = freqz(b, a, N_fft);

% Plot the magnitude and phase response
figure;

% Magnitude response
subplot(3, 1, 1);
plot_mag(freq, abs(H));

% Phase response
subplot(3, 1, 2);
phase = unwrap(angle(H))/pi;
plot_phase(freq, phase);

% Compute the group delay
g = grpdelay(b, a, N_fft, 'whole');

% Normalized frequency for plotting
subplot(3, 1, 3);
plot_grpdelay(freq, g); 

% Two allpass filters
% Define the coefficient alpha for A0(z)
alpha = -0.15;

% Define the filter coefficients for A0(z)
b0 = [alpha, 1];  % Numerator coefficients: alpha + z^-1
a0 = [1, alpha];  % Denominator coefficients: 1 + alpha*z^-1

% Define the filter coefficients for A1(z) (identity filter)
b1 = 1; % Numerator coefficient
a1 = 1; % Denominator coefficient

% Compute the frequency response for both filters
H0 = freqz(b0, a0, N_fft);
H1 = freqz(b1, a1, N_fft);

% Compute the overall system response by adding the responses
H_total = H0 + H1;

% Compute the group delay for the overall system
g = grpdelay(H_total, 1, N_fft);

% Plot the magnitude response in dB and the group delay
figure;

% Magnitude response in dB
subplot(2, 1, 1);
plot_db(freq, 20*log10(abs(H_total)))

% Group delay
subplot(2, 1, 2);
plot_grpdelay(freq, g);


function plot_mag(freq, magnitude)
plot(freq, magnitude);
ylabel('Magnitude');
xlabel('Normalised Frequency');
end

function plot_phase(freq, phase)
plot(freq, phase);
ylabel('Phase pi radians');
xlabel('Normalised Frequency');
end

function plot_grpdelay(freq, g)
plot(freq, g);
ylabel('Group delay samples');
xlabel('Normalised Frequency');
end

function plot_db(freq, magnitude)
plot(freq, magnitude);
ylabel('Magnitude (dB)');
xlabel('Normalised Frequency');
end
