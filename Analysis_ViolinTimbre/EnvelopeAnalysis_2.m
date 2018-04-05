fs=44100;
filename=['l1.wav';'l2.wav';'l3.wav';'l4.wav';'l5.wav';'l6.wav';'l7.wav';'m1.wav'];
l=[100 150 100 200 200 200 400 400];
h=[400 500 500 500 700 800 900 900];
fm=[262 294 330 349 392 440 494 523];

for i=1:8
[violinExample,fs]=audioread(filename(i,1:6));
[nn,wn]=buttord(l(i)*2/fs,h(i)*2/fs,1,30);
[B,A]=butter(nn,wn,'low');
bl=filter(B,A,abs(violinExample)*2);
plot(bl);
save(filename(i,1:2),'bl');
end