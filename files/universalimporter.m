identifier = {'.csv','.asc'}; iden_length = length(identifier); fold_listapp = cell(0); % initialize criteria

folder = uigetdir; cd(folder); %goto folder

fold_listram = struct2cell(dir(folder)); fold_listram(2:end,:)=[];
if exist('foldlist', 'var') == 1
    foldlist = foldlist(~cellfun('isempty',foldlist));  
    fold_listram = setdiff(fold_listram,foldlist);
    for i=1:length(fold_listram)
        foldlist{end+i} = fold_listram{i}; 
    end
else
    foldlist = fold_listram;
end
%generate folder list

j = 1;l = 1;m = 0;
while j == 1
    file = sprintf('CSV%d',l);
    if exist(file,'var') == 1
        l = l+1;
    else 
        j = 0;
    end
end %check for earlier CSVs

for i=1:iden_length
    fold_listapp = cell(0);
    
    for k=1:length(fold_listram) %find folders applicable to identifier
        j = char(fold_listram{k});
        j = strfind(j, identifier(i)); 
        if j > 0
            fold_listapp{end+1} = k;
        end
    end
    
    for k=1:length(fold_listapp) %import applicable files
        m = 0;
        num = fold_listapp{k};
        file = char(fold_listram{num});
        file = fopen(file);
        resultfile = textscan(file,'%c');
        m = m+1;
        
        if identifier{i} == '.csv' % .csv importer; 
            fprintf('Importing .csv file (%d of %d)\n',m, length(fold_listapp));
            evalc(['CSV' num2str(k+l-1) '= resultfile']);
            fold_listram{m} = file;
            
        else if identifier{i} == '.asc' %.asc importer
            fprintf('Importing .asc file (%d of %d)\n',m, length(fold_listapp));
            evalc(['ASC' num2str(k+l-1) '= resultfile']);
            fold_listram{m} = file;
            
%        else if identifier{i} == 'SOME' % More importers!
  %          fprintf('Importing SOME file (%d)\n',m);
   %         evalc(['ASC' num2str(k+l-1) '= resultfile']);
    %        fold_listram{m} = file;
    
%        else if identifier{i} == 'SOME' % More importers!
  %          fprintf('Importing SOME file (%d)\n',m);
   %         evalc(['ASC' num2str(k+l-1) '= resultfile']);
    %        fold_listram{m} = file;
    
            end
        end
    end
end
foldlist = foldlist(~cellfun('isempty',foldlist));  
fold_listram = setdiff(foldlist, fold_listram);
foldlist = [foldlist, fold_listram];
foldlist = unique(foldlist); 
if m == 0
    msgbox('No new files found!');
else
    msgbox('Import successful!');
end

run declutter.m;

