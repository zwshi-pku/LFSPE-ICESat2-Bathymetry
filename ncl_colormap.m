function color = ncl_colormap(colorname)
temp = import_ascii([colorname '.rgb']);
temp(1:2) = [];
% temp = split(temp,'#');
% temp = temp(:,1);
% % color = deblank(color);
% temp = strtrim(temp);
% temp = regexp(temp, '\s+', 'split');
% 
% for i=1:size(temp,1)
%     color(i,:) = str2double(temp{i});    
% end

for i=1:size(temp,1)
    t = temp{i};
    t = strtrim(t);
    t = regexp(t, '\s+', 'split');
    t = str2double(t);  
    color(i,:) = t(1:3);    
end
if ~isempty(find(color>1))
    color = color/255;
end
end