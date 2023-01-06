function result = integrate(history, input, coefficients, integration_order)
    if isvector(input)
        result=[];
        h = zeros(integration_order, 1);
        h(1) = history;
        for in = input
            h(1) = h(1) * coefficients(1) + in * coefficients(2);
            for n = 2:integration_order
                h(n) = h(n) * coefficients(1) + h(n-1) * coefficients(2);
            end
            result(end+1) = h(integration_order);
        end
    else
        if integration_order <= 1
            result = history * coefficients(1) + input * coefficients(2)
        else
            h = zeros(integration_order, 1);
            h(1) = h(1) * coefficients(1) + input * coefficients(2);
            for n = 2:integration_order
                h(n) = h(n) * coefficients(1) + h(n-1) * coefficients(2);
            end
            result = h(n)
        end
    end
end
