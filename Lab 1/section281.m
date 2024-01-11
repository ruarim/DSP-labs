M_vec = [5, 21, 51];
bouy_data = readbouydata(); % read bouy data intro data structure
data = bouy_data.Tp; % extract the peak period from the data strucutre
dates = bouy_data.date; % extract the dates to scale the x axis label

y_label = 'Peak Period (s)'; % define Y axis label text
tiledlayout(3,1); % create a plot layout to display the three moving average plots
for m = M_vec % run non causal moving average for each window size - 5, 21, 51
movavg = non_causal_mov_avg(data, m); % calculate the moving average for each M
plot_movavg(data, movavg, m, dates, y_label); % plot the moving average for each M
end

function [out_data] = non_causal_mov_avg(x, m)
data_length = length(x);
half_window = (m - 1) / 2; % pad both the start and end of the input with M-1/2 zeros to use future values
in_data = [zeros(1, half_window), x, zeros(1, half_window)];
out_data = zeros(1, data_length);
out_data = movavg(m, in_data, out_data, data_length); % calculate and assign the moving average to the output vector
end
function plot_movavg(data, data_avg, m, date, y_label)
date_min = min(date); % get the min and max date to scale the x axis label
date_max = max(date);
nexttile;
plot(date, data,'Color',[0.8 0.8 0.8],'LineWidth',2); % plot the original data
hold on
plot(date, data_avg, 'k'); % plot the averaged data
hold on
title(strcat('M=', int2str(m))); % add the M window size label
ylabel(y_label); % add the approriate Y axis label
xlim([date_min, date_max]); % set x axis limits using date range variables
datetick('x', 'mm/dd', 'keepticks', 'keeplimits'); % add dates to the X axis
end
