#ifdef HAVE_CONFIG_H
#include <config.h>
#endif

#include <cstdio>               /* for stderr, std::*printf() */

#include <sys/ioctl.h>          /* for ioctl() */

#define CAML_NAME_SPACE
#include <caml/alloc.h>         /* for caml_copy_*() */
#include <caml/memory.h>        /* for CAMLlocal1(), CAMLparam?(), CAMLreturn() */
#include <caml/mlvalues.h>      /* for value */
#include <caml/unixsupport.h>   /* for uerror() */

////////////////////////////////////////////////////////////////////////////////

extern "C" void
hello(void) {
  std::fprintf(stderr, "Greetings from C++ via libffi!\n");
}

////////////////////////////////////////////////////////////////////////////////

extern "C" CAMLprim value
caml_conreality_ioctl_void(value v_fd,
                           value v_cmd) {
  CAMLparam2(v_fd, v_cmd);
  CAMLlocal1(v_rc);

  const int fd = Int_val(v_fd);
  const unsigned long cmd = Int64_val(v_cmd);

  const int rc = ioctl(fd, cmd, NULL);
  if (rc == -1) {
    char arg_string[64];
    std::snprintf(arg_string, sizeof(arg_string), "%d, 0x%08lx", fd, cmd);
    uerror(const_cast<char*>("ioctl"), caml_copy_string(arg_string));
  }

  v_rc = caml_copy_int32(rc);
  CAMLreturn(v_rc);
}

////////////////////////////////////////////////////////////////////////////////

extern "C" CAMLprim value
caml_conreality_ioctl_int64(value v_fd,
                            value v_cmd,
                            value v_arg) {
  CAMLparam3(v_fd, v_cmd, v_arg);
  CAMLlocal1(v_rc);

  const int fd = Int_val(v_fd);
  const unsigned long cmd = Int64_val(v_cmd);
  const unsigned long arg = Int64_val(v_arg);

  const int rc = ioctl(fd, cmd, arg);
  if (rc == -1) {
    char arg_string[64];
    std::snprintf(arg_string, sizeof(arg_string), "%d, 0x%08lx, 0x%08lx", fd, cmd, arg);
    uerror(const_cast<char*>("ioctl"), caml_copy_string(arg_string));
  }

  v_rc = caml_copy_int32(rc);
  CAMLreturn(v_rc);
}
