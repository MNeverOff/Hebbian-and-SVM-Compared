classdef (Abstract) StructureModel
    %StructureModel Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        Input
        Layers
        Output
        Log
    end
    
    methods
        function obj = StructureModel(modelDefinition, labels)
            if nargin == 0
                % Handle the no-argument case
                error('Defined dimentions are invalid')
            end
            
            if (size(labels,2) ~= 2)
                error('labels size is invalid')
            else
            end
            
            if (size(modelDefinition,2) >= 2)
                obj = CreateStructure(obj, modelDefinition, labels);     
            else
                error('Defined dimentions are invalid')
            end
        end
        
        function obj = CreateStructure(obj, modelDefinition, labels, thetaFunction)
            networkWidth = size(modelDefinition,2);
               
            obj.Input.values = [];
            obj.Input.labels = [];
            layers(1).values = obj.Input.values;
            layers(1).weights = zeros(modelDefinition(1),modelDefinition(2));

            obj.Output.values = zeros(modelDefinition(networkWidth),1);
            obj.Output.labels = labels;

            theta = thetaFunction(thetaFunction, 0.1); % second param is random connectivity rate
            
            % for each inner layer
            for i=2:networkWidth-1
               layers(i).values = [zeros(modelDefinition(i),1)];
               %layers(i).weights = [zeros(modelDefinition(i),modelDefinition(i+1))];
               layers(i).weights = theta{i};
            end

            obj.Layers = layers;
            obj.Log.initial = {obj.Input, obj.Layers, obj.Output};
        end
        
        function obj = Init(obj, dataSet)
            [obj.Input.values, obj.Input.labels] = balanceSet(...
                dataSet.values, dataSet.labels, obj.Output.labels(1), obj.Output.labels(1));
            obj.Layers(1).values = obj.Input.values;
            
            obj.Log.init = {obj.Input, obj.Layers, obj.Output};
        end
        
        function obj = Predict(obj, dataSet)
            obj.Input = dataSet;
        end
    end
    
    
    
    methods (Abstract)
        obj = Train(obj, learningModel)
    end
    
end

