clc
clear
close all

save_figures = 0;
video_boolian = 1;
show_plot = 0;
save_freq = 1;

% loading images
% rat_img = imread('assets/rat.png');
% cat_img = imread('assets/cat.png');
% target_img = imread('assets/target.png');

% configs
target_value = 2;
cat_value = -2;
num_trials = 500;
learning_rate_main = 0.1;
forgetting_factor = 1;
discount_factor = 1;
max_steps = 200;

map_size = [15, 15];
cat_loc = [ceil(map_size(1,1)*rand(1,1)), ceil(map_size(1,2)*rand(1,1))];
cat_loc = [12, 13];
target_loc = [ceil(map_size(1,1)*rand(1,1)), ceil(map_size(1,2)*rand(1,1))];
target_loc = [7, 7];

map_mat_main = zeros(map_size);
map_mat_main(cat_loc(1,1), cat_loc(1,2)) = -1;
map_mat_main(target_loc(1,1), target_loc(1,2)) = 1;

num_directions = 4;

direction_map{1} = [0, 1]; % up
direction_map{2} = [0, -1]; % down
direction_map{3} = [-1, 0]; % left
direction_map{4} = [1, 0]; % right

% initializing the movement direction probabilities
states = zeros(map_size);

for i = 1:map_size(1,1)
    for j = 1:map_size(1,2)
        transitions{i,j} = zeros(1,4);
    end
end

% defining the softmax function
softmax_func = @(x) exp(x)/sum(exp(x));

fig = figure('units','normalized','outerposition',[0 0 1 1]);


% if video_boolian
%     writerObj = VideoWriter("videos/Demo_simpleRL");
%     writerObj.FrameRate = 50;
%     writerObj.Quality = 20;
%     open(writerObj);
% end

states_r = zeros(map_size);
states_r(target_loc(1,1), target_loc(1,2)) = target_value;
states_r(cat_loc(1,1), cat_loc(1,2)) = cat_value;
num_steps = zeros(1, num_trials);













%%
for trial_no = 1:num_trials
    % applying the forgeting factor
    states = states*forgetting_factor;

    learning_rate = learning_rate_main/(1+log10(trial_no));
    reach_target_bool = 0;
    reach_cat_bool = 0;
    agent_loc = randi([2,14],[1,2]);;
    agent_loc_past = [1, 1];
    step_no = 1;
    agent_locs = [];
    
    if mod(trial_no-1, 1)==0
        show_plot = 1;
    else
        show_plot = 0;
    end
    
    while ~reach_target_bool && ~reach_cat_bool
        

        % deciding which direction to choose
        directions_probs = softmax_func(cell2mat(transitions(agent_loc(1,1), agent_loc(1,2))))
        direction_no = choose_by_prob(directions_probs)
        
        direction = direction_map{direction_no};
        check_mat = map_size - (agent_loc + direction);
        if check_mat(1,1) > 0 && check_mat(1,2) > 0 && check_mat(1,1) < map_size(1,1) && check_mat(1,2) < map_size(1,2)
           agent_loc = agent_loc + direction;
        else
            for i = randperm(num_directions)
                direction = direction_map{i};
                check_mat = map_size - (agent_loc + direction);
                if check_mat(1,1) > 0 && check_mat(1,2) > 0 && check_mat(1,1) < map_size(1,1) && check_mat(1,2) < map_size(1,2)
                    agent_loc = agent_loc + direction;
                    pass_bool = 1;
                    break
                end
            end
            if ~pass_bool
                agent_loc = [randi(map_size(1,1), 1, 1), randi(map_size(1,2), 1, 1)];
            end
        end

        % checking location
        
        agent_locs = [agent_locs; agent_loc];
        
        [states, transitions] = update_state_and_transition(states_r, states, transitions, direction_no, learning_rate, discount_factor, agent_loc, agent_loc_past, target_value, cat_value, softmax_func);
        
        if agent_loc == target_loc
            reach_target_bool = 1;
            states(target_loc(1,1), target_loc(1,2)) = target_value;
        end
        if agent_loc == cat_loc
            reach_cat_bool = 1;
            states(cat_loc(1,1), cat_loc(1,2)) = cat_value;
        end

        if show_plot
            subplot(2,3,[1,2,4,5])
            plot_map(agent_loc, agent_locs, target_loc, cat_loc, map_size, rat_img, cat_img, target_img)
            title("Trial "+num2str(trial_no)+" | "+"Step "+num2str(step_no)+" | LR "+num2str(learning_rate))
            subplot(2,3,3)
            imagesc(states);
            set(gca,'YDir','normal')
            colormap bone
            colorbar
            caxis([cat_value, target_value])
            title('States')
            subplot(2,3,6)
            [fx,fy] = gradient(states);
            quiver(fx,fy)
            title('States Gradients')            
        end
        
        step_no = step_no + 1;
        agent_loc_past = agent_loc;
        
        if video_boolian
            frame = getframe(fig);
            for frame_index = 1:2
                writeVideo(writerObj,frame);
            end
        else
            pause(0.01)
        end
    
        if step_no>max_steps
            break
        end
    end
    num_steps(trial_no) = step_no;
    if mod(trial_no-1, save_freq)==0
        if save_figures
            set(gcf,'PaperPositionMode','auto')
            print("images/trial_"+num2str(trial_no),'-dpng','-r0')
        end
    end
    
end
