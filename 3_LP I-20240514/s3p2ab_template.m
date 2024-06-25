clc;
clear all;
% Network parameters
n = 8; % fill with value % ; % number of edges
m = 6; % fill with value % ; % number of vertices
rate = 10; % fill with value % ;

c = [ 2 3 4 2 3 3 4 2]'; % fill with values % ].';

A = [ 1, 1, 0, 0, 0, 0, 0, 0;
     -1, 0, 1, 1, 0, 0, 0, 0;
      0,-1, 0, 0, 1, 1, 0, 0;
      0, 0,-1, 0,-1, 0, 1, 0;
      0, 0, 0,-1, 0,-1, 0, 1;
      0, 0, 0, 0, 0, 0,-1,-1];
  
b = [10, 0, 0, 0, 0, -10]';
