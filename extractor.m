clear all


%             MACROS!

identifier = {'VisCheck', 'Aud', 'Tact', 'Video'}; % What are the file identifiers?
mkdir('MATLAB files'); % Where should the files be stored? Any name works.


folder = uigetdir();
cd ..;

cd(folder);

fold_list = struct2cell(dir(folder));
fold_size = length(fold_list);
fold_list(2:end,:) = []; % get folder information
for q = 1:length(identifier)
   fold_listapp = cell(0);
   identify = identifier{q};
   for i=1:fold_size
        j = char(fold_list(i));
        j = strfind(j, identify); 
        if j > 0
            fold_listapp{end+1} = i;
        end
   end
for i = 1:length(fold_listapp) %convert files to .mat format
    j = char(fold_listapp{i});
    filename = fold_list{j};
 SIG = pop_biosig(filename, 'channels', 37:41);
 SIG.data(3:4, :) = [];
 filename = regexprep(filename, 'bdf', 'mat');
 cd ..; cd('MATLAB files');
 save(filename, 'SIG'); 
 cd ..; cd(folder);
end

end


