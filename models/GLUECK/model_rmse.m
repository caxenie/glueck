% GLUECK: Growth pattern Learning for Unsupervised Extraction of Cancer Kinetics
% Root Mean Squared Error, RMSE
function sum_rmse = model_rmse(alfa, sigma, p, M, y)
N = length(M);
sum_sse = model_sse(alfa, sigma, M, y);
sum_rmse = sqrt(sum_sse/(N-p));
end