% EXAMPLE: How to wait for the scanner, and start the task only after some
% amount of pulses have passed
% 
% At the scanner, you typically want to wait for some initial pulses, so
% that you can combine multi-echo data based on those. For that, you want
% to start your main task only after, say, 30 pulses have passed. This
% script shows how to set up everything in a few lines of code
% 
% written by: Peter Vavra
% 2014-06-26
%

cd '..' % change to work directory to where all the scripts are

% First, define which 'scanner' to use
SCANNER = {'Skyra','Dummy','Debugging','Keyboard'}; % These are valid SCANNER values
SCANNER = SCANNER{3}; % To easily change, use index to set which one of the above you want


% this sets up the Bitsi boxes, using the value of SCANNER. That is, if
% SCANNER = 'Skyra', it'll automatically set up the button boxes, if it's
% 'Keyboard', it'll automatically use the KbCheck function of PsychToolbox.
% However, you don't need to change your code in any way. Instead, you can
% always use the two variables bitsiboxButtons and bitsiboxScanner to check
% whether any response was given. It also automatically defines the right
% codes for the buttons.
setup_bitsi % run this at the beginning of your script. 


% Do you want to show a count-down on screen?
% if so, you need to start Psychtoolbox first
show_countdown = 1; % 0 -> no countdown shown; 1 -> countdown shown

% Start Psychtoolbox
% Note: here, only the minimum is done. In your 'real' task, you might want
% to set more settings.
[window,screenRect]=Screen('OpenWindow',max(Screen('Screens')),100);


% wait for 5 pulses of the scanner
% also, save the onset time of the very first one of those
onset_time__dummy_pulse = wait_for_scanner(5,bitsiboxScanner,scannertrigger,show_countdown);

% get the timestamp of the 31 scanner pulse 
onset_time__first_task_pulse = wait_for_scanner(1,bitsiboxScanner,scannertrigger,0); % don't show countdown here

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% HERE: start showing you task-screens
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% for demo, we show a fixation cross for 1 sec
% Fixation Screen
[xCenter, yCenter] = RectCenter(screenRect);
FixCross = [xCenter-2,yCenter-25,xCenter+2,yCenter+25;xCenter-25,yCenter-2,xCenter+25,yCenter+2]; % if i want to change fixation cross, 1 for thickness, 40 for length
Screen('FillRect', window, 255, FixCross'); % function that makes the screen with the fixation cross, (FillRect, on what, with what color, what to fill)
[VBLTimestamp lastFlipTimestamp FlipTimestamp Missed]=Screen('Flip', window);                
WaitSecs(1); % show fixation cross for 0.5 secs before ending

% release bitsi-boxes this needs to be done, especially on Linux, where you
% would need to restart Matlab most likely to be able to re-initialize the
% button boxes. That is, if an error during your task occurs and you re-run
% setup_bitsi.m, you'll most likely get an error, saying something about
% the serial port and/or the BitSi boxes. If that happens, just run the
% following 'manually'
close_bitsi

% Close Psychtoolbox
Screen('CloseAll');



