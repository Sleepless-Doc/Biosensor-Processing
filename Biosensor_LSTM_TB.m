clear all
close all
clc

load Toy_Dataset.mat

%Select classification type: 0 - binary, 1 - concentration
Classification_type = 0;

%Select feature extraction methods: 1 - yes, 0 - no
FE_raw_data = 1;
FE_time_differentiation = 1;
FE_wavelett = 0;
Wavelett_level = 3;
FE_array = [FE_raw_data,FE_time_differentiation,FE_wavelett,Wavelett_level];

%LSTM Parameters
maxEpochs = 300;
miniBatchSize = 30;
%%

if(Classification_type == 0)%Binary Classification
    numHiddenUnits = 90;
    training_labels = toy_training_labels_binary;
    test_labels = toy_testing_labels_binary;
    classLabels = ["0", "1"];
else                        %Concentration Classification
    numHiddenUnits = 180;
    training_labels = toy_training_labels_concentration;
    test_labels = toy_testing_labels_concentration;
    classLabels = ["0µM", "25µM", "50µM", "75µM", "100µM"]';
end

training_data = Prep_data(toy_training_data,FE_array);

net = get_network(Classification_type,FE_array,training_data,training_labels,...
    maxEpochs,miniBatchSize,numHiddenUnits)

testing_data = Prep_data(toy_testing_data,FE_array);
YPred = classify(net,testing_data,'MiniBatchSize',15,'SequenceLength','longest');

C = confusionmat(YPred,test_labels);
C = confusionchart(C,classLabels);
sortClasses(C,classLabels)
