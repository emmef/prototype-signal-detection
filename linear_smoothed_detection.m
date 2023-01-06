format compact;
format free;

prediction = 10
hold_samples = prediction / 2
integration_sample_factor = 0.577774
integration_samples = hold_samples * integration_sample_factor
rc_coefficients = calculate_integration_coefficients(integration_samples)
integration_order = 2

# Generate impulse response to measure detection characteristics

impulse = zeros(1, hold_samples * 5);
impulse(1)=1;

impulse_skeleton = linear_approach(impulse, hold_samples);
top = get_first_top(impulse_skeleton, rc_coefficients, integration_order, hold_samples)
ratio = top(1) / prediction;
sample_miss = round((1 - ratio) * hold_samples)

smoothed = integrate(0, impulse_skeleton, rc_coefficients, integration_order) / top(2);

t =0:length(impulse)-1;
t_skeleton = t - hold_samples;
t_predicted = t - round(top(1));

%plot(t, impulse, "-",    t_skeleton, impulse_skeleton, "-", t_predicted, smoothed, "-");

%impulse
impulse_skeleton
smoothed
