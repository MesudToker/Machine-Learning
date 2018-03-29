function hw3_q3b (dataPath)
    % dataPath = 'C:\Users\lenovo\Desktop\MESUD\6. Semester\CS 464 Machine Learning\HW 3';
    currPath = cd(dataPath);
    data = importdata('digits.csv');
    cd(currPath)

    sample = data(:,1:end-1);
    N = size(sample,2);
    [digits,~,~] = pca(abs(sample));

    for i = [1:5 N-4:N]
        I = digits( :,i );
        figure, imagesc( reshape( I, 20, 20 ) );
        colormap( gray );
        axis image;
        title(strcat('Principal Component-', num2str(i)))
    end
end