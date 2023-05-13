function [reward,done]=calc_reward(state,vmap)
    reward = vmap(state(1),state(2));
    done = 0;
    if reward ~= 0
        done=1;
    end