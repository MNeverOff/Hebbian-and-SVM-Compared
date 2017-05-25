classdef LearningModel
    %LEARNINGMODEL Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        
    end
    
    methods
        
    end
    
    methods (Abstract)
        obj = Run(obj, Theta, values, labels, )
    end
    
end