function [history, percent_cheering]  = crowdsim(rows, columns, init_threshold, threshold, rounds, num_cheerstarter)

history=[]; %Initializes Empty History Matrix

base_cheering=10+1*randn(rows,columns); %Sets the innate support level for each fan, sampled from a normal distribution with mean 10 and standard deviation 1

cheering=zeros(rows,columns); %Initializes Empty Cheering Matrix

%Loop randomly places the num_cheerstarter cheerstarters into the crowd by setting the corresponding element in the cheering matrix equal to 1 
if num_cheerstarter>0
    cheer_starter_locations=randi(rows*columns, num_cheerstarter, 1);
    for i=1:num_cheerstarter
        cheering(cheer_starter_locations(i))=1;
    end
end

percent_cheering=[]; %Intializes empty vector to store the percentage of the crowd cheering at the end of each round

% For each round this loop checks to see if whether each person in the
% crowd will begin to cheer. In round 1 it checks to see which people are
% initially cheering by comparing each element in the base_cheering matrix
% to the init_threshold. It then sets the corresponding element in the
% cheering matrix equal to 1 if the threshold is exceeded. For all
% subsequent rounds, the elements in scaled_cheering are compared to the
% absoluted threshold, threshold. If the absolute threshold is exceeded,
% the corresponding element in the cheering matrix is set to 1.
for r=1:rounds
    for i=1:rows
        for j=1:columns
            if r==1
                if base_cheering(i,j)>init_threshold
                    cheering(i,j)=1;
                end
            else
                if scaled_cheering(i,j)>threshold
                    cheering(i,j)=1;
                end
            end
        end
    end
    
adjacency_cheering=conv2(cheering, [1 1 1;1 0 1;1 1 1],'same')+ones(rows,columns);% Calculates how many elements around a given element in the cheering matrix are equal to 1. Outputs a matrix with these values.

scaled_cheering=zeros(rows,columns);

%Computes the scaled_cheering metric for each person.
for i=1:rows
    for j=1:columns
        scaled_cheering(i,j)=base_cheering(i,j)*adjacency_cheering(i,j)+r;
    end
end

%Calculates the percentage of the crowd cheering and stores it.
percent=sum(sum(cheering))/(rows*columns);

percent_cheering=[percent_cheering percent];

history=[history; ones(1, columns); cheering]; %Stores snapshot of crowd.


end

end

