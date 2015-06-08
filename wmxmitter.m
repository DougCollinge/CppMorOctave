function signal = wmxmitter(txdelay,npulses,freq)
	srate = 12000;
	nbins = 256;
	difffreq = srate/nbins;

	silence = zeros(1,txdelay);

	nsamples = npulses*nbins;
	phase = 2*pi*(0:1:nsamples-1)/srate;
	leader = -sin((freq-difffreq)*phase)/2 + sin((freq+difffreq)*phase)/2;
	leader( (nsamples-nbins/2+1):1:nsamples ) *= -1;
	signal = [silence,leader];

#or ipulse = 0:1:npulses-1
#	signal = [signal,wmleader(freq)];
#endfor

end # function

#function ret = wmleader(freq)
#	srate = 12000;
#	nbins = 256;
#	difffreq = srate/nbins;
#	ret = -sin(2*pi*(freq-difffreq)*(0:1:nbins-1)/srate)/2 + sin(2*pi*(freq+difffreq)*(0:1:nbins-1)/srate)/2 ;
#end # function
