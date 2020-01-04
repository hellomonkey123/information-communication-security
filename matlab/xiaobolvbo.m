
%% ��������ͼ4.5.6.7
clear,clc;
fs=20000;%����Ƶ��
N=65536;%����Ƶ�����������һ������ʹ�ֱ��ʴﵽ1HZ
t=1/fs:1/fs:N/(fs);%����ʱ��1/6s

fz=580;
fr=20;
a1=5;a2=2; a3=0.75; a4=0.5; a5=0.15; a6=0.05;
% a1=0.25;a2=0.75; a3=2.5; a4=7.5; a5=10; a6=25;
% a1=7.5;a2=2.5; a3=0.75; a4=0.25; a5=0.15; a6=0.05;
% %r�൱��ѧ�����������2-10
r=(a1/100)*sin(2*pi*fr*t)+(a2/100)*sin(2*2*pi*fr*t)+(a3/100)*sin(2*3*pi*fr*t)+(a4/100)*sin(2*4*pi*fr*t)+0.25/300*exp(-600*(t));
% %r�൱��ѧ�����������2-11
b=(a1/100)*sin(2*pi*fr*t)+(a2/100)*sin(2*2*pi*fr*t)+(a3/100)*sin(2*3*pi*fr*t)+(a4/100)*sin(2*4*pi*fr*t)-0.25/300*exp(-600*(t));
%% ���ϳ��ֵ��ź�
x=(1+r).*(a1*cos(2*pi*fz*t+b)+a2*cos(2*2*pi*fz*t+b)+a3*cos(2*3*pi*fz*t+b)+a4*cos(2*4*pi*fz*t+b))+2*wgn(1,65536,1)+0.25*exp(-600*t).*cos(2*pi*fr*t);
% x=(1+r).*(a1*cos(2*pi*fz*t+b)+a2*cos(2*2*pi*fz*t+b)+a3*cos(2*3*pi*fz*t+b)+a4*cos(2*4*pi*fz*t+b))+0.25*exp(-600*t).*cos(2*pi*fr*t);
M=mean(x)
figure(1)%���������ź�ʱ��ͼfig4
plot(t,x);xlabel('time(sec)');ylabel('Amplitude');title('Simulated faulty signal');
%% ���������ź�Ƶ��ͼfig5
NFFT=2^nextpow2(N);     % the most efficient sequence length for FFT
SF=fft(x,NFFT);
SF(1)=[];
SF=SF(1:NFFT/2);
ASF=abs(SF);
nyquist=fs/2;      % nyquist frequency
f=(1:NFFT/2)*nyquist/(NFFT/2);

figure(2)%���������ź�Ƶ��ͼfig5
plot(f,ASF(1:length(f)));xlabel('Frequency(Hz)');ylabel('Absolute value');title('FFT of simulated faulty signal');


%% ����ѧ������ͼ4-10.4-12�������кܴ�ͬ����paper�е�6.7
% �����kurtosis=4.01�Ļ����Ͻ���morletС�������������ڲ�ͬ��i��j(��Ӧmorlet�����a=1��beta=8��)
% % y1=[exp(-((beta)^2).*(t-1/fs).^2./(2*a^2))].*cos(pi.*(t-1/fs)./a)
y1=[exp(-((4)^2).*(t-1/fz).^2./(2*1^2))].*cos(pi.*(t-1/fz)./1);%��ʽ4

% �����kurtosis=2.8995�Ļ��������Ͻ���meyr��ñ�����������ڲ�ͬ��i��j(��Ӧmeyr��ñ�����a= 1��beta=4��)
%y1=(exp(-0.5.*((t-(b))./a).^2)).*(1-((t-(b))./a).^2)% ����meyrС��������
% y1=(exp(-0.5.*((t-(4))./1).^2)).*(1-((t-(4))./1).^2);% ����meyr��ñС��������

figure
plot(t,y1)
% c1=conv(y1,x);% С���˲�%ֻ������һ�¾������������С���˲�,ֻ����������С���ı任ϵ��
c1=filter(y1,1,x);
%%
% figure(2)%���������ź�Ƶ��ͼfig5
% plot(f,F);xlabel('Frequency(Hz)');ylabel('Absolute value');title('FFT of simulated faulty signal');
% t1=0:1/fs:(2*N-2)/fs;
figure(3)%���������ź�ʱ��ͼfig3
plot(t,c1);xlabel('time(sec)');ylabel('Amplitude');title('������ʱ���ź�maxkurtosis filter');%�����ʱ�������⣬2018.5.29.21:41

NFFT=2^nextpow2(N);     % the most efficient sequence length for FFT
SF=fft(c1,NFFT);
SF(1)=[];
SF=SF(1:NFFT/2);
ASF=abs(SF);
nyquist=fs/2;      % nyquist frequency
f=(1:NFFT/2)*nyquist/(NFFT/2);

figure(4)
plot(f,ASF(1:length(f)));xlabel('Frequency(Hz)');ylabel('Amplitude');title('Frequency maxkurtosis filter');

%% ͨ�����ַ��������С��alphaֵ��Ӧ��beta��a��Ȼ���beta��a �����ع�ʽ4��
%Ȼ���ù�ʽ4��Ϊ�˲������źŽ��д���
% ����Сalpha�Ļ����Ͻ���morletС�������������ڲ�ͬ��i��j(��Ӧmorlet�����a=1��beta=7.9��)
% %  y1=[exp(-((beta)^2).*(t-1/fz).^2./(2*a^2))].*cos(pi.*(t-1/fz)./a)
% y1=[exp(-((4)^2).*(t-1/fz).^2./(2*1^2))].*cos(pi.*(t-1/fz)./1);%��ʽ4

% ����Сalpha=0.7986�Ļ����Ͻ���meyr��ñ�����������ڲ�ͬ��i��j(��Ӧmeyr��ñ�����a= 2��beta=2.1000��)
%y1=(exp(-0.5.*((t-(b))./a).^2)).*(1-((t-(b))./a).^2)% ����meyrС��������% ����meyrС��������
% y2=0.0019.*(exp(-0.5.*((t-(2.1000))./2).^2)).*(1-((t-(2.1000))./2).^2);% ����meyr��ñС��������

% c2=conv(y2,x);% С���˲� %ֻ������һ�¾������������С���˲�
c2=filter(y2,1,x);
% t2=1/fs:1/fs:(2*N-1)/(fs);

figure(5)%���������ź�ʱ��ͼfig3
plot(t,c2);xlabel('time(sec)');ylabel('Amplitude');title('������ʱ���ź�minAlpha filter');%�����ʱ�������⣬2018.5.29.21:41


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
