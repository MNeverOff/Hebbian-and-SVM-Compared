classdef OneVsOneModel < StructureModel
    %OneVsOneModel Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        
    end
    
    methods
        function obj = OneVsOneModel(modelDefinition, labels, thetaFunction)
            obj = obj@StructureModel(modelDefinition, labels, thetaFunction);
        end
        
        function obj = Init(obj, dataSet)
            [obj.Input.values, obj.Input.labels] = obj.BalanceSet(...
                dataSet.values, dataSet.labels, obj.Output.labels(1), obj.Output.labels(2));
            obj.Layers(1).values = obj.Input.values;
            
            obj.Log.init = {obj.Input, obj.Layers, obj.Output};
        end
        
        % Change to label-less balancing, leave as aux method
        function [balancedValues, balancedLabels] = BalanceSet(obj, values, ...
                labels, label1, label2)
            %BalanceSet Balance the set: creates an equal distribution of
            %two digits from the data set with values and labels
            %   values = data set values
            %   labels = data set labels
            %   label1 = first label
            %   label2 = second label
            input_layer_size = size(values,2); 

            % Getting correct labels, forming up the size
            yF = [];
            for I=1:size(labels,1)
               if (labels(I) == label1 || labels(I) == label2)
                  yF = [yF; labels(I)];
               end
            end

            num = size(yF,1);
            xF = zeros(num, input_layer_size);

            % Creating values array and getting correct labels again
            j = 1;
            for I=1:size(labels,1)
               if (labels(I) == label1 || labels(I) == label2)
                  xF(j,:) = values(I,:);
                  j = j+1;
               end
            end

            balancedValues = xF; balancedLabels = yF;
        end
        
        function Train(obj, dataSet)
            
        end
    end
    
end

