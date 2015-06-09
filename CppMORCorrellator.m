
display(mfilename());
pkg load signal;
clear;

graphics_settings;
WMFunctions;

corr = WMTxSignal(0,2);
plot(corr); return;

sig= WMRxSignal(10,256,3);
plot(sig);
