function [keys, is_empty] = record_keys(start_time, dur, device_num,ignore_key)
% Collects all keypresses for a given duration (in secs).
% Written by KGS Lab
% Edited by AS 8/2014

device_num = [];

% wait until keys are released
keys = [];
while KbCheck(device_num)
    if (GetSecs - start_time) > dur
        break
    end
end

if exist('ignore_key','var')
    RestrictKeysForKbCheck(setdiff(1:256,ignore_key));
end

% check for pressed keys
while 1
    [key_is_down, ~, key_code] = KbCheck(device_num);
    if key_is_down
        keys = [keys KbName(key_code)];
        while KbCheck(device_num)
            if (GetSecs - start_time) > dur
                break
            end
        end
    end
    if (GetSecs - start_time) > dur
        break
    end
end

% label null responses and store multiple presses as an array
if isempty(keys)
    is_empty = 1;
elseif iscell(keys)
    keys = num2str(cell2mat(keys));
    is_empty = 0;
else
    is_empty = 0;
end

%reenable all keys
RestrictKeysForKbCheck([]);

end
