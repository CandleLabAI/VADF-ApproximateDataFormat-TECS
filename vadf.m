function val = vadf(x,N,k)
% @param k: Number of bits that are stored by VADF
% @param x: original number
% @param N: inital bit-width of the number
% @param val: final approximate value 
% This file is used for compression, without adding any soft-error. 

a = de2bi(x,N,'left-msb');
l = lod(a,N);
if l>k
    a(N-l+k) = a(N-l+k+1) | a(N-l+k);
    data = a(N-l+1:N-l+k);
    data = [zeros(1,N-l-1),1,data, zeros(1,l-k)];
    val = bi2de(data,'left-msb');
else
    if l==k
        data = a(N-l+1:N-l+k);
        data = [zeros(1,N-l-1),1,data, zeros(1,l-k)];
        val = bi2de(data,'left-msb');
    else
        data = a;
        val =bi2de(data,'left-msb');
    end
end
end


 
