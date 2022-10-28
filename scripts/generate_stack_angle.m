img_folder = "data/images/";
images = dir(fullfile(img_folder, "*.mat"));

images_pass_1_3 = regexpi({images.name}, 'm_\d_p_(1|3).+', 'match');
images_pass_1_3 = [images_pass_1_3{:}];

stack_1_3 = zeros(3000, 2000, length(images_pass_1_3));
for i = 1:length(images_pass_1_3)
    stack_1_3(:, :, i) = load(img_folder + images_pass_1_3(i)).im;
end


images_pass_2_4 = regexpi({images.name}, 'm_\d_p_(2|4).+', 'match');
images_pass_2_4 = [images_pass_2_4{:}];

stack_2_4 = zeros(3000, 2000, length(images_pass_2_4));
for i = 1:length(images_pass_2_4)
    stack_2_4(:, :, i) = load(img_folder + images_pass_2_4(i)).im;
end


images_pass_5_6 = regexpi({images.name}, 'm_\d_p_(5|6).+', 'match');
images_pass_5_6 = [images_pass_5_6{:}];

stack_5_6 = zeros(3000, 2000, length(images_pass_5_6));
for i = 1:length(images_pass_5_6)
    stack_5_6(:, :, i) = load(img_folder + images_pass_5_6(i)).im;
end