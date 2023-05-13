function action=wheel(probabilities)
    probabilities = probabilities - min(probabilities)+1;
    x = cumsum(probabilities);
    x = x./x(4);
    n = rand(1,1);
    
    if n<x(1) 
        action = 1;
    elseif n<x(2) 
        action = 2;
    elseif n<x(3) 
        action = 3;
    else
        action = 4;
    end
end