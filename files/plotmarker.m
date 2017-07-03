% Adds plots to SIG for 'vischeck' 'aud' 'tact' that are marked with 1 minute mark. 

fprintf('Please show me where your processed GSR data is.\n');
folder = uigetdir(); cd(folder); 

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
list = x;
for i = 1:length(list)
    if strfind(char(list{i}), '.tif') > 1
        list{i} = '';
    end
end
list = unique(list);
list(1) = [];
h = waitbar(0,'Creating Figures...');
for i = 1:length(list) 
    clear titl x;
    filename = list{i}; load(filename);
    waitbar(i/length(list));
    
    x = plot(SIG.zscored); hold on
    yL = get(gca,'YLim'); titl = strcat(filename,' Z scored data');
    line([30720 30720],yL,'Color','r'); 
    xlabel('512 hz'); 
    title(titl);
    hold off;
    filename1 = strcat('GSR ', filename, 'zscored.tif');
    filename1 = strrep(filename1, '.mat','');
    filename1 = strrep(filename1, ' ', '');
    saveas(x,filename1);
    clear x;
    
    x = plot(SIG.filtered); hold on
    yL = get(gca,'YLim'); titl = strcat(filename,' filtered data');
    line([30720 30720],yL,'Color','r'); 
    xlabel('512 hz'); 
    title(titl);
    hold off;
    filename1 = strcat('GSR ', filename, 'filtered.tif');
    filename1 = strrep(filename1, '.mat','');
    filename1 = strrep(filename1, ' ', '');
    saveas(x,filename1);
    clear x;
    
    x = plot(SIG.baselineavg); hold on
    yL = get(gca,'YLim'); titl = strcat(filename,' baseline avg and std normalized data');
    line([30720 30720],yL,'Color','r'); 
    xlabel('512 hz'); 
    title(titl);
    hold off;
    filename1 = strcat('GSR ', filename, 'avgstd.tif');
    filename1 = strrep(filename1, '.mat','');
    filename1 = strrep(filename1, ' ', '');
    saveas(x,filename1);
    clear x;
    
    x = plot(SIG.raw); hold on
    yL = get(gca,'YLim'); titl = strcat(filename,' raw data');
    line([30720 30720],yL,'Color','r'); 
    xlabel('512 hz'); 
    title(titl);
    hold off;
    filename1 = strcat('GSR ', filename, 'raw.tif');
    filename1 = strrep(filename1, '.mat','');
    filename1 = strrep(filename1, ' ', '');
    saveas(x,filename1);
    clear x;
    
end
close(h);