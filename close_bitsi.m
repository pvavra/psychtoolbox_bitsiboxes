
if exist('bitsiboxScanner','var') && exist('bitsiboxButtons','var')
    %%% try closing default bitsi-box objects
    close(bitsiboxScanner);
    close(bitsiboxButtons);
else
    %%% disconnect all com-port devices
    % this works also when the workspace doesn't contain the
    % bitsiboxScanner and bitsiboxButtons variables
    delete(instrfind);
end