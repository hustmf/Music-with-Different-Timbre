fs=44100;
song=readmidi('../midi/Storybrooke.mid');
score=midiInfo(song,0);%获得乐曲信息
len=ceil((score(end,6)+5)*fs);%获得采样数量
y=zeros(len,1);
for i=1:size(score,1)%音符数量
    tbegin=score(i,5);%该音符开始时间
    tend=score(i,6);%该音符停止时间
    t=tend-tbegin;%音符持续时间
    pitch=score(i,3);%音符音高
    frequency=midi2freq(pitch);%音符频率
    x=pianoTimbre(t,frequency);%合成对应音符
    nbegin=max(1,round(tbegin*fs));
    y(nbegin:(nbegin+length(x)-1))=y(nbegin:(nbegin+length(x)-1))+x;%在对应位置插入音符
    process=i/size(score,1)*100%合成进度
end
y=y/max(abs(y));
audiowrite('Storybrooke.mp4',y,fs);
