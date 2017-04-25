classdef (Abstract) StructureModel
    %STRUCTUREMODEL Summary of this class goes here
    %   Detailed explanation goes here
    
    properties (SetAccess = protected, GetAccess = protected)
        Input
        Layers
        Output
        Log
    end
    
    methods
        function obj = StructureModel(modelDefinition)
            if (size(modelDefinition,2) >= 2)
                obj = CreateStructure(obj, modelDefinition);
                
            else
                error('Defined dimentions are invalid')
            end
        end
        
        function obj = CreateStructure(obj, modelDefinition)
            networkWidth = size(modelDefinition,2);
               
            obj.Input.values = zeros(modelDefinition(1),1);
            obj.Input.weights = zeros(modelDefinition(1),modelDefinition(2));
            layers(1).values = obj.Input.values;
            layers(1).weights = obj.Input.weights;

            obj.Output.values = zeros(modelDefinition(networkWidth),1);
            layers(networkWidth).values = obj.Output.values;

            % for each inner layer
            for i=2:networkWidth-1
               layers(i).values = [obj.Layers zeros(modelDefinition(i),1)];
               layers(i).weights = [obj.Layers zeros(modelDefinition(i),modelDefinition(i+1))];
            end

            obj.Layers = layers;
            obj.Log.initial = {obj.Input, obj.Layers, obj.Output};
        end
        
        function obj = Predict(obj, dataSet)
            obj.Input = dataSet;
        end
    end
    
    methods (Abstract)
        obj = Init(obj, dataSet)
        obj = Train(obj, learningModel)
    end
    
end

