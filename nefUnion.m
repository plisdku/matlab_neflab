function [vertices, faces] = nefUnion(v1, f1, v2, f2)
% nefUnion    Calculate union of two polyhedra
%
% [vertices faces] = nefUnion(v1, f1, v2, f2)
%

% Write args to file
% Call NefLab
% Get polyhedron back out

%detectSingularFaces(v1,f1);
%editdetectSingularFaces(v2,f2);

if size(f1,1) == 0
    vertices = v2;
    faces = f2;
    return
elseif size(f2,1) == 0
    vertices = v1;
    faces = f1;
    return
elseif neflab.nefTestBoundaryIntersection(v1, f1, v2, f2) == 0
    [vertices, faces] = neflab.easyUnion(v1, f1, v2, f2);
    return
end

inFile = [tempdir sprintf('nefTemp%1.4f.txt', now)];
outFile = [tempdir sprintf('nefOut%1.4f.txt', now)];

fh = fopen(inFile, 'w');
neflab.writeMultiOFF(fh, v1, f1);
neflab.writeMultiOFF(fh, v2, f2);
fclose(fh);

if ~ismac
    cmd = sprintf('env -u LD_LIBRARY_PATH NefLab union < %s > %s', ...
        inFile, outFile);
else
    cmd = sprintf('NefLab union < %s > %s', inFile, outFile);
end

[status, stdout] = unix(cmd);
if status
    keyboard;
end


fh = fopen(outFile, 'r');
[vertices, faces] = neflab.readNefPolyhedron(fh);
fclose(fh);

% Cleanup step to fix some geometry problems.
vertices = neflab.consolidateVertices([v1; v2], vertices);

