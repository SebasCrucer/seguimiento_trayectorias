function heatmapImage = generateHeatmap(matrix)
    maxValue = max(matrix(:));

    cmap = [linspace(0, 1, maxValue+1)', zeros(maxValue+1, 1), linspace(1, 0, maxValue+1)'];

    scaledMatrix = round(matrix * (maxValue / max(matrix(:))));

    scaledMatrix(scaledMatrix < 0) = 0;
    scaledMatrix(scaledMatrix > maxValue) = maxValue;

    scaledMatrix = uint8(scaledMatrix);

    heatmapImage = ind2rgb(scaledMatrix, cmap);
end
