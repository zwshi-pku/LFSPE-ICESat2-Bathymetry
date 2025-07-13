% 成行读取文本数据
% Edited Time:2019-02-22
function ascii = import_ascii(file_name)
i = 1;
fid = fopen(file_name);
while feof(fid) ~= 1
    tline = fgetl(fid);
    ascii{i,1} = tline; i = i + 1;
end
fclose(fid);
end