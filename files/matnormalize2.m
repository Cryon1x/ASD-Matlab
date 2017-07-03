% Normalizes GSR files by taking the baseline average (first 60 seconds
% multiplied by 512 hz sampling, subtracting it from GSR data, and then
% dividing by std of whole set. 

files = uigetdir(); cd(files); list = struct2cell(dir(files)); list(2:end,:) = []; x = cell(0);
for i = 1:length(list) % generates list of applicable files as list
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

for i = 1:length(list)
    file = char(list(i));
    load(file);
    ref = SIG.data(1,1:end); %adjust 3 to 3:4 to include events
    ref1 = ref(1:30720); mean = 0;
    for j = 1:30720
        mean = mean + ref(j);
    end
    mean = mean / 30720;
    ref = ref - mean;
    mean = std(ref);
    ref = ref / mean;
    SIG.data(4,1:end) = SIG.data(3,1:end);
    SIG.data(3,1:end) = ref;
    save(file,'SIG');
    fprintf('File successfully normalized (%d of %d)\n', i, length(list));
end
