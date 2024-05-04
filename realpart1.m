
% Input the real sequence and DFT length
Xrn = input("Enter the real sequence: ");
Nr_real = input("Enter the length of DFT for real sequence: ");

% Pad the real sequence to match length Nr_real
xrn = [Xrn, zeros(1, Nr_real - length(Xrn))];

% Compute DFT sequence of real sequence
Xrn = df_transform(xrn, Nr_real);

% Print the DFT values for real sequence
fprintf('DFT values for real sequence:\n');
for k = 1:Nr_real
    fprintf('X_real(%d) = %f\n', k, Xrn(k));
end

% Checking the symmetry for real sequence
tolerance = 1e-10; 

for k = 1:Nr_real/2
    if abs(abs(real(Xrn(k))) - abs(real(Xrn(Nr_real-k+1)))) < tolerance
        fprintf('Xrn(%d) = Xrn(%d) = %d\n', k, Nr_real-k, real(Xrn(k)));
    end
end


% Plot magnitude and phase of DFT for real sequence
k_real = 0:Nr_real-1;
subplot(3, 2, 1);
stem(k_real, abs(Xrn));
xlabel('k');
ylabel('|X_r(k)|');
title('Magnitude of DFT (Real Sequence)');

subplot(3, 2, 2);
stem(k_real, angle(Xrn));
xlabel('k');
ylabel('Phase(X_r(k))');
title('Phase of DFT (Real Sequence)');

% Input the imaginary sequence and DFT length
Xi = input("Enter the imaginary sequence: ");
Nr_imag = input("Enter the length of DFT for imaginary sequence: ");

% Pad the imaginary sequence to match length Nr_imag
xi = [Xi, zeros(1, Nr_imag - length(Xi))];

% Compute DFT sequence of imaginary sequence
Xi = df_transform(xi, Nr_imag);

% Print the DFT values for imaginary sequence
fprintf('DFT values for imaginary sequence:\n');
for k = 1:Nr_imag
    fprintf('X_imag(%d) = %f + %fi\n', k, real(Xi(k)), imag(Xi(k)));
end
% verification
tolerance = 1e-10;
for k = 1:Nr_imag/2
    if abs(abs(imag(Xi(k))) - abs(imag(Xi(Nr_imag-k)))) < tolerance
        fprintf('Xi(%d)_imag = Xi(%d)_imag = %fi\n', k, Nr_imag-k, imag(Xi(k)));
    end
end



% Plot magnitude and phase of DFT for imaginary sequence
k_imag = 0:Nr_imag-1;
subplot(3, 2, 3);
stem(k_imag, abs(Xi));
xlabel('k');
ylabel('|X_i(k)|');
title('Magnitude of DFT (Imaginary Sequence)');

subplot(3, 2, 4);
stem(k_imag, angle(Xi));
xlabel('k');
ylabel('Phase(X_i(k))');
title('Phase of DFT (Imaginary Sequence)');

% Input the complex sequence and DFT length
X_complex = input("Enter the complex sequence (in the form a + bi): ");
Nr_complex = input("Enter the length of DFT for complex sequence: ");

% Pad the complex sequence to match length Nr_complex
x_complex = [X_complex, zeros(1, Nr_complex - length(X_complex))];

% Compute DFT sequence of complex sequence
X_complex = df_transform(x_complex, Nr_complex);

% Print the DFT values for complex sequence
fprintf('DFT values for complex sequence:\n');
for k = 1:Nr_complex
    fprintf('X_complex(%d) = %f + %fi\n', k, real(X_complex(k)), imag(X_complex(k)));
end


% Plot magnitude and phase of DFT for entire complex sequence
k_imag = 0:Nr_complex-1;
subplot(3, 2, 5);
stem(k_complex, abs(X_complex));
xlabel('k');
ylabel('|X(k)|');
title('Magnitude of DFT (Complex Sequence)');

subplot(3, 2, 6);
stem(k_complex, angle(X_complex));
xlabel('k');
ylabel('Phase(X(k))');
title('Phase of DFT (Complex Sequence)');

% Function to compute DFT
function Xk = df_transform(xn, N)
    L = length(xn);
    if (N < L)
        error('N should be greater than or equal to L');
    end
    xn = [xn, zeros(1, N - L)]; % Padding xn
    for k = 0:N-1
        for n = 0:N-1
            Wn = exp(-1i * 2 * pi * k * n / N); % Twiddle factor of each n,k
            Xl(k + 1, n + 1) = Wn; % Twiddle factor matrix
        end
    end
    Xk = Xl * xn.'; % DFT matrix
end
