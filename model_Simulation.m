%global interaction
clear;
T = 20;
stepSize = 10^(-4);
pointNum = T / stepSize + 1;
indivNumMatrix = [5, 10, 15, 20];
SWTimesMatrix = zeros(10, 10, 4);
spendTimeMatrix = zeros(10, 10, 4);
for inNum = 2
    tic;
indivNum = indivNumMatrix(1, inNum);
randn('state',20000);
S = zeros(indivNum, pointNum);
S(:, 1) = normrnd(0, 1, indivNum, 1);
% S(:, 1) = [0;0;0;0;0;0;0;0;0;0];

eta = 0.5

alpha = 0.3
dW = normrnd(0, 1, indivNum, pointNum);

for t = 2:pointNum
    sum_s = sum(S(:, t-1));
    for i = 1:indivNum
        S_local = (1 / (indivNum - 1)) * (sum_s - S(i, t-1));
%         FS = alpha * S_local + (1 - alpha)*sign(S_local);
        if S_local>alpha          
            FS = S_local/(1+alpha) + alpha/(1+alpha);
        end
        if abs(S_local)<=alpha   
            FS = 0;
        end
        if S_local<-alpha          
            FS = S_local/(1+alpha) - alpha/(1+alpha);
        end
        
        
        S(i, t) = S(i,t-1)+((FS - S(i, t-1))  + eta * dW(i, t))*1;
    end
end
SWTimesSum = 0;
spendTimeSum = 0;
for id = 1:1:indivNum
    [SWTimes, spendTime] = returnSWTimes( S(id, :));
    SWTimesSum = SWTimesSum + SWTimes;
    spendTimeSum = spendTimeSum + spendTime;
end
SWTimesMatrix( floor(10*eta), floor(10*alpha), inNum) = SWTimesSum / indivNum;
spendTimeMatrix(floor(10*eta), floor(10*alpha), inNum) = spendTimeSum / indivNum;
end
% end

max_ms = max(S(1, 1:20000));
S(1, 1:20000) = S(1, 1:20000) / max_ms;
plot(1:20:5000, S(1, 1:20:5000),'r--');
hold on
xlabel('step');
ylabel('\it{s_i}')



