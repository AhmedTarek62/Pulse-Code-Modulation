function [ encoded, type ] = Encoding( n, x )
%n: N.of levels
%x: Matrix of level values in decimal 
encoded=[];
prompt = 'Enter 0 for Unipolar NRZ, 1 for Polar NRZ and 2 for Manchester coding';
type = input(prompt);
% Step1: Converting level values from decimal to binary 

bits= log2(n); % Number of bits per sample
y=[];              %bit matrix
for i=1:length(x)
    d= x(i);   %to let levels start at zero 
    y=[y double(dec2bin(d,bits))-48]; 

end
 %Unipolar NRZ 
 if type==0
figure
stairs([y y(length(y))],'linewidth',1.5)  
title('Unipolar NRZ Encoding')
ylim([-2 2]);
for j=1:length(y)
encoded(j)= y(j);
end
 
% Polar NRZ
 elseif type==1
ypolar=[];
% since 0 is represented by a stair at -1, I created another matrix where all zeros become -1s 
for i=1: length(y) 
    if y(i)==0
        ypolar(i)=-1; 
    else 
        ypolar(i)=y(i); 
    end
end
figure
stairs([ypolar ypolar(length(ypolar))],'linewidth',1.5) 
ylim([-2 2]);
title('Polar NRZ Encoding')

for j=1:length(ypolar)
encoded(j)= ypolar(j);
end
% Manchester 
%Clock value Xnor unipolar= Manchester
 elseif type==2
yMan=[]; 
for i=1:length(y) 
        yMan= [yMan ~xor(y(i), 1)];
        yMan=[yMan ~xor(y(i),0)];
    
end
figure
stairs([yMan yMan(length(yMan))],'linewidth',1.5)  
title('Manchester Encoding')
ylim([-2 2]);
for j=1:length(yMan)
encoded(j)= yMan(j);
end
 
else 
    prompt = 'Please stick to the values and try again';
 end

end