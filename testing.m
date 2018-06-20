%%
syms t;
m_t(t)=5*sin(20*pi*t);
f_s=50;
[t,Y]=IdealSampler(m_t,f_s);
sig=Y;
%%
%Quantization Section
prompt='Please input number of Quantization levels (L): ';
    L=input(prompt); %%was:: L=10;
    prompt='Please input maximum Amplitude allowed. (mp): ';
    mp=input(prompt); %% was:: mp=1;
    
prompt='Please input the 0 for mu quantization, 1 for uniform mid-rise quantization: ';
uni_flag=input(prompt);
if ~uni_flag  
    prompt='Please input mu (255 recommended): '; 
    mu=input(prompt);%% was:: mu=255;
    z=quantize_mu(sig,L,mp,mu);
else 
    y=quantize_uni(sig,L,mp);
end

 

zeroaxis=zeros(1,length(t));
if uni_flag
    figure
    %first plot: uniform quantization o/p and i/p
    subplot(1,2,1)
    plot(t, sig, t,y,t,zeroaxis);
    plot1title=strcat('Uniform Mid-rise Quantization for L = ', num2str(L), ...
        ', m_p = ', num2str(mp));
    title(plot1title);
    xlabel('Time (s)');
    ylabel('Signal (V)');
    legend('Input','Output');
end

%second plot: non-uniform quantization o/p and i/p
if ~uni_flag
    figure
    subplot(1,2,2)
    plot(t, sig, t,z,t,zeroaxis);
    plot2title=strcat('Non-uniform mu-Law Quantization for L = ', num2str(L), ...
        ', m_p = ', num2str(mp), ', mu = ', num2str(mu));
    title(plot2title);
    xlabel('Time (s)');
    ylabel('Signal (V)');
    legend('Input','Output');
end

%%
%Mapping the values to levels section.
%1:Get 'quantized' Array regardless of the quantization method.
if uni_flag %%was uniformly quantized (i.e. quanitzed signal is y)
    quantized=y;
else %%quanitzed signal is z
    quantized=z;
end

%2:Assign each /NEW/ value to mapping key

key=NaN;
ctr=1;
for i=1:length(quantized)
    found_flag=0;
    for j=1:length(key)
        if key(j)==round(quantized(i),3); %%%%%%%First Fix
            found_flag=1;
        end
    end
    if ~found_flag
        key(ctr)=round(quantized(i),3); %%%%%%%%Second Fix
        ctr=ctr+1;
    end
end

%3 Now, change each value in quantized to its level's name
%(That is the index where it is found-1)
%Since levels go like 0 1 2 3.. while indices go like 1 2 3...

Mapped_Quantized=zeros(1,length(quantized));
for i=1:length(quantized)
    Mapped_Quantized(i)=find(key==round(quantized(i))-1); %%%%%%Third Fix
end

%%
%Encoding Section
  [encoded,type]=Encoding(L,Mapped_Quantized);
%type Map
%0->    Unipolar NRZ
%1->    Polar NRZ
%2->    Manchester

%%
%Decoding Section
decoded=Decoding(encoded,type,L);

%%
%DeMapping Section
Final_Decoded=zeros(1,length(decoded));
for i=1:length(decoded)
    Final_Decoded(i)=key(decoded(i)+1);
end



%%
%Filtering Section
%%Use Final_Decoded here.

ReconstructionFilter1(t,Y,10,f_S);
