identifier = {'.csv','.asc'}; iden_length = length(identifier); fold_listapp = cell(0); % initialize criteria

folder = uigetdir; cd(folder); %goto folder

fold_listram = struct2cell(dir(folder)); fold_listram(2:end,:)=[];
if exist('fold_list', 'var') == 1
    fold_listram = setdiff(fold_listram,fold_list);
    for i=1:length(fold_listram)
        fold_list{end+i} = fold_listram{i}; 
    end
else
    fold_list = fold_listram;
end
%generate folder list

j = 1;l = 1; m = 1; while j == 1
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
        num = fold_listapp{k};
        file = char(fold_listram{num});
        resultfile = importdata(file);
        m = m+1;
        
        if identifier{i} == '.csv' % .csv importer; 
            fprintf('Importing .csv file (%d)\n',m);
            evalc(['CSV' num2str(k+l-1) '= resultfile']);
            fold_listram{m} = file;
            
        else if identifier{i} == '.asc' %.asc importer
            fprintf('Importing .asc file (%d)\n',m);
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

fold_listram = setdiff(fold_list, fold_listram);
fold_list = [fold_list, fold_listram];
fold_list = unique(fold_list); 
if m == 1
    msgbox('No new files found!');
else
    msgbox('Import successful!');
end

clear file fold_listapp folder i iden_length identifier j k l num resultfile m fold_listram ans

