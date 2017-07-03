% Organizes filtered + normalized data into fields and cleans up the
% SIG structure. 
fprintf('Please go to the folder where your normalized data is.\n');
folder = uigetdir(); cd(folder); x = cell(0);
list = struct2cell(dir(folder)); list(2:end,:) = [];

for i = 1:length(dir(folder))-1 % generates list of applicable files as 'list'
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
    file = list{i};
    load(file); 
    if isfield(SIG,'data') == 0
        fprintf('No unprocessed files exist in this directory! \n');
        break
    end
    names = fieldnames(SIG);
    ref = SIG.data;
    for j = 1:length(names)
        evalc(['SIG = rmfield(SIG' ',''' names{j} ''')']);
    end
    SIG.filtered = ref(1,1:end);
    SIG.zscored = ref(2,1:end);
    SIG.baselineavg = ref(3,1:end);
    SIG.raw = ref(4,1:end);
    save(file, 'SIG');
end