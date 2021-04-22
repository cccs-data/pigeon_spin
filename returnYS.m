function [outPut, S] = returnYS(s, t, q, num, exponent)
%s:transfer matrix   t:present time   q:step    num:ID  exponent:1-5
%return Y:outPut    dictionary matrix:S
outPut = zeros(q, 1);
S = zeros(q, 9*5);
outPut(:, :) = s(1, t:-1:t-q+1, num)';
j = 1;
for i = 1:10
    if i ~= num
       S(:, j)  = (s(1, t-1:-1:t-q, i) - s(1, t-1:-1:t-q, num))';
       j = j + 1;
    end
end
for i = 1:4
    S(:, 9*i+1:9*(i+1)) = S(:, 1:9) .^ (i+1);
end
switch exponent
    case {1}
        S = S(:, 1:9);
    case {2}
        S = S(:, 1:9*2);
    case {3}
        S = S(:, 1:9*3);
    case {4}
        S = S(:, 1:9*4);
    case {5}
        S = S(:, 1:9*5);
end