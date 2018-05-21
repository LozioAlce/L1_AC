function LinkAll()
% LinkAll() links all the figure in the x-axis
  FIG = get(0,'Children'); % Find all the figures automatically
  MAX_FIG = length(FIG);   % Find max number of figures
  All_Axes = [];
  for kk = 1 : MAX_FIG
      N_Axes = length( FIG(kk).Children );
      All_Axes_now =FIG(kk).Children';    % get all the axes of the kk figure
      All_Axes = [ All_Axes , All_Axes_now ]; % add all the axes all together
  end
  linkaxes(All_Axes,'x');
end
