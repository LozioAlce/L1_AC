function [T] = holdALL(INPUT)

FIG = get(0,'Children');

for kk = max(size(FIG)):-1:1
    figure(FIG(kk)) 
    pause(.01)
    hold on
end

end

