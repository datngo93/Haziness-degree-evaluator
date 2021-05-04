%%=========================================================================
% Copyright ©2020, SoC Design Lab., Dong-A University. All Right Reserved.
%==========================================================================
% - Date       : 2020/01/13
% - Author     : Dat Ngo
% - Affiliation: SoC Design Lab. - Dong-A University
% - Design     : Recording new_indicator_v5 value on hazy images
%==========================================================================

%% Clean-up
close all;
clear;
clc;

%% Add necessary path
addpath(genpath('source_code/'));
addpath(genpath('path to FADE source code'));

%% Input image
imgnum = 8;
in_img_path = 'path to test images';

%% Recording DF values
timerec_fade = zeros(imgnum,1);
timerec_df = zeros(imgnum,1);
timerec_hde = zeros(imgnum,1);

for index = 1:imgnum
    img = imread([in_img_path,num2str(index,'%d'),'.jpg']);
    
    % FADE
    func = @() FADE(img);
    timerec_fade(index) = timeit(func);
    
    % DF
    func = @() ref_model(img);
    timerec_df(index) = timeit(func);
    
    % HDE
    func = @() new_indicator_v5_opt(img,5,9);
    timerec_hde(index) = timeit(func);
end
