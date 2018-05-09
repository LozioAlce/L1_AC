function HideFig(input)
%% Hide all the figure to speed-up plotting
% if function HideFig('on') set figures visible

    FIG = get(0,'Children');
    if  nargin==1 && strcmp(input,'on')
        set(FIG,'Visible','on');
    else
        set(FIG,'Visible','off');
    end
end
