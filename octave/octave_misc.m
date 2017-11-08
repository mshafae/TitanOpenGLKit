#
# Copyright (c) 2006-2013 Michael Shafae.
# All rights reserved.
#
# This program is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY, to the extent permitted by law; without even the
# implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
#
# $Id: octave_misc.m 5667 2015-04-03 23:06:55Z mshafae $
#
#

1;

goldenratio = 0.5 * ( 1 + sqrt(5) );
# alternative way to calculate the golden ratio from http://www.mathworks.com/matlabcentral/fileexchange/28845-golden-ratio
PHI = 2 * cos(pi / 5);

function projAonB = vectorProjection(a, b)
  aDotb = dot(a, b);
  bDotb = dot(b, b);
  r = aDotb / bDotb;
  projAonB = b * r;
endfunction

function cofac = cofactor(m)
  #cofac = inv(m).'*det(m);
  cofac = adj(m)';
endfunction

# shitty implementation - assumes matrix is invertable
function adj = adjoint(m)
  adj = inv(m).*det(m);
endfunction

# %Paul Godfrey, October, 2006
# from mathworks file exchange; filename adj.m
function [B] = adj(A,mode)
  [r,c]=size(A);
  [u,s,v]=svd(A);

  k=det(u)*det(v');
  if r==1 || c==1
      s=s(1);
  end
  s=diag(s);

  if exist('mode','var')
      B=k*prod(s)*pinv(A);
  else
      for n=1:length(s)
          p=s;
          p(n)=[];
          V(:,n)=k*prod(p)*v(:,n);
      end
      B=V*u(:,1:length(s))';
  end
endfunction


function n = normalToThreePoints(a, b, c)
  pa = b - a;
  pb = c - a;
  #pa = normalize(pa);
  #pb = normalize(pb);
  n = normalize(cross(pa, pb));
endfunction

# given a 4 x 4 matrix, print out a 1D representation suitable for use with C
function s = carrayMat4(varname, m)
  s = sprintf("%s[16] = {%.20f, %.20f, %.20f, %.20f, %.20f, %.20f, %.20f, %.20f, %.20f, %.20f, %.20f, %.20f, %.20f, %.20f, %.20f, %.20f};", 
varname, m(1, 1), m(2, 1), m(3, 1), m(4, 1), m(1, 2), m(2, 2), m(3, 2), m(4, 2),
  m(1, 3), m(2, 3), m(3, 3), m(4, 3), m(1, 4), m(2, 4), m(3, 4), m(4, 4) );
endfunction

function s = carrayMat40(varname, m)
  s = sprintf("%s[16] = {%.80f, %.80f, %.80f, %.80f, %.80f, %.80f, %.80f, %.80f, %.80f, %.80f, %.80f, %.80f, %.80f, %.80f, %.80f, %.80f};", 
varname, m(1, 1), m(2, 1), m(3, 1), m(4, 1), m(1, 2), m(2, 2), m(3, 2), m(4, 2),
  m(1, 3), m(2, 3), m(3, 3), m(4, 3), m(1, 4), m(2, 4), m(3, 4), m(4, 4) );
endfunction


function s = carrayMat3(varname, m)
  s = sprintf("%s[9] = {%.20f, %.20f, %.20f, %.20f, %.20f, %.20f, %.20f, %.20f, %.20f};", 
varname, m(1, 1), m(2, 1), m(3, 1), m(1, 2), m(2, 2), m(3, 2),
  m(1, 3), m(2, 3), m(3, 3));
endfunction

function s = carrayMat2(varname, m)
  s = sprintf("%s[4] = {%.20f, %.20f, %.20f, %.20f};", 
varname, m(1, 1), m(2, 1), m(1, 2), m(2, 2) );
endfunction


function s = carrayVec4(varname, v)
  s = sprintf("%s[4] = {%.20f, %.20f, %.20f, %.20f};", 
varname, v(1), v(2), v(3), v(4));
endfunction

function s = carrayVec3(varname, v)
  s = sprintf("%s[3] = {%.20f, %.20f, %.20f};", 
varname, v(1), v(2), v(3));
endfunction

function s = carrayVec2(varname, v)
  s = sprintf("%s[2] = {%.20f, %.20f};", 
varname, v(1), v(2));
endfunction

function theta = dms2degrees( deg, min, sec )
  theta = deg;
  theta += min / 60.0;
  theta += sec / 3600.0;
endfunction

function [deg, min, sec] = degrees2dms( theta )
  deg = floor(theta);
  min = floor((theta - deg) * 60.0);
  sec = (theta - deg - (min/60.0)) * 3600;
endfunction

function [a, b] = seive( c )
  j = 1;
  k = 1;
  for i = 1:length(c)
    if( rem(i, 2) == 1 )
      a(j++) = c(i);
    else
      b(k++) = c(i);
    endif
  endfor
  a = a';
  b = b';
endfunction

function s = sqr( x )
  s = x * x;
endfunction

function l = lengthBetween( a, b )
  c = a - b;
  accum = 0;
  for i = 1:length(c)
    accum += sqr(c(i));
  endfor
  l = sqrt(accum);
endfunction

function m = magnitude( a )
  accum = 0;
  for i = 1:length(a)
    accum += sqr(a(i));
  endfor
  m = sqrt(accum);
endfunction

function v = normalize( a )
  #m = magnitude(a);
  #v = a / m;
  if( norm(a) != 0 )
    v = a / norm(a);    
  else
    v = a;
  endif

endfunction

function p = centroid( a, b, c )
  p = (a + b + c) / 3
endfunction

function r = deg2rad( d )
  r = d * pi / 180;
endfunction

function d = rad2deg( r )
  d = 180 * r / pi;
endfunction

#
# Conversion to different data sizes
#
function byte = bit2byte(x)
  byte = x/2**3;
endfunction

function bit = byte2bit(x)
  bit = x * 2**3;
endfunction

# XBytes to Bytes
function B = KB2B(x)
	B = x * 2**10;
endfunction

function B = MB2B(x)
	B = x * 2**20;
endfunction

function B = GB2B(x)
	B = x * 2**30;
endfunction

# Bytes to XBytes
function KB = B2KB(x)
	KB = x / 2**10;
endfunction

function MB = B2MB(x)
  MB = x / 2**20;
endfunction

function GB = B2GB(x)
  GB = x / 2**30;
endfunction

# Xbits to bits
function b = Kb2b(x)
	b = x * 2**10;
endfunction

function b = Mb2b(x)
	b = x * 2**20;
endfunction

function b = Gb2b(x)
	b = x * 2**30;
endfunction

# bits to Xbits
function KB = b2Kb(x)
	KB = x / 2**10;
endfunction

function MB = b2Mb(x)
  MB = x / 2**20;
endfunction

function GB = b2Gb(x)
  GB = x / 2**30;
endfunction

# XBytes to bits
function b = KB2b(x)
	b = x * 2**13;
endfunction

function b = MB2b(x)
	b = x * 2**23;
endfunction

function b = GB2b(x)
	b = x * 2**33;
endfunction

function s = secondsInDay( x )
	s = 24 * 60 * 60 * x;
endfunction

function s = secondsInMonth( x )
	s = secondsInDay( 30 ) * x;
endfunction

function GB = Kbs2GB(x)
	GB = B2GB(bit2byte(Kb2b(x) * secondsInMonth( 1 )));
endfunction

function GB = Kbs2MB(x)
	GB = B2MB(bit2byte(Kb2b(x) * secondsInMonth( 1 )));
endfunction

function GB = Mbs2GB(x)
	GB = B2GB(bit2byte(Mb2b(x) * secondsInMonth( 1 )));
endfunction

function Kbs = GB2Kbs(x)
	Kbs = b2Kb(GB2b(x) / secondsInMonth( 1 ));
endfunction

function Mbs = GB2Mbs(x)
	Mbs = b2Mb(GB2b(x) / secondsInMonth( 1 ));
endfunction

function b = sortlastbandwidth(pixels, colordepth, depthdepth, refresh)
  a = pixels * colordepth;
  b = pixels * depthdepth;
  bits = a + b;
  bitssec = bits * refresh;
  b = b2MB(bitssec);
endfunction

function p = percentchange(old, new)
  p = ((new - old)/old) * 100;
endfunction

function f = vtiles(x, y)
  T = sqr(x)
  #t = sqr(y)
  #tmax = sqr((x * y) - 1)
  A = 1280 * 1024 * T
  Tarea = A / T
  #tarea = Tarea / t
  F = 1757.02 * 1000000
  fps = 30
  denom = (tmax * tarea * fps)
  f = F / denom;
endfunction

function minuspoints = latepenalty( late, totalpts )
	possiblepts = totalpts;
	for i = 1:late
		minus = possiblepts * 0.1;
		possiblepts -= minus;
	endfor
	minuspoints = totalpts - possiblepts;
endfunction

function v = cylindervolume(r, h)
  v = pi*(r**2)*h;
endfunction

function n = cross4(u, v, w)
  a = (v(1) * w(2)) - (v(2) * w(1));
  b = (v(1) * w(3)) - (v(3) * w(1));
  c = (v(1) * w(4)) - (v(4) * w(1));
  d = (v(2) * w(3)) - (v(3) * w(2));
  e = (v(2) * w(4)) - (v(4) * w(2));
  f = (v(3) * w(4)) - (v(4) * w(3));

  n(1) =   (u(2) * f) - (u(3) * e) + (u(4) * d);
  n(2) = - (u(1) * f) + (u(3) * c) - (u(4) * b);
  n(3) =   (u(1) * e) - (u(2) * c) + (u(4) * a);
  n(4) = - (u(1) * d) + (u(2) * b) - (u(3) * a);
endfunction

function d = distanceBetween(a, b)
  d = norm(a-b)
endfunction

function rv = dpi(xpixels, ypixels, diagonalInches)
    if( xpixels == 0 || ypixels == 0 )
      return;
    endif
    ratio = ypixels / xpixels;
    pixels = xpixels * ypixels;
    ppi = pixels / diagonalInches;

    xInches = sqrt( diagonalInches**2 / (1 + ratio**2) );
    yInches = xInches * ratio;
    
    xMM = 2.54 * xInches;
    yMM = 2.54 * yInches;
    
    # metric 1in == 25.4mm
    horizontalPitch = 25.4 / (xpixels / xInches);
    verticalPitch = 25.4 / (ypixels / yInches);
    diagonalPitch = 25.4 / ppi;
    
    sqppi = (xpixels / xInches) * (ypixels / yInches);

    rv = [ratio, pixels, ppi, xInches, yInches, xMM, yMM, horizontalPitch, verticalPitch, diagonalPitch, sqppi];

endfunction
