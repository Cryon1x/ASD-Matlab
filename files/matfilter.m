fprintf('Navigate to source GSR files to be filtered\n');
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

order = 350;
   Fs = 256; %sampling frequency at 200Hz
   flow = 0.4;
   fc = flow * 2/Fs;
  fstp = 0.45 * 2/Fs;
   Ap  = 0.01;
Ast = 80;

Rp  = (10^(Ap/20) - 1)/(10^(Ap/20) + 1);
Rst = 10^(-Ast/20);

h_filter = firls(order, [0 fc fstp 1], [1 1 0 0],[Rp,Rst]);

for i = 1:length(list)
    file = char(list(i));
    load(file);
    ref = SIG.data(3,1:end);    %adjust 3 to 3:4 to include events
    ref = double(ref); 
    ref1 = zeros(size(ref));
for j = 1:size(ref,1)
    ref1(j,:) = filtfilt(h_filter,1,ref(j,:));
end
    SIG.data(1,1:end) = ref1; 
    save(file,'SIG');
    fprintf('File successfully filtered (%d of %d)\n', i, length(list));
end

