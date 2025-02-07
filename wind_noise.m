close all;
clear sound;
[voice, Fs] = audioread('sound.wav');

f = (-N/2:N/2-1) * (Fs/N);


whiteNoise = randn(N,1); 
fc = 200; % Cutoff frequency (Hz) for wind noise (adjust as needed)
[b, a] = butter(2, fc/(Fs/2), 'low'); % 2nd order Butterworth low-pass filter
windNoise = filter(b, a, whiteNoise);

% Adjust Wind Noise Amplitude
noiseLevel = 0.6;
windNoise = windNoise * noiseLevel * max(abs(voice));

noisyVoice = voice + windNoise;
audiowrite('voices/voice_with_wind_noise.wav', noisyVoice, Fs);
sound(noisyVoice,Fs)

figure; 
subplot(2,1,1);
plot(f,fftshift(abs(fft(y))));
xlim([-2000, 2000]);
ylim([0 10000])
title('normal Sound');
grid on;

subplot(2,1,2);
plot(f,fftshift(abs(fft(noisyVoice))));
title('Windy Sound');
ylim([0 10000])
xlim([-2000, 2000]);
grid on;



% RECOVER FROM NOISE
[b, a] = butter(4, fc/(Fs/2), 'high'); % Create filter
cleanVoice = filtfilt(b, a, noisyVoice);

