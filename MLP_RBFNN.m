clc, clear all, close

A= 151;
B = 300;
%length of robot arms
l1 = 3; 
l2 = 3;
l3 = 3; 


% input and target
I = [];
T = [];

for k =1:150
    t = (B-A)*rand() + B;
    
    %angles of robot
    theta1 = 0.3 * cos(t);
    theta2 = 0.3 * sin(t);
    theta3 = 0.2 * cos(t);

    I = [I;theta1, theta2, theta2];
    
    %trajactory of robot
    x = l1*cos(theta1) + l2*cos(theta2) + l3*cos(theta3);
    y = l1*sin(theta1) + l2*sin(theta2) + l3*sin(theta3);
    
    T = [T;x,y];
  
end

%split data into train data and test data
I_train =I(1:150,:) %120
I_test =I(121:150,:); 
length = length(I_train)
T_train = T(1:150,:);  %120
T_test = T(121:150,:); %T(121:150,:)
numFeatures = 3 ;


plot(I_train)
plot(T_train)
title('Training data')
legend('I-training data', 'T-training data')

%plot(I_test)



%mlp layer
layers = [
    featureInputLayer(numFeatures,'Normalization', 'zscore')
    fullyConnectedLayer(50)
    batchNormalizationLayer
    reluLayer
    fullyConnectedLayer(2)
    regressionLayer()
    ];
%Specify the training options.
miniBatchSize = 16;

options = trainingOptions('adam', ...
    'MiniBatchSize',miniBatchSize, ...
    'MaxEpochs',100,...
    'Shuffle','every-epoch', ...
    'Plots','training-progress', ...
    'Verbose',false);
%Train the network using the architecture defined by layers, the training data, and the training options.
net = trainNetwork(I_train,T_train,layers,options);


pred1 = predict(net,I_test);

% Evaluate the performance of the model by calculating the root-mean-square error (RMSE) of the predicted and
% actual angles of rotation.
rmse1 = sqrt(sum(mean((T_test - pred1).^2)))

%% RBFNN

net = newrb(I_train', T_train');
pred2 = net(I_test');
rmse2 = sqrt(sum(mean((T_test - pred2').^2)))



