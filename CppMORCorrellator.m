
display(mfilename());
pkg load signal;
clear;

graphics_settings;
WMFunctions;

corr = WMTxSignal(0,1);
%corr = corr(128+(-64:63));
%corr * transpose(corr)
%return
%plot(corr); return;

txsig= WMTxSignal(256*1000,3);
%plot(txsig); return;

chansig= Channel(txsig,signalLevel=-3,SNR=-1);
%plot(chansig);return;

rxsig= Receiver(chansig);
%plot(rxsig); return;

for ilag=0:1:(columns(rxsig)-columns(corr))

  xcor = rxsig((1:columns(corr))+ilag) * transpose(corr);
  xcors(1+ilag) = xcor;
endfor
plot(xcors)