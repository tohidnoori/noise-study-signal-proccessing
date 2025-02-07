close all;
[voice, Fs] = audioread('sound.wav');

N = length(y);
f = (-N/2:N/2-1) * (Fs/N);

% Generate pink-white noise
pinkNoise = dsp.ColoredNoise('Color','pink','SamplesPerFrame',N);
whiteNoise = dsp.ColoredNoise('Color','white','SamplesPerFrame',N);
% Convert to a static vector
pinkNoise = pinkNoise();
whiteNoise = whiteNoise();

pinkNoisedVoice = prod(G) * sosfilt(SOS, pinkNoise) + y; 
whiteNoisedVoice = prod(G) * sosfilt(SOS, whiteNoise) + y; 

audiowrite('voices/voice_with_pink_noise.wav', pinkNoisedVoice, Fs);
audiowrite('voices/voice_with_white_noise.wav', whiteNoisedVoice, Fs);


sound(pinkNoisedVoice,Fs)

figure; 
subplot(3,1,1);
plot(f,fftshift(abs(fft(y))));
ylim([0 2000]);
title('normal Sound');
grid on;

subplot(3,1,2);
plot(f,fftshift(abs(fft(whiteNoisedVoice))));
ylim([0 2000]);
title('White noise added voice');
grid on;

subplot(3,1,3);
plot(f,fftshift(abs(fft(pinkNoisedVoice))));
ylim([0 2000]);
title('Pink noise added voice');
grid on;
