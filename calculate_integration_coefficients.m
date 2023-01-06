function coefficients = calculate_integration_coefficients(integration_sample_count)
    history_multiplier =  exp(-1.0 / integration_sample_count);
    coefficients = [history_multiplier, 1 -  history_multiplier];
endfunction