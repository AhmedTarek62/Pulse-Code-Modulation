function y=quantize_mu(sig,L,mp,mu)

sc=compand(sig,mu,mp,'mu/compressor'); %compressed signal
scq=quantize_uni(sc,L,mp); %quantized signal
y=compand(scq,mu,mp,'mu/expander'); %compressed signal

end