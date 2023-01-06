function result = linear_approach(inputs, hold_samples)
  result = [];
  
  position = 1;
  value = 0;
  peak = 0;
  slope = 0;
  afterSlope = -1 / hold_samples;
  afterPosition = 0;
  afterSet = 0;

  for in = inputs
    slopeToIn = (in - value) / (hold_samples + 1);
    if (slopeToIn > slope) 
      position = hold_samples;
      slope = slopeToIn;
      peak = in;
      afterSlope = -1 / hold_samples;
    elseif position > 0
      position--;
      peakToInSlope = (in - peak) / hold_samples;
      if (peakToInSlope > afterSlope)
        afterSlope = peakToInSlope;
        afterPosition = hold_samples - position;
        afterSet=1;
      endif
    else
      if afterPosition > 0
        if afterSet > 0
          slope = afterSlope;
          afterSet = 0;
         endif
         afterPosition--;
      else 
         slope = slopeToIn;
      endif
    endif
    value += slope;
    result(end + 1)=value;
  endfor
  
endfunction