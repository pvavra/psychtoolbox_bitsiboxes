function [ onset_first_trigger] = wait_for_scanner( nScans, bitsiScanner, trigger, PTB)
%wait_for_scanner Wait for specified number of Scanner-trigger events
%
% Input:
%       nScans          number of scan-trigger events to wait for
%       bitsiScanner    bitsibox object, which to listen to for triggers
%       trigger         ASCI code of trigger (aka scanner-trigger) to wait for
%       PTB             boolean, indicating whether to show count-down on
%                       screen. This assumes PsychToolBox is already running, and
%                       only drawing/flipping is necessary.
%
% Output:
%       onset_first_trigger     onset time of first trigger-event
%
% adapted by: Peter Vavra
% version: 2014/05/19
%

% remove all previous codes from Bitsibox
bitsiScanner.clearResponses();

nEvents = 0;

message_waiting = 'Waiting for Scanner';


% get PTB-window pointer
if PTB
    windowpointers=Screen('Windows');
    window = windowpointers(1);
    DrawFormattedText(window, message_waiting, 'center', 250, 255);
    DrawFormattedText(window,int2str(nScans-nEvents), 'center', 300, 255);
    Screen(window,'Flip');
end

% wait for trigger-events
while nEvents < nScans;
    [response, timestamp] = bitsiScanner.getResponse(1, true);
    if response == trigger;
        nEvents = nEvents + 1;
        if nEvents == 1
            onset_first_trigger=timestamp;
        end
        
        % clear response from buffer
        bitsiScanner.clearResponses();
        
        % show countdown on screen
        if PTB
            DrawFormattedText(window, message_waiting, 'center', 250, 255);
            if nScans-nEvents > 0 % don't show zero
                DrawFormattedText(window,int2str(nScans-nEvents), 'center', 300, 255);
            end
            Screen(window,'Flip');
        end
        
        % log status to console
        fprintf('trigger nr: %i  -- timestamp: %f\n',nEvents, timestamp);
    end
end
end

