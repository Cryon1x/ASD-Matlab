e = 0; clear fold_list;
folder = mfilename('fullpath'); folder = strsplit(folder, 'YALEprocessor'); folder = char(folder{1});
cd(folder); cd files;
addpath(pwd); cd ..; % check 'files' folder next in processor.m directory. 'files' holds all the 
clear folder;     
while e == 0
    choice = menu('Yale GSR Pre-processor','Import Data','Crop Data','Clear Workspace','Unclutter Workspace','Update Workspace');
    switch choice
        case 1
            run universalimporter.m; % imports non-bdf and non-mat files. Stores in workspace.
        case 2
            run eyecropper.m; % crops data, but does not save it. 
        case 3
            run clrwkspce.m; % clears workspace.
        case 4
            run declutter.m; % clears workspace except for foldlist and imported data.
        case 5
            e = 1;           % exits to make workspace, filesystem and user defined programs accessible.
            clear choice;
    end
end
clear e;