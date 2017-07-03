% Saves processed code to folders marked with subject names in folders
% 'VisCheck' 'Aud' 'Video' and 'Tact.'

fprintf('Please show me where your processed GSR data is.\n');
folder = uigetdir(); cd(folder)

fprintf('Please show me where your Tact, Aud, VisCheck and Video folders are.\n');
appfolder = uigetdir();

list = struct2cell(dir(folder)); list(2:end,:) = []; x = cell(0);
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
list = x; cd(appfolder);

for i = 1:length(list)
    x = list{i}; filename = x;
    x = str2num(regexprep(x,{'\D*([\d\.]+\d)[^\d]*', '[^\d\.]*'},{'$1 ', ' '}));
    j = strfind(filename,'VisCheck');
    if j > 0
        cd VisCheck;
        stim = 'VisCheck';
    else
        j = strfind(filename,'Tact');
        if j > 0
            cd Tact;
            stim = 'Tact';
        else 
            j = strfind(filename,'Aud');
            if j > 0
                cd Aud;
                stim = 'Aud';
            else 
                fprintf('%c is not recognized!\n', filename);
            end
        end
    end
    
    y = dir(); y = extractfield(y,'name'); k = 0; j = 0; x = num2str(x);
    while k == 0
        j = j + 1;
        if j > length(y)
            k = 1; z = 0;
        else
            z = strfind(x,char(y(j)));
            if z == 1
                k = 1; 
            end
        end
    end
    if z ~= 1
        fprintf('Subject %s folder in %s directory does not exist! \n', x, stim);
    else
        z = strsplit(x,' ');
        if length(z) > 1
            cd(z{1}); filename = strcat(z{1},stim,'freq',z{2},'GSR');
            fprintf('File successfully moved (%d of %d)\n',i,length(list)); 
        else
            cd(x); filename = strcat(x,stim,'GSR'); 
            fprintf('File successfully moved (%d of %d)\n',i,length(list));
        end
    save(filename,'SIG');
    if strfind(char(list{i}),'.tif') > 1
        tifappfolder = pwd();
        cd(folder);
        copyfile(list{i},tifappfolder);
    end
    end
    cd(appfolder);
end