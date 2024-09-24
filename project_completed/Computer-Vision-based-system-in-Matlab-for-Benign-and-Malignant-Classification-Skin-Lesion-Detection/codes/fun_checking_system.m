function system= fun_checking_system()
    if ismac
        % Code to run on Mac platform
        disp('You Have Mac');
            system='M';
    elseif ispc
        disp('You Have Windows');
        system='W';
        % Code to run on Windows platform
    else
        disp('Platform not supported')
        system='0';
    end
end