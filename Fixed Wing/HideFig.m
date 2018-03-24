function HideFig(input)
    FIG = get(0,'Children');
    
    if  nargin==1 && strcmp(input,'on')
        set(FIG,'Visible','on');
    else
        set(FIG,'Visible','off');
    end
    
end
