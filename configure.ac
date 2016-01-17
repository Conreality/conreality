dnl configure.ac                                        -*- Autoconf -*-
dnl
dnl Process this file with `autoconf` to produce a configure script.
dnl
dnl This is free and unencumbered software released into the public domain.

dnl The build system requires M4, Autoconf, Automake, and GNU Make.
dnl It does _not_ and _should_ not require GNU Libtool nor pkg-config.
AC_PREREQ([2.68])

dnl Define version information:
m4_define([VERSION_MAJOR],
  m4_esyscmd([cut -d'.' -f1 VERSION | tr -d '\n']))
m4_define([VERSION_MINOR],
  m4_esyscmd([cut -d'.' -f2 VERSION | tr -d '\n']))
m4_define([VERSION_PATCH],
  m4_esyscmd([cut -d'.' -f3 VERSION | tr -d '\n']))
m4_define([VERSION_STRING],
  m4_esyscmd([git describe --dirty --always | tr -d '\n']))

dnl Define package information:
AC_INIT([Conreality], [VERSION_STRING],
  [conreality@googlegroups.com], [conreality],
  [https://conreality.org/])

dnl Configure Autoconf:
AC_CONFIG_HEADERS([src/config.h])
AC_CONFIG_SRCDIR([src/META.in])
AC_CONFIG_AUX_DIR([etc/aclocal])
AC_CONFIG_MACRO_DIR([etc/aclocal])
AC_CONFIG_LIBOBJ_DIR([lib])

dnl Configure Automake:
AM_INIT_AUTOMAKE([foreign -Wall -Werror -Wno-override -Wno-portability dist-bzip2 subdir-objects nostdinc no-exeext])
AM_SILENT_RULES([yes])

dnl Check for programs:
AC_PROG_CC
AC_PROG_CPP
AC_PROG_CXX
AC_PROG_CXXCPP
m4_ifdef([AM_PROG_AR], [AM_PROG_AR])
AC_PROG_RANLIB
AC_LANG([C++])
AC_PROG_OCAML
AC_PROG_OCAMLLEX
AC_PROG_FINDLIB
AC_CHECK_PROGS([MENHIR], [menhir])
AC_CHECK_PROGS([CPPO], [cppo])
AC_CHECK_PROGS([PANDOC], [pandoc])

dnl Check for configuration options:
# --enable-debug/--disable-debug
AC_ARG_ENABLE([debug],
  [AS_HELP_STRING([--enable-debug],
    [build with debugging support [default=no]])],
  [], [enable_debug=no])
AS_IF([test "x$enable_debug" != "xno"],
  [AC_DEFINE([DEBUG], [1], [Enable debugging support.])],
  [AC_DEFINE([NDEBUG], [1], [Disable assertions.])])
AM_CONDITIONAL([ENABLE_DEBUG], [test "x$enable_debug" != "xno"])
# --enable-coverage/--disable-coverage
AC_ARG_ENABLE([coverage],
  [AS_HELP_STRING([--enable-coverage],
    [build with code coverage instrumentation [default=no]])],
  [], [enable_coverage=no])
AM_CONDITIONAL([ENABLE_COVERAGE], [test "x$enable_coverage" != "xno"])

dnl Check for libraries:
# libffi (libffi-dev on Ubuntu, libffi on Mac OS X + MacPorts)
AC_CHECK_HEADERS([ffi.h],
  AC_SEARCH_LIBS([ffi_call], [ffi], [],
    AC_MSG_ERROR([*** FFI native library libffi not found ***])),
  AC_MSG_ERROR([*** FFI header file <ffi.h> not found ***]))
# Lua (liblua5.1-0-dev on Ubuntu, lua51 on Mac OS X + MacPorts)
AC_CHECK_HEADERS([lua5.1/lua.h],
  AC_SEARCH_LIBS([lua_load], [lua5.1], [],
    AC_MSG_ERROR([*** Lua native library liblua5.1 not found ***])),
  AC_MSG_ERROR([*** Lua header file <lua5.1/lua.h> not found ***]))
# OpenCV (libopencv-dev on Ubuntu, opencv on Mac OS X + MacPorts)
AC_CHECK_HEADERS([opencv2/opencv.hpp],
  AC_SEARCH_LIBS([cvLoad], [opencv_core], [],
    AC_MSG_ERROR([*** OpenCV native library libopencv_core not found ***])),
  AC_MSG_ERROR([*** OpenCV header file <opencv2/opencv.hpp> not found ***]))
# OCaml packages (install with OPAM as needed)
AC_CHECK_OCAML_PKG([alcotest])
AC_CHECK_OCAML_PKG([cmdliner])
AC_CHECK_OCAML_PKG([ctypes])
AC_CHECK_OCAML_PKG([ctypes.foreign])
AC_CHECK_OCAML_PKG([irc-client])
AC_CHECK_OCAML_PKG([lwt])
AC_CHECK_OCAML_PKG([lua])

dnl Check for header files:
AC_CHECK_HEADERS_ONCE([sys/ioctl.h])
AC_CHECK_HEADERS_ONCE([caml/alloc.h])
AC_CHECK_HEADERS_ONCE([caml/bigarray.h])
AC_CHECK_HEADERS_ONCE([caml/memory.h])
AC_CHECK_HEADERS_ONCE([caml/misc.h])
AC_CHECK_HEADERS_ONCE([caml/mlvalues.h])
AC_CHECK_HEADERS([caml/threads.h], [], [], [
  #ifdef HAVE_CAML_MISC_H
  #include <caml/misc.h>
  #endif
])
AC_CHECK_HEADERS([caml/unixsupport.h], [], [], [
  #ifdef HAVE_CAML_MLVALUES_H
  #include <caml/mlvalues.h>
  #endif
])

dnl Check for types:

dnl Check for structures:

dnl Check for compiler characteristics:
AC_CANONICAL_HOST
AS_CASE([$host_cpu],
  [amd64],    [host_cpu="x86_64"],
  [armv6l],   [host_cpu="arm"],
  [armv7l],   [host_cpu="arm"],
  [i?86],     [host_cpu="x86"],
  [x86],      [host_cpu="x86"],
  [x86_64],   [host_cpu="x86_64"],
  [AC_MSG_ERROR([unsupported CPU architecture: $host_cpu])])
AS_CASE([$host_os],
  [darwin*],  [host_type="posix" host_os="darwin"],
  [freebsd*], [host_type="posix" host_os="bsd"],
  [linux*],   [host_type="posix" host_os="linux"],
  [netbsd*],  [host_type="posix" host_os="bsd"],
  [openbsd*], [host_type="posix" host_os="bsd"],
  [AC_MSG_ERROR([unsupported OS platform: $host_os])])
AM_CPPFLAGS="$AM_CPPFLAGS -I\$(top_srcdir)/src"
AC_SUBST([AM_CPPFLAGS])

dnl Check for library functions:

dnl Check for system services:

dnl Generate output:
AC_CONFIG_FILES([
  Makefile
  src/Makefile
  src/libconreality/Makefile
  src/consensus/Makefile
  src/conctl/Makefile
  src/conreald/Makefile
  test/Makefile
])
AC_SUBST([PACKAGE_VERSION_MAJOR], ["VERSION_MAJOR"])
AC_SUBST([PACKAGE_VERSION_MINOR], ["VERSION_MINOR"])
AC_SUBST([PACKAGE_VERSION_PATCH], ["VERSION_PATCH"])
AC_CONFIG_FILES([src/META])
AC_CONFIG_FILES([src/consensus/version.ml])
AC_OUTPUT
