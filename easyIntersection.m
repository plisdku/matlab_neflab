function [vertices, faces] = easyIntersection(v1, f1, v2, f2)
% [vertices, faces] = easyUnion(v1, f1, v2, f2)
% Compute union of two polyhedra with nonintersecting boundaries.


%shells1 = neflab.divideIntoShells(f1);
%shells2 = neflab.divideIntoShells(f2);


shells1 = neflab.divideIntoShells(f1);
shells2 = neflab.divideIntoShells(f2);

%% Calculate shell containments
% Does a shell of P1 contain a shell of P2?
% Does a shell of P2 contain a shell of P1?

containment12 = zeros(length(shells1), length(shells2));
containment21 = zeros(length(shells2), length(shells1));

for i1 = 1:length(shells1)
    for i2 = 1:length(shells2)
        shellFaces1 = shells1{i1};
        shellFaces2 = shells2{i2};
        
        if neflab.boundsEncloses(shellFaces1, v1, shellFaces2, v2)
            containment12(i1,i2) = 1;
        elseif neflab.boundsEncloses(shellFaces2, v2, shellFaces1, v1)
            containment21(i2,i1) = 1;
        end
    end
end
        
%% Determine which shells remain in the union

v2_offset = length(v1);

iKeepShell1 = find(mod(sum(containment21),2) == 1);
iKeepShell2 = find(mod(sum(containment12),2) == 1);

keptShells1 = cat(1, shells1{iKeepShell1});
keptShells2 = cat(1, shells2{iKeepShell2});

faces = [keptShells1; v2_offset + keptShells2];
vertices = [v1; v2];

[vertices, faces] = neflab.reduceVertices(vertices, faces);


%, 2, 4, 6 etc. of the other poly's shells is
% included


