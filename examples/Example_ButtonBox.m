% To measure responses in the scanner using the button boxes, you need to
% use the Bitsi-class. To make setting up easy and quick, use setup_bitsi.m
% This script demonstrates the simplest usage of that script: a fixation
% cross is presented, and we proceed if any of the defined buttons has been
% pressed, unless a timeout has been reached.

cd '..' % change to work directory to where all the scripts are

% First, define which 'scanner' to use
SCANNER = {'Skyra','Dummy','Debugging','Keyboard'}; % These are valid SCANNER values
SCANNER = SCANNER{3}; % To easily change, use index to set which one of the above you want

% define how long to wait for response - maximally
timeout = 2; % in seconds



% this sets up the Bitsi boxes, using the value of SCANNER. That is, if
% SCANNER = 'Skyra', it'll automatically set up the button boxes, if it's
% 'Keyboard', it'll automatically use the KbCheck function of PsychToolbox.
% However, you don't need to change your code in any way. Instead, you can
% always use the two variables bitsiboxButtons and bitsiboxScanner to check
% whether any response was given. It also automatically defines the right
% codes for the buttons.
setup_bitsi % run this at the beginning of your script. 

% Start Psychtoolbox
% Note: here, only the minimum is done. In your 'real' task, you might want
% to set more settings.
[window,screenRect]=Screen('OpenWindow',max(Screen('Screens')),100);

% Fixation Screen
[xCenter, yCenter] = RectCenter(screenRect);
FixCross = [xCenter-2,yCenter-25,xCenter+2,yCenter+25;xCenter-25,yCenter-2,xCenter+25,yCenter+2]; % if i want to change fixation cross, 1 for thickness, 40 for length
Screen('FillRect', window, 255, FixCross'); % function that makes the screen with the fixation cross, (FillRect, on what, with what color, what to fill)
[VBLTimestamp lastFlipTimestamp FlipTimestamp Missed]=Screen('Flip', window);                

% define how long to wait for response - maximally
timeout = 2; % in seconds


% wait for button-press
% check every millisecond for key being pressed -- only if
% timeout not reached yet
response = 0;
while (response == 0) && ((GetSecs - lastFlipTimestamp )<= timeout)
    [response, keyDownTimestamp] = bitsiboxButtons.getResponse(0.001, true);
end


% Once response is received, we can proceed to the next steps. Here, as an
% example, we choose a different message to display on screen - as a
% function of which button was pressed
switch response
    % do something when button "A" was pressed (index finger on right hand)
    case ButtonA
        text = 'You pressed button A!';
     
    % do something different for several different responses
    case {ButtonB, ButtonC, ButtonD, ButtonE, ButtonF, ButtonG, ButtonH}
        text = 'You pressed some button...';
        
    % do something unique if no button presed on time
    case 0
        text = 'You did not press a button on time..';
        
    % throw an error if an unkown response code is received
    % note: this should never happen on a scanner, but can happen easily
    % when running via keyboard (by pressing a key which is not associated
    % with a label 'ButtonA',...,'ButtonH'. 
    otherwise
        sca; % close psychtoolbox - just to avoid getting stuck in PTB
        close_bitsi; 
        error(['Error - response unknown! response received: ' num2str(response)]);
end
% and draw text on screen:
DrawFormattedText(window, text, 'center', 'center',255)
[VBLTimestamp lastFlipTimestamp FlipTimestamp Missed]=Screen('Flip', window);                
WaitSecs(1);

% release bitsi-boxes this needs to be done, especially on Linux, where you
% would need to restart Matlab most likely to be able to re-initialize the
% button boxes. That is, if an error during your task occurs and you re-run
% setup_bitsi.m, you'll most likely get an error, saying something about
% the serial port and/or the BitSi boxes. If that happens, just run the
% following 'manually'
close_bitsi

% Close Psychtoolbox
Screen('CloseAll');
