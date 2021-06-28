function [y, seed] = gaussian_noise(mean,variance,n,seed)

%
% Generates n Gaussian distributed random variables
%

if (nargin == 4)
   randn('seed',seed);
end

%-------------------------------------------------------------------------
% Generate N(0,1) random variables x and transform to N(mean,variance)
% variables using y = (sqrt(variance)*x) + mean)
%-------------------------------------------------------------------------

y = sqrt(variance)*randn(n) + mean;
if (nargout == 2), seed = randn('seed'); end
