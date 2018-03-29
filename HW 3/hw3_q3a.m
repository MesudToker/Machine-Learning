function hw3_q3a (dataPath)
    % dataPath = 'C:\Users\lenovo\Desktop\MESUD\6. Semester\CS 464 Machine Learning\HW 3';
    currPath = cd(dataPath);
    data = importdata('digits.csv');
    cd(currPath)

    sample = data(:,1:end-1);
    [~,~,eigenvalues] = pca(abs(sample));

    figure;
    plot(eigenvalues);
    title('eigenvalues in descending order');
end