clear all; close all;

Rb = 1000;      fs = 10*Rb;
Tb = 1/Rb;      ts = 1/fs;

Nbit = fs/Rb;

B = fs/2;           % System Bandwidth for Simulation;

Eb = 1/2;             % Bit energy Eb is assumed to be 1;
A = sqrt(Eb/Tb);    % Amplitude of Signal for Unipolar NRZ;
% -------------------------------------------------------------------------
bitlen = 1*10^5;
bit = randi([0,1], 1, bitlen);

[st, t, pulse_shape] = Function_Linecode_Gen(bit, 'unipolar_nrz', Rb, fs);

st = A*st;
% -------------------------------------------------------------------------
Q_FUNC = inline( 'erfc( x / sqrt(2) ) / 2', 'x');
% -------------------------------------------------------------------------

EbNodB = 0:2:12;
for n = 1:length(EbNodB)
    EbNo = 10^(EbNodB(n)/10);
    
    Pe_theory(n) = Q_FUNC(sqrt(2*EbNo/2));
    
    % ---------------------------------------------------------------------
    noise_var = B/EbNo;
    nt = sqrt(noise_var)*randn(1, length(st));
    % ---------------------------------------------------------------------
    rt = st + nt;
        
    z = Function_Matched_Filter(pulse_shape, rt, fs);
    
    bhat = z(Nbit*(1:bitlen));
    bhat(bhat >= 0.5) = 1;
    bhat(bhat < 0.5) = 0;
    % ---------------------------------------------------------------------
    
    errbits = sum(abs(bit-bhat));
    Pe(n) = errbits/bitlen /2;
end

AXIS_BER = [-inf inf 10^(-6) 1];
figure
semilogy(EbNodB, Pe_theory, 'b-.'); hold on;
semilogy(EbNodB, Pe, 'rx-'); hold on;
grid on; axis(AXIS_BER);
xlabel('Eb/No [dB]'); ylabel('Probability of bit error');
title('Unipolar NRZ Signaling');
legend('Theoretical Pb','Simulation result');

