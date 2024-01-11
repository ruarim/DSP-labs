[data, count] = readbouydata();
% extract relevant bouy data from structure
Hs = data.Hs;
Tp = data.Tp;
date = data.date;
% create date range variables
date_min = min(date);
date_max = max(date);
% create Hs/Tp max range variables
max_Hs = max(Hs);
max_Tp = max(Tp);
tiledlayout(2,1); % set up plot layout
nexttile;
plot(date, Hs); % plot wave height
ylabel('Wave Height (m)'); % label y axis Wave Height
ylim([0, inf]); % force plot to start at 0 on y axis
xlim([date_min, date_max]); % set x axis limits using date range variables
datetick('x', 'mm/dd', 'keepticks', 'keeplimits'); % add date label on x axis
nexttile;
plot(date, Tp); % plot peak period
ylabel('Peak Period (s)'); % label y axis Peak period
xlim([date_min, date_max]); % set x axis date limits
datetick('x', 'mm/dd', 'keepticks', 'keeplimits'); % add date label on x axis