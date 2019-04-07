gdist=makedist('Normal','mu',0.06,'sigma',0.03);
time = linspace(0,1,1000);
gpdf=pdf(gdist,time);
gpulse=gpdf/max(gpdf);
plot(time,gpulse)

% gap = zeros(1,59);
% dist = normpdf([60:1:1000],470,30);
% dist = (1/max(dist))*dist;
% gaussin = [gap,dist];
% figure(7);
% plot(time,gaussin);