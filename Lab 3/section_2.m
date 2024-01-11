N_31 = 31;
N_32 = 32;

w_tri = my_triang(N_31);  % Generating the triangular window
% plot_window(w_tri, 'Triangle');
% hold;
w_rec = my_rec(N_32);
% plot_window(w_rec, 'Rectangle');
w_sin = my_sin(N_32);
% plot_window(w_sin, 'Sine');
w_hann = my_hann(N_32);
% plot_window(w_hann,  'Hann');

ylim([-0.2, 1.2]);
xlim([1, 32]);

hold off

% tiledlayout(2,2);
% plot_mag(w_rec, 'Rectangle');
% plot_mag(w_tri, 'Triangle');
% plot_mag(w_sin, 'Sine');
% plot_mag(w_hann, 'Hann');

N = 1024;
plot_mag_db(w_tri, N, 'Triangle');
hold
plot_mag_db(w_rec, N, 'Rectangle');
hold off

plot_mag_db(w_sin, N, 'Sine');
hold
plot_mag_db(w_hann, N, "Hann");
hold off

function plot_mag_db(w, N, name)
X = fft(w, N);
X_shift = fftshift(X);
fshift = (-N/2:N/2-1) * (1/N);
window_dB = 20 * log10(abs(X_shift) / max(abs(X_shift)));
plot(fshift, window_dB);
ylim([-80, 5]); % Set y-axis limit
xlim([-0.2, 0.2]); % Set x-axis limit
ylabel('Magnitude (dB)');
xlabel('Normalised Frequency');
% gtext(name);
end

function plot_mag(w, name)
nexttile;
X = fft(w, 1024);
X_shift = fftshift(X);

fshift = (-1024/2:1024/2-1) * 1/1024;
plot(fshift, abs(X_shift));
title(name)
end

function plot_window(w, name)
% Plotting the window
plot(w);
title('Windows');
xlabel('Sample');
ylabel('Amplitude');
% gtext(name);
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
% sin(pi * n / (N-1)).'
n = 0:N-1;
w = sin(pi * n / (N-1)).';
end

function [w] = my_hann(N)
n = 0:N-1;
w = 0.5 * (1 - cos(2 * pi * n /(N-1))).';
end