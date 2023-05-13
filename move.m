function nextloc=move(agent,action)
direction(1,:)=[0,-1];
direction(2,:)=[-1,0];
direction(3,:)=[0,1];
direction(4,:)=[1,0]; 

nextloc=agent+direction(action,:);

if nextloc(1) > 15
    nextloc(1) = 15;
end

if nextloc(1) < 1
    nextloc(1) = 1;
end

if nextloc(2) > 15
    nextloc(2) = 15;
end

if nextloc(2) < 1
    nextloc(2) = 1;
end
end