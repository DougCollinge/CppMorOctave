# Utility functions for WinMOR signals.
display(mfilename());

function signal = WMLeaderPulse()
  N=256;
  freq= 32;
  ic = 0:1:(N-1);
  signal = sin(2*pi*ic/N).*cos(2*pi*freq*ic/N);
endfunction

function signal = WMLeader(npulses=20)
  signal = [];
  for ipulse=1:npulses
    signal = [signal,WMLeaderPulse()];
  endfor
endfunction
