function decoded = Decoding( encoded , type ,L)
number_of_bits=log2(L);
n=number_of_bits; 
if type==0
    %loop over i from 0 to length of encoded
    %for each n bits, calculate the equivalent binary number and put it
   bit=0;ctr=1;
   for i=1:n:length(encoded)
       bit=0;
      for j=0:n-1
          bit=bit+encoded(i+j)*(2^(mod((i+j),n)));
      end
      decoded(ctr)=bit;
      ctr=ctr+1;
   end
    
   
elseif type==1
    for i=1:length(encoded)
        if encoded(i)==-1
            encoded(i)=0;
        end
    end
    %%Then just like unipolar
    %loop over i from 0 to length of encoded
    %for each n bits, calculate the equivalent binary number and put it
   bit=0;ctr=1;
   for i=1:n:length(encoded)
       bit=0;
      for j=0:n-1
          bit=bit+encoded(i+j)*(2^(mod((i+j),n)));
      end
      decoded(ctr)=bit;
      ctr=ctr+1;
   end

        
else %%type==2 i.e. manchester
    to_decode=zeros(1,length(encoded)/2); ctr=1;
    for i=1:2:length(encoded)
        to_decode(ctr)= encoded(i);
        ctr=ctr+1;
    end
    %%Then Just like Unipolar

    %loop over i from 0 to length of encoded
    %for each n bits, calculate the equivalent binary number and put it
   bit=0;ctr=1;
   for i=1:n:length(to_decode)
       bit=0;
      for j=0:n-1
          bit=bit+to_decode(i+j)*(2^(mod((i+j),n)));
      end
      decoded(ctr)=bit;
      ctr=ctr+1;
   end
      
    
end

end
