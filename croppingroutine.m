
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
   
 