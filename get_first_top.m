# Returns the first top of
function top = get_first_top(samples, coefficients, integration_order, additional_runtime)
    integrated = zeros(integration_order, 1);
    position = 0;
    top_value = -inf();
    top_position = 0;

    for sample = samples
        integrated(1) = integrate(integrated(1), sample, coefficients, 1);
        for n = 2:integration_order
            integrated(n) = integrate(integrated(n), integrated(n-1), coefficients, 1);
        end
        if (integrated(integration_order) > top_value)
            top_value = integrated(integration_order);
            top_position = position;
        elseif integrated(integration_order) <  top_value
            top = [ top_position, top_value ];
            return
        end
        position++;
    end

    for n = 1:additional_runtime
        integrated(1) = integrate(integrated(1), 0, coefficients, 1);
        for n = 2:integration_order
            integrated(n) = integrate(integrated(n), integrated(n-1), coefficients, 1);
        end
        if (integrated(integration_order) > top_value)
            top_value = integrated(integration_order);
            top_position = position;
        elseif integrated(integration_order) <  top_value
            "EXTENDED"
            top = [ top_position, top_value ];
            return
        end
        position++;
    end

    top = [ top_position, top_value ];
end
