
CSUF OpenGL Kit

1/20/2015

The purpose of this kit is to provide a student with all the
libraries needed to perform computer graphics course work
at CSUF. The kit is organized such that all dlls and binaries
are in the bin directory, all header files are in the include
directory, and all libraries are in the lib directory.

If you do not know what to do with this kit, then this kit
is not for you. Seek guidance from your instructor and use
the recommended virtual machine image which includes all the
software you need to complete your work.

The share directory contains the readme files, licenses, etc.
of the included software packages.

The examples directory contains sample code provided by the 
package authors. All of the samples are built to run with the
libraries included in this kit. You must modify your development
and test environment to include the pathes to this kit such that
the examples work as well as your IDE finding the headers and
libraries.

On a Microsoft Windows system using Microsoft Visual Studio,
installing this kit typically includes modifying the user's
or system's %PATH% variable to include the bin directory and
adding the include and lib directory paths to either an
individual project's properties or the IDE user's environment.

On an Apple OS X system using Apple's Xcode, installing this
kit typically includes modifying the project's properties.
Alternatively, one can modify the environment variables such
as LDFLAGS, CPPFLAGS, CXXFLAGS, etc.

This kit includes the following libraries:

freeglut-2.8.1.tar.gz
http://freeglut.sourceforge.net/
FreeImage3154.zip
http://freeimage.sourceforge.net/
glew-1.10.0.tgz
http://glew.sourceforge.net
glfw-3.0.4.zip
http://www.glfw.org
gli-0.5.1.0.zip
http://sourceforge.net/projects/ogl-image/
glm-0.9.5.8.zip
http://glm.g-truc.net/
redbook.zip
http://www.opengl.org/archives/resources/code/samples/redbook.zip

The kit was built with either:
OS X 10.8.5 with Xcode 5
Windows 7 with MS VS 10 (Win32, Debug)
