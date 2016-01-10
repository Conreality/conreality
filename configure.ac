dnl configure.ac                                        -*- Autoconf -*-
dnl
dnl Process this file with `autoconf` to produce a configure script.
dnl
dnl This is free and unencumbered software released into the public domain.
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
AM_INIT_AUTOMAKE([foreign -Wall -Werror -Wno-override dist-bzip2 subdir-objects nostdinc no-exeext])
AM_SILENT_RULES([yes])

dnl Check for programs:
AC_PROG_CC
AC_PROG_CPP
AC_PROG_CXX
AC_PROG_CXXCPP
m4_ifdef([AM_PROG_AR], [AM_PROG_AR])
AC_PROG_RANLIB
dnl LT_INIT
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
  [AS_HELP_STRING([--enable-debug], [build with debugging support [default=no]])],
  [], [enable_debug=no])
AS_IF([test "x$enable_debug" != "xno"],
  [AC_DEFINE([DEBUG], [1], [Enable debugging support.])],
  [AC_DEFINE([NDEBUG], [1], [Disable assertions.])])
AM_CONDITIONAL([ENABLE_DEBUG], [test "x$enable_debug" != "xno"])

dnl Check for libraries:
AC_CHECK_OCAML_PKG([alcotest])
AC_CHECK_OCAML_PKG([cmdliner])
AC_CHECK_OCAML_PKG([ctypes])
AC_CHECK_OCAML_PKG([ctypes.foreign])
AC_CHECK_OCAML_PKG([irc-client])
AC_CHECK_OCAML_PKG([lwt])
AC_CHECK_OCAML_PKG([lua])

dnl Check for header files:

dnl Check for types:

dnl Check for structures:

dnl Check for compiler characteristics:
AC_CANONICAL_HOST
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
AC_OUTPUT
