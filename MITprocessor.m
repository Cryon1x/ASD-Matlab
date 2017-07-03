e = 0;
folder = mfilename('fullpath'); folder = strsplit(folder, 'MITprocessor'); folder = char(folder{1});
cd(folder); cd files;
addpath(pwd); cd ..; % check 'files' folder next in processor.m directory. 'files' holds all the 
clear folder;        % functions and subprograms that processor.m calls. 
while e == 0
    clear choice;
    choice = menu('MIT GSR Pre-processor','Convert .bdf files to .mat','Crop Vi/Tact/Aud', 'Filter GSR data','Normalize GSR Z-scores', 'Normalize GSR avg. baseline','Clear Workspace','Unclutter Workspace','Clean Up Pre-processed Data','Create Plots','Store Pre-processed Data to Dedicated Files','Update Workspace');
    
    switch choice 
        case 1
            run extractor.m; %takes vischeck, tact, aud, video files and converts .bdt to .mat
        case 2
            run matcropper.m; %crops .mat files for vischeck, tact, aud and video files
        case 3
            run matfilter.m; %filter the data (row 1)
        case 4
            run matnormalize1.m; %normalizes function (row 2)
        case 5
            run matnormalize2.m % normalizes function (row 3 - original data gets ported to 4)
        case 6
            run clrwkspce.m; % clears workspace
        case 7
            run declutter.m; % clears workspace except file_list and CSV/ASC files
        case 8
            run processedsctorganize.m; % cleans up SIGs for aud/vischeck/tact.
        case 9
            run plotmarker.m; % generates .tif files. 
        case 10
            run sv2sbjct.m; % stores 'cleaned' files to AUD, TACT, VISCHECK
        case 11
            e = 1;           % exits to make workspace, filesystem and user defined programs accessible.
            clear choice;
    end
end

clear e;
