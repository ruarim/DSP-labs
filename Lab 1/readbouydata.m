% Define a function to read data from buoy dataset file
% Return the data encapsulated in a form that can be used throughout the implementation.
% Also return the number of elements in the data structure.
function [data, count] = readbouydata()
% Assign a variable to hold the file name of the bouy dataset.
datafile = '045200603.txt';
% Open the dataset file for reading and get a reference to the file via fid.
fid = fopen(datafile, 'r');
% Skip the first two lines in the file.
fgetl(fid);
fgetl(fid);
% Assign file data to matrix A from the fid file reference.
% The first argument to fscanf references which file to read data from into matrix A.
% The second argument of fscanf specifies how each line in the file should be %interpreted by assigning items to data types, %d stores value as an integer %f %stores value as a float.
% The argument value 10 indicates each line in the file should be interpreted as a %set of 10 values with the types specified by the format string at the second %argument.
% inf indicates each line should be interpreted until the end of the file
[A, count] = fscanf(fid, '%d %d %d %d %d %f %f %d %f %f', [10, inf]);
% Process data and assign it to the bouy data structure
% Access the relevant part of the A matrix created by fscanf and store it
% with an appropriate name such as date, Hs, Tp, Dp, Ta, SST
data.date = datenum([A(1:5,:); zeros(1,size(A,2))]')'; % Convert to datetime
data.Hs = A(6, :); % Store significant wave height
data.Tp = A(7, :); % Store peak period
data.Dp = A(8, :); % Store peak period direction
data.Ta = A(9, :); % Store average period
data.SST = A(10, :); % Store sea surface temperature
% delete the reference to the dataset file
fclose(fid);
% end the function
end
