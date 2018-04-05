addpath ../Violin
load('Melody.mat');
base=[0 2 4 5 7 9 11];
high1=base+12;
high2=high1+12;
low1=base-12;
low2=low1-12;
pitch=zeros(length(melody),1);
yincheng=0;
for i=1:length(melody)
    yincheng=0;
    m=melody(i);
    while m>7
        m=m-7;
        yincheng=yincheng+12;
    end
    while m<1
        m=m+7;
        yincheng=yincheng-12;
    end    
    if (ceil(m)-m)~=0
        if m~=3&&m~=7
            pitch(i,1)=base(ceil(m))-1+yincheng;
        else
            pitch(i,1)=base(ceil(m))+yincheng;
        end
    else
        pitch(i,1)=base(m)+yincheng;
    end
end
music=[];
fs=44100;
for i=1:length(melody)
    note=Note(i);
    p=pitch(i,1);
    [t,f]=transform(do,note,tbase,p);
    y=violinTimbre(t,f);
    music=[music;y];
end
music=music/max(abs(music));
sound(music,fs);