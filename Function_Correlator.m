function hout = Function_Correlator(g, in, fs)

% CORRELATION RECEIVER
% Input arguments :
%   g ; basic pulse shape of the line code
%   in : received signal which input to the matched filter
%   fs : sampling rate

ts = 1/fs;
x = in(1:end-1);


Nbit = length(g);
bitlen = length(x)/length(g);

x = reshape(x, Nbit, bitlen);

hout = zeros(Nbit, bitlen);

for ii = 1:bitlen
    hout(:,ii) = x(:,ii).*g';
end
hout = cumsum(hout).*ts;
hout = hout(:)';
hout = [hout, 0];
