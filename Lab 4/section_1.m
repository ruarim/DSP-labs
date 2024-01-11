M_values = [5, 21, 51];
N_fft = 1024;

figure;
for i = 1:length(M_values)
    M = M_values(i);
    % Create the impulse response
    h = ones(1,M)./M;
    H = fft(h, N_fft);

    freq = linspace(0, 0.5, N_fft / 2);
    magnitude = abs(H(1:N_fft / 2));

    plot_mag(freq, magnitude, string(M));
end
hold off;

figure;
for i = 1:length(M_values)
    M = M_values(i);
    h = ones(1,M)./M;
    H = fft(h, N_fft);

    freq = linspace(0, 0.5, N_fft / 2);
    phase = angle(H(1:N_fft / 2)) / pi;

    plot_phase(freq, phase);
end
hold off;

figure;
for M = M_values
    % Create the impulse response h(n) = 1/M for n = 0, 1, ..., M-1
    h = ones(1, M) / M;

    % Compute the group delay
    [g, w] = grpdelay(h, 1, 1024, 'whole');

    % Normalized frequency for plotting
    freq = linspace(0, 0.5, N_fft);

    plot_groupdelay(freq, g, string(M));
end
hold off;


function plot_mag(freq, magnitude, name)
plot(freq, magnitude);
ylabel('Magnitude');
xlabel('Normalised Frequency');
gtext(name);
hold on; % Hold on to plot multiple curves on the same figure
end

function plot_phase(freq, phase)
plot(freq, phase);
ylabel('Phase pi radians');
xlabel('Normalised Frequency');
hold on; % Hold on to plot multiple curves on the same figure
end

function plot_groupdelay(freq, g, name)
% Plot the group delay
plot(freq, g);
ylabel('Group delay (samples)');
xlabel('Normalised Frequency');
gtext(name);
hold on; % Hold on to plot multiple curves on the same figure
end
