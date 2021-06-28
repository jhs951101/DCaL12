function bhat = Function_Sampling_Receiver(x, Rb, fs)

Nbit = fs/Rb;

bhat = x(Nbit/2:Nbit:end);
bhat(bhat>0) = 1;
bhat(bhat<0) = 0;