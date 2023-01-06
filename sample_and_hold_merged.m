function result = sample_and_hold_merged(input, hold_samples)
    peak = 0;
    sample_count = length(input);
    result = zeros(1, sample_count);
    hold_count = - hold_samples - 1;
    difference = 0;
    delta = 0;
    for n = 1:sample_count
        if input(n) > peak
            peak = input(n);
            hold_count = hold_samples;
        elseif hold_count > 0
            hold_count--;
        elseif hold_count == 0
            difference = peak - input(n);
            delta = -difference / hold_samples;
            difference = difference + delta;
            peak = input(n) + difference;
            hold_count--;
        elseif hold_count > -hold_samples
            difference = difference + delta;
            peak = input(n) + difference;
            hold_count--;
        else
            peak = input(n);
        end
        result(n) = peak;
    end
end
