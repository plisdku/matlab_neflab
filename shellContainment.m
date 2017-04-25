function [shells, containment] = shellContainment(v, f)
% [shells, containment] = shellContainment(v, f)
% containment(ii,jj) = whether shell ii contains shell jj.
% the diagonal elements will be zero.

shells = neflab.divideIntoShells(f);
containment = zeros(length(shells));

% We are going to use the VERY CRAPPY assumption here that

for ss = 1:length(shells)
    for rr = 1:length(shells)
        if ss ~= rr
            % Here we apply the INCORRECT assumption that if bbox(A)
            % encloses bbox(B) that A encloses B.  Fix this later using
            % CGAL.  For most cases it will be ok and I need to get back
            % to physics.
            
            if boundsEncloses(v(shells{ss},:), v(shells{rr},:))
                containment(ss,rr) = 1;
            end
        end
    end
end

end
