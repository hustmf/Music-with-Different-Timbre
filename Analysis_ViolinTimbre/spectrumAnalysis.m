fs=44100;
filename=['l1.wav';'l2.wav';'l3.wav';'l4.wav';'l5.wav';'l6.wav';'l7.wav';'m1.wav'];
k=30;
fv=zeros(k,2*7);
for num=1:7
[violinExample,fs]=audioread(filename(num,1:6));
if length(violinExample)<fs
    spectrum=abs(fft(violinExample(1:length(violinExample))));
else
spectrum=abs(fft(violinExample(1:fs)));
end
f=zeros(k,2);
[f(1,2),f(1,1)]=max(spectrum(1:300));

plot(spectrum(1:5000)/max(spectrum(1:5000)));
hold on
for i=2:k
    left=round((i-0.5)*f(1,1));
    right=round((i+0.5)*f(1,1));
    [f(i,2),f(i,1)]=max(spectrum(left:right));
    f(i,1)=f(i,1)+left-1;
end
fv(1:k,2*num-1:2*num)=f;
end
save violinSpectrum fv;
