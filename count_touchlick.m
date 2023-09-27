function count_touchlick

cd('C:\Users\C238\phase2D_responsive')
LS = ls;
for i=1:length(LS)
    if ~isempty(strfind(LS(i,:), '.mat'))
        data = load(LS(i,:));
    end
end