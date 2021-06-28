function hout = Function_Matched_Filter(g, in, fs)

% MATCHED FILTER
% Input arguments :
%   g ; basic pulse shape of the line code
%   in : received signal which input to the matched filter
%   fs : sampling rate

ts = 1/fs;

h = g(length(g):-1:1);

hout = conv(in, h)*ts;
hout = [hout, 0];