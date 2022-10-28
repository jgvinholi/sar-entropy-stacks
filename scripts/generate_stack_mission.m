img_folder = "data/images/";
images = dir(fullfile(img_folder, "*.mat"));

images_pass_1 = regexpi({images.name}, 'm_\d_p_1.+', 'match');
images_pass_1 = [images_pass_1{:}];

stack_1 = zeros(3000, 2000, length(images_pass_1));
for i = 1:length(images_pass_1)
    stack_1(:, :, i) = load(img_folder + images_pass_1(i)).im;
end
save("data/stacks/passes_mission/stack_pass_1", "stack_1")


images_pass_2 = regexpi({images.name}, 'm_\d_p_2.+', 'match');
images_pass_2 = [images_pass_2{:}];

stack_2 = zeros(3000, 2000, length(images_pass_2));
for i = 1:length(images_pass_2)
    stack_2(:, :, i) = load(img_folder + images_pass_2(i)).im;
end
save("data/stacks/passes_mission/stack_pass_2", "stack_2")



images_pass_3 = regexpi({images.name}, 'm_\d_p_3.+', 'match');
images_pass_3 = [images_pass_3{:}];

stack_3 = zeros(3000, 2000, length(images_pass_3));
for i = 1:length(images_pass_3)
    stack_3(:, :, i) = load(img_folder + images_pass_3(i)).im;
end
save("data/stacks/passes_mission/stack_pass_3", "stack_3")



images_pass_4 = regexpi({images.name}, 'm_\d_p_4.+', 'match');
images_pass_4 = [images_pass_4{:}];

stack_4 = zeros(3000, 2000, length(images_pass_4));
for i = 1:length(images_pass_4)
    stack_4(:, :, i) = load(img_folder + images_pass_4(i)).im;
end
save("data/stacks/passes_mission/stack_pass_4", "stack_4")


images_pass_5 = regexpi({images.name}, 'm_\d_p_5.+', 'match');
images_pass_5 = [images_pass_5{:}];

stack_5 = zeros(3000, 2000, length(images_pass_5));
for i = 1:length(images_pass_5)
    stack_5(:, :, i) = load(img_folder + images_pass_5(i)).im;
end
save("data/stacks/passes_mission/stack_pass_5", "stack_5")


images_pass_6 = regexpi({images.name}, 'm_\d_p_6.+', 'match');
images_pass_6 = [images_pass_6{:}];

stack_6 = zeros(3000, 2000, length(images_pass_6));
for i = 1:length(images_pass_6)
    stack_6(:, :, i) = load(img_folder + images_pass_6(i)).im;
end
save("data/stacks/passes_mission/stack_pass_6", "stack_6")


images_pass_7 = regexpi({images.name}, 'm_\d_p_7.+', 'match');
images_pass_7 = [images_pass_7{:}];

stack_7 = zeros(3000, 2000, length(images_pass_7));
for i = 1:length(images_pass_7)
    stack_7(:, :, i) = load(img_folder + images_pass_7(i)).im;
end
save("data/stacks/passes_mission/stack_pass_7", "stack_7")



images_pass_8 = regexpi({images.name}, 'm_\d_p_8.+', 'match');
images_pass_8 = [images_pass_8{:}];

stack_8 = zeros(3000, 2000, length(images_pass_8));
for i = 1:length(images_pass_8)
    stack_8(:, :, i) = load(img_folder + images_pass_8(i)).im;
end
save("data/stacks/passes_mission/stack_pass_8", "stack_8")