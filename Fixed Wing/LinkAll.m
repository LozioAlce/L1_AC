function LinkAll()
  FIG = get(0,'Children');
  MAX_FIG = length(FIG);
  All_Axes = [];
  for kk = 1 : MAX_FIG
      N_Axes = length( FIG(kk).Children );
      All_Axes_now =FIG(kk).Children';    % get all the axes of the kk figure
      All_Axes = [ All_Axes , All_Axes_now ]; % add all the axes all together
  end
  linkaxes(All_Axes,'x');
end
