function angles = calculateAnglesBetweenVectors(vector, matrixOfVectors, angleThreshold)
    % 计算向量的模
    normVector = norm(vector);
    normsMatrix = sqrt(sum(matrixOfVectors.^2, 2));

    % 计算点积
    dotProducts = sum(bsxfun(@times, matrixOfVectors, vector), 2);

    % 计算余弦值
    cosThetas = dotProducts ./ (normsMatrix * normVector);
    cosThetas = max(min(cosThetas, 1), -1);  % 限制余弦值在 [-1, 1] 范围内

    % 计算夹角（单位：度）
    angles = acosd(cosThetas);
end