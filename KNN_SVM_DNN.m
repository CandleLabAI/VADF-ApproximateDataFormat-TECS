% This file implements KNN, SVM and DNN applications using VADF compression.

train_data=readtable("mnist_train.csv","VariableNamingRule","preserve")
test_data = readtable("mnist_test.csv","VariableNamingRule","preserve")
train_data=train_data{1:20000,:}
test_data=test_data{1:2000,:}
%%
for i=1:size(train_data(:,1),1)
    for j=1:size(train_data(1,:),2)
        train_data(i,j)= vadf(train_data(i,j),8,4);
    end
 end   
%%
for i=1:size(test_data(:,1),1)
    for j=2:size(test_data(1,:),2)
        test_data(i,j)= vadf(test_data(i,j),8,4);  %To introduce soft-error, replace vadf with vadf_1b function.      
    end
end

%In above code, if you do not use VADF function, then you are simulating baseline execution, i.e., without VADF compression. 

%% 
% *######################################################*

xtrain=train_data(:,2:size(train_data(1,:),2));
ytrain=train_data(:,1);
xtest=test_data(:,2:size(test_data(1,:),2));
ytest=test_data(:,1);

%%

% r1 = randi(size(xtrain,2)-1,size(xtrain,1),32);
r2 = randi(size(xtest,2)-1,size(xtest,1),32);
% for i=1:size(r1,1)    
%     for j=1:size(r1,2)
%         xtrain(i,r1(i,j))=FTapprox_1b(xtrain(i,j),8,2);
%     end
% end
for i=1:size(r2,1)    
    for j=1:size(r2,2)
        xtest(i,r2(i,j))=vadf_1b(xtest(i,j),8,4);
    end
end
%% 
% 

knn_acc=knn(xtrain,ytrain,xtest,ytest)
svm_acc=svm(xtrain,ytrain,xtest,ytest)
dnn_acc=dnn(xtrain,ytrain,xtest,ytest)

%%
function accuracy_knn=knn(xtrain,ytrain,xtest,ytest)
    m1=fitcknn(xtrain,ytrain,'NumNeighbors',5);
    pred=predict(m1,xtest);
    %result=confusionmat(pred,ytest);
    accuracy_knn = sum(pred == ytest,'all')/numel(pred);
end

function accuracy_svm=svm(xtrain,ytrain,xtest,ytest)
   t = templateSVM('Standardize',true,'KernelFunction','linear');
   svm=fitcecoc(xtrain,ytrain,"Learners",t);  
   pred=predict(svm,xtest);
   accuracy_svm = sum(pred == ytest,'all')/numel(pred);
end

function accuracy_dnn=dnn(xtrain,ytrain,xtest,ytest)
    layers = [
    featureInputLayer(784,'Normalization', 'zscore')
    fullyConnectedLayer(100)
    batchNormalizationLayer
    reluLayer
    fullyConnectedLayer(10)
    softmaxLayer
    classificationLayer];
    miniBatchSize = 16;
    options = trainingOptions('adam','MiniBatchSize',miniBatchSize,'Shuffle','every-epoch','Plots','training-progress','Verbose',false);
    ytrain=categorical(ytrain);
    net = trainNetwork(xtrain,ytrain,layers,options);
    YPred = classify(net,xtest,'MiniBatchSize',miniBatchSize);
    labels=double(string(YPred));
    accuracy_dnn = sum(labels == ytest,'all')/numel(ytest);
end
