%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DJB - Pattern function -- create fourier background, 7.20.2021 %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%{
    This function increases the intensity of individual panel LEDs
    by step size, Nshift.
%}

%% Create background %%
function [outInitPat] = ShiftBrightness(InitPat, Nshift)

[height, width] =   size(InitPat);
MinIntensity =      min(min(InitPat));
MaxIntensity =      max(max(InitPat));
outInitPat =        InitPat;
GS =                NaN;

switch MaxIntensity
    case 0
        error('No brightness values were detected, please try again.')
    case 1
        GS = 1;
    case 3
        GS = 2;
    case 7
        GS = 3;
end

%% Increase star brightness %%
outInitPat(:,:,1,1) = InitPat(:,:,1,1) +Nshift;

switch GS
    case 1
        if outInitPat(outInitPat(:,:,1,1) >1)
            outInitPat(outInitPat(:,:,1,1) >1) = outInitPat(outInitPat(:,:,1,1) >1) -2;                           % outInitPat(outInitPat(:,:,1,1) == 2) = 0;
        end
    case 2
        if outInitPat(outInitPat(:,:,1,1) >3)
            outInitPat(outInitPat(:,:,1,1) >3) = outInitPat(outInitPat(:,:,1,1) >3) -4; 
        end
    case 3
        if outInitPat(outInitPat(:,:,1,1) >7)
            outInitPat(outInitPat(:,:,1,1) >7) = outInitPat(outInitPat(:,:,1,1) >7) -8; 
        end
end

end
