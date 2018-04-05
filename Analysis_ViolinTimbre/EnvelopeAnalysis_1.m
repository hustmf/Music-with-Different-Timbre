fs=44100;
filename=['l1.wav';'l2.wav';'l3.wav';'l4.wav';'l5.wav';'l6.wav';'l7.wav';'m1.wav'];
l=[50 100 100 100 100 100 100 400];
h=[200 200 250 300 250 300 300 900];
fm=[132 148 165 175 197 220 247];

for i=1:1
x=audioread(filename(i,1:6));
[yupper,ylower]=envelope(x,1000,'peak');
plot(x)
hold on 
plot(yupper,'r')
plot(ylower,'g')
%save(filename(i,1:2),'yupper','ylower');
end