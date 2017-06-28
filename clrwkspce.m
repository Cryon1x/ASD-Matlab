x = who();
    y = 0;
        identifier2 = {'x','i','j','identifier2','y','str1','str2'};
        for i=1:length(x)
            for j=1:length(identifier2)
                str1 = char(x{i});
                str2 = char(identifier2{j});
                y = y + strncmpi(str1, str2,3);
            end
            if y == 0
                clear(x{i});
            end
        end
    clear identify n o q x identifier2 y str1 str2 j i ans col f file filename appfiles k ref ref1 row l m u;
    e = 0;