% This script sets up the Bitsi boxes - on for the button boxes, one for the scanner-triggers
% It assumes that there is a SCANNER variable
% SCANNER = {'Skyra','Dummy','Debugging','Keyboard'}; SCANNER = SCANNER{3};

switch SCANNER    
    case 'Skyra'
        scannertrigger = 97;
        % note, should be only run under linux (timing is more accurate)
        bitsiboxScanner = Bitsi('/dev/ttyS2');
        bitsiboxButtons = Bitsi('/dev/ttyS1');

        % Right hand -- button down
        ButtonA = 97; % index finger
        ButtonB = 98; % middle finger
        ButtonC = 99; % ring finger
        ButtonD = 100; % pinky finger
        ButtonA_up = 65;
        ButtonB_up = 66;
        ButtonC_up = 67;
        ButtonD_up = 68;
        % left hand  -- button down
        ButtonE = 101; % index
        ButtonF = 102; % middle
        ButtonG = 103; % ring
        ButtonH = 104; % pinky
        ButtonE_up = 69;
        ButtonF_up = 70;
        ButtonG_up = 71;
        ButtonH_up = 72;
        
    case 'Dummy'
        scannertrigger = 97;
        bitsiboxScanner = Bitsi('/dev/ttyS2');
        bitsiboxButtons = Bitsi('/dev/ttyS1');
     
        % Right hand -- button down
        ButtonA = 97; % index finger
        ButtonB = 98; % middle finger
        ButtonC = 99; % ring finger
        ButtonD = 100; % pinky finger
        ButtonA_up = 65;
        ButtonB_up = 66;
        ButtonC_up = 67;
        ButtonD_up = 68;
        
        % left hand  -- button down
        ButtonE = 101; % index
        ButtonF = 102; % middle
        ButtonG = 103; % ring
        ButtonH = 104; % pinky
        ButtonE_up = 69;
        ButtonF_up = 70;
        ButtonG_up = 71;
        ButtonH_up = 72;
        
    case {'Debugging', 'Keyboard'}
        scannertrigger = KbName('a'); %key "a"
        bitsiboxScanner = Bitsi('');
        bitsiboxButtons = Bitsi('');
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % Note: Edit any of letters below, to use the ones you want
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        ButtonA = KbName('a'); % A
        ButtonB = KbName('s'); % S
        ButtonC = KbName('d'); % D
        ButtonD = KbName('f'); % F
        ButtonE = KbName('j'); % J
        ButtonF = KbName('k'); % K
        ButtonG = KbName('l'); % L
        ButtonH = KbName(';'); % semi-colon
        % to explicitly simulate button-up
        ButtonA_up = KbName('q'); 
        ButtonB_up = KbName('w');
        ButtonC_up = KbName('e');
        ButtonD_up = KbName('r');
        ButtonE_up = KbName('u'); 
        ButtonF_up = KbName('i'); 
        ButtonG_up = KbName('o'); 
        ButtonH_up = KbName('p');
         
    otherwise
        disp('Missing proper value for "SCANNER" variable. Cannot set up Bitsi-boxes properly..');
end