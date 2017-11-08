#
# Copyright (c) 2006-2014 Michael Shafae.
# All rights reserved.
#
# This program is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY, to the extent permitted by law; without even the
# implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
#
# $Id: octave_graphics.m 5209 2014-09-24 02:20:36Z mshafae $
#
#

1;

function windowCoord = glProject(objCoord, modelMatrix, projectionMatrix, viewport)
  in = [objCoord,
        1.0];
  out = modelMatrix * in;
  out = projectionMatrix * out;
  if( out(4) == 0.0 )
    windowCoord = [false,
  0.0,
  0.0,
  0.0];
    return;
  endif
  out /= out(4);
  in = (in * 0.5) + 0.5;
  in(1) = (in(1) * viewport(3)) + viewport(1);
  in(2) = (in(2) * viewport(4)) + viewport(2);
  windowCoord = [true,
  in];
endfunction

function objCoord = glUnProject(winCoord, modelMatrix, projectionMatrix,
viewport)
  finalMatrix = modelMatrix * projectionMatrix;
  if( det(finalMatrix) == 0.0 )
    objCoord = [false,
  0.0,
  0.0,
  0.0];
    return;
  endif
  finalMatrix = inv(finalMatrix)
  in = [winCoord,
  1.0];
  
  in(1) = (in(1) - viewport(1)) / viewport(3);
  in(2) = (in(2) - viewport(2)) / viewport(4);
  
  in = (in * 2.0 - 1.0);
  out = finalMatrix * in;
  if( out(4) == 0.0 )
    objCoord = [false,
  0.0,
  0.0,
  0.0];
    return;
  endif
  out = out / out(4);
  objCoord = [true,
  out];
endfunction
  
function objCoord = glUnProject4d(winCoord, clipw, modelMatrix,
projectionMatrix, viewport, near, far)
  finalMatrix = modelMatrix * projectionMatrix;
  if( det(finalMatrix) == 0.0 )
    objCoord = [false,
  0.0,
  0.0,
  0.0,
  0.0];
    return;
  endif

  finalMatrix = inv(finalMatrix)

  in = [winCoord,
  clipw];
  
  in(1) = (in(1) - viewport(1)) / viewport(3);
  in(2) = (in(2) - viewport(2)) / viewport(4);
  in(3) = (in(3) - near) / (far - near);

  in = (in * 2.0 - 1.0);
  
  out = finalMatrix * in;

  if( out(4) == 0.0 )
    objCoord = [false,
  0.0,
  0.0,
  0.0,
  0.0];
    return;
  endif

  objCoord = [true,
  out];
endfunction