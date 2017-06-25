
clear all;

identifier = {'.csv'};

folder = uigetdir;
cd(folder);
fold_list = struct2cell(dir(folder));
fold_list(2:end,:) = [];
fold_size=length(fold_list);
identify = identifier{1};
fold_listapp = 0;
   for i=1:fold_size
        j = char(fold_list(i));
        j = strfind(j, identify); 
        if j > 0
            fold_listapp = i;
        end
   end
fold_list = fold_list(fold_listapp);
file = char(fold_list(1));

excelfile = readtable(file);
