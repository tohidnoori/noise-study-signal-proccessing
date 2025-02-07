clear sound;
close all;
[y, Fs] = audioread('sound.wav');

N = length(y);

numClicks = 500; % Number of clicks to add
clickStrength = 0.5;
clickNoise = zeros(N,1); % Create silent noise vector
clickPositions = randi([1, N], numClicks, 1); 
clickNoise(clickPositions) = clickStrength * (2*rand(numClicks,1) - 1);

clickedVoice = y + clickNoise;
sound(clickedVoice, Fs);
audiowrite('voices/voice_with_clicks.wav', clickedVoice, Fs);

figure; 
subplot(2,1,1);
plot(y);
title('normal Sound');
grid on;

subplot(2,1,2);
plot(clickedVoice);
title('clicked Sound');
grid on;


% RECOVER FROM NOISE
filteredVoice = medfilt1(clickedVoice, 5); % 5-sample median filter
