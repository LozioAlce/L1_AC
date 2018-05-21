function UnDockAll()
%DOCKNEWFIG Summary of this function goes here
%   Detailed explanation goes here
  FIG = get( 0,'Children');

  set( FIG , 'WindowStyle' , 'Normal')

  for kk = max( size(FIG) ):-1:1
      figure( FIG(kk) )
      pause(.01)
      hold on
  end

end
