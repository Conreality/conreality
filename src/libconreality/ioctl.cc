#ifdef HAVE_CONFIG_H
#include <config.h>
#endif

#include <cstdio>             /* for std::snprintf() */

#ifdef HAVE_SYS_IOCTL_H
#include <sys/ioctl.h>        /* for ioctl() */
#endif

#define CAML_NAME_SPACE
extern "C" {
#include <caml/alloc.h>       /* for caml_copy_*() */
#include <caml/bigarray.h>    /* for Caml_ba_data_val() */
#include <caml/memory.h>      /* for CAMLlocal1(), CAMLparam?(), CAMLreturn() */
#include <caml/mlvalues.h>    /* for value */
#include <caml/threads.h>     /* for caml_{enter,leave}_blocking_section() */
#include <caml/unixsupport.h> /* for uerror() */
}

////////////////////////////////////////////////////////////////////////////////

extern "C" CAMLprim value
caml_conreality_ioctl_void(value v_fd,
                           value v_cmd) {
  CAMLparam2(v_fd, v_cmd);
  CAMLlocal1(v_result);

#ifdef HAVE_SYS_IOCTL_H
  const int fd = Int_val(v_fd);
  const unsigned long cmd = Int64_val(v_cmd);

  caml_enter_blocking_section();
  const int rc = ioctl(fd, cmd, NULL);
  caml_leave_blocking_section();

  if (rc == -1) {
    char arg_string[64];
    std::snprintf(arg_string, sizeof(arg_string), "%d, 0x%08lx", fd, cmd);
    uerror(const_cast<char*>("ioctl"), caml_copy_string(arg_string));
  }

  v_result = caml_copy_int64(rc);
#else
  v_result = caml_copy_int64(0);
#endif /* HAVE_SYS_IOCTL_H */
  CAMLreturn(v_result);
}

////////////////////////////////////////////////////////////////////////////////

extern "C" CAMLprim value
caml_conreality_ioctl_int64_val(value v_fd,
                                value v_cmd,
                                value v_arg) {
  CAMLparam3(v_fd, v_cmd, v_arg);
  CAMLlocal1(v_result);

#ifdef HAVE_SYS_IOCTL_H
  const int fd = Int_val(v_fd);
  const unsigned long cmd = Int64_val(v_cmd);
  const unsigned long arg = Int64_val(v_arg);

  caml_enter_blocking_section();
  const int rc = ioctl(fd, cmd, arg);
  caml_leave_blocking_section();

  if (rc == -1) {
    char arg_string[64];
    std::snprintf(arg_string, sizeof(arg_string), "%d, 0x%08lx, 0x%08lx", fd, cmd, arg);
    uerror(const_cast<char*>("ioctl"), caml_copy_string(arg_string));
  }

  v_result = caml_copy_int64(rc);
#else
  v_result = caml_copy_int64(0);
#endif /* HAVE_SYS_IOCTL_H */
  CAMLreturn(v_result);
}

////////////////////////////////////////////////////////////////////////////////

extern "C" CAMLprim value
caml_conreality_ioctl_int64_ref(value v_fd,
                                value v_cmd,
                                value v_arg) {
  CAMLparam3(v_fd, v_cmd, v_arg);
  CAMLlocal1(v_result);

#ifdef HAVE_SYS_IOCTL_H
  const int fd = Int_val(v_fd);
  const unsigned long cmd = Int64_val(v_cmd);
  unsigned long arg = Int64_val(v_arg);

  caml_enter_blocking_section();
  const int rc = ioctl(fd, cmd, &arg);
  caml_leave_blocking_section();

  if (rc == -1) {
    char arg_string[64];
    std::snprintf(arg_string, sizeof(arg_string), "%d, 0x%08lx, 0x%08lx", fd, cmd, arg);
    uerror(const_cast<char*>("ioctl"), caml_copy_string(arg_string));
  }

  v_result = caml_copy_int64(arg);
#else
  v_result = caml_copy_int64(0);
#endif /* HAVE_SYS_IOCTL_H */
  CAMLreturn(v_result);
}

////////////////////////////////////////////////////////////////////////////////

extern "C" CAMLprim value
caml_conreality_ioctl_bigarray(value v_fd,
                               value v_cmd,
                               value v_arg) {
  CAMLparam3(v_fd, v_cmd, v_arg);
  CAMLlocal1(v_result);

#ifdef HAVE_SYS_IOCTL_H
  const int fd = Int_val(v_fd);
  const unsigned long cmd = Int64_val(v_cmd);
  void* arg = Caml_ba_data_val(v_arg);

  //caml_enter_blocking_section(); // FIXME
  const int rc = ioctl(fd, cmd, arg);
  //caml_leave_blocking_section();

  if (rc == -1) {
    char arg_string[64];
    std::snprintf(arg_string, sizeof(arg_string), "%d, 0x%08lx, %p", fd, cmd, arg);
    uerror(const_cast<char*>("ioctl"), caml_copy_string(arg_string));
  }

  v_result = caml_copy_int64(rc);
#else
  v_result = caml_copy_int64(0);
#endif /* HAVE_SYS_IOCTL_H */
  CAMLreturn(v_result);
}
