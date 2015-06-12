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

function osignal = Channel(isignal, signalLevel=-3, SNR=10)
  # Add gaussian noise at a given SNR. -3dB is the signal level of the Tx.
  # signalLevel in dB relative to 1.0, SNR in dB. 
  osignal = awgn(isignal,SNR,signalLevel);
  # Add additional features of the channel here later; e.g. fade, multipath
endfunction

function osignal = Receiver(isignal)
  # Simulate the receiver front end with filtering only for now.
  [b,a] = butter(3,[(32-5)/256,(32+5)/256]);
  osignal = filter(b,a,isignal);
endfunction

