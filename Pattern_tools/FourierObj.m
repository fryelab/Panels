%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DJB - Pattern function -- switch fourier object values, 7.21.2021 %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%{
    This function changes the opponancy of the values in [X,Y]. If the
    grayscale value |pattern.gs| is set to 1, opponancy is 0/1. Level 2 
    switches 0/3, and 1/2 and level 3 switches 0/7, 1/6, 2/5, and 3/4.
%}

%% Opponancy switch %%
function [out_object] = FourierObj(object, gs_val)

out_object = object;

switch gs_val
    case 1
        out_object(object(:,:) == 0) = 1;
        out_object(object(:,:) == 1) = 0;
    case 2
        out_object(object(:,:) == 0) = 3;
        out_object(object(:,:) == 1) = 2;
        out_object(object(:,:) == 2) = 1;
        out_object(object(:,:) == 3) = 0;
    case 3
        out_object(object(:,:) == 0) = 7;
        out_object(object(:,:) == 1) = 6;
        out_object(object(:,:) == 2) = 5;
        out_object(object(:,:) == 3) = 4;
        out_object(object(:,:) == 4) = 3;
        out_object(object(:,:) == 5) = 2;
        out_object(object(:,:) == 6) = 1;
        out_object(object(:,:) == 7) = 0;
end

end