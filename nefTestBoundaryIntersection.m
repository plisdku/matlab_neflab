function yesNo = nefTestBoundaryIntersection(v1, f1, v2, f2)

if neflab.disjointHulls(v1, v2)
    yesNo = 0;
end



inFile = [tempdir sprintf('nefTemp%1.4f.txt', now)];
outFile = [tempdir sprintf('nefOut%1.4f.txt', now)];

fh = fopen(inFile, 'w');
neflab.writeMultiOFF(fh, v1, f1);
neflab.writeMultiOFF(fh, v2, f2);
fclose(fh);

if ~ismac
    cmd = sprintf('env -u LD_LIBRARY_PATH NefLab testBoundaryIntersection < %s > %s', ...
        inFile, outFile);
else
    cmd = sprintf('NefLab testBoundaryIntersection < %s > %s', inFile, outFile);
end


[status, stdout] = unix(cmd);

if status
    keyboard;
end


fh = fopen(outFile, 'r');
val = fscanf(fh, '%i', 1);
fclose(fh);

yesNo = val;