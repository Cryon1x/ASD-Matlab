% returns destination as
% 'appfolder.' ASSUMES THAT WORKING DIRECTORY IS SOURCE FILES

folder = pwd();
button = questdlg('Would you like Matlab to create a new directory "MIT GSR Files" to store processed files?');
i = strcmp(button, 'Yes');
if i == 1
    mkdir('MIT GSR Files'); % Where should the files be stored? Any name works.
    appfolder = strcat(pwd(),'/MIT GSR Files');
else                        % Else the program will use a user-specified directory.
    i = strcmp(button, 'No');
    if i == 1
       appfolder = uigetdir();
    else 
        exit(extractor.m);
    end
end

clear button i;
cd(folder);