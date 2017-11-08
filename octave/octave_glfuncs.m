#
# Copyright (c) 2006-2007 Michael Shafae.
# All rights reserved.
#
# This program is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY, to the extent permitted by law; without even the
# implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
#
# $Id: octave_glfuncs.m 5530 2015-02-13 08:12:33Z mshafae $
#
#

1;

function x = printNice(a)
	printf("Vec3 v(%.15f, %.15f, %.15f);\n", a(1), a(2), a(3))
endfunction

function v = normalize( a )
  if( norm(a) != 0 )
    v = a / norm(a);    
  else
    v = a;
  endif

endfunction

function Mf = glFrustum( left, right, bottom, top, zn, zf )
  Mf =[ (2*zn)/(right-left)  0  (right+left)/(right-left)  0
        0  (2*zn)/(top - bottom) (top+bottom)/(top-bottom)  0
        0 0 -(zf+zn)/(zf-zn) -(2*zf*zn)/(zf - zn)
        0 0 -1 0];
endfunction

function Mf = gluPerspective( fovy, aspect, zn, zf )
  f = cot(deg2rad(fovy)/2);
  Mf = [ f/aspect 0 0 0
         0 f 0 0
         0 0 (zf+zn)/(zn-zf) (2*zf*zn)/(zn-zf)
         0 0 -1 0 ];
endfunction

function Mo = glOrtho( left, right, bottom, top, zn, zf  )
  tx = -(right + left) / (right - left);
  ty = -(top + bottom) / (top - bottom);
  tz = -(zf + zn) / (zf - zn);
  Mo =[ 2/(right-left) 0 0 tx
        0  2/(top - bottom) 0 ty
        0 0 -2/(zf-zn) tz
        0 0 0 1];
endfunction

function Mr = glRotate( angle, x, y, z )
  r = deg2rad( angle );
  c = cos( r );
  s = sin( r );
  Mr = [ x**2*(1-c)+c     x*y*(1-c)-z*s     x*z*(1-c)+y*s     0
         y*x*(1-c)+z*s     y**2*(1-c)+c     y*z*(1-c)-x*s     0
         x*z*(1-c)-y*s     y*z*(1-c)+x*s     z**2*(1-c)+c     0
              0              0               0        1 ];
endfunction

function Mt = glTranslate( x, y, z )
  Mt = [1 0 0 x
        0 1 0 y
        0 0 1 z
        0 0 0 1];
endfunction

function Ms = glScale( x, y, z )
#  Ms = [x 0 0 0
#        0 y 0 0
#        0 0 z 0
#        0 0 0 1];
  Ms = diag([x, y, z])
endfunction

function Ml = gluLookAt( eye, center, up )
  f = normalize(center - eye);
  upn = normalize(up);
  s = cross(f, upn);
  u = cross(s, f);
  m = [ s 0
        u 0
       -f 0
    0 0 0 1];
  t = glTranslate(-eye(1), -eye(2), -eye(3));
  Ml = m * t;
endfunction

function win = gluProject(obj, modelM, projM, viewport)
  in = [obj 1.0];
  out = modelM * in;
  in = projM * out;
  if(in(4) == 0.0)
    printf("Broken!");
  endif
  in = in / in(3);
  # Map x, y, and z to range 0-1
  in = in .* 0.5 .+ 0.5;
  # Map x,y to viewport
  in(1) = in(1) * viewport(3) + viewport(1);
  in(2) = in(2) * viewport(4) + viewport(2);

  win = in
endfunction

function obj = gluUnProject4(win, clipw, modelM, projM, viewport, near, far)
    M = modelM * projM;
    if(det(M) == 0.0)
      printf("Broken!")
    endif
    Minv = inv(M);
    in = [win, 1.0]
    
    # Map x and y from window coordinates
    in(1) = (in(1) - viewport(1)) / viewport(3);
    in(2) = (in(2) - viewport(2)) / viewport(4);

    # Map to range -1 to 1
    in(1) = in(1) * 2 - 1;
    in(2) = in(2) * 2 - 1;
    in(3) = in(3) * 2 - 1;

    out = Minv * in
    if (out(4) == 0.0)
      printf("Broken!")
    endif
    out = out ./ out(4)
    obj = out    
endfunction

function obj = gluUnProject4(win, clipw, modelM, projM, viewport, near, far)
    M = modelM * projM;
    if(det(M) == 0.0)
      printf("Broken!")
    endif
    Minv = inv(M);
    in = [win, clipw]
    # Map x and y from window coordinates
    in(1) = (in(1) - viewport(1)) / viewport(3);
    in(2) = (in(2) - viewport(2)) / viewport(4);
    in(3) = (in(3) - near) / (far - near);

    # Map to range -1 to 1
    in(1) = in(1) * 2 - 1;
    in(2) = in(2) * 2 - 1;
    in(3) = in(3) * 2 - 1;

    out = Minv * in
    if (out(4) == 0.0)
      printf("Broken!")
    endif
    obj = out    
endfunction
  
