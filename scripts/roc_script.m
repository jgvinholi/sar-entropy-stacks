function roc_script(selection_index, stack_angle_or_pass, savepath)
    norm_type = 'mean_std';
    format short g % format of the variables
    warning('off', 'Images:initSize:adjustingMag');
    % stack type
    stack_type = {'gaussian/', 'rayleigh/', 'gamma/', 'weibull/', 'log_normal/', 'rician/'};
    % selection index:
    % 1 - Gaussian
    % 2 - Rayleigh
    % 3 - Gamma
    % 4 - Weibull
    % 5 - Log-Normal
    % 6 - Rician
    %%-- Set the command window --%%
    
    if stack_angle_or_pass == "angle"
        name_files = ["ssh_stack_1_3", "ssh_stack_2_4", "ssh_stack_5_6"];
        pass_folder = "passes_angle/";
    elseif stack_angle_or_pass == "pass"
        name_files = [
            "ssh_stack_1", "ssh_stack_2", "ssh_stack_3";
            "ssh_stack_4", "ssh_stack_5", "ssh_stack_6"
            ];
        pass_folder = "passes_pass/";
    end

    %% thrarget positions - 4 missions
    load('data/stacks/S1.mat')
    load('data/stacks/K1.mat')
    load('data/stacks/F1.mat')
    load('data/stacks/AF1.mat')
    
    %% Load 24 SAR images
    for im=1:24
        name=strcat('data/images_sequential/image_', num2str(im));
        load(name);
    end
    
    %% target positions image pairs
    % target positions (mission stack)
    target_positions = [S1; K1; F1; AF1];
    
    
    % Constants
    NUM_STACKS = length(name_files);
    NUM_OF_TARGETS = 100;
    NUM_IMAGES_PER_STACK = 4;
    
    im_cell = cell(1,NUM_STACKS);
    im_cell_dim = cell(1,NUM_STACKS);
    limx = 3000;
    limy = 2000;
    q = 11; % size of the window
    % t = (q-1)/2 + 1; % border handling
    
    % Ssh loading
    Ssh = cell(1,NUM_STACKS);
    for i=1:NUM_STACKS
        name = strcat( strcat('data/stacks/', pass_folder), stack_type{selection_index});
        name = strcat(name, name_files(i));
        name = strcat(name, '.mat');
    
        try
            % vectorized format
            ssh = load(name);
            % dispenses with the use of the fieldname
            ssh = struct2cell(ssh);
            % it is necessary to access the first cell
            % the mean serves to reduce the feature to a 2D grid, in case
            % it is a 3D tensor
            Ssh{i} = mean(ssh{1},3);
            ssh_flatten = Ssh{i}(:);
            if norm_type == 'zero_one'
                min_ssh =  min(ssh_flatten);
                max_ssh = max(ssh_flatten);
                Ssh{i} = (Ssh{i} - min_ssh)/(max_ssh - min_ssh);
            elseif norm_type =="mean_std"
                mean_ssh = mean(ssh_flatten, 'omitnan');
                std_ssh = std(ssh_flatten, 'omitnan');
                Ssh{i} = (Ssh{i} - mean_ssh)/std_ssh;
            end
        catch
            break
        end
    end
    
    % Getting number of cell members that are non-empty
    num_nonempty = sum(~cellfun(@isempty,Ssh));
    
    %%=======================================
    % thrhresholding
%     thr = 10^2*(20:4:200);
    thr = 1:1:50;
    % thr = 1;
    nt = length(thr);
    far = zeros(1,nt);
    pd = zeros(1,nt);
    
    for t = 1:nt
        fprintf('\n\n Threshold %.2f: \n\n',thr(t));
        
        number_detected_targets = zeros(1,1);
        number_false_alarms = zeros(1,1);
        for im = 1:num_nonempty %apenas 1 imagem
            
            ssh= Ssh{im}; %testing only one image
            
    %%% The masking out of negative targets is important for
    %%% other types of stack
       %     Mask out the negative targets
    %         for k=1:NUM_OF_TARGETS
    %             ssh(mask{im}(k,1)-10:mask{im}(k,1)+10, ...
    %                    mask{im}(k,2)-10:mask{im}(k,2)+10) = 0;
    %         end
    
            detec = ssh >= thr(t);
    
            % Morphological operations
            sq = strel('square',3);
            er = imerode(detec,sq);
            d1 = imdilate(er,sq);
            d2 = imdilate(d1,sq);
            
            % Locate detection centroids
            detected = bwconncomp(d2,8);
            detected_regions = regionprops(d2,'centroid');
            centroids = cat(1, detected_regions.Centroid);
            if detected.NumObjects > 0
                centre = sortrows([centroids(:,2) centroids(:,1)]);
                Nd = size(centre,1);
                
                % < 10 from target centroids
                target_index = 1:NUM_OF_TARGETS;
                defacto_targets = [];
                target_count = 0;
                for i = 1:Nd
                    flag = 0;
                    for j = 1:NUM_OF_TARGETS
                        if (abs(centre(i,1) - target_positions(j,1)) < 10) && ...
                           (abs(centre(i,2) - target_positions(j,2)) < 10)
                            if ~ismember(target_index(j),defacto_targets)
                                defacto_targets = [defacto_targets target_index(j)];
                                target_count = target_count + 1;
                            end
                        end
                    end
                end
                number_detected_targets(im) = target_count;
                number_false_alarms(im) = detected.NumObjects-number_detected_targets(im);
                fprintf('- Image %d: %d targets and %d false alarms \n',im,number_detected_targets(im),number_false_alarms(im));
            else
               break 
            end
            
            % Detection visualization
    %         figure(im)
    %         imshow(d2)
    %         hold on
    %         plot(centroids(:,1), centroids(:,2), 'b*')
    %         hold off
    %         title('Detected','FontSize',12)
        end
        
    %     pd(t)  = sum(number_detected_targets)/thrOthrAL_NUMBER_thrARGEthrS;
    %     far(t) = sum(number_false_alarms)/thrOthrAL_AREA_FIGURES;
    
        pd(t)  = mean(number_detected_targets)/25/4;
        far(t) = mean(number_false_alarms)/6/4;    
    
    
        fprintf('\n Detection Probability (pd): %.3f%%',pd(t));
        fprintf('\n False Alarm Rate (far): %.3f \n',far(t));
    end
    
    %
    % Plot ROC (linear far)
    figure
    plot(far,pd,'o','Linewidth',2,'MarkerSize',3,'MarkerEdgeColor','k','MarkerFaceColor','w');
    ylabel('P_{D}','fontweight','bold','fontsize',12);
    xlabel('far','fontweight','bold','fontsize',12);
    grid on;
    axis([0 0.8 0 1])
    strcat(savepath, stack_type{selection_index}(1:end-1), '_', stack_angle_or_pass, '.png')
    saveas(gcf, strcat(savepath, stack_type{selection_index}(1:end-1), '_', stack_angle_or_pass, '.png'))
    saveas(gcf, strcat(savepath, stack_type{selection_index}(1:end-1), '_', stack_angle_or_pass, '.eps'))
    
%     % Plot ROC (log far)
%     figure
%     semilogx(far,pd,'-o','Linewidth',2,'MarkerSize',5,'MarkerEdgeColor','b','MarkerFaceColor','g');
%     ylabel('P_{D}','fontweight','bold','fontsize',12);
%     xlabel('far','fontweight','bold','fontsize',12);
%     grid on;

end




