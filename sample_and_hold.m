function result = sample_and_hold(input, hold_samples)
    peak = 0;
    sample_count = length(input);
    result = zeros(1, sample_count);
    hold_count = - hold_samples - 1;
    for n = 1:sample_count
        if input(n) > peak
            peak = input(n);
            hold_count = hold_samples;
        elseif hold_count > 0
            hold_count--;
        else
            peak = input(n);
        end
        result(n) = peak;
    end
end
