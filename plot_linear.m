hold_samples=5;

inputs=zeros(1, hold_samples * 15);
inputs(hold_samples*2)=1;
#inputs(round(hold_samples*3.4))=1;

inputs 

line_skeleton=linear_approach(inputs, hold_samples)

hm=samples_to_history_multiplier(hold_samples);
im=1-hm;
overshoot=calculate_overshoot_and_peak_position(hm, im, hold_samples, 1);
integrated=integrate_multiple(line_skeleton, hm, im);
x=1:length(inputs);
x1=x-hold_samples;

integrated *= overshoot(1);
x2=x1 - overshoot(2);#round(x-2*hold_samples);

plot(x, inputs, "-", x1, line_skeleton,"-", x2, integrated);

line_skeleton
#integrated
#overshoot
 