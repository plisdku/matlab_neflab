function [vOut, fOut] = reduceVertices(vertices, faces)

[iVertsToKeep, ~, ff_reindexed] = unique(faces);
fOut = reshape(ff_reindexed, size(faces));
vOut = vertices(iVertsToKeep,:);