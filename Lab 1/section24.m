M_vec = [5, 21, 51];
bouy_data = readbouydata(); % read bouy dataset file into a data structure
data = bouy_data.Tp; % extract the peak period from the data strucutre
dates = bouy_data.date; % extract the dates to scale the x axis label
y_label = 'Peak Period (s)'; % define Y axis label text
tiledlayout(3,1); % create a plot layout to display the three moving average plots
for m = M_vec % run causal moving average for each window size - 5, 21, 51
avg = causal_mov_avg(data, m); % calculate the causal moving average for each M
plot_movavg(data, avg, m, dates, y_label); % plot the moving average for each M
end

function [out_data] = causal_mov_avg(x, m)
data_length = length(x);
in_data = [zeros(1, m-1), x]; % add the appropriate zero padding at the start for both input and output vectors
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
function [out_data] = movavg(m, in_data, out_data, data_length)
if m <= 0 && data_length > m % check values greater than 0 and less than input vector length
error('Invalid input parameters.'); % throw error if true
end
for i = 1:data_length %iterate over the input vector
sum = 0;
for j = i:i+m-1 % iterate through the M window
sum = sum + in_data(j); % sum the values in the window
end
avg = sum/m; % calculate the average of the summed values
out_data(i) = avg; % assign the average to the output vector
end
end
