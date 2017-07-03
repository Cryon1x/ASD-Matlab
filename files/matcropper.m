keygen = cell2mat({0,226,235,245,218,228,198,215,20,21,212,214,233,111,068,114,129,126,069,109,110,112,127,40,89,154, 219, 221, 224,226,120,200,117,102,101,70,206,205,231,226,210,229,207,116,201,222,223,239,232,234,230,244;
                   0,2,1,2,2,2,2,1,1,2,2,1,2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2,0,0,0,0,1,0,0,0,2,2,2,0,1,1,1,2,2,2,2,1,1,2,1,0});
event_elf = cell2mat({30720,35840,40448,50176,51200,56320,60928,70656,71680,76800,81408,91136,92160,97280,101888,111616,112640,117760,122368,132096,133120;21,22,23,24,21,22,23,24,21,22,23,24,21,22,23,24,21,22,23,24,25});
event_roller = cell2mat({30720,35840,49152,51200,56320,69632,71680,76800,90112,92160,97280,110592,112640,117760,131072,133120;21,26,27,21,26,27,21,26,27,21,26,27,21,26,27,25});
% 'event_elf' and 'event_roller' correspond to parts in the data where
% actions occurred. 'keygen'
% identifies files for the sequence of videos. More info on 'EEG and NEU
% Participant Tracking' google doc. Don't touch event_elf or event_roller
% unless the Sinha Lab ASD/NT experiment setup itself has changed. Add
% entries to keygen if new participants have been added. Video combo is the 
% opposite polarity to the identifier, e.g. if participant 505 has video 
% combo (1 OR 3), he would be assigned a two in keygen, and if participant 
% 506 has a combo (2 OR 4), she would be assigned a one. Otherwise, with no
% data, participants are assigned zero. See keygen in matlab variables tab 
% if you're confused. Keep the zeroes in the first column of keygen. 
folder = uigetdir(); cd(folder); x = cell(0);
list = struct2cell(dir(folder)); list(2:end,:) = [];

for i = 1:length(dir(folder))-1 % generates list of applicable files
    j = strfind(list{i},'VisCheck');
    if j > 0
        x{end+1} = list{i};  %#ok<*SAGROW>
    else 
        j = strfind(list{i},'Tact');
        if j > 0
            x{end+1} = list{i}; 
            else j = strfind(list{i},'Aud');
                if j > 0
                x{end+1} = list{i};
                end
        end
    end
end
list = x;

if isempty(list) == 0
    run dir2dir.m;
end
    
for i=1:length(list) % crop non-'Video' data
    load(char(list{i})); k = 0; j = 1;
    ref = [SIG.event]; n = extractfield(ref, 'type'); ref = extractfield(ref, 'latency');
    while k == 0
        x = n(j);
        if x == 4 || x == 11 || x == 65288
            k = 1;
        else 
            j = j + 1;
            if j > length(n)
                k = 1; j = 0;
            end
        end
    end
    if j == 0
        fprintf('Error! File %d does not have proper event in SIG.events!\n',i);
    else
    x = ref(j);
    ref = [SIG.data];
    if x + 174080 > length(ref)
        SIG.data = ref(1:end, x-30720:end);
    else
    SIG.data = ref(1:end,x - 30720:x + 174080);
    end
    cd(appfolder);
    save(char(list{i}),'SIG');
    cd(folder);
    fprintf('File successfully cropped (%d of %d)\n',i,length(list));
    end
end


x = cell(0); list = dir(folder); list = extractfield(list, 'name'); % generate filename

for i = 1:length(list) % generates list of applicable 'video' files
    j = list{i}; j = strfind(j, 'Video');
    if j > 0
        x{end + 1} = list{i};
    end
end
list = x;

for i=1:length(list) % crop 'Video' data
    load(char(list{i})); k = 0; j = 1;
    ref = SIG.urevent; n = extractfield(ref, 'type'); ref = extractfield(ref, 'latency');
    while k == 0
        x = n(j);
        if x == 8
            k = 1;
        else 
            j = j + 1;
        end
    end
    x = ref(j); k = 0;
    
    ref = [SIG.data];
    SIG.data = ref(1:end,x:x + 133120);
    cd(appfolder); num = 1; k = 0;
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
        save(char(list{i}),'SIG');
        fprintf('Video file successfully cropped, though data unknown. (%d of %d)\n',i,length(list));
    end
    if k == 1
        ref1 = SIG.data;
        for j = 1:length(event_roller)
            l = event_roller(1,j);
            ref1(4,l) = event_roller(2,j);
        end
        SIG.data = ref1;
        SIG.event = event_roller;
        save(strcat('roller', char(list{i})),'SIG');
        fprintf('Video file successfully cropped (%d of %d)\n',i, length(list));
    end
    if k == 2
        ref1 = SIG.data;
        for j = 1:length(event_elf)
            l = event_elf(1,j);
            ref1(4,l) = event_elf(2,j);
        end
        SIG.data = ref1;
    	SIG.event = event_elf;
        save(strcat('elf', char(list{i})),'SIG');
        fprintf('Video file successfully cropped (%d of %d)\n',i, length(list));
    end
    cd(folder); load(char(list{i})); 
    ref = [SIG.data];SIG.data = ref(1:end,x + 133120:x + 133120 + 133120);
    if k == 1
        SIG.data = ref;
        cd(appfolder);
        save(strcat('elf', char(list{i})),'SIG');
    end
    if k == 2
        SIG.data = ref;
        cd(appfolder);
        save(strcat('roller', char(list{i})),'SIG');
    end
    cd(folder); % fprintf('%c\n',list{i});  % to see which file doesn't work/isn't compatible...
end
run declutter.m
fprintf('Successful!\n');
    