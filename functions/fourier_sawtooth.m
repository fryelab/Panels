%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DJB - Pattern function -- create fourier background, 7.20.2021 %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%{
    This pattern makes a fourier sawtooth background
    of mixed intensity.
%}

%% Create background %%
function [outInitPat] = fourier_sawtooth(InitPat)

RepPat =                        zeros(size(InitPat(:,:,1,1)));
RepPat(:,:,1,1) =               InitPat(:,:,1,1);

for i = 1:length(RepPat(1,:,1,1))
    if RepPat(1,i,1,1) ~= 0
        intensity =             RepPat(1,i,1,1);
        RepPat(2,i+1,1,1) =     intensity;
        RepPat(3,i+2,1,1) =     intensity;
        RepPat(4,i+3,1,1) =     intensity;
        RepPat(5,i+3,1,1) =     intensity;
        RepPat(6,i+2,1,1) =     intensity;
        RepPat(7,i+1,1,1) =     intensity;
        RepPat(8,i,1,1) =       intensity;
    end
end

%% Eat the leftovers %%
InitPat(:,:,1,1) =              repmat(RepPat(1:8,1:96,:,:), [4 1]);
%leftovers =                     zeros(pattern.y_pixels,2,1,1);
leftovers =                     repmat(RepPat(1:8,97:end,:,:), [4 1]);

for ii = 1:length(leftovers(1,:,:,:))
    for iii = 1:length(leftovers(:,1,:,:))
        if leftovers(iii,ii,1,1) ~= 0 && InitPat(iii,ii,1,1) == 0
            InitPat(iii,ii,1,1) = leftovers(iii,ii,1,1);
        end
    end
end

outInitPat = InitPat;
end
