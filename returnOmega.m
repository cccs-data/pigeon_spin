clear all
%input data
%to run this code, one needs an installed CVX packet
for i = 1
    fileName = strcat(strcat('./coordinationData/ffA2/ffA2_', num2str(i)), '.mat');
    Data = cell2mat(struct2cell(load(fileName)));
    Data = permute(Data, [2, 3, 1]);

    lambda = 1;
    MAXITER = 5;
    q = 5;
    %time step
    exponent = 1;
    omega = zeros(9, q);
    Omega = zeros(10, q*(150-q));
    outPut = zeros(q, 1);
    S = zeros(q, 9);
    tic
    for num = 1:10
        k = 0;
        for t = q+1 : 150
            [outPut, S] = returnYS(Data(7, :, :), t, q, num, exponent);
            omega = tac_reconstruction(outPut, S, lambda, MAXITER);
            Omega(num, k*9+1:(k+1)*9) = omega(:, end)';
            k = k + 1;
        end
    end
    fileName = strcat(strcat('./coordinationOmega/ffA2_Omega/Omega_', num2str(i)), '.mat');
    save(fileName, 'Omega')
    toc
end