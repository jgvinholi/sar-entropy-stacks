
Ssh = gamma_generate_entropy_map(stack_5_6);
save('C:\Users\jgvin\OneDrive\ITA\Paulo\scripts\data\stacks\passes_angle\gamma\ssh_stack_5_6.mat', 'Ssh')


% Gaussian
mkdir('C:\Users\jgvin\OneDrive\ITA\Paulo\scripts\data\stacks\passes_angle\gaussian\')

Ssh = gaussian_generate_entropy_map(stack_1_3);
save('C:\Users\jgvin\OneDrive\ITA\Paulo\scripts\data\stacks\passes_angle\gaussian\ssh_stack_1_3.mat', 'Ssh')

Ssh = gaussian_generate_entropy_map(stack_2_4);
save('C:\Users\jgvin\OneDrive\ITA\Paulo\scripts\data\stacks\passes_angle\gaussian\ssh_stack_2_4.mat', 'Ssh')

Ssh = gaussian_generate_entropy_map(stack_5_6);
save('C:\Users\jgvin\OneDrive\ITA\Paulo\scripts\data\stacks\passes_angle\gaussian\ssh_stack_5_6.mat', 'Ssh')


% Rayleigh

mkdir('C:\Users\jgvin\OneDrive\ITA\Paulo\scripts\data\stacks\passes_angle\rayleigh\')

Ssh = rayleigh_generate_entropy_map(stack_1_3);
save('C:\Users\jgvin\OneDrive\ITA\Paulo\scripts\data\stacks\passes_angle\rayleigh\ssh_stack_1_3.mat', 'Ssh')

Ssh = rayleigh_generate_entropy_map(stack_2_4);
save('C:\Users\jgvin\OneDrive\ITA\Paulo\scripts\data\stacks\passes_angle\rayleigh\ssh_stack_2_4.mat', 'Ssh')

Ssh = rayleigh_generate_entropy_map(stack_5_6);
save('C:\Users\jgvin\OneDrive\ITA\Paulo\scripts\data\stacks\passes_angle\rayleigh\ssh_stack_5_6.mat', 'Ssh')


% Log Normal

mkdir('C:\Users\jgvin\OneDrive\ITA\Paulo\scripts\data\stacks\passes_angle\log_normal\')

Ssh = log_normal_generate_entropy_map(stack_1_3);
save('C:\Users\jgvin\OneDrive\ITA\Paulo\scripts\data\stacks\passes_angle\log_normal\ssh_stack_1_3.mat', 'Ssh')

Ssh = log_normal_generate_entropy_map(stack_2_4);
save('C:\Users\jgvin\OneDrive\ITA\Paulo\scripts\data\stacks\passes_angle\log_normal\ssh_stack_2_4.mat', 'Ssh')

Ssh = log_normal_generate_entropy_map(stack_5_6);
save('C:\Users\jgvin\OneDrive\ITA\Paulo\scripts\data\stacks\passes_angle\log_normal\ssh_stack_5_6.mat', 'Ssh')


% Weibull


mkdir('C:\Users\jgvin\OneDrive\ITA\Paulo\scripts\data\stacks\passes_angle\weibull\')

Ssh = weibull_generate_entropy_map(stack_1_3);
save('C:\Users\jgvin\OneDrive\ITA\Paulo\scripts\data\stacks\passes_angle\weibull\ssh_stack_1_3.mat', 'Ssh')

Ssh = weibull_generate_entropy_map(stack_2_4);
save('C:\Users\jgvin\OneDrive\ITA\Paulo\scripts\data\stacks\passes_angle\weibull\ssh_stack_2_4.mat', 'Ssh')

Ssh = weibull_generate_entropy_map(stack_5_6);
save('C:\Users\jgvin\OneDrive\ITA\Paulo\scripts\data\stacks\passes_angle\weibull\ssh_stack_5_6.mat', 'Ssh')