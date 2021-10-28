function PC = PControl_init()
%PControl_init
%PControl initializer script
global serialPort SD myPCCfg;
panel_control_paths;

PC.x_gain_max = 10;
PC.x_gain_min = -10;
PC.x_gain_val = 0;

PC.y_gain_max = 10;
PC.y_gain_min = -10;
PC.y_gain_val = 0;

PC.x_offset_max = 5;
PC.x_offset_min = -5;
PC.x_offset_val = 0;

PC.y_offset_max = 5;
PC.y_offset_min = -5;
PC.y_offset_val = 0;

PC.x_pos = 1;
PC.y_pos = 1;


PC.x_mode = 0;  % default is open loop
PC.y_mode = 0;

PC.current_pattern = 0; % use this as the init value to check if real pattern is set

% load the SD file, we cannot load and save mat file in the init_serial
% because it is nested function and panel_control_paths.m cannnot be called.
if exist('myPCCfg.mat','file')
    load([controller_path '\myPCCfg'],'-mat');
else
    myPCCfg.portNum = 99; %trust user instead of a default value   
end

%if initialize serial port 
if init_serial == 1  
    Panel_com('ctr_reset');
end

%save serial port number to SD
save([controller_path '\myPCCfg'], 'myPCCfg','-v7.3');

%empty serialport input buffer
%This is necessary because uncleanned data in the buffer will be save to
%the SD.mat and corrupt the mat file.
while serialPort.BytesAvailable ~= 0
    messRevd = fscanf(serialPort);
end
%sync the sd information to the PC, save as SD.mat in controller_path
%Panel_com('sync_sd_info');

% load the SD file - 
panel_control_paths;

try
    tempload = load([controller_path '\SD']);
    SD = tempload.SD;
    PC.num_patterns = SD.pattern.num_patterns;
    %PC.numVelFunc = SD.function.numVelFunc;
    %PC.numPosFunc = SD.function.numPosFunc;
    for j = 1:SD.pattern.num_patterns
        PC.pattern_x_size(j) = SD.pattern.x_num(j);
        PC.pattern_y_size(j) = SD.pattern.y_num(j);
    end
catch
    try % load SD.mat from SD card
        Panel_com('sync_sd_info');
%         
%          SDfile = fullfile(controller_path, 'SD.mat');
%          sdFid = fopen(SDfile, 'w');
         
        tempload = load([controller_path '\SD']);
        SD = tempload.SD;
        PC.num_patterns = SD.pattern.num_patterns;
        %PC.numVelFunc = SD.function.numVelFunc;
        %PC.numPosFunc = SD.function.numPosFunc;
        for j = 1:SD.pattern.num_patterns
            PC.pattern_x_size(j) = SD.pattern.x_num(j);
            PC.pattern_y_size(j) = SD.pattern.y_num(j);
        end
    catch
        if ~exist('SD') || isempty(SD)
            error('cannot find a clean SD.mat file on PC or SD card!')
        else
            
            warning('cannot find a clean SD.mat file - sync SD info or write pats to card on startup')
        end
        
    end
end

PC.num_patterns = SD.pattern.num_patterns;
%PC.numVelFunc = SD.function.numVelFunc;
%PC.numPosFunc = SD.function.numPosFunc;
for j = 1:SD.pattern.num_patterns
     PC.pattern_x_size(j) = SD.pattern.x_num(j); 
     PC.pattern_y_size(j) = SD.pattern.y_num(j); 
end

save([controller_path '\SD.mat'], 'SD', '-v7.3');

