h = [0.00506, 0, -0.04194, 0, 0.28848, 0.49679, 0.28848, 0, -0.04194, 0, 0.00506];
N_fft = 1024;

figure;
stem(h);
ylabel('Amplitude');
xlabel('Samples');
ylim([-0.5, 0.5]);

H = fft(h, N_fft);

abs_H = abs(H);
phase = unwrap(angle(H(1:N_fft / 2)))/pi;

freq = linspace(0, 0.5, N_fft / 2);
magnitude = abs_H(1:N_fft / 2);

db = 20*log10(magnitude./max(magnitude));

figure;
plot_db(freq, db);

figure;
plot_phase(freq, phase);

% Compute the group delay
g = grpdelay(h, 1, 1024);

% Normalized frequency for plotting
freq = linspace(0, 0.5, N_fft);
figure;
plot_grpdelay(freq, g);

h = h .* (-1) .^ (0:length(h)-1);
H = fft(h, N_fft);

abs_H = abs(H);
phase = unwrap(angle(H(1:N_fft / 2)))/pi;

freq = linspace(0, 0.5, N_fft / 2);
magnitude = abs_H(1:N_fft / 2);

figure;
plot_mag(freq, magnitude);

db = 20*log10(magnitude./max(magnitude));

figure;
plot_db(freq, db);

figure;
plot_phase(freq, unwrap(phase));

% Compute the group delay
g = grpdelay(h, 1, N_fft, 'whole');

% Normalized frequency for plotting
freq = linspace(0, 0.5, N_fft);
figure;
plot_grpdelay(freq, g);

function plot_mag(freq, magnitude)
plot(freq, magnitude);
ylabel('Magnitude');
xlabel('Normalised Frequency');
end

function plot_db(freq, magnitude)
plot(freq, magnitude);
ylabel('Magnitude (dB)');
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


