e = 0;
while e == 0
    clear choice;
choice = menu('Choose a Function','Import Data','Convert .bdt files to .mat','Crop data', 'Clear Workspace','Unclutter Workspace','Update Workspace');

switch choice 
    case 1
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


    case 2


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



    case 3
        
i = 1;
folder = uigetdir();
cd(folder);
mkdir('Cropped_Data');
   fold_list = struct2cell(dir(folder));
   fold_size = length(fold_list);
   fold_list(2:end,:) = [];
   fold_listapp = cell(0);
   for i=1:fold_size
        j = char(fold_list(i));
        j = strfind(j, 'VisCheck'); %MACRO!
        if j > 0
            fold_listapp{end+1} = i;
        end
   end
   
   for u=1:length(fold_listapp)
   k = (fold_listapp(u));
   k = k{1};
   j = char(fold_list(k));
   o = j;
   load(j) % literally loads data file 
   
   concdata = [SIG.times;SIG.data]; %macro? 
   events = [SIG.event]; %macro?
   k = 0; m = 0;
   n = extractfield(events, 'type');
       
   for i=1:length(n) % finds mention of 11, stores it as m
       j = n(i);
       m = m + 1;
       if j == 11 % MACRO!
           k = 1;
           break
           end
       end
       
   n = extractfield(events, 'latency');
   m = n(m);  % m is now latency, manipulate concdata using minimize function
   
   k = abs(concdata(1,:) - m); % find cell with right latency
   j = min(k); n = length(k);
   for i = 1:length(k)
       if k(i) == j
           break
       end
   end
   
   concdata = concdata(2:end,i:174080+i); % actually crop data
   SIG.data = concdata;  %store as SIG.data
   o = strcat('Cropped ',o);
   cd Cropped_Data;
   save(o,'SIG');
   cd ..;
   end
%----------------------------% aud
   fold_listapp = cell(0);
   for i=1:fold_size
        j = char(fold_list(i));
        j = strfind(j, 'aud'); %MACRO!
        if j > 0
            fold_listapp{end+1} = i;
        end
   end
   
   for u=1:length(fold_listapp)
   k = (fold_listapp(u));
   k = k{1};
   j = char(fold_list(k));
   o = j;
   load(j) % literally loads data file 
   
   concdata = [SIG.times;SIG.data]; %macro? 
   events = [SIG.event]; %macro?
   k = 0; m = 0;
   n = extractfield(events, 'type');
       
   for i=1:length(n) % finds mention of 11, stores it as m
       j = n(i);
       m = m + 1;
       if j == 4 % MACRO!
           k = 1;
           break
           end
       end
       
   n = extractfield(events, 'latency');
   m = n(m);  % m is now latency, manipulate concdata using minimize function
   
   k = abs(concdata(1,:) - m); % find cell with right latency
   j = min(k); n = length(k);
   for i = 1:length(k)
       if k(i) == j
           break
       end
   end
   [row, col] = size(concdata);
   if col > i + 174080
       concdata = concdata(2:end,i:174080+i); % actually crop data
   else
       concdata = concdata(2:end,i:end);
   end
   SIG.data = concdata;  %store as SIG.data
   o = strcat('Cropped ',o);
   cd Cropped_Data;
   save(o,'SIG');
   cd ..;
   end
   %----------------------------% VIDEO
   fold_listapp = cell(0);
   for i=1:fold_size
        j = char(fold_list(i));
        j = strfind(j, 'Video'); %MACRO!
        if j > 0
            fold_listapp{end+1} = i;
        end
   end
   
   for u=1:length(fold_listapp)
   k = (fold_listapp(u));
   k = k{1};
   j = char(fold_list(k));
   o = j;
   load(j) % literally loads data file 
   
   concdata = [SIG.times;SIG.data]; %macro?
   events = [SIG.event]; %macro?
   k = 0; m = 0;
   n = extractfield(events, 'type');
       
   for i=1:length(n) % finds mention of 11, stores it as m
       j = n(i);
       m = m + 1;
       if j == 8 % MACRO!
           k = 1;
           break
           end
       end
       
   n = extractfield(events, 'latency');
   m = n(m);  % m is now latency, manipulate concdata using minimize function
   
   k = abs(concdata(1,:) - m); % find cell with right latency
   j = min(k); n = length(k);
   for i = 1:length(k)
       if k(i) == j
           break
       end
   end
      [row, col] = size(concdata);
   if col > i + 174080-13757
       concdata = concdata(2:end,1:(91715+i)); % actually crop data
       if i > 13757
           concdata = concdata(1:end,(i-13757):end);
       end
   else
       concdata = concdata(2:end,(i-13757):end);
       if i > 13757
           concdata = concdata(1:end,(i-13757):end);
       end
   end
   SIG.data = concdata;  %store as SIG.data
   o = strcat('Cropped ',o);
   cd Cropped_Data;
   save(o,'SIG');
   cd ..;
   end
%----------------------------% tact

 fold_listapp = cell(0);
   for i=1:fold_size
        j = char(fold_list(i));
        j = strfind(j, 'tact'); %MACRO!
        if j > 0
            fold_listapp{end+1} = i;
        end
   end
   
   for u=1:length(fold_listapp)
   k = (fold_listapp(u));
   k = k{1};
   j = char(fold_list(k));
   o = j;
   load(j) % literally loads data file 
   
   concdata = [SIG.times;SIG.data]; %macro? 
   events = [SIG.event]; %macro?
   k = 0; m = 0;
   n = extractfield(events, 'type');
       
   for i=1:length(n) % finds mention of 11, stores it as m
       j = n(i);
       m = m + 1;
       if j == 65288 % MACRO!
           k = 1;
           break
           end
       end
       
   n = extractfield(events, 'latency');
   m = n(m);  % m is now latency, manipulate concdata using minimize function
   
   k = abs(concdata(1,:) - m); % find cell with right latency
   j = min(k); n = length(k);
   for i = 1:length(k)
       if k(i) == j
           break
       end
   end
      [row, col] = size(concdata);
   if col > i + 174080-13757
       concdata = concdata(2:end,i-13757:91715+i); % actually crop data
   else
       concdata = concdata(2:end,i-13757:end);
   end
   SIG.data = concdata;  %store as SIG.data
   o = strcat('Cropped ',o);
   cd Cropped_Data;
   save(o,'SIG');
   cd ..;
   end
   
 
    case 4
        clear all;
        e = 0;
    case 5
        x = who();
identifier2 = {'.csv','.asc', 'fold_list'};
for i=1:length(x)
    for j=1:length(identifier2)
        str1 = char(x{i});
        str2 = char(identifier2{j});
        y = strcmp(str1, str2);
        if y ~= 1
        clear x(i);
        end
    end
end
clear x identifier2 y str1 str2 i j ans;
e = 0;
    case 6
        e = 1;
        clear choice;
end
end

clear e;
