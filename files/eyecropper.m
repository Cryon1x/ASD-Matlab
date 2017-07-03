appfiles1 = who(); appfiles = cell(0);
for i = 1:length(appfiles1) %returns ASC files as appfiles 
   x = strncmpi(appfiles1{i},'ASC',3);
   if x ~= 1
       appfiles{i} = '';
   else
       appfiles{end+1} = appfiles1{i};  %#ok<SAGROW>
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
    l = 'ASC'; k = num2str(i);
    f = strcat(l,k);
    for u=1:2
    filename = ref{1,6};% rename filename
    filename = strsplit(filename, 'hab_video'); filename = filename{2}; filename = strsplit(filename, '.'); filename = filename{1}; record = filename; filename = strcat('Video',filename);
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
    fprintf('Process complete.\n');
    evalc([f '= setfield(' f ',filename,ref1)']);
    end
    fprintf('File successfully processed (%d of %d)\n', i,length(appfiles));
end

run declutter.m; appfiles1 = who(); appfiles = cell(0);
for i = 1:length(appfiles1) %returns CSV files as appfiles 
   x = strncmpi(appfiles1{i},'CSV',3);
   if x ~= 1
       appfiles{i} = '';
   else
       appfiles{end+1} = appfiles1{i};  %#ok<SAGROW>
   end
end
appfiles = appfiles(~cellfun('isempty',appfiles));  
clear appfiles1;

for i = 1:length(appfiles)
    evalc(['file=' appfiles{i} '.data']);
    file = file(1:end,7);j=0;k=0;
    while j == 0 % returns index of event as k
        k = k+1;
        event = file(k);
        if event == 1
            j = 1;
        end
    end
    evalc(['file=' appfiles{i} '.data']);
    file = file(k:k+3360,1:end);
    if record == 2
    filename = strcat('video','1'); %#ok<NASGU>
    else 
    filename = strcat('video','2');
    end
    fprintf('Process complete.\n');
    evalc([appfiles{i} '= setfield(' appfiles{i} ',filename,file)']);
    
    evalc(['file=' appfiles{i} '.data']);
    file = file(k+3360:k+(2*3360),1:end);if record == 2
    filename = strcat('video','2'); %#ok<NASGU>
    else 
    filename = strcat('video','1');
    end
    fprintf('File successfully processed (%d of %d)\n',i, length(appfiles));
    evalc([appfiles{i} '= setfield(' appfiles{i} ',filename,file)']);
end
fprintf('\a');
run declutter.m;

        