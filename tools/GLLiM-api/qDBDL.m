function [Estimation, Model] = qDBDL(Sequences, Dico, References, Model)

if nargin < 2, error('Not enought input arguments'); end
if ~exist('References','var'),  References  = []; end
if ~exist('Model','var'),       Model       = []; end

% Format MRI data in 3D or 4D matrices
[Sequences,s1,s2,t,slices] = SequencesSizes(Sequences);
if ~isempty(References) && length(size(References))== 2
    References = reshape(References, s1, s2, size(References,2));
end

% This parameters is only used to enable the parameter data normalisation
% it can possibly be set to zero but this is not recommended 
normalization = 1;

% Model (neural network) settings
if ~any(strcmp(fieldnames(Model),'Z')), Model.Z = 100; end
if ~any(strcmp(fieldnames(Model),'H')), Model.H = 6; end
if ~any(strcmp(fieldnames(Model),'Exec')), Model.Exec = 'auto'; end


% If no model has already be computed (ie theta), learn it
tic
if ~any(strcmp(fieldnames(Model),'NeuralNet'))
    if normalization == 1
        Model.factors.Ymin = min(Dico.Parameters.Par);
        Model.factors.Ymax = max(Dico.Parameters.Par - Model.factors.Ymin);
        Dico.Parameters.Par = (Dico.Parameters.Par - Model.factors.Ymin) ./ Model.factors.Ymax;
        Model.factors.normalization = 1;
        
    else
        Model.factors.Ymin = 0;
        Model.factors.Ymax = 1;
        Model.factors.normalization = 0;
    end
    
    Model.NeuralNet = EstimateNNmodel(Dico.MRSignals, Dico.Parameters.Par, 0, Model.Exec, Model.Z, Model.H);
end
Estimation.Regression.learning_time = toc; 

% Use the model to quantify estimates
tic
for s = 1:slices
    Estimation.Regression.Y(:,:,:,s) = EstimateParametersFromNNmodel(reshape(Sequences(:,:,:),s1*s2,t), Model.NeuralNet, Model.Exec);
    Estimation.Regression.Y(:,:,:,s) = (Estimation.Regression.Y(:,:,:,s) .* Model.factors.Ymax) + Model.factors.Ymin;
    
    if ~isempty(References)
        [Estimation.Regression.Errors.Rmse(s,:), Estimation.Regression.Errors.Nrmse(s,:), Estimation.Regression.Errors.Mae(s,:), Estimation.Regression.Errors.Nmae(s,:)] = ...
            EvaluateEstimation(reshape(References(:,:,:,s),s1*s2,size(References,3)), reshape(Estimation.Regression.Y(:,:,:,s),s1*s2,size(References,3)));
    end
end
Estimation.Regression.quantification_time = toc;