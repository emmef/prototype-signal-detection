function result = calculate_overshoot_and_peak_position(history_multiplier, input_multiplier, hold_samples, times)
  output = zeros(times,1);
  result = [0, 0];
  totalSamples = 0;
  for i = 1:hold_samples
    input = i/ (hold_samples + 1);
    input
    output(1) = get_integrated(output(1), input, history_multiplier, input_multiplier);
    for j = 2:times
      output(j) = get_integrated(output(j), output(j-1), history_multiplier, input_multiplier);
    endfor
    if (output(times) > result(1)) 
      result(2) = totalSamples;
      result(1) = output(times);
    endif
    
    totalSamples++;
  endfor

  for i = 1:hold_samples-1
    input = (1 + hold_samples - i) / hold_samples
    output(1) = get_integrated(output(1), input, history_multiplier, input_multiplier);
    for j = 2:times
      output(j) = get_integrated(output(j), output(j-1), history_multiplier, input_multiplier);
    endfor
    
    if (output(times) > result(1)) 
      result(2) = totalSamples;
      result(1) = output(times);
    endif
    
    totalSamples++;
  endfor
  
  for i = 1:hold_samples
    output(1) = get_integrated(output(1), 0, history_multiplier, input_multiplier);
    for j = 2:times
      output(j) = get_integrated(output(j), output(j-1), history_multiplier, input_multiplier);
    endfor

    if output(times) > result(1)
      result(2) = totalSamples;
      result(1) = output(times);
    endif
    
    totalSamples++;
  endfor
  result(1) = 1 / result(1);
  
endfunction
