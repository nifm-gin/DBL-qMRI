
%% Description
%
% The aim of this script is to run all the others and to produce numerical
% experiment results that allow to illustrate the interest of the
% dictionary-based statistical learning (DB-SL) method.
%
% Fabien Boux - 01/2020

Init
disp(['Running ' mfilename '.m'])


%% Setting

% Figures are saved in the ./figures folder 
close_figure = 1;

% Specify the number of workers for parallelization
nb_workers = 16;
%p = parpool(nb_workers);


%% Effect of parameter space sampling
% Producing 3 figures:
%   - ParameterSpaceSampling-illustration.fig illustrates
%       2-dimensional projections of 3-dimensional samples obtained from 3
%       different sampling strategies (grid, random and quasi-random).
%
%   - ParameterSpaceSampling.fig
%       Distribution of average RMSE for the different sampling strategies
%       applying the DBL method.
%
%   - ParameterSpaceSampling-supp.fig
%       More experiments and average RMSE is computed for both the DBM and
%       DBL methods.

try
    clear 
    ParameterSpaceSampling
    if close_figure == 1, close all; end
catch
    warning('ParameterSpaceSampling.m execution failed')
end


%% Impact of the dictionary size
% Produce 2 figures: 
%   - DictionarySize.fig
%       Average RMSE are given as a function of the SNR for different
%       dictionary sizes and both the DBM and DBL methods.
%
%   - DictionarySize-supp.fig 
%       More experiments.

try
    clear 
    DictionarySize
    if close_figure == 1, close all; end
catch
    warning('DictionarySize.m execution failed')
end


%% Boundary behaviour
% Produce 2 figures: 
%   - BoundaryBehaviour.fig
%       Average RMSE over the 2-dimensional space obtained using the DBM
%       and the DBL methods on dictionary smaller than this space.
%
%   - BoundaryBehaviour-supp.fig 
%       Same experiment with few randomly picked signals added to the 
%       dictionary.

try
    clear 
    BoundaryBehavior
    if close_figure == 1, close all; end
catch
    warning('BoundaryBehavior.m execution failed')
end


%% Impact of noise on the dictionary signals
% Produce 1 figure: 
%   - NoisyDicoSignals-supp.fig
%       Average RMSE of DBL method are given as a function of the SNR for
%       different dictionary sizes and number of parameters. We compute the
%       estimates with an infinite SNR  (no noise), three values of SNR:
%       30, 60 and 90 and with SNR values randomly picked between 10 and
%       100 for each dictionary signal.

% clear 
% NoisyDicoSignals
% if close_figure == 1, close all; end


%% ConfidenceIndex

try
    clear 
    ConfidenceIndex
    if close_figure == 1, close all; end
catch
    warning('ConfidenceIndex.m execution failed')
end

try
    clear 
    BoundaryBehavior_vMRF
    if close_figure == 1, close all; end
catch
    warning('BoundaryBehavior_vMRF.m execution failed')
end


%% vascular MRF   of the dictionary.

try
    clear 
    vMRFperformance
    if close_figure == 1, close all; end
catch
    warning('vMRFperformance.m execution failed')
end


%% bSSFP fingerprints application
% Produce 2 figures: 
%   - bSSFPfingerprints.fig
%       RMSE on T1 and T2 estimates for both the DBM and the DBL methods.
%
%   - bSSFPfingerprints-supp.fig 
%       Flip angles et repetition times used and some example fingerprints
%       of the dictionary.

try
    clear 
    bSSFPfingerprints
    if close_figure == 1, close all; end
catch
    warning('bSSFPfingerprints.m execution failed')
end


%%







