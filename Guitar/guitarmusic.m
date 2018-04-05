song=readmidi('../midi/Chengdu.mid');
score=midiInfo(song,0);
fs=44100;
len=ceil((score(end,6)+100)*fs);
y=zeros(len,1);

timbre=rand(2048,1)-0.5;
for i=1:size(score,1)
    tbegin=score(i,5);
    tend=score(i,6);
    pitch=score(i,3);
    frequency=midi2freq(pitch);
    x=guitar(fs,(tend-tbegin)*5,frequency,timbre);
    velocity=score(i,4);
    nbegin=max(1,round(tbegin*fs));
    y(nbegin:(nbegin+length(x)-1))=y(nbegin:(nbegin+length(x)-1))+x;
    process=i/size(score,1)*100
end
y=y/max(abs(y));
audiowrite('Chengdu.mp4',y,fs);
%a=miraudio(y,fs);
%mirplay(a);