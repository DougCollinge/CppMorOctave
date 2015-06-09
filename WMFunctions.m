# Utility functions for WinMOR signals.
display(mfilename());

function signal = WMLeaderPulse(syncpulse=false)
  N=256;
  freq= 32;
  ic = 0:1:(N-1);
  signal = sin(2*pi*ic/N).*cos(2*pi*freq*ic/N);
  if syncpulse
    flipper = 2*(ic<(N/2)) - 1;
    signal = signal .* flipper;
  endif
endfunction

function signal = WMLeader(npulses=20)
  signal = [];
  for ipulse=1:(npulses-1)
    signal = [signal,WMLeaderPulse()];
  endfor
  signal = [signal,WMLeaderPulse(syncpulse=true)];
endfunction

function signal = WMTxSignal(delaysamples=0,leaderpulses=20)
  signal = zeros(1,delaysamples);
  signal = [signal, WMLeader(npulses=leaderpulses)];
endfunction

function signal = WMRxSignal(SNR=10,delaysamples=0,leaderpulses=20)
  txs = WMTxSignal(delaysamples,leaderpulses);
  
  # Add gaussian noise at a given SNR.
  signal = awgn(txs,SNR,'measured');

endfunction



