% GLUECK: Growth pattern Learning for Unsupervised Extraction of Cancer Kinetics
% Evaluate the tumor growth models against the ML approach
% prepare environment
clear;
clc; close all; 
% dataset name
dataset = 'Experiment_dataset_*';
load(dataset);
global T M
% data points and time indices
T = 1:DATASET_LEN_ORIG; T = T';
M = sensory_data_orig.y;
%%  ODE integration is sensitive to initial conditions
% some experiments have a scale 3 order of magnitude larger as others
% adjust the initial condition for these two experiments

% Dataset 1: Rodallec, Anne et al, Tumor growth kinetics of human MDA-MB-231
% Dataset 2: Gaddy et al, Mechanistic modeling quantifies the influence of
% tumor growth kinetics, Volk11b sub-dataset
if experiment_dataset == 1 || (experiment_dataset == 2 && strcmp(study_id, 'Volk11b'))
    minv = 0.2;
else
    minv = 0.02;
end
%% evaluate classical models 
[t1g, y1g] = tumor_growth_model_fit(T, M,'Gompertz', minv);
[t1l, y1l] = tumor_growth_model_fit(T, M,'logistic', minv);
[t1v, y1v] = tumor_growth_model_fit(T, M,'vonBertalanffy', minv);
[t1h, y1h] = tumor_growth_model_fit(T, M,'Holling', minv);
% evaluate the neural model 
t1neuro = T;
y1neuro = neural_model(T)';
% evalute visually 
figure();
set(gcf, 'color', 'w');hold on; box off;
% dataset points
plot(T,M,'r*'); 
% neural model 
plot(t1neuro, y1neuro);
% classical models
plot(t1g,y1g); 
plot(t1l,y1l);
plot(t1v,y1v);
plot(t1h,y1h);
title('Growth models analysis');
legend('Data points', 'GLUECK', 'Gompertz','Logistic','vonBertalanffy','Holling');
legend('boxoff');
box off;
%% boxplot evaluation
figure; set(gcf,'color', 'w'); box off;
% combine the prediction in unified vector
x = [M;y1neuro;y1g;y1l;y1v;y1h];
% create a grouping variable
g1 = repmat({'Data'}, length(M), 1);
g2 = repmat({'GLUECK'}, length(y1neuro), 1);
g3 = repmat({'Gompertz'}, length(y1g), 1);
g4 = repmat({'Logistic'}, length(y1l), 1);
g5 = repmat({'vonBertalanffy'}, length(y1v), 1);
g6 = repmat({'Holling'}, length(y1h), 1);
g=[g1;g2;g3;g4;g5;g6];
boxplot(x, g); box off;
%% Evaluate SSE, RMSE, MAPE

% resample
y1g = interp1(1:length(y1g), y1g, linspace(1,length(y1g),length(M)))';
y1l = interp1(1:length(y1l), y1l, linspace(1,length(y1l),length(M)))';
y1v = interp1(1:length(y1v), y1v, linspace(1,length(y1v),length(M)))';
y1h = interp1(1:length(y1h), y1h, linspace(1,length(y1h),length(M)))';

% params as from [Benzekry et al., 2014c]
alfa = 0.84;
sigma = 0.21;

% locals, model sequence, names and param numbers from [Benzekry et al., 2014c]
models = 1:5;
names = {'GLUECK'; 'Gompertz'; 'Logistic'; 'Bertalanffy'; 'Holling'};
param_num = [0, 2, 2, 3, 3]; % param number for each model 

% SSE
SSEn = model_sse(alfa, sigma, M, y1neuro);
SSEg = model_sse(alfa, sigma, M, y1g);
SSEl = model_sse(alfa, sigma, M, y1l);
SSEv = model_sse(alfa, sigma, M, y1v);
SSEh = model_sse(alfa, sigma, M, y1h);
%plot comparatively
figure(); set(gcf, 'color', 'w'); 
plot(models, [SSEn, SSEg, SSEl, SSEv, SSEh],'k*');box off;
ylabel('SSE');
set(gca,'xtick', models, 'xticklabel', names);

% RMSE
RMSEn = model_rmse(alfa, sigma, param_num(1), M, y1neuro);
RMSEg = model_rmse(alfa, sigma, param_num(2), M, y1g);
RMSEl = model_rmse(alfa, sigma, param_num(3), M, y1l);
RMSEv = model_rmse(alfa, sigma, param_num(4), M, y1v);
RMSEh = model_rmse(alfa, sigma, param_num(5), M, y1h);
%plot comparatively
figure(); set(gcf, 'color', 'w'); 
plot(models, [RMSEn, RMSEg, RMSEl, RMSEv, RMSEh],'k*');
ylabel('RMSE');
set(gca,'xtick', models, 'xticklabel', names);box off;

% sMAPE
sMAPEn = mean(2*abs((M-y1neuro))./(abs(M) + abs(y1neuro)));
sMAPEg = mean(2*abs((M-y1g))./(abs(M) + abs(y1g)));
sMAPEl = mean(2*abs((M-y1g))./(abs(M) + abs(y1g)));
sMAPEv = mean(2*abs((M-y1g))./(abs(M) + abs(y1g)));
sMAPEh = mean(2*abs((M-y1h))./(abs(M) + abs(y1h)));
%plot comparatively
figure(); set(gcf, 'color', 'w'); 
plot(models, [sMAPEn, sMAPEg, sMAPEl, sMAPEv, sMAPEh],'k*');box off;
ylabel('sMAPE');
set(gca,'xtick', models, 'xticklabel', names);

% AIC
AICn = model_aic(alfa, sigma, param_num(1), M, y1neuro);
AICg = model_aic(alfa, sigma, param_num(2), M, y1g);
AICl = model_aic(alfa, sigma, param_num(3), M, y1l);
AICv = model_aic(alfa, sigma, param_num(4), M, y1v);
AICh = model_aic(alfa, sigma, param_num(5), M, y1h);
%plot comparatively
figure(); set(gcf, 'color', 'w'); 
plot(models, [AICn, AICg, AICl, AICv, AICh],'k*');
ylabel('AIC');
set(gca,'xtick', models, 'xticklabel', names);box off;

% BIC
BICn = model_bic(alfa, sigma, param_num(1), M, y1neuro);
BICg = model_bic(alfa, sigma, param_num(2), M, y1g);
BICl = model_bic(alfa, sigma, param_num(3), M, y1l);
BICv = model_bic(alfa, sigma, param_num(4), M, y1v);
BICh = model_bic(alfa, sigma, param_num(5), M, y1h);
%plot comparatively
figure(); set(gcf, 'color', 'w'); 
plot(models, [BICn, BICg, BICl, BICv, BICh],'k*');
ylabel('BIC');
set(gca,'xtick', models, 'xticklabel', names);box off;
