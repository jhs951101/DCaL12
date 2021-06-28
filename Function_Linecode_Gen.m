function [x, time, pulse_shape] = Function_Linecode_Gen(bit, code_name, Rb, fs)

Tb = 1/Rb; ts = 1/fs;
Nbit = fs/Rb;

bitlen = length(bit);

bitp = bit;
bitp(bitp==0) = -1;
bitb = zeros(1, bitlen);
bflag = 1;
for ii = 1:bitlen
    if bitp(ii) == 0
        bitb(ii) = bitp(ii);
    elseif bitp(ii) == 1
        bitb(ii) = bflag;
        bflag = -bflag;
    end
end
% -------------------------------------------------------------------------
time = 0:ts:(bitlen*Tb)-ts;

pulse_nrz = ones(1, Nbit);
pulse_rz = [ones(1, Nbit/2), zeros(1, Nbit/2)];
pulse_man = [ones(1,Nbit/2), -ones(1,Nbit/2)];
%pulse_tri = 
% -------------------------------------------------------------------------
if strcmp(code_name, 'unipolar_nrz')
    x = bit'*pulse_nrz;
    pulse_shape = pulse_nrz;
elseif strcmp(code_name, 'polar_nrz')
    x = bitp'*pulse_nrz;
    pulse_shape = pulse_nrz;
elseif strcmp(code_name, 'bipolar_nrz')
    x = bitb'*pulse_nrz;
    pulse_shape = pulse_nrz;
elseif strcmp(code_name, 'unipolar_rz')
    x = bit'*pulse_rz;
    pulse_shape = pulse_rz;
elseif strcmp(code_name, 'polar_rz')
    x = bitp'*pulse_rz;
    pulse_shape = pulse_rz;
elseif strcmp(code_name, 'bipolar_rz')
    x = bitb'*pulse_rz;
    pulse_shape = pulse_rz;
elseif strcmp(code_name, 'manchester')
    x = bitp'*pulse_man;
    pulse_shape = pulse_man;
%elseif strcmp(code_name, 'triangular')
   
    
end
% -------------------------------------------------------------------------
x = x';     x = x(:)';









