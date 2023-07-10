function val = vadf_1b(x,N,k)
%********DEFINE k and e ********%
% @param k: Number of bits that are stored by VADF
% @param x: original number
% @param N: inital bit-width of the number
% @param val: final approximate value 

 
% This file is used for VADF compression, while also introducing soft-error in the most significant bit of data bits in the compressed data format. See the ~ operation below which flips a bit. 

a = de2bi(x,N,'left-msb');
l = lod(a,N);

if l>k
    a(N-l+k) = a(N-l+k+1) | a(N-l+k);
    data = a(N-l+1:N-l+k);
    data = [zeros(1,N-l-1),1,~data(1),data(2:length(data)), zeros(1,l-k)];
    val = bi2de(data,'left-msb');
else
    if l==k
        data = a(N-l+1:N-l+k);
        data = [zeros(1,N-l-1),1,~data(1),data(2:length(data)), zeros(1,l-k)];
        val = bi2de(data,'left-msb');
    else
        temp = de2bi(x,4,'left-msb');
       if x==1 || x==0
             data=x;
       else
            temp(k-l+1) = ~temp(k-l+1);
            data = temp;
        end
        val = bi2de(data,'left-msb');
      
    end
end
end
