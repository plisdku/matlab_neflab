function yesNo = boundsEncloses(f1, v1, f2, v2)
% yesNo = boundsEncloses(f1, v1, f2, v2)

min1 = min(v1(f1,:));
max1 = max(v1(f1,:));
min2 = min(v2(f2,:));
max2 = max(v2(f2,:));

if all(min1 <= min2) && all(max1 >= max2)
    yesNo = 1;
else
    yesNo = 0;
end
