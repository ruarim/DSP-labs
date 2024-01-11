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