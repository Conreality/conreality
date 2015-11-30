#ifdef HAVE_CONFIG_H
#include <config.h>
#endif

#include <cstdio>               /* for stderr, std::fprintf() */

#include <sys/ioctl.h>          /* for ioctl() */

#define CAML_NAME_SPACE
#include <caml/alloc.h>         /* for caml_copy_int32() */
#include <caml/memory.h>        /* for CAMLlocal1(), CAMLparam2(), CAMLreturn() */
#include <caml/mlvalues.h>      /* for value */
#include <caml/unixsupport.h>   /* for uerror() */

////////////////////////////////////////////////////////////////////////////////

extern "C" void
hello(void) {
  std::fprintf(stderr, "Greetings from C++ via libffi!\n");
}

////////////////////////////////////////////////////////////////////////////////

extern "C" CAMLprim value
caml_conreality_ioctl(value v_fd,
                      value v_cmd) {
  CAMLparam2(v_fd, v_cmd);
  CAMLlocal1(v_rc);

  const int fd = Int_val(v_fd);
  const unsigned long cmd = Int64_val(v_cmd);

  const int rc = ioctl(fd, cmd, NULL);
  if (rc == -1) {
    uerror("ioctl", Nothing);
  }

  v_rc = caml_copy_int32(rc);
  CAMLreturn(v_rc);
}
