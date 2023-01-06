function result = integrate_multiple(inputs, hm, im)
  if (isvector(inputs))
    history = 0;
    result = inputs;
    i = 1;
    for s = inputs
      history = get_integrated(history, s, hm, im);
      result(i) = history;
      i += 1;
    endfor
  endif
endfunction
