clear all
%the file name to use in frequency analysis
sndfile = 'speech_female.wav';
% reading the file and creating variables for the samaples and sampling
% rate of the audio file
[x,Fs] = audioread(sndfile);
% the number of samples to use for analysis with the spectrogram
N = 512;
% passing a subset of the audio file to the spectrogram, this is denoted by
% N defined above
[S,F,T] = spectrogram(x(1:Fs*1.4),N,3*N/4,N*4,Fs);

% create a plot of the frequency representation returned from the
% spectrogram
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
print(gcf,'-depsc2','p2i1.eps');