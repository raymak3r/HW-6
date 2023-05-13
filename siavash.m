clear
close all
clc

target_value = 2;
cat_value = -2;
num_trials = 500;
learning_rate = 0.1;
% forgetting_factor = 1;
% discount_factor = 1;
max_steps = 200;

x_map_size = 15;
y_map_size = 15;
n_action = 4;

punishloc = [5,5];
rewardloc = [10,10];
% locs.agent=randi([2,14],[1,2]);

vmap=zeros(y_map_size,x_map_size);
vmap(punishloc(1),punishloc(2))=cat_value;
vmap(rewardloc(1),rewardloc(2))=target_value;

p_map = ones(y_map_size,x_map_size,n_action);

map=zeros(y_map_size,x_map_size);
%%
for trial=1:100000
    step=1;
    clear agent
    agent(step,:)=randi([1,15],[1,2]);
    
    done=0;
    
    while done==0
        action=act(agent(step,:),p_map);
        agent(step+1,:)=move(agent(step,:),action);
        
        x = agent(step,2);
        y = agent(step,1);
        
        x_new = agent(step+1,2);
        y_new = agent(step+1,1); 
        [reward,done]=calc_reward(agent(step+1,:),vmap);
        p_map(y,x,action) = p_map(y,x,action) + reward + ...
            (mean(p_map(y_new,x_new,:)) - mean(p_map(y,x,:)))* learning_rate;
        
        step=step+1;

% figure(1)
%         imagesc(vmap)
%         hold on
%         scatter(agent(step,2),agent(step,1),100,'k','filled','linewidth',5)
%         scatter(punishloc(2),punishloc(1),100,'r','linewidth',5)
%         scatter(rewardloc(2),rewardloc(1),100,'g','linewidth',5)
% 
%         title(num2str(trial))
%         subtitle(num2str(step))
%         pause(0.0001)
    end
%     figure(2)
%     subplot(2,2,1)
%     heatmap(p_map(:,:,1))
%     subplot(2,2,2)
%     heatmap(p_map(:,:,2))
%     subplot(2,2,3)
%     heatmap(p_map(:,:,3))
%     subplot(2,2,4)
%     heatmap(p_map(:,:,4))
%     sgtitle(num2str(trial))


% Pmap=mean(p_map,3);
% figure(2)
% imagesc(Pmap)
% title(num2str(trial))
    
%     pause(0.1)
    stepnum(trial)=step;
    AGENT{trial}=agent;
end
%% path
figure(98)

for i =1:100
    imagesc(vmap)
    hold on

    location =randi([1,15],[1,2]);
    done = 0;
    % agent=cell2mat(AGENT(10000));
    while ~done
        p1 = location;
        action=act(location,p_map);
        location=move(location,action);

        p2=location;
        dp=p2-p1;
            figure(98)
        quiver(p1(2),p1(1),dp(2),dp(1),0,'r')
        pause(0.001)
       [reward,done]=calc_reward(location,vmap);
    end
    pause(1)
    hold off
end

%% quiv

Pmap=mean(p_map,3);
[px,py]=gradient(Pmap);
figure(97)
subplot(1,2,1)
imagesc(Pmap)
subplot(1,2,2)
quiver(px,py)
set(gca, 'XDir','reverse')
set(gca, 'YDir','reverse')



%% function


% function action=Qact(agent)



