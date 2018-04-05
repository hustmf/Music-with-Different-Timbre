function music = violinTimbre(t,f)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
 fs=44100;
count=0;
k=30;
 F=f;
 %Hz=[132 148 165 175 197 220 247];
 Hz=[262 294 330 349 392 440 494];
 name=['l1.mat';'l2.mat';'l3.mat';'l4.mat';'l5.mat';'l6.mat';'l7.mat';'m1.mat'];
 while F<255
     F=2*F;
 end
 while F>510
     F=F/2;
count=count+1;
 end
 [value,loc]=min(abs(Hz-F));
 load('violinSpectrum.mat');
 strength=fv(1:k,2*loc);
 
 load(name(loc,1:6));
 N=round(fs*t);
m=round(0.2*length(yupper));
     p=ceil((N-m)/(length(yupper)-m));
     if p<=0
         p=1
     end
     U1=resample(yupper(m+1:length(yupper)),p,1);
     L1=resample(ylower(m+1:length(ylower)),p,1);
     U=[yupper(1:m);U1];
     L=[ylower(1:m);L1];
     U=U(1:N);
     L=L(1:N);
     

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

% music=music.*envelope;
 for i=1:N
    if music(i)>=0
        music(i)=abs(music(i)*U(i));
    else
       music(i)=music(i)*L(i)*(-1);
    end
end
 n=round(length(music)/10);
 l=linspace(0,1,n)';
 %music(1:n)=music(1:n).*l;
 ll=linspace(1,0,n)';
 music((length(music)-n+1):length(music))=music((length(music)-n+1):length(music)).*ll;
%music=music-mean(music);
music=music/max(abs(music));
end

