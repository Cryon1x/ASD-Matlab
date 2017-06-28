 e = 0;
while e == 0
    clear choice;
    choice = menu('Choose a Function','Import Data','Convert .bdt files to .mat','Crop data', 'Clear Workspace','Unclutter Workspace','GSR Cropper','Update Workspace');

    switch choice 
        case 1
            run universalimporter.m;
        case 2
            run extractor.m;
        case 3
            run matcropper.m;
        case 4
            run clrwkspce.m;
        case 5
            run declutter.m;
        case 6
            run gsrcropper.m;
        case 7
            e = 1;
            clear choice;
    end
end

clear e;
