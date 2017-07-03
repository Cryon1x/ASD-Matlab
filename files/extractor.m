%             MACROS!

identifier = {'VisCheck', 'Aud', 'Tact', 'Video'}; % What are the file identifiers? If
                                                   % you decide to use
                                                   % different files, then
                                                   % add/delete from here.


folder = uigetdir(); % get file source dir; cd for user convenience. 
cd(folder);

run dir2dir;

fold_list = struct2cell(dir(folder));
fold_size = length(fold_list);
h = waitbar(0,'Converting files...');
fold_list(2:end,:) = []; % get folder information
for q = 1:length(identifier)
   waitbar(q/length(identifier));
   fold_listapp = cell(0);
   identify = identifier{q};
   for i=1:fold_size
        j = char(fold_list(i));
        j = strfind(j, identify); 
        if j > 0
            fold_listapp{end+1} = i; %#ok<SAGROW>
        end
   end
for i = 1:length(fold_listapp) %convert files to .mat format
    j = fold_listapp{i};
    filename = fold_list{j};
 SIG = pop_biosig(filename, 'channels', 37:41);
 SIG.data(3:4, :) = [];
 filename = regexprep(filename, 'bdf', 'mat');
 cd(appfolder);
 save(filename, 'SIG'); 
 cd(folder);
end

end
close(h);


