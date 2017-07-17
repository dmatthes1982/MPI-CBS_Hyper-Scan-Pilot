function [ row, column ] = HSP_cmpData( data1, data2 )
% HSP_CMPDATA test the data matrices of different data structures
% (trial, powsprectrum, PLV and mPLV) for differenzes
%
% Use as
%   [ row, column ] = HSP_cmpData( data1, data2 )

% Copyright (C) 2017, Daniel Matthes, MPI CBS

dataLength = length(data1);
row{1, dataLength} = [];
column{1, dataLength} = [];

trialLength = [];

for i = 1:1:dataLength                                                      % allocate the output
  if isfield(data1(i), 'part1')                                             % test if data1 has a field 'part1' 
    if ~isempty(data1(i).part1) && ~isempty(data2(i).part1)                 % test if th ith row is empty
      if isfield(data1(i).part1, 'trial')                                   % test if data1(i).part1 has a field 'trial'
        trialLength = length(data1(i).part1.trial);
        part = 2;
      elseif isfield(data1(i).part1, 'powspctrm')                           % test if data1(i).part1 has a field 'powspctrm'
        trialLength = 1;
        part = 2;
      end
    end
  elseif isfield(data1(i), 'dyad')                                          % test if data1 has a field 'dyad
    if ~isempty(data1(i).dyad)                                              % test if th ith row is empty                                            
      if isfield(data1(i).dyad, 'PLV')                                     % test if data1(i).dyad has a field 'PLV'
        trialLength = length(data1(i).dyad.PLV);                            
        part = 1;
      elseif isfield(data1(i).dyad, 'mPLV')                                % test if data1(i).dyad has a field 'mPLV'
        trialLength = length(data1(i).dyad.mPLV);
        part = 1;
      end
    end
  end
  if ~isempty(trialLength)
    row{1, i}{trialLength} = [];
    column{1, i}{trialLength} = [];
    if part > 1
      row{2, i}{trialLength} = [];
      column{2, i}{trialLength} = [];
    end
  end
end

for i=1:1:dataLength                                                        % compare the data structures
  if isfield(data1(i), 'part1')                                             % test if data1 has a field 'part1' 
    if ~isempty(data1(i).part1) && ~isempty(data2(i).part1)                 % test if th ith row is empty
      if isfield(data1(i).part1, 'trial')                                   % test if data1(i).part1 has a field 'trial'
        for j=1:1:length(data1(i).part1.trial)
          [row{1, i}{j}, column{1, i}{j}] = find( ...
                      data1(i).part1.trial{j} ~= ...
                      data2(i).part1.trial{j} );
          [row{2, i}{j}, column{2, i}{j}] = find( ...
                      data1(i).part2.trial{j} ~= ...
                      data2(i).part2.trial{j} );
        end
      elseif isfield(data1(i).part1, 'powspctrm')                           % test if data1(i).part1 has a field 'powspctrm'
        for j=1:1:trialLength
          [row{1, i}{j}, column{1, i}{j}] = find( ...
                    data1(i).part1.powspctrm ~= ...
                    data2(i).part1.powspctrm );
          [row{2, i}{j}, column{2, i}{j}] = find( ...
                    data1(i).part2.powspctrm ~= ...
                    data2(i).part2.powspctrm );
        end
      end
    end
  elseif isfield(data1(i), 'dyad')                                          % test if data1 has a field 'dyad
    if ~isempty(data1(i).dyad)                                              % test if th ith row is empty 
      if isfield(data1(i).dyad, 'PLV')                                     % test if data1(i).dyad has a field 'PLV'
        for j=1:1:length(data1(i).dyad.PLV)                                     
          [row{1, i}{j}, column{1, i}{j}] = find( ...
                    data1(i).dyad.PLV{j} ~= ...
                    data2(i).dyad.PLV{j} );
        end
      elseif isfield(data1(i).dyad, 'mPLV')                                % test if data1(i).dyad has a field 'mPLV'
        for j=1:1:length(data1(i).dyad.mPLV)
          [row{1, i}{j}, column{1, i}{j}] = find( ...
                    data1(i).dyad.mPLV{j} ~= ...
                    data2(i).dyad.mPLV{j} );
        end
      end
    end
  end
end
