function [str]=greg2str(gtime)

%
% GREG2STR: Converts Gregorian date array to string
% 
% [str]=greg2str(gtime)
%
% This function Converts Gregorian date to string for display.
% It does not include seconds.
%
% On Input:
%
%    gtime       Gregorian date. A six component vector:
%                  gtime=[yyyy month day hour minute second]
%
% On Output:
%
%    str         Gregorian date string.
%                  greg2str([1968 5 23 0 0 0]) = '1968/05/23 00:00'

% svn $Id$
%===========================================================================%
%  Copyright (c) 2002-2025 The ROMS Group                                   %
%    Licensed under a MIT/X style license                                   %
%    See License_ROMS.md                                Rich Signell        %
%===========================================================================%

str=sprintf('%4.4d/%2.2d/%2.2d %2.2d:%2.2d',gtime(1:5));

return
