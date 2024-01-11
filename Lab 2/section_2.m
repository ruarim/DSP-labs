clear all
 
sndfile = 'speech_female.wav';
 
[x,Fs] = audioread(sndfile);

N = 512;
 
n = 10;
d_Fs = Fs/n;

y = myDecimate(x, n);
sound(y, d_Fs);

create_spectrogram(N, y, Fs);

function create_spectrogram(N, x, Fs)
[S,F,T] = spectrogram(x(1:Fs*1.4),N,3*N/4,N*4,Fs);
 
f = figure('Position',[500 300 700 500],'MenuBar','none', ...
  'Units','Normalized');
set(f,'PaperPosition',[0.25 1.5 8 5]);
axes('FontSize',14);
colormap('jet');
imagesc(T,F./1000,20*log10(abs(S)));
axis xy;
set(gca,'YTick',[0:2000:Fs/2]./1000,'YTickLabel',[0:2000:Fs/2]./1000);
 
ylabel('Frequency (kHz)');
xlabel('Time (s)');
  
end

function [y] = myDecimate(x, n)
    % Check if n is a positive integer
    if(~isnumeric(n) || n <= 0 || rem(n, 1) ~= 0) 
        error('Decimation factor must be a positive integer');
    end

    % Decimate the signal
    indices = 1:n:length(x);
    y = x(indices);
end