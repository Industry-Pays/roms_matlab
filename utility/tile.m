function [Istr,Iend,Jstr,Jend]=tile(Lm,Mm,NtileX,NtileE,varargin);
      
%
% TILE:  Compute ROMS parallel horizontal tile partitions
%
% [Istr,Iend,Jstr,Jend]=tile(Lm,Mm,NtileX,NtileE,tile,verbose);
%
% This function computes parallel tile partitions in grid units.
%
% On Input:
%
%    Lm          Number of interior RHO-points in the I-direction
%    Mm          Number of interior RHO-points in the J-direction
%    NtileI      Number of parallel partitions in the I-direction
%    NtileJ      Number of parallel partitions in the J-direction
%    tile        Tile number (optional, 0 <= tile <= NtileI*NtileJ-1)
%    verbose     display information (optional, default=true)
%
% On Output:
%
%    Istr        Starting tile I-direction index
%    Iend        Ending   tile I-direction index
%    Jstr        Starting tile J-direction index
%    Jend        Ending   tile J-direction index
%

% svn $Id$
%===========================================================================%
%  Copyright (c) 2002-2025 The ROMS Group                                   %
%    Licensed under a MIT/X style license                                   %
%    See License_ROMS.md                            Hernan G. Arango        %
%===========================================================================%

switch numel(varargin)
  case 0
    tile=0:1:NtileX*NtileE-1;
    verbose=true;
  case 1
    tile=varargin{1};
    verbose=true;
  case 2
    tile=varargin{1};
    verbose=varargin{2};
end

%---------------------------------------------------------------------------
% Compute tile(s) starting and ending indices.
%---------------------------------------------------------------------------

ChunkSizeX=fix((Lm+NtileX-1)./NtileX);
ChunkSizeE=fix((Mm+NtileE-1)./NtileE);
MarginX=fix((NtileX.*ChunkSizeX-Lm)./2);
MarginE=fix((NtileE.*ChunkSizeE-Mm)./2);

jtile=fix(tile./NtileX);
itile=tile-jtile.*NtileX;

Istr=1+itile.*ChunkSizeX-MarginX;
Iend=Istr+ChunkSizeX-1;
Istr=max(Istr,1);
Iend=min(Iend,Lm);

Jstr=1+jtile.*ChunkSizeE-MarginE;
Jend=Jstr+ChunkSizeE-1;
Jstr=max(Jstr,1);
Jend=min(Jend,Mm);

if (verbose),
  disp(' ');
  for i=1:length(tile),
    disp([' tile: ',  num2str(tile(i),'%2.2i'), '  ', ...
	  ' Itile = ', num2str(itile(i),'%2.2i'),     ...
          ' Jtile = ', num2str(jtile(i),'%2.2i'),     ...
          ' Istr = ', num2str(Istr(i),'%3.3i'),       ...
          ' Iend = ', num2str(Iend(i),'%3.3i'),       ...
          ' Jstr = ', num2str(Jstr(i),'%3.3i'),       ...
          ' Jend = ', num2str(Jend(i),'%3.3i'),       ...
	  ' (',num2str(Iend(i)-Istr(i)+1), ' x ',     ...
	     num2str(Jend(i)-Jstr(i)+1), ')'])
  end
  disp(' ');
end

return
