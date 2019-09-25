function scaledfeatures = featureScaling(unscaledfeatures)
for i = 1:numel(unscaledfeatures)
    scaledfeatures(i) = ( unscaledfeatures(i)-min(unscaledfeatures) )/( max(unscaledfeatures)-min(unscaledfeatures) );
end
end