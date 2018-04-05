fs=44100;
song=readmidi('../midi/Butterfly Lovers.mid');
score=midiInfo(song,0);
len=ceil((score(end,6)+5)*fs);
y=zeros(len,1);
p=zeros(len,1);
%for i=1:size(score,1)
    for i=1:ceil(size(score,1))
    tbegin=score(i,5);
    tend=score(i,6);
    t=tend-tbegin;
    pitch=score(i,3);
    frequency=midi2freq(pitch);
    x=violinTimbre(t,frequency);
    %x=piano(fs,t,frequency,timbren,fbase);
    %…˘“Ù
    %n=round(length(x)/10);
   % l=linspace(0,1,n)';
    %x(1:n)=x(1:n).*l;
    %ll=linspace(1,0,n)';
    %x((length(x)-n+1):length(x))=x((length(x)-n+1):length(x)).*ll;
    %x=x*pitch*pitch/(127*127);
    %velocity=score(i,4);
    %x=x*exp(velocity/20);
    nbegin=max(1,round(tbegin*fs));
    y(nbegin:(nbegin+length(x)-1))=y(nbegin:(nbegin+length(x)-1))+x;
    process=i/size(score,1)*100
end
y=y/max(abs(y));


audiowrite('Butterfly Lovers.m4a',y,fs);
