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
% locs.agent=randi([2,14],[1,2]);

vmap=zeros(15,15);
vmap(punishloc(1),punishloc(2))=-1;
vmap(rewardloc(1),rewardloc(2))=1;
rmap=vmap;

map=zeros(15,15);
%%
for tt=1:500
    ss=1;
    agent(ss,:)=randi([2,14],[1,2]);
    criteria=0;
    
    while criteria==0
        
    action=act(agent(ss,:));
    agent(ss+1,:)=move(agent(ss,:),action);
    V(ss)=vmap(agent(ss,1),agent(ss,2));
    V(ss+1)=vmap(agent(ss+1,1),agent(ss+1,2));
    R=rmap(agent(ss,1),agent(ss,2));
%     agent(ss,:)
    
    d(ss)=R+V(ss+1)-V(ss);
    vmap(agent(ss,1),agent(ss,2))=vmap(agent(ss,1),agent(ss,2))+d(ss);
    
    
    if agent(ss,:)==punishloc
        criteria=-1;
    elseif agent(ss,:)==rewardloc
        criteria=1;
    end
    
            ss=ss+1;
    imagesc(vmap)
    hold on
    scatter(agent(ss,2),agent(ss,1),100,'k','filled','linewidth',5)
    scatter(punishloc(2),punishloc(1),100,'r','linewidth',5)
    scatter(rewardloc(2),rewardloc(1),100,'g','linewidth',5)

    title(num2str(tt))
    subtitle(num2str(ss))
    pause(0.0001)
    end
%     pause(0.1)
    stepnum(tt)=ss;
end






    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    




        




%% function
function nextloc=move(agent,action)
direction(1,:)=[0,-1];
direction(2,:)=[-1,0];
direction(3,:)=[0,1];
direction(4,:)=[1,0]; 

nextloc=agent+direction(action,:);
end

% function action=Qact(agent)
































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
            action=1;
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


