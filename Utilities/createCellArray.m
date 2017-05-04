function result = createCellArray(nArrays, arraySize)
%CREATECELLARRAY Summary of this function goes here
%   Detailed explanation goes here

result = cell(1, nArrays);
    for i = 1 : nArrays
        result{i} = zeros(arraySize);
    end
end