% Stack angle
stack_type = {'gaussian', 'rayleigh/', 'gamma/', 'weibull/', 'log_normal/'};
len_type = length(stack_type);
for i=1:len_type
    roc_script(i, 'angle', strcat('C:\Users\jgvin\OneDrive\ITA\Paulo\scripts\data\stacks\passes_angle\', stack_type{i}))
end


% Stack pass
stack_type = {'gaussian/', 'rayleigh/', 'gamma/', 'weibull/', 'log_normal/'};
len_type = length(stack_type);
for i=1:len_type
    roc_script(i, 'pass', strcat('C:\Users\jgvin\OneDrive\ITA\Paulo\scripts\data\stacks\passes_pass\', stack_type{i}))
end