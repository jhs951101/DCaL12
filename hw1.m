clear all; close all;

Rb = 1000;      fs = 100*Rb;
Tb = 1/Rb;      ts = 1/fs;

Nbit = fs/Rb;
Nsym = (2*fs)/Rb;

% -------------------------------------------------------------------------
bitlen = 10^1;
bit = randi([0,1], 1, bitlen);

[st, time, pulse_shape] = Function_Linecode_Gen(bit, 'polar_nrz', Rb, fs);
st = 5*st;
% -------------------------------------------------------------------------
Ttime = 0:ts:bitlen*Tb-ts;
% -------------------------------------------------------------------------
noise_power = 10;  % 10, 20, 30
nt = sqrt(noise_power)*randn(1, length(st));

rt = st + nt;
% -------------------------------------------------------------------------
AXIS_TIME = [0, bitlen*Tb, -25 25];

figure
stairs(Ttime, st);
grid on; axis(AXIS_TIME);
xlabel('time [sec]'); title('Polar NRZ Signal');

figure
plot(Ttime, rt);
grid on; axis(AXIS_TIME);
xlabel('time [sec]'); title(['Received Signal with Noise, variance = ',num2str(noise_power)]);
% -------------------------------------------------------------------------
% Rx : Sampling Receiver;
bhat1 = Function_Sampling_Receiver(rt, Rb, fs);

% Rx : Matched Filter;
AXIS_MATCHED = [0, (bitlen+1)*Tb, -10*Tb 10*Tb];
Ytime = 0:ts:(bitlen+1)*Tb-ts;
y_matched = Function_Matched_Filter(pulse_shape, rt, fs);

bhat2 = y_matched(Nbit:Nbit:end);
bhat2 = bhat2(1:end-1);
bhat2(bhat2>0) = 1; bhat2(bhat2<0) = 0;
% -------------------------------------------------------------------------
figure
plot(Ytime, y_matched);
grid on; axis(AXIS_MATCHED);
xlabel('time [sec]'); title('Output of Matched Filter in Rx');
% -------------------------------------------------------------------------
Prob_Err_Sampling = sum(abs(bit-bhat1))/bitlen
Prob_Err_Matched = sum(abs(bit-bhat2))/bitlen

