x = who();
identifier2 = {'.csv','.asc', 'fold_list'};
for i=1:length(x)
    for j=1:length(identifier2)
        str1 = char(x{i});
        str2 = char(identifier2{j});
        y = strcmp(str1, str2);
        if y ~= 1
        clear x(i);
        end
    end
end
clear x identifier2 y str1 str2 i j ans;
e = 0;