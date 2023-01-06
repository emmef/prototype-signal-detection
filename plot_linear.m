hold_samples = 96;
rc_coefficients = calculate_integration_coefficients(hold_samples/1.4)
integration_order = 2

# Generate impulse response to measure detection characteristics

impulse = zeros(1, hold_samples * 15);
impulse(1)=1;

impulse_skeleton = linear_approach(impulse, hold_samples);
top = get_first_top(impulse_skeleton, rc_coefficients, integration_order, hold_samples)

# Create input to test

inputs = impulse;
%inputs(round(hold_samples*0.8))=0.4;
inputs(round(hold_samples*7.3))=1;

line_skeleton = linear_approach(inputs, hold_samples);
smoothed = integrate(0, line_skeleton, rc_coefficients, integration_order);

# Create different time-offsets to align in graph

t =0:length(inputs)-1;
t_skeleton = t - hold_samples;
t_predicted = t - top(1);
smoothed = smoothed / top(2);

plot(t, inputs, "-",    t_skeleton, line_skeleton, "-", t_predicted, smoothed, "-");
