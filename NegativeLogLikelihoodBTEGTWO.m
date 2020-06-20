function [negativeLL]=NegativeLogLikelihoodBTEGTWO(parameter_vector,returns)

%% Extract the stuff we need from the input arguments
omega    = parameter_vector(1,1);
phi1 = parameter_vector(2,1);
kappa1 = parameter_vector(3,1);
kappastar1 = parameter_vector(4,1);
phi2  = parameter_vector(5,1);
kappa2 = parameter_vector(6,1);
kappastar2 = parameter_vector(7,1);
nu = parameter_vector(8,1);
mu = parameter_vector(9,1);
T     = size(returns,1);

%% Run the GARCH filter


[ lambda , lambda1 , lambda2 ] = DynamicScalerTwo(omega,phi1,kappa1,kappastar1,phi2,kappa2,kappastar2,nu,mu, returns);

[ sigma ] = exp(lambda);
% Collect a row vector of log likelihood per observation (this is the log
% of the pdf of a t distribution)
LL = - log(sigma(1:T)) + log( gamma( (nu+1) /2 ) / ( gamma( nu/2 ) * sqrt(pi*(nu-2)) )  * ...
    ( 1 + (((returns - mu)./sigma(1:T)).^2 /(nu-2) )).^-((nu+1)/2) );

% Put a negative sign in front and sum over all obserations
negativeLL = - sum( LL(1:end) )    ;            

% Close the function
end

