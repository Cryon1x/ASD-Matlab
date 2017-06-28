keygen = cell2mat({0,218,228,198,215,20,21,212,214,233,111,068,114,129,126,069,109,110,112,127,40,89,154, 219, 221, 224,226,120,200,117,102,101,70,206,205,231,226,210,229,207,116,201,222,223,239,232,234,230,244;0,2,2,2,1,1,2,2,1,2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2,0,0,0,0,1,0,0,0,2,2,2,0,1,1,1,2,2,2,2,1,1,2,1,0});
folder = uigetdir(); cd(folder); x = cell(0);
list = struct2cell(dir(folder)); list(2:end,:) = [];
mkdir('Cropped Data');

for i = 1:length(dir(folder))-1 % generates list of applicable files
    j = strfind(list{i},'VisCheck');
    if j > 0
        x{end+1} = list{i};  %#ok<*SAGROW>
    else 
        j = strfind(list{i},'tact');
        if j > 0
            x{end+1} = list{i}; 
            else j = strfind(list{i},'aud');
                if j > 0
                x{end+1} = list{i}; 
                end
        end
    end
end
list = x;

for i=1:length(list)
    load(char(list{i})); k = 0; j = 1;
    ref = [SIG.event]; n = extractfield(ref, 'type'); ref = extractfield(ref, 'latency');
    while k == 0
        x = n(j);
        if x == 4 || x == 11 || x == 65288
            k = 1;
        else 
            j = j + 1;
        end
    end
    x = ref(j);
    
    ref = [SIG.data];
    if x + 174080 > length(SIG.data)
        SIG.data = ref(1:end,x - 30720:end);
    else
    SIG.data = ref(1:end,x - 30720:x + 174080);
    end
    cd('Cropped Data');
    save(strcat('Cropped', char(list{i})),'SIG');
    cd ..;
    fprintf('File successfully cropped (%d)\n',i);
    
end

x = cell(0); list = dir(folder); list = extractfield(list, 'name');
for i = 1:length(list)
    j = list{i}; j = strfind(j, 'Video');
    if j > 0
        x{end + 1} = list{i};
    end
end
list = x;

for i=1:length(list)
    load(char(list{i})); k = 0; j = 1;
    ref = [SIG.event]; n = extractfield(ref, 'type'); ref = extractfield(ref, 'latency');
    while k == 0
        x = n(j);
        if x == 8
            k = 1;
        else 
            j = j + 1;
        end
    end
    x = ref(j); k = 0;
    
    while k == 0
        x = n(j+1);
        if x == 8
            k = 1;
        else 
            j = j + 1;
        end
    end
    y = ref(j);
    
    ref = [SIG.data];
    if x + 133120 > length(SIG.data)
        SIG.data = ref(1:end,x:end);
    else
    SIG.data = ref(1:end,x:x + 133120);
    end
    cd('Cropped Data'); num = 1; k = 0;
    filename = regexp(char(list{i}),('\d+\.?\d*'),'match');
    filename = str2double(filename{1});
    while k == 0
        if num > length(keygen);
            num = 1;
            break
        end
        j = keygen(1,num);
        if filename == j
            k = 1;
        else
            num = num+1;
        end
    end
    
    if keygen(2,num) == 0
        k = 0;
    
    else if keygen(2,num) == 1
        k = 1;
    
        else if keygen(2,num) == 2
        k = 2;
            else 
        fprintf('No information about this video exists! ');
            end
        end
    end
    filename = strcat(filename, char(list{i}));
    if k == 0
    save(strcat('Cropped_Unknown', char(list{i})),'SIG')
    fprintf('Video file successfully cropped, though data unknown. (%d)\n',i);
    end
    if k == 1
    save(strcat('Cropped_roller', char(list{i})),'SIG')
    fprintf('Video file successfully cropped (%d)\n',i);
    end
    if k == 2
    save(strcat('Cropped_elf', char(list{i})),'SIG')
    fprintf('Video file successfully cropped (%d)\n',i);
    end
    cd ..;

    if y + 133120 > length(SIG.data)
        SIG.data = ref(1:end,y:end);
    else
    SIG.data = ref(1:end,y:y + 133120);
    end
    cd('Cropped Data');
    if k == 0
    save(strcat('Cropped_unknown', char(list{i})),'SIG');
    end 
    if k == 1
    save(strcat('Cropped_elf', char(list{i})),'SIG');
    end
    if k == 2
        save(strcat('Cropped_roller', char(list{i})), 'SIG');
    end
    cd ..;
end
    