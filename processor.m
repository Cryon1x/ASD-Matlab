 e = 0;
while e == 0
    clear choice;
choice = menu('Choose a Function','Import Data','Convert .bdt files to .mat','Crop data', 'Clear Workspace','Unclutter Workspace','GSR Cropper','Update Workspace');

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
    x = who();
    y = 0;
        identifier2 = {'x','i','j','identifier2','y','str1','str2'};
        for i=1:length(x)
            for j=1:length(identifier2)
                str1 = char(x{i});
                str2 = char(identifier2{j});
                y = y + strncmpi(str1, str2,3);
            end
            if y == 0
                clear(x{i});
            end
        end
    clear x identifier2 y str1 str2 j i ans col f file filename appfiles k ref ref1 row l m u;
    e = 0;
    case 5
        y = 0;
        x = who();
        identifier2 = {'i', 'identifier2','x','str1','str2','j','i', 'CSV','ASC', 'fold_list'};
        for i=1:length(x)
            for j=1:length(identifier2)
                str1 = char(x{i});
                str2 = char(identifier2{j});
                y = y + strncmpi(str1, str2, 3);
            end
            if y == 0
                clear(x{i});
            end
        end
    clear x identifier2 y str1 str2 j i ans col f file filename appfiles k ref ref1 row l m u;
e = 0;
    case 6
        
        appfiles1 = who(); appfiles = cell(0);
for i = 1:length(appfiles1) %returns ASC files as appfiles 
   x = strncmpi(appfiles1{i},'ASC',3);
   if x ~= 1
       appfiles{i} = '';
   else
       appfiles{end+1} = appfiles1{i}; %#ok<SAGROW>
   end
end
for i = 1:length(appfiles)
    x = strncmpi(appfiles{i},'',1);
    if x == 1
        appfiles = appfiles(1:i-1);
        break
    end
end
clear appfiles1;
for i=1:length(appfiles) 
    file = strcat(appfiles{i}, '.textdata');
    evalc(['ref=' file]);
    fprintf('File Successfully Imported (%d)\n', i);
    ref = ref(93:end,1:end);
    [row,~] = size(ref);
    j = 1; col = 0; m = 0;
    while col == 0 % find the first mention of MSG
        j = j + 1;
        k = char(ref{j,1});
        col = strncmpi(k,'MSG',3);
        if col == 1
            m = m + 1;
            col = 0;
            if m == 3
                break
            end
        end
    end

    ref1 = ref(1:j-1,1:end);
    ref = ref(j:end,1:end);
    filename = 'taringSCL_GSR'; 
    l = 'ASC'; k = num2str(i);
    f = strcat(l,k);
    evalc([f '= setfield(' f ',filename,ref1)']);  % Save tare file to struct
    for u=1:2
    filename = ref{1,6};% rename filename
    filename = strsplit(filename, '\hab_video'); filename = filename{2}; filename = strsplit(filename, '.'); filename = filename{1}; filename = strcat('GSRVideo',filename);
    while col == 0 % find the next mention of MSG
        j = j + 1;
        k = char(ref{j,1});
        col = strncmpi(k,'MSG',3);
        [row,~] = size(ref);
        if j == row
            break
        end
    end
    ref1 = ref(1:j-1,1:end);
    ref = ref(j:end,1:end);
    j = 1; col = 0;
    evalc([f '= setfield(' f ',filename,ref1)']);
    end
    fprintf('File Successfully Processed (%d)\n', i)
end
        
    case 7
        e = 1;
        clear choice;
end
end

clear e;
