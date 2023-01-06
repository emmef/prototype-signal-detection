function result = calculate_overshoot(history_multiplier, input_multiplier, hold_samples, times)
  output = zeros(times,1);
  for i = 1:hold_samples
    output(1) = get_integrated(output(1), 1, history_multiplier, input_multiplier);
    for j = 2:times
      output(j) = get_integrated(output(j), output(j-1), history_multiplier, input_multiplier);
    endfor
  endfor
#  result = 1 / output(times);
  maximum = output(times);
  for i = 1:hold_samples
    output(1) = get_integrated(output(1), 0, history_multiplier, input_multiplier);
    for j = 2:times
      output(j) = get_integrated(output(j), output(j-1), history_multiplier, input_multiplier);
    endfor
    value = output(times);
    if (maximum < value)
      maximum = value;
    else
      timing = i / hold_samples;
      result = 1 / maximum;
      return
    endif
  endfor
  
endfunction