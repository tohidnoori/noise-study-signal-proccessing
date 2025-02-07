
clear sound;
close all;
[y, Fs] = audioread('sound.wav');
N = length(y);
f = (-N/2:N/2-1) * (Fs/N);
t = (0:N-1)' / Fs;
f0 = 50;

humNoise = .3 * (sin(2*pi*f0*t) + 0.5*sin(2*pi*3*f0*t) + 0.3*sin(2*pi*5*f0*t));
audiowrite("voices/sound_with_humy_noise.wav",y + humNoise ,Fs);
sound(y + humNoise ,Fs);


figure; 

ferq_y = fftshift(abs(fft(y)));
subplot(2,1,1);
plot(f,ferq_y);
xlim([-300, 300]);
ylim([0,5000]);
title('Filtered Sound');
xlabel('Hz');
ylabel('Amplitude');
grid on;


x=fftshift(abs(fft(humNoise + y)));
subplot(2,1,2);
plot(f,fftshift(abs(fft(humNoise + y))));
xlim([-300, 300]); 
ylim([0,5000]);
title('humy Sound');
xlabel('Hz');
ylabel('Amplitude');
grid on;



