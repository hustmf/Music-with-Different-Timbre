function music = pianoTimbre(t,f)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
 fs=44100;
 
 
k=30;
 F=f;
 Hz=[132 148 165 175 197 220 247];
 %Hz=[262 294 330 349 392 440 494];
count=0;
 name=['l1.mat';'l2.mat';'l3.mat';'l4.mat';'l5.mat';'l6.mat';'l7.mat';'m1.mat'];
 while F<125
     F=2*F;
 end
 while F>255
     F=F/2;
count=count+1;
 end
 [value,loc]=min(abs(Hz-F));
 load('pianoSpectrum.mat');
 strength=fv(1:k,2*loc);
 
% load(name(loc,1:6));
load('l2.mat');%加载原始基准音包络数据
N=round(fs*t);%计算当前合成音长度
m=round(0.045*length(yupper));%取原始包络中启动部分
q=length(yupper)-m;%衰减部分
if N>m%合成音长度大于包络长度
  p=N-m;
  %******减小计算量**********%
  while p*q>2^31||(p>100&&q>100)
  p=p/2;q=q/2;
  end
  %*************************%
  eu=[];
  el=[];
  %调制衰减部分包络长度
  eu=resample(yupper(m:length(yupper)),ceil(p),floor(q));
  %与启动部分包络合成完整包络
  eu=[yupper(1:m);eu];
  eu=eu(1:N);  
  el=resample(ylower(m:length(ylower)),ceil(p),floor(q));
  el=[ylower(1:m);el];  
  el=el(1:N);  
else%合成音长度小于基准音包络
  eu=resample(yupper(1:2*m),N,2*m);
  el=resample(ylower(1:2*m),N,2*m); 
end


music=zeros(N,1);
t=(0:N-1)/fs;%采样时间s
if count==0
k=22;
 for h=1:k
         music(1:N,1)=music(1:N,1)+[sin(2*pi*h*f*t)]'*strength(h,1);%信号采样       
 end
else
   i=2^count;
   l=floor(k/i);
   s=zeros(l,1);
   for h=1:l
   s(h,1)=strength(i*h,1);
   end
   for h=1:l
         music(1:N,1)=music(1:N,1)+[sin(2*pi*h*f*t)]'*s(h,1);%信号采样       
   end
end
for i=1:N
    if music(i)>=0
        music(i)=abs(music(i)*eu(i));
    else
       music(i)=music(i)*el(i)*(-1);
    end
end
% music=music.*envelope;
 %for i=1:N
  %  if music(i)>=0
   %     music(i)=abs(music(i)*U(i));
    %else
     %  music(i)=music(i)*L(i)*(-1);
    %end
%end
 n=round(length(music)/10);
 l=linspace(0,1,n)';
 %music(1:n)=music(1:n).*l;
 ll=linspace(1,0,n)';
%music=adsr(0.0431,0.0805,0.2577,0.6187,music',t);
% music((length(music)-n+1):length(music))=music((length(music)-n+1):length(music)).*ll;
%music=music-mean(music);
music=music/max(abs(music));
end

