clear
close all
clc

target_value = 2;
cat_value = -2;
num_trials = 500;
learning_rate = 0.1;
forgetting_factor = 1;
discount_factor = 1;
max_steps = 200;

punishloc = [4,4];
rewardloc = [10,10];
agent=randi([2,14],[1,2]);

vmap=zeros(15,15);
vmap(punishloc(1),punishloc(2))=-1;
vmap(rewardloc(1),rewardloc(2))=1;
rmap=vmap;

map=zeros(15,15);


















%% function
function nextloc=move(agent,action)
direction(1,:)=[0,-1];
direction(2,:)=[-1,0];
direction(3,:)=[0,1];
direction(4,:)=[1,0]; 
nextloc=agent+direction(action);
end





















function action=act(agent)

if agent(1)==1 
    if agent(2)==1
        action=randi([3,4],1);
    elseif agent(2)==15
        action=randi([4,5],1);
        if action==5
            action=1;
        end
    else
        action=randi([3,5],1);
        if action==5
            action==1;
        end
    end
    
elseif agent(1)==15
    if agent(2)==1
        action=randi([2,3],1);
    elseif agent(2)==15
        action=randi([1,2],1);
    else
        action=randi([1,3],1);
    end

elseif agent(2)==1
    action=randi([2,4],1);
elseif agent(2)==15
    action=randi([4,6],1);
    if action==5
        action=1;
    elseif action==6
        action=2;
    end
    
else
    action=randi([1,4],1);
end
end
