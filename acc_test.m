%% Clean-up
close all;
clear;
clc;

%% Unknown input data
% FADE
hazy_fade = [];
hazefree_fade = [];

load("FADE/dfRESIDE.mat");
hazy_fade = cat(1,hazy_fade,df_value); clear df_value;
load("FADE/dfRESIDE_GT.mat");
hazefree_fade = cat(1,hazefree_fade,df_value); clear df_value;


% DF
hazy_df = [];
hazefree_df = [];

load("DF/dfRESIDE.mat");
hazy_df = cat(1,hazy_df,df_value); clear df_value;
load("DF/dfRESIDE_GT.mat");
hazefree_df = cat(1,hazefree_df,df_value); clear df_value;


% HDE
hazy_hde = [];
hazefree_hde = [];

load("HDE/dfRESIDE.mat");
hazy_hde = cat(1,hazy_hde,df_value); clear df_value;
load("HDE/dfRESIDE_GT.mat");
hazefree_hde = cat(1,hazefree_hde,df_value); clear df_value;

%% Hazy/haze-free classification
thres_fade = 0.9866;
thres_df = 0.2968;
thres_hde = 0.8811;

acc_fade = classifyhhf(hazy_fade,hazefree_fade,thres_fade);
acc_df = classifyhhf(hazy_df,hazefree_df,thres_df);
acc_hde = classifyhhf(hazy_hde,hazefree_hde,thres_hde);

%% Auxiliary function
function [acc_info] = classifyhhf(h,hf,thres)

P = length(h);
TP = sum(h>thres);
TPR = TP/P;
FN = P-TP;
FNR = FN/P;

N = length(hf);
TN = sum(hf<=thres);
TNR = TN/N;
FP = N-TN;
FPR = FP/N;

ACC = (TP+TN)/(P+N);

acc_info.P = P;
acc_info.TP = TP;
acc_info.TPR = TPR;
acc_info.FN = FN;
acc_info.FNR = FNR;

acc_info.N = N;
acc_info.TN = TN;
acc_info.TNR = TNR;
acc_info.FP = FP;
acc_info.FPR = FPR;

acc_info.ACC = ACC;

end
