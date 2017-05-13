function obj = createModel(code, Config)
%CREATEMODEL Takes in string code of the model and parameters, returns the
%appropriate object
%   code = string like OvO or OvM
%   modelDefinition = is an vector-string of layer sizes [784 100 2] 

%networkDepth =  size(modelDefinition,2);

switch code
    case string('OvO')
        obj = OneVsOneModel(Config.Sizes, Config.Labels, @Config.ThetaFunction);
    case string('OvM')
        %modelDefinition(networkDepth) = 2;
        %obj = OneVsManyModel(modelDefinition);
    otherwise
        error('No model found for code given')
end

end

