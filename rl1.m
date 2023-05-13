clear
close all
clc


target_value = 2;
cat_value = -2;
num_trials = 500;
learning_rate_main = 0.1;
forgetting_factor = 1;
discount_factor = 1;
max_steps = 200;

locs.punish = [4,4];
locs.reward = [10,10];
locs.agent=randi([2,14],[1,2]);

vmap=zeros(15,15);
vmap(locs.punish)=-1;
vmap(locs.reward)=1;
rmap=vmap;
%% left up right down
pamp = 1/4*ones(15,15,4);
% corner
pmap(1,1,[3,4])=1/2;
pmap(1,15,[1,4])=1/2;
pmap(15,1,[2,3])=1/2;
pmap(15,15,[1,2])=1/2;
% prob
pamp(2:14,1,[2,3,4]) = 1/3;
pamp(1,2:14,[1,2,4]) = 1/3;
pamp(2:14,15,[1,2,4]) = 1/3;
pamp(15,2:14,[1,2,3]) = 1/3;

%%

for tt=1:200
    agent(tt,1,:)=randi([2,14],[1,2]);
    vmap=forgetting_factor*vmap;
    
    ss=0;
    while criteria==0;
        ss=ss+1;
        
%         action(tt,ss)=randi([1,4]);
%         if action=1
%             agent(tt,ss+1,2)=agent(tt,ss,2)-1;
%         end
%         if action=2
%             agent(tt,ss+1,1)=agent(tt,ss,1)-1;
%         end
%         if action=3
%             agent(tt,ss+1,2)=agent(tt,ss,2)+1;
%         end
%         if action=4
%             agent(tt,ss+1,1)=agent(tt,ss,1)+1;
%         end
        
        amap(1)=vmap(squeeze(agent(tt,ss,1)),squeeze(agent(tt,ss,2))-1)      -vmap(squeeze(agent(tt,ss,1)),squeeze(agent(tt,ss,2))));
        amap(2)=vmap(squeeze(agent(tt,ss,1))-1,squeeze(agent(tt,ss,2)))      -vmap(squeeze(agent(tt,ss,1)),squeeze(agent(tt,ss,2)))));
        amap(3)=vmap(squeeze(agent(tt,ss,1)),squeeze(agent(tt,ss,2))+1)      -vmap(squeeze(agent(tt,ss,1)),squeeze(agent(tt,ss,2)))));
        amap(4)=vmap(squeeze(agent(tt,ss,1))+1,squeeze(agent(tt,ss,2)))      -vmap(squeeze(agent(tt,ss,1)),squeeze(agent(tt,ss,2)))));


        [~ action]=max(amap);
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        e(tt,ss)=rmap(squeeze(agent(tt,ss,:)))+vmap(squeeze(agent(tt,ss+1,:))-vmap(squeeze(agent(tt,ss,:));
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
    end
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
