
%% 画出论文图4.5.6.7
clear,clc;
fs=20000;%采样频率
N=65536;%采样频率与采样点数一样才能使分辨率达到1HZ
t=1/fs:1/fs:N/(fs);%采样时间1/6s

fz=580;
fr=20;
a1=5;a2=2; a3=0.75; a4=0.5; a5=0.15; a6=0.05;
% a1=0.25;a2=0.75; a3=2.5; a4=7.5; a5=10; a6=25;
% a1=7.5;a2=2.5; a3=0.75; a4=0.25; a5=0.15; a6=0.05;
% %r相当于学姐论文里面的2-10
r=(a1/100)*sin(2*pi*fr*t)+(a2/100)*sin(2*2*pi*fr*t)+(a3/100)*sin(2*3*pi*fr*t)+(a4/100)*sin(2*4*pi*fr*t)+0.25/300*exp(-600*(t));
% %r相当于学姐论文里面的2-11
b=(a1/100)*sin(2*pi*fr*t)+(a2/100)*sin(2*2*pi*fr*t)+(a3/100)*sin(2*3*pi*fr*t)+(a4/100)*sin(2*4*pi*fr*t)-0.25/300*exp(-600*(t));
%% 故障齿轮的信号
x=(1+r).*(a1*cos(2*pi*fz*t+b)+a2*cos(2*2*pi*fz*t+b)+a3*cos(2*3*pi*fz*t+b)+a4*cos(2*4*pi*fz*t+b))+2*wgn(1,65536,1)+0.25*exp(-600*t).*cos(2*pi*fr*t);
% x=(1+r).*(a1*cos(2*pi*fz*t+b)+a2*cos(2*2*pi*fz*t+b)+a3*cos(2*3*pi*fz*t+b)+a4*cos(2*4*pi*fz*t+b))+0.25*exp(-600*t).*cos(2*pi*fr*t);
M=mean(x)
figure(1)%画出故障信号时域图fig4
plot(t,x);xlabel('time(sec)');ylabel('Amplitude');title('Simulated faulty signal');
%% 画出故障信号频域图fig5
NFFT=2^nextpow2(N);     % the most efficient sequence length for FFT
SF=fft(x,NFFT);
SF(1)=[];
SF=SF(1:NFFT/2);
ASF=abs(SF);
nyquist=fs/2;      % nyquist frequency
f=(1:NFFT/2)*nyquist/(NFFT/2);

figure(2)%画出故障信号频域图fig5
plot(f,ASF(1:length(f)));xlabel('Frequency(Hz)');ylabel('Absolute value');title('FFT of simulated faulty signal');


%% 画出学姐论文图4-10.4-12，但是有很大不同画出paper中的6.7
% 在最大kurtosis=4.01的基础上建立morlet小波基函数，对于不同的i和j(对应morlet里面的a=1和beta=8，)
% % y1=[exp(-((beta)^2).*(t-1/fs).^2./(2*a^2))].*cos(pi.*(t-1/fs)./a)
y1=[exp(-((4)^2).*(t-1/fz).^2./(2*1^2))].*cos(pi.*(t-1/fz)./1);%公式4

% 在最大kurtosis=2.8995的基础基础上建立meyr草帽基函数，对于不同的i和j(对应meyr草帽里面的a= 1和beta=4，)
%y1=(exp(-0.5.*((t-(b))./a).^2)).*(1-((t-(b))./a).^2)% 建立meyr小波基函数
% y1=(exp(-0.5.*((t-(4))./1).^2)).*(1-((t-(4))./1).^2);% 建立meyr草帽小波基函数

figure
plot(t,y1)
% c1=conv(y1,x);% 小波滤波%只是做了一下卷积，并不算是小波滤波,只是求了连续小波的变换系数
c1=filter(y1,1,x);
%%
% figure(2)%画出故障信号频域图fig5
% plot(f,F);xlabel('Frequency(Hz)');ylabel('Absolute value');title('FFT of simulated faulty signal');
% t1=0:1/fs:(2*N-2)/fs;
figure(3)%画出故障信号时域图fig3
plot(t,c1);xlabel('time(sec)');ylabel('Amplitude');title('卷积后的时间信号maxkurtosis filter');%这里的时间有问题，2018.5.29.21:41

NFFT=2^nextpow2(N);     % the most efficient sequence length for FFT
SF=fft(c1,NFFT);
SF(1)=[];
SF=SF(1:NFFT/2);
ASF=abs(SF);
nyquist=fs/2;      % nyquist frequency
f=(1:NFFT/2)*nyquist/(NFFT/2);

figure(4)
plot(f,ASF(1:length(f)));xlabel('Frequency(Hz)');ylabel('Amplitude');title('Frequency maxkurtosis filter');

%% 通过这种方法求出最小的alpha值对应的beta和a，然后把beta和a 反代回公式4，
%然后用公式4作为滤波器对信号进行处理
% 在最小alpha的基础上建立morlet小波基函数，对于不同的i和j(对应morlet里面的a=1和beta=7.9，)
% %  y1=[exp(-((beta)^2).*(t-1/fz).^2./(2*a^2))].*cos(pi.*(t-1/fz)./a)
% y1=[exp(-((4)^2).*(t-1/fz).^2./(2*1^2))].*cos(pi.*(t-1/fz)./1);%公式4

% 在最小alpha=0.7986的基础上建立meyr草帽基函数，对于不同的i和j(对应meyr草帽里面的a= 2和beta=2.1000，)
%y1=(exp(-0.5.*((t-(b))./a).^2)).*(1-((t-(b))./a).^2)% 建立meyr小波基函数% 建立meyr小波基函数
% y2=0.0019.*(exp(-0.5.*((t-(2.1000))./2).^2)).*(1-((t-(2.1000))./2).^2);% 建立meyr草帽小波基函数

% c2=conv(y2,x);% 小波滤波 %只是做了一下卷积，并不算是小波滤波
c2=filter(y2,1,x);
% t2=1/fs:1/fs:(2*N-1)/(fs);

figure(5)%画出故障信号时域图fig3
plot(t,c2);xlabel('time(sec)');ylabel('Amplitude');title('卷积后的时间信号minAlpha filter');%这里的时间有问题，2018.5.29.21:41


%% 
NFFT=2^nextpow2(N);     % the most efficient sequence length for FFT
SF=fft(c2,NFFT);
SF(1)=[];
SF=SF(1:NFFT/2);
ASF=abs(SF);
nyquist=fs/2;      % nyquist frequency
f=(1:NFFT/2)*nyquist/(NFFT/2);

% SF=fft(c2);
% SFA=abs(SF);
% n=0:length(SF)-1;
% f=fs*n/length(SF);
%%
figure(6)
plot(f,ASF(1:length(f)));xlabel('Frequency(Hz)');ylabel('Amplitude');title('Frequency minAlpha filter')
