function y= guitar(fs,t,f,timbre)
%GUITARMUSIC Summary of this function goes here
%   Detailed explanation goes here
%总采样个数
N=round(fs*t);
%每周期采样个数
p=(1/f)*fs;
l=ceil(p);
%采样周期数
np=floor(N/p)-1;
%随机生成一个周期信号
part=timbre(1:l);
part=part-mean(part);
%生成Nx1的空矩阵
y=zeros(N,1);
r=0.5;
for i=1:np
    part=part*r+[part(end);part(1:end-1)]*(1-r);
    pos=floor((i-1)*p+1);
    y(pos:pos+l-1)=part;
end
y=y.*linspace(1,0,length(y))';

end

