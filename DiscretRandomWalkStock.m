% HW Q5
% Arjun Singh
% 1/23/2018

deltat = 0.01;
deltas = sqrt(deltat);

sigma = 0.1;
mu = 0.05;
T = 10;
m = T/deltat; % step number
shareprice(m) = 1; % vector of share prices
time = linspace(0,T,m+1);
finalVal(1,10000)=0; % vector to store price at expiry

for i = 1:10000 % 10000 random walkers
    s = 1; % starting share price
    for j  = 1:m
        u = (sigma^2*shareprice(j)^2 + mu*shareprice(j)*deltas)/2; % probability of moving up
        d = (sigma^2*shareprice(j)^2 - mu*shareprice(j)*deltas)/2; % probability of moving down
        ud = u + d;
        u = u/ud;
        d = d/ud; % normalize u and d between 0 and 1
        move = rand;
        if move <= u % move share price up or down by deltas
            s = s+deltas;
        elseif move > u && move <= u+d
            s = s-deltas;
        end       
        shareprice(j) = shareprice(j) + s; % store share price
    end
    finalVal(1,i) = s; % store final value of share
end

for isteps=1:1:m
    shareprice(isteps)=shareprice(isteps)/10000; % normalize share prices
end

strikes = 0:1:6; % vector of strike prices
newMeans = [];
newVar = [];
for i = 1:length(strikes)
    tempDis = finalVal;
    for j = 1:10000
        tempDis(j) = max(finalVal(j)-i,0); % value of call option at expiry
    end
    newMeans(i) = mean(tempDis);
    newVar(i) = var(tempDis);
end
plot(strikes, newMeans, strikes, newVar)



