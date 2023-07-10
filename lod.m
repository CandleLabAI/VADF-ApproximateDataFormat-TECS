function l = lod(a,n)
%This function is used for leading-one detection

for i=0:n-1
    if a(i+1) == 1
        l = n-i-1;
        break
    else
        l=-1;
    end
end
end
