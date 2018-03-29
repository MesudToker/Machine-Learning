function [bestConfusion, accuracy] = hw3_q2a(dataPath)
    % dataPath = 'C:\Users\lenovo\Desktop\MESUD\6. Semester\CS 464 Machine Learning\HW 3';
    currPath = cd(dataPath);
    origData = load('clustering.csv');
    cd(currPath);

    bestCenters = zeros(2,2);
    bestConfusion = zeros(2,2);
    bestClass1 = [];
    bestClass2 = [];

    data = origData(:, 1:2);
    label = ones(size(origData(:,3)));

    for k = 1:10000
        centers =  20.*rand(2,2)-10;

        while centers(1,:) == centers(2,:)
            centers =  20.*rand(2,2)-10;
        end

        oldCenters = zeros(2,2);

        class1 = [];
        class2 = [];

        while oldCenters ~= centers
            distance1 = sum((data-centers(1, :)).^2,2);
            distance2 = sum((data-centers(2, :)).^2,2);

            label(distance2 >= distance1) = 1;
            label(distance2 < distance1) = 2;

            class1 = data(label==1, :);
            class2 = data(label==2, :);

            oldCenters = centers;

            centers(1,:) = sum(class1,1)/size(class1,1);
            centers(2,:) = sum(class2,1)/size(class2,1);
        end

        confusion = zeros(2,2);

        for i=1:size(origData(:, 3))
            confusion(label(i),origData(i, 3)) = confusion(label(i),origData(i, 3))+1;
        end

        if bestConfusion(1,1)+bestConfusion(2,2)<confusion(1,1)+confusion(2,2)
            bestConfusion = confusion;
            bestCenters = centers;
            bestClass1 = class1;
            bestClass2 = class2;
        end
    end
    
    accuracy = (bestConfusion(1,1)+bestConfusion(2,2))/2;
    
    figure;
    plot(bestClass1(:,1),bestClass1(:,2),'.r');
    hold on;
    plot(bestClass2(:,1),bestClass2(:,2),'.b');
    plot(bestCenters(1,1),bestCenters(1,2),'r*');
    plot(bestCenters(2,1),bestCenters(2,2),'b*');
    legend('cluster1', 'cluster2', 'center of cluster1', 'center of cluster2');
    title('The visualization of the given dataset');
end