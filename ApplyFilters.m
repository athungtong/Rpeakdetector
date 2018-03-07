function ecg=ApplyFilters(ecg,fs)
%This is a sample IIR low pass, highpass, and notch filter


TotalFilterA=1;
TotalFilterB=1;

% notch filter at 60 hz

wo = 60/(fs/2);
bw = wo/35;
[B,A] = iirnotch(wo,bw); % design the notch filter for the given sampling rate
TotalFilterA = conv(TotalFilterA,A);
TotalFilterB = conv(TotalFilterB,B);




% low passs filtering
 
wo = (fs/3)/(fs/2); %cut off at fs/3 hz  
[B,A] = butter(2,wo,'low');

TotalFilterA = conv(TotalFilterA,A);
TotalFilterB = conv(TotalFilterB,B);



% High pass filtering
wo = 5/(fs/2); %cut off at 5 hz
[B,A] = butter(1,wo,'high');

TotalFilterA = conv(TotalFilterA,A);
TotalFilterB = conv(TotalFilterB,B);


%assignin('base','FilterPara',FilterPara);
FilterPara.A=TotalFilterA;
FilterPara.B=TotalFilterB;

% Perform filtering
ecg = filter(TotalFilterB,TotalFilterA,ecg);


