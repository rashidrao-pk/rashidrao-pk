% Matlab Program to demonstrate the concpet of "Signal Smoothing" 
% Signal Smoothing or Averaging is the Fundamental Noise Reduction Tool in
% 1-D Signal Processing Such as a Monotonic Signal, Speech or Voice.
clc;
clear all;
close all;
% Initialise the Time 
t = 0:0.001:1;   % 0 -- Starting Time, 0.001-- Sampling Time, 1 -- Ending Time
% reading the size of the time
[m,n] = size(t);
% Generation of sine wave
% amplitude
a = 2;
% frequency
f = 4;
% sine wave argument according to the definition
y = a*sin(2*pi*f*t);
% Generation of Random signal using "rand" command in the matlab 
% Please see the sintax of "rand" command by typing help rand in the matlab
% command window
r = rand(m,n);
% Note: Observer that, we generated the random signal in the matlab using
% rand function such that, size of the signal and random signal both are
% similar. 
% Adding both signal and noise
y1 = (y + r);

% Algorithm:
%               X(n-1) + X(n) + X(n+1)
%    Y(n) =     ----------------------   
%                         3
y2 = zeros(m,n);

for i = 2:(n-1)
    y2(i) = (y1(i-1) + y1(i) + y1(i+1))/3;
end

% therefore y2(i) will be the smoothed signal
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Lets plot the signals and see the output
subplot(411);
plot(t,y); title('input signal');
subplot(412);
plot(t,r); title('random signal');
subplot(413);
plot(t,y1); title('noise added signal');
subplot(414);
plot(t,y2); title('smoothed signal');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Please try this implementation an extension
% initiate a for loop for 2-4 times, and make y2 = y1, i.e., we are making
% a feed back, it becomes a recursive filter, this will be the first step
% towards the implementation of Recursive filter
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% For any questions please send a mail to samudrala.naren@gmail.com
% Implemented by : Jagadeesh Samudrala, Asst. Prof., Dept. of ECE, Aditya
% Engineering College. 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%