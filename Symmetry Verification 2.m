clear;
%input real and even sequence
xre=input("Enter the real even sequence: ");
Ne= input("enter the length of DFT: ");

%input real and odd sequence 
xro=input("Enter the real odd sequence: ");
No= input("enter the length of DFT: ");

Xek=df_transform(xre,Ne);%DFT sequence of xre
Xok=df_transform(xro,No);%DFT sequence of xro


%storing imaginary values of dft of even sequence
for k=1:Ne
    fprintf("%d + %d\n",real(Xek(k,1)),imag(Xek(k,1)));
    imaginary(k)=imag(Xek(k,1));
end

%storing real values of dft of odd sequence
for k=1:No
    fprintf("%d + %d\n",real(Xok(k,1)),imag(Xok(k,1)));
    realodd(k)=real(Xok(k,1));
end
ce=0;

tolerance = 1e-10;


%checking the symmetry for real even sequence
for m=1:Ne
    %fprintf("M %d",m);
    part1 = real(Xek(m,1));
    part2 = imaginary(m);
    %since j term is involved, the value is not zero accurately. 
    % we need to add concept of tolerance to check whether the value
    % approaches zero or not
     if(abs(part2)<tolerance)
        part2=0;
        imaginary(m)=0;%making it perfect zero
     end 

    if (part2~=0)
        fprintf('not verified for Xek(%d)\n',m);
        ce=ce+1;
    end

end


co=0;
%checking the symmetry for real odd sequence
for k = 1:No
    
    part1 = realodd(k);
    fprintf("real %d ",part1);
    
    part2 = imag(Xok(k,1));
    fprintf("+ imag %d\n",part2);
    %since j term is involved, the value is not zero accurately. 
    % we need to add concept of tolerance to check whether the value
    % approaches zero or not
    if (abs(part1)<tolerance)
        part1=0;
        realodd(k)=0;%making it zero
    end 
    if (part1~=0)
        fprintf(' not verified for Xok(%d)\n',k);
        co=co+1;
    end
end

if (ce==0)
    
%plotting for real and even sequence
    k=0:Ne-1;
    subplot(4,2,1)
    stem(k,abs(Xek))
    xlabel('k')
    ylabel('|Xk|')
    title ('magnitude')
    subplot(4,2,3)
    stem(k,real(Xek))
    xlabel('k')
    ylabel('|Xr(k)|')
    title ('Real Values')
    subplot(4,2,5)
    stem(k,imaginary)
    xlabel('k')
    ylabel('|Xi(k)|')
    title ('Imaginary Values')
end 

if (co==0)
%plotting for real and odd sequence
    k=0:No-1;
    subplot(4,2,2)
    stem(k,abs(Xok))
    xlabel('k')
    ylabel('|Xk|')
    title ('magnitude')
    subplot(4,2,4)
    stem(k,angle(Xok))
    xlabel('k')
    ylabel('<Xk')
    title ('phase')
    subplot(4,2,6)
    stem(k,realodd)
    xlabel('k')
    ylabel('|Xrk|')
    title ('Real')
end




function Xk=df_transform(xn,N)
L=length(xn);
if(N<L)
    error ('N should be greater than or equal to L');
end
xn=[xn zeros(1,N-L)];%padding xn
for k=0:N-1
    for n=0:N-1
        Wn=exp(-1i*2*pi*k*n/N);%twiddle factor of each n,k
        Xl(k+1,n+1)=Wn;%twiddle factor matrix
    end
end
Xk=Xl*xn';%dft matrix
end
