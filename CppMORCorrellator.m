
display(mfilename());
pkg load signal;
clear;

graphics_settings;
WMFunctions;

corr = WMTxSignal(0,1);
corr * transpose(corr)
%return
%plot(corr); return;

sig= WMRxSignal(SNR=10,256*20,20);
%plot(sig); return;

for ilag=0:1:(columns(sig)-columns(corr))

  xcor = sig((1:columns(corr))+ilag) * transpose(corr);
  xcors(1+ilag) = xcor;
endfor
plot(xcors)