function [ num ] = HSP_checkCondition( condition )
% HSP_CHECKCONDITION - This functions checks the defined condition. 
%
% If condition is a number the function checks, if this number is equal to 
% one of the default values and return this number in case of confirmity. 
% If condition is a string, the function returns the associated number, if
% the given string is valid. Otherwise the function throws an error.

% Copyright (C) 2017, Daniel Matthes, MPI CBS

% -------------------------------------------------------------------------
% Default values
% -------------------------------------------------------------------------

defaultVals = [21, 22, 24, 25, 26, 27, 28, 29, 31, 32, 41, 42, 51, ...
                  52, 53, 10, 100];

% -------------------------------------------------------------------------
% Check Condition
% -------------------------------------------------------------------------
if isnumeric(condition)                                                     % if condition is already numeric
  if isempty(find(defaultVals == condition, 1))
    error('%d is not a valid condition', condition);
  else
    num = condition;
  end
else                                                                        % if condition is specified as string
  switch condition
    case 'Earphone2HzS'
      num = 21;
    case 'Speaker2HzS'
      num = 22;
    case 'Tapping2HzS'
      num = 24;
    case 'Dialogue2HzS'
      num = 25;
    case 'Speaker20HzS'
      num = 26;
    case 'Earphone20HzS'
      num = 27;
    case 'Speaker20HzA'
      num = 28;
    case 'Earphone20HzA'
      num = 29;
    case 'Earphone2HzA'
      num = 31;
    case 'Speaker2HzA'
      num = 32;
    case 'Earphone40HzS'
      num = 41;
    case 'Speaker40HzS'
      num = 42;
    case 'Atalks2B'
      num = 51;
    case 'Btalks2A'
      num = 52;
    case 'Dialogue'
      num = 53;
    case 'SilEyesOpen'
      num = 10;
    case 'SilEyesClosed'
      num = 100;
    otherwise
      error('%s is not a valid condition', condition);
  end
end

