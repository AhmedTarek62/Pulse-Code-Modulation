function [t,Y] = ReconstructionFilter1(t1,Y1,B_W,f_s)
t=t1;
T_s=1/f_s;
for i=1:length(t)
    Y2(i)=2*B_W*T_s*sinc(2*pi*B_W*t(i));
end
Y=conv(double(Y1),Y2);



