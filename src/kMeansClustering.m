% K均值聚类函数
function clusteredImg = kMeansClustering(~, I, k)
    [rows, cols] = size(I);
    data = I(:);
    centroids = linspace(min(data), max(data), k);
    labels = zeros(size(data));
    while true
        oldCentroids = centroids;
        for i = 1:length(data)
            [~, labels(i)] = min(abs(data(i) - centroids));
        end
        for j = 1:k
            centroids(j) = mean(data(labels == j));
        end
        if isequal(oldCentroids, centroids)
            break;
        end
    end
    clusteredImg = reshape(labels, rows, cols);
end